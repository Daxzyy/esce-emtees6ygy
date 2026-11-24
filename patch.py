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


def replace_method(path, old_sig, new_sig, text, tag):
    src = read(path)
    if new_sig in src:
        LOG.append("SKIP already applied: %s" % tag)
        return
    lines = src.split("\n")
    if old_sig not in lines:
        ensure_method(path, new_sig, text, tag)
        return
    start, end = _span(lines, old_sig)
    write(path, "\n".join(lines[:start] + text.rstrip("\n").split("\n") + lines[end + 1:]))
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

PKG = "smali_classes3/com/sekolah/ujianbrowser/"
BASE_URL = "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app/"
DEFAULT_BAN = "Akses aplikasi dinonaktifkan karena alasan tertentu. Hubungi admin untuk informasi lebih lanjut."
CHIP_TABLE = (";SM8750=Snapdragon 8 Elite;SM8650=Snapdragon 8 Gen 3;SM8550=Snapdragon 8 Gen 2;"
              "SM8475=Snapdragon 8+ Gen 1;SM8450=Snapdragon 8 Gen 1;SM8350=Snapdragon 888;"
              "SM8150=Snapdragon 855;SM7550=Snapdragon 7 Gen 3;SM7475=Snapdragon 7+ Gen 2;"
              "SM7450=Snapdragon 7 Gen 1;SM6450=Snapdragon 6 Gen 1;SM6375=Snapdragon 695 5G;"
              "SM6350=Snapdragon 690 5G;SM6225=Snapdragon 680 4G;SM6115=Snapdragon 662;"
              "SM4350=Snapdragon 480 5G;MT6989=Dimensity 9300;MT6985=Dimensity 9200;"
              "GS101=Google Tensor;GS201=Google Tensor G2;S5E9945=Exynos 2400;"
              "S5E9925=Exynos 2200;S5E9840=Exynos 2100;")

DEV_NET_SMALI = r'''.class public final Lcom/sekolah/ujianbrowser/DevNet;
.super Ljava/lang/Object;
.source "DevNet.kt"


.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final url(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@BASE@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final http(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/net/URL;

    invoke-direct {v1, p1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;

    move-object v0, v1

    invoke-virtual {v0, p0}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    const/16 v2, 0x1f40

    invoke-virtual {v0, v2}, Ljava/net/URLConnection;->setConnectTimeout(I)V

    invoke-virtual {v0, v2}, Ljava/net/URLConnection;->setReadTimeout(I)V

    if-eqz p2, :no_body

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/net/URLConnection;->setDoOutput(Z)V

    const-string v2, "Content-Type"

    const-string v3, "application/json; charset=utf-8"

    invoke-virtual {v0, v2, v3}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    const-string v3, "UTF-8"

    invoke-virtual {p2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    :no_body
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v2

    const/16 v3, 0xc8

    if-lt v2, v3, :fail

    const/16 v3, 0x12c

    if-ge v2, v3, :fail

    invoke-virtual {v0}, Ljava/net/URLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v4, 0x400

    new-array v4, v4, [B

    :read_loop
    invoke-virtual {v2, v4}, Ljava/io/InputStream;->read([B)I

    move-result v5

    if-ltz v5, :read_done

    const/4 v6, 0x0

    invoke-virtual {v3, v4, v6, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :read_loop

    :read_done
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    const-string v2, "UTF-8"

    invoke-virtual {v3, v2}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    return-object v2

    :fail
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    const/4 v2, 0x0

    return-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v2, 0x0

    return-object v2
.end method

.method public static final nz(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    if-nez p0, :nz_have

    const-string v0, "Tidak diketahui"

    return-object v0

    :nz_have
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :nz_ok

    const-string v0, "Tidak diketahui"

    :nz_ok
    return-object v0
.end method

.method private static final ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p2}, Lcom/sekolah/ujianbrowser/DevNet;->nz(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static final pl(Lorg/json/JSONObject;Ljava/lang/String;J)V
    .locals 0

    :try_start_0
    invoke-virtual {p0, p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static final lookup(Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    if-nez p0, :lk_have

    const/4 v0, 0x0

    return-object v0

    :lk_have
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ";"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "@TABLE@"

    invoke-virtual {v3, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-ltz v4, :lk_none

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v4, v0

    invoke-virtual {v3, v2, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v0

    if-ltz v0, :lk_none

    invoke-virtual {v3, v4, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :lk_none
    const/4 v0, 0x0

    return-object v0
.end method

.method public static final chipset(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-eqz p0, :cs_hw

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cs_hw

    const-string v0, " "

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cs_code

    return-object p0

    :cs_code
    invoke-static {p0}, Lcom/sekolah/ujianbrowser/DevNet;->lookup(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cs_hw

    return-object v0

    :cs_hw
    invoke-static {p1}, Lcom/sekolah/ujianbrowser/DevNet;->lookup(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cs_unknown

    return-object v0

    :cs_unknown
    const-string v0, "Tidak diketahui"

    return-object v0
.end method

.method public static final buildSpecs(Landroid/content/Context;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 10

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "deviceCode"

    invoke-static {v0, v1, p1}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "model"

    sget-object v2, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "manufacturer"

    sget-object v2, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v3, 0x0

    const/4 v4, 0x0

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1f

    if-lt v5, v6, :no_soc

    sget-object v3, Landroid/os/Build;->SOC_MODEL:Ljava/lang/String;

    sget-object v4, Landroid/os/Build;->SOC_MANUFACTURER:Ljava/lang/String;

    :no_soc
    sget-object v7, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-static {v3, v7}, Lcom/sekolah/ujianbrowser/DevNet;->chipset(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v1, "chipset"

    invoke-static {v0, v1, v8}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "socModel"

    invoke-static {v0, v1, v3}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "socManufacturer"

    invoke-static {v0, v1, v4}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "hardware"

    invoke-static {v0, v1, v7}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    sget-object v3, Landroid/os/Build;->SUPPORTED_ABIS:[Ljava/lang/String;

    if-eqz v3, :abi_done

    array-length v4, v3

    const/4 v5, 0x0

    :abi_loop
    if-ge v5, v4, :abi_done

    aget-object v6, v3, v5

    invoke-virtual {v2, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v5, v5, 0x1

    goto :abi_loop

    :abi_done
    const-string v1, "supportedAbis"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "androidVersion"

    sget-object v2, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/DevNet;->ps(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "sdkInt"

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    int-to-long v2, v2

    invoke-static {v0, v1, v2, v3}, Lcom/sekolah/ujianbrowser/DevNet;->pl(Lorg/json/JSONObject;Ljava/lang/String;J)V

    const-string v1, "activity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager;

    new-instance v2, Landroid/app/ActivityManager$MemoryInfo;

    invoke-direct {v2}, Landroid/app/ActivityManager$MemoryInfo;-><init>()V

    invoke-virtual {v1, v2}, Landroid/app/ActivityManager;->getMemoryInfo(Landroid/app/ActivityManager$MemoryInfo;)V

    iget-wide v3, v2, Landroid/app/ActivityManager$MemoryInfo;->totalMem:J

    const-wide/32 v5, 0x100000

    div-long/2addr v3, v5

    const-string v1, "totalRamMB"

    invoke-static {v0, v1, v3, v4}, Lcom/sekolah/ujianbrowser/DevNet;->pl(Lorg/json/JSONObject;Ljava/lang/String;J)V

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Landroid/os/StatFs;

    invoke-direct {v2, v1}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Landroid/os/StatFs;->getTotalBytes()J

    move-result-wide v3

    const-wide/32 v5, 0x3b9aca00

    div-long/2addr v3, v5

    const-wide/16 v5, 0x1

    :st_loop
    cmp-long v7, v5, v3

    if-gez v7, :st_done

    const/4 v7, 0x1

    shl-long/2addr v5, v7

    goto :st_loop

    :st_done
    const-string v1, "totalStorageGB"

    invoke-static {v0, v1, v5, v6}, Lcom/sekolah/ujianbrowser/DevNet;->pl(Lorg/json/JSONObject;Ljava/lang/String;J)V

    const-string v1, "lastSeen"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Lcom/sekolah/ujianbrowser/DevNet;->pl(Lorg/json/JSONObject;Ljava/lang/String;J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object v0
.end method

.method public static final pushSpecs(Landroid/content/Context;Ljava/lang/String;)V
    .locals 7

    const-string v0, "devices/"

    const-string v1, "/firstSeen.json"

    invoke-static {v0, p1, v1}, Lcom/sekolah/ujianbrowser/DevNet;->url(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "GET"

    const/4 v4, 0x0

    invoke-static {v3, v2, v4}, Lcom/sekolah/ujianbrowser/DevNet;->http(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, p1}, Lcom/sekolah/ujianbrowser/DevNet;->buildSpecs(Landroid/content/Context;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    if-eqz v2, :ps_send

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v4, "null"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :ps_send

    const-string v4, "firstSeen"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-static {v3, v4, v5, v6}, Lcom/sekolah/ujianbrowser/DevNet;->pl(Lorg/json/JSONObject;Ljava/lang/String;J)V

    :ps_send
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v1, ".json?x-http-method-override=PATCH"

    invoke-static {v0, p1, v1}, Lcom/sekolah/ujianbrowser/DevNet;->url(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "POST"

    invoke-static {v1, v0, v3}, Lcom/sekolah/ujianbrowser/DevNet;->http(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method public static final banMessage(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    if-nez p0, :bm_have

    const/4 v0, 0x0

    return-object v0

    :bm_have
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    const-string v0, "true"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :bm_notbool

    const-string v0, "@DEFAULT@"

    return-object v0

    :bm_notbool
    const-string v0, "{"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :bm_obj

    const/4 v0, 0x0

    return-object v0

    :bm_obj
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v1, "banned"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-nez v2, :bm_yes

    const/4 v0, 0x0

    return-object v0

    :bm_yes
    const-string v1, "message"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :bm_nonempty

    const-string v0, "@DEFAULT@"

    return-object v0

    :bm_nonempty
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0x1f4

    if-le v1, v2, :bm_done

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    :bm_done
    return-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static final checkBan(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    const-string v0, "banned/"

    const-string v1, ".json"

    invoke-static {v0, p0, v1}, Lcom/sekolah/ujianbrowser/DevNet;->url(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "GET"

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Lcom/sekolah/ujianbrowser/DevNet;->http(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/sekolah/ujianbrowser/DevNet;->banMessage(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
'''

DEV_NET_UI_SMALI = r'''
.method public static final dp(Landroid/content/Context;I)I
    .locals 3

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    int-to-float v1, p1

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f000000

    add-float/2addr v0, v1

    float-to-int v0, v0

    return v0
.end method

.method public static final lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;
    .locals 4

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x2

    invoke-direct {v0, p1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-static {p0, p2}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v2, v3, v3}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    return-object v0
.end method

.method public static final tv(Landroid/content/Context;Ljava/lang/String;FLjava/lang/String;Z)Landroid/widget/TextView;
    .locals 3

    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextSize(F)V

    invoke-static {p3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    if-eqz p4, :tv_plain

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    :tv_plain
    return-object v0
.end method

.method public static final buildBanView(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)Landroid/view/View;
    .locals 10

    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setClickable(Z)V

    const-string v1, "#1A0B0B"

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/16 v2, 0x18

    invoke-static {p0, v2}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v3

    const/16 v2, 0x20

    invoke-static {p0, v2}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v4

    invoke-virtual {v1, v3, v4, v3, v4}, Landroid/view/View;->setPadding(IIII)V

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    mul-int/lit8 v5, v3, 0x2

    sub-int/2addr v2, v5

    const/16 v5, 0x230

    invoke-static {p0, v5}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v5

    invoke-static {v2, v5}, Ljava/lang/Math;->min(II)I

    move-result v2

    const-string v5, "\u26d4"

    const/high16 v6, 0x42600000

    const-string v7, "#F87171"

    const/4 v8, 0x0

    invoke-static {p0, v5, v6, v7, v8}, Lcom/sekolah/ujianbrowser/DevNet;->tv(Landroid/content/Context;Ljava/lang/String;FLjava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {p0, v2, v6}, Lcom/sekolah/ujianbrowser/DevNet;->lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const-string v5, "AKSES DINONAKTIFKAN"

    const/high16 v6, 0x41400000

    const-string v7, "#FCA5A5"

    const/4 v8, 0x1

    invoke-static {p0, v5, v6, v7, v8}, Lcom/sekolah/ujianbrowser/DevNet;->tv(Landroid/content/Context;Ljava/lang/String;FLjava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v5

    const v6, 0x3e19999a

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setLetterSpacing(F)V

    new-instance v6, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v6}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const-string v7, "#3B1010"

    invoke-static {v7}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/16 v7, 0x14

    invoke-static {p0, v7}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v7

    int-to-float v7, v7

    invoke-virtual {v6, v7}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v5, v6}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/16 v6, 0x10

    invoke-static {p0, v6}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v6

    const/16 v7, 0x8

    invoke-static {p0, v7}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v7

    invoke-virtual {v5, v6, v7, v6, v7}, Landroid/view/View;->setPadding(IIII)V

    const/4 v6, -0x2

    const/16 v7, 0x10

    invoke-static {p0, v6, v7}, Lcom/sekolah/ujianbrowser/DevNet;->lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const-string v5, "Aplikasi Tidak Dapat Digunakan"

    const/high16 v6, 0x41e00000

    const-string v7, "#FFFFFF"

    const/4 v8, 0x1

    invoke-static {p0, v5, v6, v7, v8}, Lcom/sekolah/ujianbrowser/DevNet;->tv(Landroid/content/Context;Ljava/lang/String;FLjava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v5

    const/16 v6, 0x10

    invoke-static {p0, v2, v6}, Lcom/sekolah/ujianbrowser/DevNet;->lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const/high16 v6, 0x41800000

    const-string v7, "#F3F4F6"

    const/4 v8, 0x0

    invoke-static {p0, p1, v6, v7, v8}, Lcom/sekolah/ujianbrowser/DevNet;->tv(Landroid/content/Context;Ljava/lang/String;FLjava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v5

    const/4 v6, 0x3

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setGravity(I)V

    const/4 v6, 0x0

    const v7, 0x3fa66666

    invoke-virtual {v5, v6, v7}, Landroid/widget/TextView;->setLineSpacing(FF)V

    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextIsSelectable(Z)V

    new-instance v6, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v6}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const-string v7, "#2B1515"

    invoke-static {v7}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/16 v7, 0x10

    invoke-static {p0, v7}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v7

    int-to-float v7, v7

    invoke-virtual {v6, v7}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const/4 v7, 0x1

    invoke-static {p0, v7}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v7

    const-string v8, "#7F1D1D"

    invoke-static {v8}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v8

    invoke-virtual {v6, v7, v8}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-virtual {v5, v6}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/16 v6, 0x14

    invoke-static {p0, v6}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v6

    invoke-virtual {v5, v6, v6, v6, v6}, Landroid/view/View;->setPadding(IIII)V

    const/16 v6, 0x18

    invoke-static {p0, v2, v6}, Lcom/sekolah/ujianbrowser/DevNet;->lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const-string v5, "Hubungi admin untuk mengaktifkan kembali akses."

    const/high16 v6, 0x41600000

    const-string v7, "#D1D5DB"

    const/4 v8, 0x0

    invoke-static {p0, v5, v6, v7, v8}, Lcom/sekolah/ujianbrowser/DevNet;->tv(Landroid/content/Context;Ljava/lang/String;FLjava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v5

    const/16 v6, 0x14

    invoke-static {p0, v2, v6}, Lcom/sekolah/ujianbrowser/DevNet;->lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Kode perangkat: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41400000

    const-string v7, "#9CA3AF"

    const/4 v8, 0x0

    invoke-static {p0, v5, v6, v7, v8}, Lcom/sekolah/ujianbrowser/DevNet;->tv(Landroid/content/Context;Ljava/lang/String;FLjava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v5

    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextIsSelectable(Z)V

    const/16 v6, 0x8

    invoke-static {p0, v2, v6}, Lcom/sekolah/ujianbrowser/DevNet;->lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v5, Landroid/widget/Button;

    invoke-direct {v5, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    const-string v6, "Tutup Aplikasi"

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setAllCaps(Z)V

    const/high16 v6, 0x41700000

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextSize(F)V

    const/4 v6, -0x1

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextColor(I)V

    const/4 v6, 0x0

    const/4 v7, 0x1

    invoke-virtual {v5, v6, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    new-instance v6, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v6}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const-string v7, "#B91C1C"

    invoke-static {v7}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/16 v7, 0xc

    invoke-static {p0, v7}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v7

    int-to-float v7, v7

    invoke-virtual {v6, v7}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v5, v6}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/16 v6, 0x14

    invoke-static {p0, v6}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v6

    const/16 v7, 0xc

    invoke-static {p0, v7}, Lcom/sekolah/ujianbrowser/DevNet;->dp(Landroid/content/Context;I)I

    move-result v7

    invoke-virtual {v5, v6, v7, v6, v7}, Landroid/view/View;->setPadding(IIII)V

    new-instance v6, Lcom/sekolah/ujianbrowser/DevExitClick;

    invoke-direct {v6, p0}, Lcom/sekolah/ujianbrowser/DevExitClick;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v5, v6}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/16 v6, 0x1c

    invoke-static {p0, v2, v6}, Lcom/sekolah/ujianbrowser/DevNet;->lp(Landroid/content/Context;II)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v0
.end method
'''

DEV_NET_SYNC_SMALI = r'''.class public final Lcom/sekolah/ujianbrowser/DevNetSync;
.super Ljava/lang/Object;
.source "DevNetSync.kt"

.implements Ljava/lang/Runnable;


.field private final activity:Lcom/sekolah/ujianbrowser/ExamActivity;


.method public constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevNetSync;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    return-void
.end method

.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevNetSync;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-virtual {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->computeDeviceCode()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v3, Lcom/sekolah/ujianbrowser/DevToastRunnable;

    invoke-direct {v3, v0}, Lcom/sekolah/ujianbrowser/DevToastRunnable;-><init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :try_start_0
    move-object v3, v0

    check-cast v3, Landroid/content/Context;

    invoke-static {v3, v1}, Lcom/sekolah/ujianbrowser/DevNet;->pushSpecs(Landroid/content/Context;Ljava/lang/String;)V

    invoke-static {v1}, Lcom/sekolah/ujianbrowser/DevNet;->checkBan(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :sync_done

    new-instance v4, Lcom/sekolah/ujianbrowser/DevBanRunnable;

    invoke-direct {v4, v0, v3}, Lcom/sekolah/ujianbrowser/DevBanRunnable;-><init>(Lcom/sekolah/ujianbrowser/ExamActivity;Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :sync_done
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
'''

DEV_BAN_RUNNABLE_SMALI = r'''.class public final Lcom/sekolah/ujianbrowser/DevBanRunnable;
.super Ljava/lang/Object;
.source "DevBanRunnable.kt"

.implements Ljava/lang/Runnable;


.field private final activity:Lcom/sekolah/ujianbrowser/ExamActivity;

.field private final message:Ljava/lang/String;


.method public constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevBanRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    iput-object p2, p0, Lcom/sekolah/ujianbrowser/DevBanRunnable;->message:Ljava/lang/String;

    return-void
.end method

.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevBanRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/DevBanRunnable;->message:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/ExamActivity;->showBanScreen(Ljava/lang/String;)V

    return-void
.end method
'''

DEV_TOAST_RUNNABLE_SMALI = r'''.class public final Lcom/sekolah/ujianbrowser/DevToastRunnable;
.super Ljava/lang/Object;
.source "DevToastRunnable.kt"

.implements Ljava/lang/Runnable;


.field private final activity:Lcom/sekolah/ujianbrowser/ExamActivity;


.method public constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevToastRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    return-void
.end method

.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevToastRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    :try_start_0
    const-string v1, "Spesifikasi perangkat (model, chipset, RAM, penyimpanan) dikirim ke Firebase untuk pengelolaan akses aplikasi."

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
'''

DEV_EXIT_CLICK_SMALI = r'''.class public final Lcom/sekolah/ujianbrowser/DevExitClick;
.super Ljava/lang/Object;
.source "DevExitClick.kt"

.implements Landroid/view/View$OnClickListener;


.field private final activity:Landroid/app/Activity;


.method public constructor <init>(Landroid/app/Activity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevExitClick;->activity:Landroid/app/Activity;

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevExitClick;->activity:Landroid/app/Activity;

    :try_start_0
    invoke-virtual {v0}, Landroid/app/Activity;->stopLockTask()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    return-void
.end method
'''

SHOW_BAN_SCREEN_SMALI = r'''.method public final showBanScreen(Ljava/lang/String;)V
    .locals 3

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->computeDeviceCode()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/sekolah/ujianbrowser/DevNet;->buildBanView(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    const/4 v1, -0x1

    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v2, v1, v1}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0, v2}, Lcom/sekolah/ujianbrowser/ExamActivity;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->webView:Landroid/webkit/WebView;

    if-eqz v1, :ban_no_webview

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setVisibility(I)V

    :ban_no_webview
    return-void
.end method
'''

dev_net_full = (DEV_NET_SMALI.replace("@BASE@", BASE_URL)
                .replace("@TABLE@", CHIP_TABLE)
                .replace("@DEFAULT@", DEFAULT_BAN)
                .rstrip("\n") + "\n" + DEV_NET_UI_SMALI)

write_file(os.path.join(ROOT, PKG + "DevNet.smali"), dev_net_full,
           "DevNet.smali (device specs, PATCH sync, ban parsing, ban screen UI)")
write_file(os.path.join(ROOT, PKG + "DevNetSync.smali"), DEV_NET_SYNC_SMALI,
           "DevNetSync.smali (background: specs PATCH + ban check)")
write_file(os.path.join(ROOT, PKG + "DevBanRunnable.smali"), DEV_BAN_RUNNABLE_SMALI,
           "DevBanRunnable.smali (carries custom ban message)")
write_file(os.path.join(ROOT, PKG + "DevToastRunnable.smali"), DEV_TOAST_RUNNABLE_SMALI,
           "DevToastRunnable.smali (tells the user specs are sent to Firebase)")
write_file(os.path.join(ROOT, PKG + "DevExitClick.smali"), DEV_EXIT_CLICK_SMALI,
           "DevExitClick.smali (exit button on ban screen, releases lock task)")

replace_method(EXAM, ".method public final showBanScreen()V",
               ".method public final showBanScreen(Ljava/lang/String;)V",
               SHOW_BAN_SCREEN_SMALI,
               "ExamActivity.showBanScreen(String) -> professional ban screen with custom message")

print("\n".join(LOG))
print("TOTAL PATCHES: %d" % len(LOG))
