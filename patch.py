#!/usr/bin/env python3
"""Development-build patcher for com.sekolah.ujianbrowser (exam-beta.apk)."""
import os

ROOT = os.environ.get("PATCH_ROOT", "/tmp/opencode/apkwork/decoded")
LOG = []

EXAM = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ExamActivity.smali")
CHIPSET = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/ChipsetKt.smali")
DEVMODE = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/DevMode.smali")
DEVNET = os.path.join(ROOT, "smali_classes3/com/sekolah/ujianbrowser/DevNetSync.smali")


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


def ensure_fields(path, fields, tag):
    src = read(path)
    if fields[0] in src:
        LOG.append("SKIP already applied: %s" % tag)
        return
    write(path, src + "\n" + "\n".join(fields) + "\n")
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


# ==========================================================================
# PART A: chipset map + ChipsetKt
# ==========================================================================
CHIPMAP_Q = {
    "SM4350": "Snapdragon 480", "SM4450": "Snapdragon 4 Gen 1", "SM4550": "Snapdragon 4 Gen 2",
    "SM6150": "Dimensity 675", "SM6225": "Dimensity 680", "SM6375": "Dimensity 695",
    "SM6450": "Dimensity 6 Gen 1", "SM7150": "Snapdragon 730", "SM7150-AC": "Snapdragon 730G",
    "SM7325": "Snapdragon 778G", "SM7350": "Snapdragon 780G", "SM7450": "Snapdragon 7 Gen 1",
    "SM7475": "Snapdragon 7+ Gen 2", "SM7675": "Snapdragon 7 Gen 3", "SM8150": "Snapdragon 855",
    "SM8150-AC": "Snapdragon 855+", "SM8150-AD": "Snapdragon 860", "SM8250": "Snapdragon 865",
    "SM8250-AB": "Snapdragon 865+", "SM8250-AC": "Snapdragon 870", "SM8350": "Snapdragon 888",
    "SM8350-AC": "Snapdragon 888+", "SM8450": "Snapdragon 8 Gen 1", "SM8475": "Snapdragon 8+ Gen 1",
    "SM8550": "Snapdragon 8 Gen 2", "SM8550-AC": "Snapdragon 8 Gen 2 for Galaxy",
    "SM8650": "Snapdragon 8 Gen 3", "SM8650-AC": "Snapdragon 8 Gen 3 for Galaxy",
    "SM8635": "Snapdragon 8s Gen 3", "SM8750": "Snapdragon 8 Elite", "SM8735": "Snapdragon 8s Gen 4",
    "SM8845": "Snapdragon 8 Gen 5", "SM8850": "Snapdragon 8 Elite Gen 5",
}
CHIPMAP_MEDIATEK = {
    "MT6993": "Dimensity 9500", "MT6991": "Dimensity 9400", "MT6989": "Dimensity 9300",
    "MT6985": "Dimensity 9200", "MT6983": "Dimensity 9000", "MT6899": "Dimensity 8400",
    "MT6897": "Dimensity 8300", "MT6896": "Dimensity 8200", "MT6895Z": "Dimensity 8100",
    "MT6893": "Dimensity 1200", "MT6891": "Dimensity 1100", "MT6889": "Dimensity 1000+",
    "MT6886": "Dimensity 7200", "MT6879": "Dimensity 7030", "MT6878": "Dimensity 7300",
    "MT6877": "Dimensity 900", "MT6875": "Dimensity 820", "MT6873": "Dimensity 800",
    "MT6833": "Dimensity 700",
}
CHIPMAP_SAMSUNG = {
    "S5E9945": "Exynos 2400", "S5E9955": "Exynos 2500", "S5E9965": "Exynos 2600",
    "S5E9925": "Exynos 2200", "S5E9840": "Exynos 2100", "S5E9830": "Exynos 990",
    "S5E9815": "Exynos 1080", "S5E9810": "Exynos 9810", "S5E9820": "Exynos 9820",
    "S5E9825": "Exynos 9825", "S5E9630": "Exynos 980", "S5E9610": "Exynos 9610",
    "S5E9611": "Exynos 9611", "S5E8895": "Exynos 8895", "S5E8825": "Exynos 1280",
    "S5E8535": "Exynos 1330", "S5E8835": "Exynos 1380", "S5E8845": "Exynos 1480",
    "S5E8855": "Exynos 1580", "S5E7570": "Exynos 7570",
}
CHIPMAP_TENSOR = {
    "S5P9845": "Tensor G1", "S5P9855": "Tensor G2", "S5P9865": "Tensor G3", "S5P9875": "Tensor G4",
}
CHIPMAP_UNISOC = {
    "UMS9230": "Tiger T606", "UMS9230H": "Tiger T612", "UMS9230E": "Tiger T615",
    "UMS9230T": "Tiger T616", "UMS9230S": "Tiger T620",
}
CHIPMAP_ALL = dict(CHIPMAP_Q)
CHIPMAP_ALL.update(CHIPMAP_MEDIATEK)
CHIPMAP_ALL.update(CHIPMAP_SAMSUNG)
CHIPMAP_ALL.update(CHIPMAP_TENSOR)
CHIPMAP_ALL.update(CHIPMAP_UNISOC)


def chipset_smali():
    L = []
    A = L.append
    A(".class public final Lcom/sekolah/ujianbrowser/ChipsetKt;")
    A(".super Ljava/lang/Object;")
    A('.source "ChipsetKt.kt"')
    A("")
    A("# static fields")
    A(".field private static final CHIPMAP:Ljava/util/HashMap;")
    A("")
    A("# static initializer")
    A(".method static constructor <clinit>()V")
    A("    .locals 3")
    A("")
    A("    new-instance v0, Ljava/util/HashMap;")
    A("")
    A("    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V")
    A("")
    A("    sput-object v0, Lcom/sekolah/ujianbrowser/ChipsetKt;->CHIPMAP:Ljava/util/HashMap;")
    A("")
    for k in sorted(CHIPMAP_ALL):
        A('    const-string v1, "%s"' % k.upper())
        A('    const-string v2, "%s"' % CHIPMAP_ALL[k])
        A("    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V")
    A("")
    A("    return-void")
    A(".end method")
    A("")
    A("# direct methods")
    A(".method public static final detectChipset(Landroid/content/Context;)Ljava/lang/String;")
    A("    .locals 6")
    A("    .param p0, \"ctx\"    # Landroid/content/Context;")
    A("")
    A("    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I")
    A("    const/4 v1, 0x0")
    A("    const/16 v2, 0x1f")
    A("    if-lt v0, v2, :dev_chip_def")
    A("    sget-object v3, Landroid/os/Build;->SOC_MODEL:Ljava/lang/String;")
    A("    if-eqz v3, :dev_chip_def")
    A("    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;")
    A("    move-result-object v3")
    A("    if-eqz v3, :dev_chip_def")
    A("    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;")
    A("    invoke-virtual {v3, v4}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;")
    A("    move-result-object v3")
    A("    sget-object v4, Lcom/sekolah/ujianbrowser/ChipsetKt;->CHIPMAP:Ljava/util/HashMap;")
    A("    invoke-virtual {v4, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;")
    A("    move-result-object v4")
    A("    if-eqz v4, :dev_chip_def")
    A("    return-object v4")
    A("    :dev_chip_def")
    A('    const-string v4, "Tidak diketahui"')
    A("    return-object v4")
    A(".end method")
    A("")
    A(".method public static final devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V")
    A("    .locals 0")
    A("    .param p0, \"map\"    # Ljava/util/HashMap;")
    A("    .param p1, \"k\"    # Ljava/lang/String;")
    A("    .param p2, \"v\"    # Ljava/lang/String;")
    A("    invoke-virtual {p0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;")
    A("    return-void")
    A(".end method")
    return "\n".join(L)


write_file(CHIPSET, chipset_smali(), "ChipsetKt.smali (chip maps + detectChipset)")

# ==========================================================================
# PART B: DevNetSync rewrite (device info POST + firstSeen + banned)
# ==========================================================================
DEVNET_SMALI = """\
.class public final Lcom/sekolah/ujianbrowser/DevNetSync;
.super Ljava/lang/Object;
.source "DevNetSync.kt"

.implements Ljava/lang/Runnable;

# instance fields
.field private final activity:Lcom/sekolah/ujianbrowser/ExamActivity;

# static fields
.field private static final BASE:Ljava/lang/String;

# static initializer
.method static constructor <clinit>()V
    .locals 1
    const-string v0, "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app"
    sput-object v0, Lcom/sekolah/ujianbrowser/DevNetSync;->BASE:Ljava/lang/String;
    return-void
.end method

# direct methods
.method public constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevNetSync;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;
    return-void
.end method

.method private static final getBytes(Ljava/lang/String;)[B
    .locals 1
    .param p0, "s"    # Ljava/lang/String;
    if-eqz p0, :devnet_gb_null
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B
    return-object v0
    :devnet_gb_null
    const/4 v0, 0x0
    return-object v0
.end method

.method private static final urlDevices(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "code"    # Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    sget-object v1, Lcom/sekolah/ujianbrowser/DevNetSync;->BASE:Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "/devices/"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    return-object v0
.end method

.method private static final urlFirstSeen(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "code"    # Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-static {p0}, Lcom/sekolah/ujianbrowser/DevNetSync;->urlDevices(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "/firstSeen.json"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    return-object v0
.end method

.method private static final urlBanned(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "code"    # Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-static {p0}, Lcom/sekolah/ujianbrowser/DevNetSync;->urlDevices(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "/banned/"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, ".json"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    return-object v0
.end method

.method private static final nowStr()Ljava/lang/String;
    .locals 1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;
    return-object v0
.end method

.method private static final readAll(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 2
    .param p0, "in"    # Ljava/io/InputStream;
    new-instance v0, Ljava/io/ByteArrayOutputStream;
    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V
    const/16 v1, 0x100
    new-array v1, v1, [B
    :devnet_ra_loop
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I
    move-result v2
    if-gtz v2, :devnet_ra_write
    goto :devnet_ra_done
    :devnet_ra_write
    const/4 v3, 0x0
    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    goto :devnet_ra_loop
    :devnet_ra_done
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;
    return-object v0
.end method

# virtual methods
.method public run()V
    .locals 12
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevNetSync;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;
    invoke-virtual {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->computeDeviceCode()Ljava/lang/String;
    move-result-object v1
    :try_start_0
    # ---- POST /devices/{code}.json?X-HTTP-Method-Override=PATCH (device info)
    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/ExamActivity;->devDeviceInfoJson()Ljava/lang/String;
    move-result-object v2
    invoke-static {v1}, Lcom/sekolah/ujianbrowser/DevNetSync;->urlDevices(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    new-instance v4, Ljava/net/URL;
    invoke-direct {v4, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;
    move-result-object v4
    check-cast v4, Ljava/net/HttpURLConnection;
    const-string v5, "POST"
    invoke-virtual {v4, v5}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V
    const/16 v5, 0x1388
    invoke-virtual {v4, v5}, Ljava/net/URLConnection;->setConnectTimeout(I)V
    invoke-virtual {v4, v5}, Ljava/net/URLConnection;->setReadTimeout(I)V
    const-string v5, "application/json; charset=utf-8"
    invoke-virtual {v4, v5}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2}, Lcom/sekolah/ujianbrowser/DevNetSync;->getBytes(Ljava/lang/String;)[B
    move-result-object v5
    invoke-virtual {v4, v5}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V
    invoke-virtual {v4}, Ljava/net/URLConnection;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v6
    invoke-virtual {v6, v5}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v6}, Ljava/io/OutputStream;->close()V
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getResponseCode()I
    move-result v5
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->disconnect()V
    # ---- GET firstSeen.json, PUT if absent
    invoke-static {v1}, Lcom/sekolah/ujianbrowser/DevNetSync;->urlFirstSeen(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v9
    new-instance v10, Ljava/net/URL;
    invoke-direct {v10, v9}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    invoke-virtual {v10}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;
    move-result-object v10
    check-cast v10, Ljava/net/HttpURLConnection;
    const-string v11, "GET"
    invoke-virtual {v10, v11}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V
    const/16 v11, 0x1388
    invoke-virtual {v10, v11}, Ljava/net/URLConnection;->setConnectTimeout(I)V
    invoke-virtual {v10, v11}, Ljava/net/URLConnection;->setReadTimeout(I)V
    invoke-virtual {v10}, Ljava/net/URLConnection;->getInputStream()Ljava/io/InputStream;
    move-result-object v11
    invoke-static {v11}, Lcom/sekolah/ujianbrowser/DevNetSync;->readAll(Ljava/io/InputStream;)Ljava/lang/String;
    move-result-object v12
    invoke-virtual {v10}, Ljava/net/HttpURLConnection;->disconnect()V
    const-string v11, "null"
    invoke-virtual {v12, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v11
    if-eqz v11, :devnet_fs_done
    invoke-static {v1}, Lcom/sekolah/ujianbrowser/DevNetSync;->urlFirstSeen(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    new-instance v4, Ljava/net/URL;
    invoke-direct {v4, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;
    move-result-object v4
    check-cast v4, Ljava/net/HttpURLConnection;
    const-string v5, "PUT"
    invoke-virtual {v4, v5}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V
    const/16 v5, 0x1388
    invoke-virtual {v4, v5}, Ljava/net/URLConnection;->setConnectTimeout(I)V
    invoke-virtual {v4, v5}, Ljava/net/URLConnection;->setReadTimeout(I)V
    invoke-static {}, Lcom/sekolah/ujianbrowser/DevNetSync;->nowStr()Ljava/lang/String;
    move-result-object v7
    invoke-static {v7}, Lcom/sekolah/ujianbrowser/DevNetSync;->getBytes(Ljava/lang/String;)[B
    move-result-object v8
    invoke-virtual {v4, v8}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V
    invoke-virtual {v4}, Ljava/net/URLConnection;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v8
    invoke-virtual {v8, v8}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v8}, Ljava/io/OutputStream;->close()V
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getResponseCode()I
    move-result v8
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->disconnect()V
    :devnet_fs_done
    # ---- GET banned/{code}.json and post if banned
    invoke-static {v1}, Lcom/sekolah/ujianbrowser/DevNetSync;->urlBanned(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    new-instance v4, Ljava/net/URL;
    invoke-direct {v4, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;
    move-result-object v4
    check-cast v4, Ljava/net/HttpURLConnection;
    const-string v5, "GET"
    invoke-virtual {v4, v5}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V
    const/16 v5, 0x1388
    invoke-virtual {v4, v5}, Ljava/net/URLConnection;->setConnectTimeout(I)V
    invoke-virtual {v4, v5}, Ljava/net/URLConnection;->setReadTimeout(I)V
    invoke-virtual {v4}, Ljava/net/URLConnection;->getInputStream()Ljava/io/InputStream;
    move-result-object v5
    invoke-static {v5}, Lcom/sekolah/ujianbrowser/DevNetSync;->readAll(Ljava/io/InputStream;)Ljava/lang/String;
    move-result-object v5
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->disconnect()V
    invoke-virtual {v0, v5}, Lcom/sekolah/ujianbrowser/ExamActivity;->setDevBanMessage(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_all
    return-void
    :catch_all
    move-exception v2
    return-void
.end method
"""

write_file(DEVNET, DEVNET_SMALI, "DevNetSync.smali (device info POST + firstSeen PUT + banned check)")

# ==========================================================================
# PART C: devDeviceInfoJson + setDevBanMessage (append to ExamActivity)
# ==========================================================================

EXAM_ADD = """\
.method public final setDevBanMessage(Ljava/lang/String;)V
    .locals 2
    .param p0, "a0"    # Ljava/lang/String;

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0

    if-eqz v0, :dev_banmsg_trim

    const-string v0, "null"

    goto :dev_banmsg_done

    :dev_banmsg_trim
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    :dev_banmsg_done
    iput-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devBanMessage:Ljava/lang/String;
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devBanned:Z
    if-eqz v0, :dev_banmsg_skip
    iput-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devBannedMsg:Ljava/lang/String;
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->showBanScreen()V
    :dev_banmsg_skip
    return-void
.end method

.method public final devDeviceInfoJson()Ljava/lang/String;
    .locals 8

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/ExamActivity;->computeDeviceCode()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0}, Lcom/sekolah/ujianbrowser/ChipsetKt;->detectChipset(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p0}, Lcom/sekolah/ujianbrowser/DevNetSync;->devRamMb(Landroid/content/Context;)J

    move-result-wide v4

    invoke-static {p0}, Lcom/sekolah/ujianbrowser/DevNetSync;->devStorageGb()J

    move-result-wide v6

    invoke-virtual {v1, "device_code", v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v1, "lastSeen", Ljava/lang/String;->valueOf(J)}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v1, "model", Ljava/lang/String;->valueOf(Ljava/lang/String;)}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    return-object v1
.end method
"""

# Use a simpler, verifiable devDeviceInfoJson
EXAM_ADD2 = """\
.method public final setDevBanMessage(Ljava/lang/String;)V
    .locals 1
    .param p0, "a0"    # Ljava/lang/String;
    iput-object p0, p0, Lcom/sekolah/ujianbrowser/ExamActivity;->devBanMessage:Ljava/langang/String;
    return-void
.end method
"""

# ==========================================================================
# PART D: dashboard files (TUGAS 3)
# ==========================================================================
DASH_INDEX = """\
<!DOCTYPE html><html lang="id"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Admin Dashboard - UjianBrowser</title><link rel="stylesheet" href="assets/css/style.css"></head><body><div class="site"><h1>UjianBrowser Admin Dashboard</h1><table id="t"></table></div><script src="assets/js/app.js"></script></body></html>
"""
DASH_CSS = ":root{--bg:#f8f9fa;--accent:#e74c3c}.body{margin:0}.site{max-width:720px;margin:auto;padding:16px}table{border-collapse:collapse;width:100%}th,td{padding:8px;border-bottom:1px solid #ddd}td{color:#0f4c81}"
DASH_APP = """\
const BASE="https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app/devices";
const PASS="GANTI_PASSWORD_INI";
async function jf(u){const r=await fetch(u);if(!r.ok)throw new Error(r.status);return r.json()}
let ran=false;function render(d){if(ran)return;ran=true;const t=document.querySelector("#t");t.innerHTML="<tr><th>Kode</th><th>Kode Device</th><th>First/Last Seen</th><th>Aksi</th></tr>";Object.keys(d||{}).forEach(k=>{const r=document.createElement("tr");r.innerHTML='<td>'+k+'</td><td>'+ (d[k].code||d[k].device_code||"") +'</td><td>'+d[k].firstSeen+' / '+d[k].lastSeen+'</td><td><button class="lancen" disabled>Lancen</button></td>';t.append(r)})}
(async()=>{try{const p=await jf(BASE+".json");render(p)}catch(e){console.error(e)}})();
document.body.addEventListener("click",e=>{const b=e.target.closest("button");if(b&&b.textContent==="Lancen"){b.disabled=true;b.textContent="Proses..."}});
"""
DASH_README = """\
# Admin Dashboard
Static admin dashboard for UjianBrowser. **Tugas 3.**
"""

dashboard = {"index.html": DASH_INDEX, "assets/css/style.css": DASH_CSS, "assets/js/app.js": DASH_APP, "README.md": DASH_README}

for f, c in dashboard.items():
    p = os.path.join(ROOT, "..", "admin-dashboard", f)
    os.makedirs(os.path.dirname(os.path.abspath(p)), exist_ok=True)
    if not os.path.exists(p) or read(p) != c:
        write(p, c)
        LOG.append("OK  admin-dashboard: wrote %s" % f)

print("\n".join(LOG))
print("TOTAL PATCHES: %d" % len(LOG))
