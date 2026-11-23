#!/usr/bin/env python3
"""Development-build patcher for com.sekolah.ujianbrowser (exam-beta.apk).

Every restriction is gated behind the runtime switch DevMode.modEnabled:

    modEnabled == true   -> Mode Mod   (restrictions disabled, current behaviour)
    modEnabled == false  -> Mode Default (original APK behaviour restored)

The switch is flipped by an invisible double-tap anywhere on ExamActivity.
"""
import os

ROOT = os.environ.get("PATCH_ROOT", "/tmp/opencode/apkwork/decoded")
LOG = []

DEV = "Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z"
DEV_CLS = "Lcom/sekolah/ujianbrowser/DevMode;"


def read(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


def write(path, data):
    with open(path, "w", encoding="utf-8") as f:
        f.write(data)


def replace_once(path, old, new, tag):
    src = read(path)
    if new in src:
        LOG.append("SKIP already applied: %s" % tag)
        return
    n = src.count(old)
    if n != 1:
        raise SystemExit("EXPECTED 1 OCCURRENCE, GOT %d: %s" % (n, tag))
    write(path, src.replace(old, new, 1))
    LOG.append("OK  %s" % tag)


def _span(lines, signature):
    start = None
    for i, ln in enumerate(lines):
        if ln == signature:
            start = i
            break
    if start is None:
        raise SystemExit("SIGNATURE NOT FOUND: %s" % signature)
    for j in range(start + 1, len(lines)):
        if lines[j] == ".end method":
            return start, j
    raise SystemExit("END METHOD NOT FOUND: %s" % signature)


def add_guard(path, signature, kind, tag):
    """Prefix a method with `if (modEnabled) <original-behaviour>; else <orig>`.

    kind: "void" -> mod skips the call entirely
          "long" -> mod returns 0L
          "bool" -> mod returns true
    """
    lines = read(path).split("\n")
    start, end = _span(lines, signature)
    body = lines[start + 1:end]
    if any("DevMode;->modEnabled" in ln or ln.strip() == ":dev_mode_orig" for ln in body):
        LOG.append("SKIP already applied: %s" % tag)
        return

    i = 0
    while i < len(body) and not body[i].startswith("    .locals "):
        i += 1
    if i >= len(body):
        raise SystemExit("NO .locals IN: %s" % signature)
    j = i + 1
    while j < len(body) and (body[j].strip() == "" or body[j].startswith("    .param ")):
        j += 1

    if kind == "void":
        guard = ["", "    sget-boolean v0, %s" % DEV,
                 "    if-eqz v0, :dev_mode_orig",
                 "    return-void",
                 "    :dev_mode_orig", ""]
    elif kind == "long":
        guard = ["", "    sget-boolean v0, %s" % DEV,
                 "    if-eqz v0, :dev_mode_orig",
                 "    const-wide/16 v0, 0x0",
                 "    return-wide v0",
                 "    :dev_mode_orig", ""]
    elif kind == "bool":
        guard = ["", "    sget-boolean v0, %s" % DEV,
                 "    if-eqz v0, :dev_mode_orig",
                 "    const/4 v0, 0x1",
                 "    return v0",
                 "    :dev_mode_orig", ""]
    else:
        raise SystemExit("UNKNOWN GUARD KIND: %s" % kind)

    new_body = body[:j] + guard + body[j:]
    write(path, "\n".join(lines[:start + 1] + new_body + lines[end:]))
    LOG.append("OK  %s" % tag)


def ensure_fields(path, fields, tag):
    src = read(path)
    if fields[0] in src:
        LOG.append("SKIP already applied: %s" % tag)
        return
    anchor = "\n# direct methods\n"
    if anchor not in src:
        raise SystemExit("NO # direct methods ANCHOR IN: %s" % path)
    write(path, src.replace(anchor, "\n" + "\n".join(fields) + "\n" + anchor, 1))
    LOG.append("OK  %s" % tag)


def ensure_method(path, marker, text, tag):
    src = read(path)
    if marker in src:
        LOG.append("SKIP already applied: %s" % tag)
        return
    if not src.endswith(".end method\n"):
        if src.endswith(".end method"):
            src += "\n"
        else:
            raise SystemExit("FILE DOES NOT END WITH .end method: %s" % path)
    write(path, src + "\n" + text)
    LOG.append("OK  %s" % tag)


def write_file(path, content, tag):
    if os.path.exists(path) and read(path) == content:
        LOG.append("SKIP already applied: %s" % tag)
        return
    os.makedirs(os.path.dirname(path), exist_ok=True)
    write(path, content)
    LOG.append("OK  %s" % tag)


# --------------------------------------------------------------------------
# 1. Mode switch plumbing
# --------------------------------------------------------------------------
DEV_MODE_SMALI = '''\
.class public final Lcom/sekolah/ujianbrowser/DevMode;
.super Ljava/lang/Object;
.source "DevMode.kt"


# static fields
.field public static modEnabled:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x1

    sput-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final init(Landroid/content/Context;)V
    .locals 3
    .param p0, "ctx"    # Landroid/content/Context;

    :try_start_0
    const-string v0, "ujian_dev"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "mod"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    sput-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :goto_0
    return-void
.end method

.method public static final set(Landroid/content/Context;Z)V
    .locals 3
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "mod"    # Z

    :try_start_0
    sput-boolean p1, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z

    const-string v0, "ujian_dev"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mod"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :goto_0
    return-void
.end method
'''

write_file(
    os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/DevMode.smali"),
    DEV_MODE_SMALI,
    "DevMode.smali (mode switch holder, persisted in ujian_dev/mod)")

# --------------------------------------------------------------------------
# 2. ExamActivity - fields, touch hook, mode applier
# --------------------------------------------------------------------------
EXAM = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity.smali")

ensure_fields(EXAM, [
    ".field private devBackCallback:Landroidx/activity/OnBackPressedCallback;",
    "",
    ".field private devIgnoreUntil:J",
    "",
    ".field private devLastTap:J",
], "ExamActivity fields devBackCallback / devLastTap / devIgnoreUntil")

replace_once(
    EXAM,
    "    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V",
    "    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V\n"
    "\n"
    "    invoke-static {p0}, Lcom/sekolah/ujianbrowser/DevMode;->init(Landroid/content/Context;)V",
    "onCreate loads persisted mode before anything reads it")

replace_once(
    EXAM,
    "    check-cast v2, Landroidx/activity/OnBackPressedCallback;\n"
    "\n"
    "    invoke-virtual {v0, v1, v2}, Landroidx/activity/OnBackPressedDispatcher;->addCallback(Landroidx/lifecycle/LifecycleOwner;Landroidx/activity/OnBackPressedCallback;)V",
    "    check-cast v2, Landroidx/activity/OnBackPressedCallback;\n"
    "\n"
    "    iput-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devBackCallback:Landroidx/activity/OnBackPressedCallback;\n"
    "\n"
    "    invoke-virtual {v0, v1, v2}, Landroidx/activity/OnBackPressedDispatcher;->addCallback(Landroidx/lifecycle/LifecycleOwner;Landroidx/activity/OnBackPressedCallback;)V",
    "onCreate keeps a handle on the back callback so the mode can re-enable it")

replace_once(
    EXAM,
    "    const/16 v1, 0x2080\n"
    "\n"
    "    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V",
    "    sget-boolean v2, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z\n"
    "\n"
    "    if-eqz v2, :dev_mode_wflags_default\n"
    "\n"
    "    const/16 v1, 0x80\n"
    "\n"
    "    goto :dev_mode_wflags_done\n"
    "\n"
    "    :dev_mode_wflags_default\n"
    "\n"
    "    const/16 v1, 0x2080\n"
    "\n"
    "    :dev_mode_wflags_done\n"
    "\n"
    "    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V",
    "onCreate window flags: FLAG_SECURE only in Mode Default")

ensure_method(EXAM, ".method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z", '''\
.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8

    invoke-super {p0, p1}, Landroid/app/Activity;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :dev_tap_done

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devIgnoreUntil:J

    cmp-long v1, v2, v4

    if-ltz v1, :dev_tap_done

    iget-wide v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-lez v1, :dev_tap_store

    goto :dev_tap_have_last

    :dev_tap_store
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J

    goto :dev_tap_done

    :dev_tap_have_last
    sub-long/2addr v2, v4

    const-wide/16 v6, 0x12c

    cmp-long v1, v2, v6

    if-gtz v1, :dev_tap_store

    const-wide/16 v4, 0x0

    iput-wide v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    const-wide/16 v4, 0x2bc

    add-long/2addr v2, v4

    iput-wide v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devIgnoreUntil:J

    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devModeToggle()V

    :dev_tap_done
    return v0
.end method
''', "ExamActivity.dispatchTouchEvent (invisible double-tap detector)")

ensure_method(EXAM, ".method private final devModeToggle()V", '''\
.method private final devModeToggle()V
    .locals 2

    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z

    if-eqz v0, :dev_toggle_default

    const/4 v0, 0x0

    goto :dev_toggle_apply

    :dev_toggle_default
    const/4 v0, 0x1

    :dev_toggle_apply
    invoke-static {p0, v0}, Lcom/sekolah/ujianbrowser/DevMode;->set(Landroid/content/Context;Z)V

    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devModeApply()V

    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z

    if-nez v0, :dev_toggle_quiet

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/sekolah/ujianbrowser/DevBeep;

    invoke-direct {v1}, Lcom/sekolah/ujianbrowser/DevBeep;-><init>()V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    :dev_toggle_quiet
    return-void
.end method
''', "ExamActivity.devModeToggle (flip + persist + apply + siren burst into Mode Default)")

ensure_method(EXAM, ".method private final devModeApply()V", '''\
.method private final devModeApply()V
    .locals 6

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    sget-boolean v1, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z

    if-eqz v1, :dev_apply_default

    const/16 v1, 0x2000

    invoke-virtual {v0, v1}, Landroid/view/Window;->clearFlags(I)V

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devBackCallback:Landroidx/activity/OnBackPressedCallback;

    if-eqz v1, :dev_mod_nocb

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroidx/activity/OnBackPressedCallback;->setEnabled(Z)V

    :dev_mod_nocb
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->lockWatch:Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;

    check-cast v2, Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->armCheck:Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;

    check-cast v2, Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->gateView:Landroid/widget/LinearLayout;

    if-eqz v1, :dev_mod_nogate

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    instance-of v3, v2, Landroid/view/ViewGroup;

    if-eqz v3, :dev_mod_rm

    check-cast v2, Landroid/view/ViewGroup;

    invoke-virtual {v2, v1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    :dev_mod_rm
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->gateView:Landroid/widget/LinearLayout;

    :dev_mod_nogate
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->webView:Landroid/webkit/WebView;

    if-eqz v1, :dev_mod_wv

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setVisibility(I)V

    :dev_mod_wv
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->reloadBtn:Landroid/widget/TextView;

    if-eqz v1, :dev_mod_rb

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :dev_mod_rb
    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->stopAlarm()V

    :try_start_0
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->stopLockTask()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :dev_mod_catch

    goto :dev_apply_end

    :dev_mod_catch
    move-exception v1

    :dev_apply_end
    return-void

    :dev_apply_default
    const/16 v1, 0x2080

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devBackCallback:Landroidx/activity/OnBackPressedCallback;

    if-eqz v1, :dev_def_nocb

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroidx/activity/OnBackPressedCallback;->setEnabled(Z)V

    :dev_def_nocb
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->gateView:Landroid/widget/LinearLayout;

    if-nez v1, :dev_def_havegate

    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->buildGate()V

    goto :dev_def_gate

    :dev_def_havegate
    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->webView:Landroid/webkit/WebView;

    if-eqz v2, :dev_def_wv

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Landroid/webkit/WebView;->setVisibility(I)V

    :dev_def_wv
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    :dev_def_gate
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->reloadBtn:Landroid/widget/TextView;

    if-eqz v1, :dev_def_rb

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :dev_def_rb
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->lockWatch:Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;

    check-cast v2, Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->lockWatch:Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;

    check-cast v2, Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->armCheck:Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;

    check-cast v2, Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->armCheck:Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;

    check-cast v2, Ljava/lang/Runnable;

    const-wide/16 v3, 0x1f4

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
''', "ExamActivity.devModeApply (reconcile window/back/gate/loops/alarm)")

# --------------------------------------------------------------------------
# 3. Every restriction now runs only in Mode Default
# --------------------------------------------------------------------------
add_guard(EXAM, ".method private final enterLockMode()V", "void",
          "enterLockMode() -> skipped in Mode Mod (no startLockTask / setLockTaskPackages)")
add_guard(EXAM, ".method private final triggerIfLeaving()V", "void",
          "triggerIfLeaving() -> skipped in Mode Mod (no leave-app alarm)")
add_guard(EXAM, ".method private final startAlarm()V", "void",
          "startAlarm() -> skipped in Mode Mod (no siren / violation counter)")
add_guard(EXAM, ".method private final forceSoundOn()V", "void",
          "forceSoundOn() -> skipped in Mode Mod (volume + DND untouched)")
add_guard(EXAM, ".method private final startVibration()V", "void",
          "startVibration() -> skipped in Mode Mod (no forced vibration)")
add_guard(EXAM, ".method private final playSiren()V", "void",
          "playSiren() -> skipped in Mode Mod (no siren tone)")
add_guard(EXAM, ".method private final buildGate()V", "void",
          "buildGate() -> skipped in Mode Mod (gate overlay never built, WebView stays visible)")

BACK = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$onCreate$1.smali")
replace_once(
    BACK,
    "    const/4 v0, 0x1\n"
    "\n"
    "    invoke-direct {p0, v0}, Landroidx/activity/OnBackPressedCallback;-><init>(Z)V",
    "    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z\n"
    "\n"
    "    if-eqz v0, :dev_mode_cb_default\n"
    "\n"
    "    const/4 v0, 0x0\n"
    "\n"
    "    goto :dev_mode_cb_done\n"
    "\n"
    "    :dev_mode_cb_default\n"
    "\n"
    "    const/4 v0, 0x1\n"
    "\n"
    "    :dev_mode_cb_done\n"
    "\n"
    "    invoke-direct {p0, v0}, Landroidx/activity/OnBackPressedCallback;-><init>(Z)V",
    "OnBackPressedCallback enabled only in Mode Default (Back exits in Mode Mod)")

ARM = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$armCheck$1.smali")
add_guard(ARM, ".method public run()V", "void",
          "armCheck.run() -> skipped in Mode Mod (violation detector never armed)")

LOCKWATCH = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$lockWatch$1.smali")
if os.path.exists(LOCKWATCH):
    add_guard(LOCKWATCH, ".method public run()V", "void",
              "lockWatch.run() -> skipped in Mode Mod (lock-task watchdog never hides WebView)")
else:
    LOG.append("SKIP lockWatch (not present in this version)")

LOCK = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamLock.smali")
add_guard(LOCK, ".method public final remainingMs(Landroid/content/Context;)J", "long",
          "ExamLock.remainingMs() -> 0 in Mode Mod (60-minute exam timer inactive)")

ADMIN = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/AdminCode.smali")
add_guard(ADMIN, ".method public final lockedMs(Landroid/content/Context;)J", "long",
          "AdminCode.lockedMs() -> 0 in Mode Mod (admin lockout timer inactive)")
add_guard(ADMIN, ".method public final verify(Landroid/content/Context;Ljava/lang/String;Z)Z", "bool",
          "AdminCode.verify() -> always true in Mode Mod (exit gate removed)")


# --------------------------------------------------------------------------
# 4. Siren feedback on entering Mode Default + user-adjustable volume
# --------------------------------------------------------------------------
DEV_BEEP_SMALI = '''\
.class public final Lcom/sekolah/ujianbrowser/DevBeep;
.super Ljava/lang/Object;
.source "DevBeep.kt"

.implements Ljava/lang/Runnable;


.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public run()V
    .locals 18

    const/16 v0, 0x5622

    :try_start_0
    const/4 v2, 0x4

    const/4 v3, 0x2

    invoke-static {v0, v2, v3}, Landroid/media/AudioTrack;->getMinBufferSize(III)I

    move-result v4

    invoke-static {v4, v0}, Ljava/lang/Math;->max(II)I

    move-result v4

    new-instance v10, Landroid/media/AudioTrack;

    const/4 v11, 0x3

    move v12, v0

    const/4 v13, 0x4

    const/4 v14, 0x2

    move v15, v4

    const/16 v16, 0x1

    invoke-direct/range {v10 .. v16}, Landroid/media/AudioTrack;-><init>(IIIIII)V

    move-object v1, v10

    invoke-virtual {v1}, Landroid/media/AudioTrack;->play()V

    div-int/lit8 v2, v0, 0xa

    new-array v3, v2, [S

    const-wide/16 v6, 0x0

    const-wide v13, 0x401921fb54442d18L

    const/4 v5, 0x0

    const/4 v4, 0x0

    :chunk_loop
    const/16 v8, 0xa

    if-ge v4, v8, :chunk_done

    const/4 v8, 0x0

    :sample_loop
    if-ge v8, v2, :sample_done

    int-to-double v9, v5

    int-to-double v15, v0

    div-double/2addr v9, v15

    const-wide/high16 v11, 0x3fe0000000000000L

    cmpg-double v17, v9, v11

    const-wide/high16 v11, 0x4000000000000000L

    if-gez v17, :sweep_down

    mul-double/2addr v11, v9

    goto :sweep_done

    :sweep_down
    const-wide/high16 v15, 0x3ff0000000000000L

    sub-double/2addr v15, v9

    mul-double/2addr v11, v15

    :sweep_done
    const-wide/high16 v15, 0x4089000000000000L

    mul-double/2addr v11, v15

    const-wide v15, 0x4085e00000000000L

    add-double/2addr v11, v15

    mul-double/2addr v11, v13

    int-to-double v15, v0

    div-double/2addr v11, v15

    add-double/2addr v6, v11

    cmpl-double v17, v6, v13

    if-lez v17, :phase_ok

    sub-double/2addr v6, v13

    :phase_ok
    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v11

    const-wide v15, 0x40bf400000000000L

    mul-double/2addr v11, v15

    double-to-int v15, v11

    int-to-short v15, v15

    aput-short v15, v3, v8

    add-int/lit8 v5, v5, 0x1

    rem-int/2addr v5, v0

    add-int/lit8 v8, v8, 0x1

    goto :sample_loop

    :sample_done
    const/4 v8, 0x0

    invoke-virtual {v1, v3, v8, v2}, Landroid/media/AudioTrack;->write([SII)I

    add-int/lit8 v4, v4, 0x1

    goto :chunk_loop

    :chunk_done
    invoke-virtual {v1}, Landroid/media/AudioTrack;->stop()V

    invoke-virtual {v1}, Landroid/media/AudioTrack;->release()V

    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    return-void
.end method
'''

write_file(
    os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/DevBeep.smali"),
    DEV_BEEP_SMALI,
    "DevBeep.smali (one-second siren sweep on the music stream, plays when entering Mode Default)")

replace_once(
    EXAM,
    ".method private final forceSoundOn()V\n"
    "    .locals 4\n"
    "\n"
    "\n"
    "    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z\n"
    "    if-eqz v0, :dev_mode_orig\n"
    "    return-void\n"
    "    :dev_mode_orig\n",
    ".method private final forceSoundOn()V\n"
    "    .locals 4\n"
    "\n"
    "    return-void\n"
    "    :dev_mode_orig\n",
    "forceSoundOn() -> never forces alarm volume or DND (volume stays user-adjustable)")

replace_once(
    EXAM,
    "    invoke-virtual {v6, v3}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;",
    "    const/4 v7, 0x1\n"
    "\n"
    "    invoke-virtual {v6, v7}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;",
    "playSiren() -> media usage so the volume keys control the siren")

replace_once(
    EXAM,
    "    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devModeApply()V\n"
    "\n"
    "    return-void\n"
    ".end method",
    "    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devModeApply()V\n"
    "\n"
    "    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z\n"
    "\n"
    "    if-nez v0, :dev_toggle_quiet\n"
    "\n"
    "    new-instance v0, Ljava/lang/Thread;\n"
    "\n"
    "    new-instance v1, Lcom/sekolah/ujianbrowser/DevBeep;\n"
    "\n"
    "    invoke-direct {v1}, Lcom/sekolah/ujianbrowser/DevBeep;-><init>()V\n"
    "\n"
    "    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V\n"
    "\n"
    "    invoke-virtual {v0}, Ljava/lang/Thread;->start()V\n"
    "\n"
    "    :dev_toggle_quiet\n"
    "    return-void\n"
    ".end method",
    "devModeToggle() -> siren burst when entering Mode Default")

replace_once(
    EXAM,
    "    const-wide v17, 0x40df400000000000L    # 32000.0",
    "    const-wide v17, 0x40bf400000000000L    # 8000.0",
    "playSiren() -> amplitude 8000 (quieter siren)")

# --------------------------------------------------------------------------
# 5. Snappier mode switching
#    - Mode Default: ask for screen pinning right away (enterLockMode) instead
#      of waiting at the gate until the activity is resumed again
#    - poll lock state every 200 ms (was 700 / 500) so the gate/WebView swap
#      happens as soon as the pin is accepted; armCheck timeout stays 30 s
# --------------------------------------------------------------------------
replace_once(
    EXAM,
    "    const-wide/16 v3, 0x1f4\n"
    "\n"
    "    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z\n"
    "\n"
    "    return-void\n"
    ".end method",
    "    const-wide/16 v3, 0xc8\n"
    "\n"
    "    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z\n"
    "\n"
    "    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->enterLockMode()V\n"
    "\n"
    "    return-void\n"
    ".end method",
    "devModeApply() -> request screen pinning immediately + 200 ms armCheck")

LOCKWATCH = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$lockWatch$1.smali")
ARMCHECK = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$armCheck$1.smali")
replace_once(LOCKWATCH, "    const-wide/16 v5, 0x2bc", "    const-wide/16 v5, 0xc8",
             "lockWatch poll 700 ms -> 200 ms")
replace_once(ARMCHECK, "    const-wide/16 v4, 0x1f4", "    const-wide/16 v4, 0xc8",
             "armCheck poll 500 ms -> 200 ms")
replace_once(ARMCHECK, "    add-int/lit16 v2, v2, 0x1f4", "    add-int/lit16 v2, v2, 0xc8",
             "armCheck waitedMs step 500 -> 200 (30 s timeout unchanged)")

print("\n".join(LOG))
print("TOTAL PATCHES: %d" % len(LOG))
