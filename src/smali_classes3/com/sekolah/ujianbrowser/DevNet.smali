.class public final Lcom/sekolah/ujianbrowser/DevNet;
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

    const-string v1, "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app/"

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

    const-string v3, ";SM8750=Snapdragon 8 Elite;SM8650=Snapdragon 8 Gen 3;SM8550=Snapdragon 8 Gen 2;SM8475=Snapdragon 8+ Gen 1;SM8450=Snapdragon 8 Gen 1;SM8350=Snapdragon 888;SM8150=Snapdragon 855;SM7550=Snapdragon 7 Gen 3;SM7475=Snapdragon 7+ Gen 2;SM7450=Snapdragon 7 Gen 1;SM6450=Snapdragon 6 Gen 1;SM6375=Snapdragon 695 5G;SM6350=Snapdragon 690 5G;SM6225=Snapdragon 680 4G;SM6115=Snapdragon 662;SM4350=Snapdragon 480 5G;MT6989=Dimensity 9300;MT6985=Dimensity 9200;GS101=Google Tensor;GS201=Google Tensor G2;S5E9945=Exynos 2400;S5E9925=Exynos 2200;S5E9840=Exynos 2100;"

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

    const-string v0, "Akses aplikasi dinonaktifkan karena alasan tertentu. Hubungi admin untuk informasi lebih lanjut."

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

    const-string v0, "Akses aplikasi dinonaktifkan karena alasan tertentu. Hubungi admin untuk informasi lebih lanjut."

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

.method public static final injectBanMsg(Landroid/app/Activity;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    invoke-static {p1}, Lcom/sekolah/ujianbrowser/DevNet;->banMessage(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :dev_inj_def
    return-object v0
    :dev_inj_def
    const-string v0, "Aplikasi Tidak Dapat Digunakan"
    return-object v0
.end method
