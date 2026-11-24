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

# --------------------------------------------------------------------------
# 6. Siren respects the media volume: if STREAM_MUSIC is 0 the siren stays
#    silent (some ROMs still let the AudioTrack through)
# --------------------------------------------------------------------------
replace_once(
    EXAM,
    "    :dev_mode_orig\n"
    "\n"
    "    .line 516\n"
    "    const/16 v1, 0x5622",
    "    :dev_mode_orig\n"
    "\n"
    "    const-string v0, \"audio\"\n"
    "\n"
    "    move-object/from16 v1, p0\n"
    "\n"
    "    invoke-virtual {v1, v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;\n"
    "\n"
    "    move-result-object v0\n"
    "\n"
    "    check-cast v0, Landroid/media/AudioManager;\n"
    "\n"
    "    if-eqz v0, :dev_vol_ok\n"
    "\n"
    "    const/4 v1, 0x3\n"
    "\n"
    "    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->getStreamVolume(I)I\n"
    "\n"
    "    move-result v0\n"
    "\n"
    "    if-nez v0, :dev_vol_ok\n"
    "\n"
    "    return-void\n"
    "\n"
    "    :dev_vol_ok\n"
    "    .line 516\n"
    "    const/16 v1, 0x5622",
    "playSiren() -> silent when media volume is 0")

# --------------------------------------------------------------------------
# 7. Volume 0 silences everything: vibration ignores the volume keys, so the
#    alarm (siren + repeating vibration) is stopped as soon as media volume
#    reads 0. Checked from lockWatch (runs every 200 ms in Mode Default).
# --------------------------------------------------------------------------
ensure_method(EXAM, ".method public final devVolCheck()V", '''\
.method public final devVolCheck()V
    .locals 3

    iget-boolean v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->sirenOn:Z

    if-eqz v0, :dev_vc_done

    const-string v0, "audio"

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    if-eqz v0, :dev_vc_done

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v0

    if-nez v0, :dev_vc_done

    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->stopAlarm()V

    :dev_vc_done
    return-void
.end method
''', "ExamActivity.devVolCheck (stop siren + vibration when media volume is 0)")

replace_once(
    LOCKWATCH,
    "    :dev_mode_orig\n"
    "\n"
    "    .line 355\n",
    "    :dev_mode_orig\n"
    "\n"
    "    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;\n"
    "\n"
    "    invoke-virtual {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devVolCheck()V\n"
    "\n"
    "    .line 355\n",
    "lockWatch.run -> devVolCheck()")

# --------------------------------------------------------------------------
# 8. Dev/testing mode toggle: require 3 consecutive taps (was 2) within a
#    tighter 250 ms gap between taps, plus a 1.5 s cooldown after toggling,
#    so normal fast tapping during testing doesn't trip devModeToggle by
#    accident. State: devLastTap (ms of previous tap) resets to 0 whenever
#    the gap is too long or count hits 0; devTapCount counts consecutive
#    taps; devIgnoreUntil is the post-toggle cooldown, unchanged in spirit.
# --------------------------------------------------------------------------
ensure_fields(EXAM, ["    .field private devTapCount:I"],
              "ExamActivity -> add devTapCount field")

replace_once(
    EXAM,
    "    iget-wide v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J\n"
    "\n"
    "    const-wide/16 v6, 0x0\n"
    "\n"
    "    cmp-long v1, v4, v6\n"
    "\n"
    "    if-lez v1, :dev_tap_store\n"
    "\n"
    "    goto :dev_tap_have_last\n"
    "\n"
    "    :dev_tap_store\n"
    "    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J\n"
    "\n"
    "    move-result-wide v2\n"
    "\n"
    "    iput-wide v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J\n"
    "\n"
    "    goto :dev_tap_done\n"
    "\n"
    "    :dev_tap_have_last\n"
    "    sub-long/2addr v2, v4\n"
    "\n"
    "    const-wide/16 v6, 0x12c\n"
    "\n"
    "    cmp-long v1, v2, v6\n"
    "\n"
    "    if-gtz v1, :dev_tap_store\n"
    "\n"
    "    const-wide/16 v4, 0x0\n"
    "\n"
    "    iput-wide v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J\n"
    "\n"
    "    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J\n"
    "\n"
    "    move-result-wide v2\n"
    "\n"
    "    const-wide/16 v4, 0x2bc\n"
    "\n"
    "    add-long/2addr v2, v4\n"
    "\n"
    "    iput-wide v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devIgnoreUntil:J\n"
    "\n"
    "    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devModeToggle()V\n"
    "\n"
    "    :dev_tap_done",
    "    iget-wide v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J\n"
    "\n"
    "    const-wide/16 v6, 0x0\n"
    "\n"
    "    cmp-long v1, v4, v6\n"
    "\n"
    "    if-lez v1, :dev_tap_store\n"
    "\n"
    "    sub-long v6, v2, v4\n"
    "\n"
    "    const-wide/16 v4, 0xfa\n"
    "\n"
    "    cmp-long v1, v6, v4\n"
    "\n"
    "    if-gtz v1, :dev_tap_store\n"
    "\n"
    "    goto :dev_tap_have_last\n"
    "\n"
    "    :dev_tap_store\n"
    "    const/4 v1, 0x1\n"
    "\n"
    "    iput v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devTapCount:I\n"
    "\n"
    "    iput-wide v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J\n"
    "\n"
    "    goto :dev_tap_done\n"
    "\n"
    "    :dev_tap_have_last\n"
    "    iget v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devTapCount:I\n"
    "\n"
    "    add-int/lit8 v1, v1, 0x1\n"
    "\n"
    "    iput v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devTapCount:I\n"
    "\n"
    "    iput-wide v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J\n"
    "\n"
    "    const/4 v4, 0x3\n"
    "\n"
    "    if-lt v1, v4, :dev_tap_done\n"
    "\n"
    "    const/4 v4, 0x0\n"
    "\n"
    "    iput v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devTapCount:I\n"
    "\n"
    "    const-wide/16 v4, 0x0\n"
    "\n"
    "    iput-wide v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devLastTap:J\n"
    "\n"
    "    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J\n"
    "\n"
    "    move-result-wide v2\n"
    "\n"
    "    const-wide/16 v4, 0x5dc\n"
    "\n"
    "    add-long/2addr v2, v4\n"
    "\n"
    "    iput-wide v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devIgnoreUntil:J\n"
    "\n"
    "    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devModeToggle()V\n"
    "\n"
    "    :dev_tap_done",
    "dispatchTouchEvent() -> 3 consecutive taps (250ms gaps) + 1.5s cooldown for devModeToggle")

# --------------------------------------------------------------------------
# 9. Device ping + remote ban (Firebase RTDB), transparent: shows a short
#    device code on the Mode Default gate so the user can tell admin their
#    code. Background-only, fail-open on any network error.
# --------------------------------------------------------------------------
ensure_fields(EXAM, ["    .field private devCode:Ljava/lang/String;"],
              "ExamActivity -> add devCode field")

ensure_method(EXAM, ".method public final computeDeviceCode()Ljava/lang/String;", '''\
.method public final computeDeviceCode()Ljava/lang/String;
    .locals 10

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devCode:Ljava/lang/String;

    if-eqz v0, :dev_code_compute

    return-object v0

    :dev_code_compute
    const-string v0, "UNKNOWN"

    :try_start_0
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "android_id"

    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :dev_code_have_id

    const-string v1, "unknown"

    :dev_code_have_id
    const-string v2, "SHA-256"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v5, 0x0

    :dev_code_loop
    const/4 v6, 0x4

    if-ge v5, v6, :dev_code_loop_done

    aget-byte v6, v3, v5

    and-int/lit16 v6, v6, 0xff

    shr-int/lit8 v7, v6, 0x4

    and-int/lit8 v7, v7, 0xf

    const/16 v9, 0xa

    if-ge v7, v9, :dev_code_hi_alpha

    add-int/lit8 v9, v7, 0x30

    goto :dev_code_hi_done

    :dev_code_hi_alpha
    add-int/lit8 v9, v7, 0x37

    :dev_code_hi_done
    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    and-int/lit8 v7, v6, 0xf

    const/16 v9, 0xa

    if-ge v7, v9, :dev_code_lo_alpha

    add-int/lit8 v9, v7, 0x30

    goto :dev_code_lo_done

    :dev_code_lo_alpha
    add-int/lit8 v9, v7, 0x37

    :dev_code_lo_done
    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v5, v5, 0x1

    goto :dev_code_loop

    :dev_code_loop_done
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :dev_code_catch

    goto :dev_code_store

    :dev_code_catch
    move-exception v1

    const-string v0, "UNKNOWN"

    :dev_code_store
    iput-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devCode:Ljava/lang/String;

    return-object v0
.end method
''', "ExamActivity.computeDeviceCode (SHA-256(ANDROID_ID), first 4 bytes as hex)")

ensure_method(EXAM, ".method public final showBanScreen()V", '''\
.method public final showBanScreen()V
    .locals 8

    new-instance v0, Landroid/widget/LinearLayout;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v2, 0x11

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    const-string v3, "#2A0D0D"

    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    new-instance v4, Landroid/widget/TextView;

    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v5, "Aplikasi ini dinonaktifkan untuk device ini.\\nHubungi admin."

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v5, -0x1

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setGravity(I)V

    move-object v5, v4

    check-cast v5, Landroid/view/View;

    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    move-object v5, v0

    check-cast v5, Landroid/view/View;

    const/4 v7, -0x1

    new-instance v6, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v6, v7, v7}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v5, v6}, Lcom/sekolah/ujianbrowser/ExamActivity;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v6, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->webView:Landroid/webkit/WebView;

    if-eqz v6, :ban_no_webview

    const/4 v7, 0x4

    invoke-virtual {v6, v7}, Landroid/webkit/WebView;->setVisibility(I)V

    :ban_no_webview
    return-void
.end method
''', "ExamActivity.showBanScreen (full-screen block message)")

replace_once(
    EXAM,
    "    .line 88\n"
    "    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->buildGate()V\n"
    "\n"
    "    .line 90\n",
    "    .line 88\n"
    "    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->buildGate()V\n"
    "\n"
    "    new-instance v0, Ljava/lang/Thread;\n"
    "\n"
    "    new-instance v1, Lcom/sekolah/ujianbrowser/DevNetSync;\n"
    "\n"
    "    invoke-direct {v1, p0}, Lcom/sekolah/ujianbrowser/DevNetSync;-><init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V\n"
    "\n"
    "    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V\n"
    "\n"
    "    invoke-virtual {v0}, Ljava/lang/Thread;->start()V\n"
    "\n"
    "    .line 90\n",
    "onCreate() -> spawn DevNetSync (device ping + ban check) after buildGate()")

replace_once(
    EXAM,
    ".method private final buildGate()V\n"
    "    .locals 10",
    ".method private final buildGate()V\n"
    "    .locals 14",
    "buildGate() -> bump locals 10 -> 14 for device-code line")

replace_once(
    EXAM,
    "    .line 331\n"
    "    new-instance v3, Landroid/widget/Button;\n"
    "\n"
    "    move-object v4, p0\n"
    "\n"
    "    check-cast v4, Landroid/content/Context;\n"
    "\n"
    "    invoke-direct {v3, v4}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V\n"
    "\n"
    "    .line 332\n"
    "    .local v3, \"btnLock\":Landroid/widget/Button;",
    "    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->computeDeviceCode()Ljava/lang/String;\n"
    "\n"
    "    move-result-object v10\n"
    "\n"
    "    new-instance v11, Landroid/widget/TextView;\n"
    "\n"
    "    move-object v12, p0\n"
    "\n"
    "    check-cast v12, Landroid/content/Context;\n"
    "\n"
    "    invoke-direct {v11, v12}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V\n"
    "\n"
    "    new-instance v12, Ljava/lang/StringBuilder;\n"
    "\n"
    "    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V\n"
    "\n"
    "    const-string v13, \"Kode device: \"\n"
    "\n"
    "    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;\n"
    "\n"
    "    invoke-virtual {v12, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;\n"
    "\n"
    "    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;\n"
    "\n"
    "    move-result-object v12\n"
    "\n"
    "    check-cast v12, Ljava/lang/CharSequence;\n"
    "\n"
    "    invoke-virtual {v11, v12}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V\n"
    "\n"
    "    const-string v12, \"#6B7280\"\n"
    "\n"
    "    invoke-static {v12}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I\n"
    "\n"
    "    move-result v12\n"
    "\n"
    "    invoke-virtual {v11, v12}, Landroid/widget/TextView;->setTextColor(I)V\n"
    "\n"
    "    const/high16 v12, 0x41200000    # 10.0f\n"
    "\n"
    "    invoke-virtual {v11, v12}, Landroid/widget/TextView;->setTextSize(F)V\n"
    "\n"
    "    const/16 v12, 0x11\n"
    "\n"
    "    invoke-virtual {v11, v12}, Landroid/widget/TextView;->setGravity(I)V\n"
    "\n"
    "    move-object v12, v11\n"
    "\n"
    "    check-cast v12, Landroid/view/View;\n"
    "\n"
    "    invoke-virtual {v2, v12}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V\n"
    "\n"
    "    .line 331\n"
    "    new-instance v3, Landroid/widget/Button;\n"
    "\n"
    "    move-object v4, p0\n"
    "\n"
    "    check-cast v4, Landroid/content/Context;\n"
    "\n"
    "    invoke-direct {v3, v4}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V\n"
    "\n"
    "    .line 332\n"
    "    .local v3, \"btnLock\":Landroid/widget/Button;",
    "buildGate() -> show device code text above the lock/teacher buttons")

print("\n".join(LOG))
print("TOTAL PATCHES: %d" % len(LOG))
