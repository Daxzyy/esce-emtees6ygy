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
