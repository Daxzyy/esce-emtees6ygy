#!/usr/bin/env python3
"""Development-build patcher for com.sekolah.ujianbrowser (exam-beta.apk).

Disables kiosk / anti-cheat device restrictions while leaving WebView,
QR scanner and all non-restriction features untouched.
"""
import os

ROOT = os.environ.get("PATCH_ROOT", "/tmp/opencode/apkwork/decoded")
LOG = []


def read(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


def write(path, data):
    with open(path, "w", encoding="utf-8") as f:
        f.write(data)


def replace_once(path, old, new, tag):
    src = read(path)
    n = src.count(old)
    if n == 0 and new in src:
        LOG.append("SKIP already applied: %s" % tag)
        return
    if n != 1:
        raise SystemExit("EXPECTED 1 OCCURRENCE, GOT %d: %s" % (n, tag))
    write(path, src.replace(old, new, 1))
    LOG.append("OK  %s" % tag)


def replace_method(path, signature, new_body_lines, tag):
    """Replace everything between `.method <signature>` and `.end method`."""
    lines = read(path).split("\n")
    start = None
    for i, ln in enumerate(lines):
        if ln == signature:
            start = i
            break
    if start is None:
        raise SystemExit("SIGNATURE NOT FOUND: %s" % signature)
    end = None
    for j in range(start + 1, len(lines)):
        if lines[j] == ".end method":
            end = j
            break
    if end is None:
        raise SystemExit("END METHOD NOT FOUND: %s" % signature)

    current = lines[start + 1:end]
    if current == new_body_lines:
        LOG.append("SKIP already applied: %s" % tag)
        return

    new_lines = lines[:start + 1] + new_body_lines + lines[end:]
    write(path, "\n".join(new_lines))
    LOG.append("OK  %s" % tag)


def noop(locals_n=0):
    body = ["    .locals %d" % locals_n, "", "    return-void"]
    return body


# --------------------------------------------------------------- ExamActivity
EXAM = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity.smali")

replace_method(
    EXAM, ".method private final enterLockMode()V", noop(),
    "enterLockMode() -> no-op (no startLockTask / setLockTaskPackages / setLockTaskFeatures)")

replace_method(EXAM, ".method private final hideSystemBars()V", [
    "    .locals 3",
    "",
    "    new-instance v0, Landroidx/core/view/WindowInsetsControllerCompat;",
    "",
    "    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->getWindow()Landroid/view/Window;",
    "",
    "    move-result-object v1",
    "",
    "    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->getWindow()Landroid/view/Window;",
    "",
    "    move-result-object v2",
    "",
    "    invoke-virtual {v2}, Landroid/view/Window;->getDecorView()Landroid/view/View;",
    "",
    "    move-result-object v2",
    "",
    "    invoke-direct {v0, v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;-><init>(Landroid/view/Window;Landroid/view/View;)V",
    "",
    "    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I",
    "",
    "    move-result v1",
    "",
    "    invoke-virtual {v0, v1}, Landroidx/core/view/WindowInsetsControllerCompat;->show(I)V",
    "",
    "    return-void",
], "hideSystemBars() -> show system bars instead of hiding them")

replace_method(
    EXAM, ".method private final triggerIfLeaving()V", noop(),
    "triggerIfLeaving() -> no-op (no leave-app detection)")

replace_method(
    EXAM, ".method private final startAlarm()V", noop(),
    "startAlarm() -> no-op (no siren / violation counter)")

replace_method(
    EXAM, ".method private final forceSoundOn()V", noop(),
    "forceSoundOn() -> no-op (volume + DND untouched)")

replace_method(
    EXAM, ".method private final startVibration()V", noop(),
    "startVibration() -> no-op (no forced vibration)")

replace_method(
    EXAM, ".method private final playSiren()V", noop(),
    "playSiren() -> no-op (no siren tone)")

replace_once(
    EXAM,
    "    const/16 v1, 0x2080\n\n    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V",
    "    const/16 v1, 0x80\n\n    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V",
    "onCreate window flags 0x2080 -> 0x80 (FLAG_SECURE removed, FLAG_KEEP_SCREEN_ON kept)")

# ------------------------------------------------------- OnBackPressedCallback
BACK = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$onCreate$1.smali")
replace_once(
    BACK,
    "    const/4 v0, 0x1\n\n    invoke-direct {p0, v0}, Landroidx/activity/OnBackPressedCallback;-><init>(Z)V",
    "    const/4 v0, 0x0\n\n    invoke-direct {p0, v0}, Landroidx/activity/OnBackPressedCallback;-><init>(Z)V",
    "OnBackPressedCallback enabled true -> false (Back uses Android default = finish)")

# ------------------------------------------------------------------- armCheck
ARM = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$armCheck$1.smali")
replace_method(
    ARM, ".method public run()V", noop(),
    "armCheck.run() -> no-op (never arms the violation detector)")

# -------------------------------------------------------------------- ExamLock
LOCK = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamLock.smali")
replace_method(
    LOCK, ".method public final remainingMs(Landroid/content/Context;)J",
    ["    .locals 2", "", "    const-wide/16 v0, 0x0", "", "    return-wide v0"],
    "ExamLock.remainingMs() -> always 0 (60-minute exam lock timer removed)")

# -------------------------------------------------------------------- AdminCode
ADMIN = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/AdminCode.smali")
replace_method(
    ADMIN, ".method public final lockedMs(Landroid/content/Context;)J",
    ["    .locals 2", "", "    const-wide/16 v0, 0x0", "", "    return-wide v0"],
    "AdminCode.lockedMs() -> always 0 (admin lockout timer removed)")

replace_method(
    ADMIN, ".method public final verify(Landroid/content/Context;Ljava/lang/String;Z)Z",
    ["    .locals 1", "", "    const/4 v0, 0x1", "", "    return v0"],
    "AdminCode.verify() -> always true (exit gate removed)")

# ----------------------------------------------------- v3 gate + lock watchdog
# v3 (versionCode 3) added an overlay gate that hides the WebView whenever lock
# task is not active. Both the gate builder and its 700ms watchdog must go.
if os.path.exists(EXAM):
    if ".method private final buildGate()V" in read(EXAM):
        replace_method(EXAM, ".method private final buildGate()V", noop(),
                       "buildGate() -> no-op (gate overlay never built, WebView stays visible)")
    else:
        LOG.append("SKIP buildGate() (not present in this version)")

LOCKWATCH = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity$lockWatch$1.smali")
if os.path.exists(LOCKWATCH):
    replace_method(LOCKWATCH, ".method public run()V", noop(),
                   "lockWatch.run() -> no-op (lock-task watchdog never hides WebView)")
else:
    LOG.append("SKIP lockWatch (not present in this version)")

print("\n".join(LOG))
print("TOTAL PATCHES: %d" % len(LOG))
