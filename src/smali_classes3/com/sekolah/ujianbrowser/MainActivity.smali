.class public final Lcom/sekolah/ujianbrowser/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMainActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MainActivity.kt\ncom/sekolah/ujianbrowser/MainActivity\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,341:1\n1#2:342\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000U\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0007*\u0001\u0017\u0018\u00002\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0012\u0010\n\u001a\u00020\u000b2\u0008\u0010\u000c\u001a\u0004\u0018\u00010\rH\u0014J\u0008\u0010\u000e\u001a\u00020\u000bH\u0014J\u0008\u0010\u000f\u001a\u00020\u000bH\u0014J\u0016\u0010\u0019\u001a\u00020\u000b2\u000c\u0010\u001a\u001a\u0008\u0012\u0004\u0012\u00020\u000b0\u001bH\u0002J\u0016\u0010\u001c\u001a\u00020\u000b2\u000c\u0010\u001a\u001a\u0008\u0012\u0004\u0012\u00020\u000b0\u001bH\u0002J\u0008\u0010\u001d\u001a\u00020\u000bH\u0002J\u0008\u0010\u001e\u001a\u00020\u000bH\u0002J\u0008\u0010\u001f\u001a\u00020 H\u0002J\u0010\u0010!\u001a\u00020\u000b2\u0006\u0010\"\u001a\u00020 H\u0002J\u0010\u0010#\u001a\u00020\u000b2\u0006\u0010$\u001a\u00020 H\u0002J\u0010\u0010%\u001a\u00020\u000b2\u0006\u0010$\u001a\u00020 H\u0002J\u0012\u0010&\u001a\u0004\u0018\u00010 2\u0006\u0010\"\u001a\u00020 H\u0002R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082.\u00a2\u0006\u0002\n\u0000R\u001c\u0010\u0006\u001a\u0010\u0012\u000c\u0012\n \t*\u0004\u0018\u00010\u00080\u00080\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0010\u001a\u0004\u0018\u00010\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0012\u001a\u00020\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0018\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/sekolah/ujianbrowser/MainActivity;",
        "Landroidx/appcompat/app/AppCompatActivity;",
        "<init>",
        "()V",
        "etLink",
        "Landroid/widget/EditText;",
        "scanLauncher",
        "Landroidx/activity/result/ActivityResultLauncher;",
        "Lcom/journeyapps/barcodescanner/ScanOptions;",
        "kotlin.jvm.PlatformType",
        "onCreate",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "onDestroy",
        "onResume",
        "updateDialog",
        "Landroidx/appcompat/app/AlertDialog;",
        "downloadId",
        "",
        "receiverRegistered",
        "",
        "onDownloadDone",
        "com/sekolah/ujianbrowser/MainActivity$onDownloadDone$1",
        "Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;",
        "checkUpdate",
        "onDone",
        "Lkotlin/Function0;",
        "showUpdateDialog",
        "startUpdate",
        "installDownloaded",
        "currentLink",
        "",
        "startExam",
        "raw",
        "launchExam",
        "url",
        "confirmThenStart",
        "normalizeUrl",
        "app"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private downloadId:J

.field private etLink:Landroid/widget/EditText;

.field private final onDownloadDone:Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;

.field private receiverRegistered:Z

.field private final scanLauncher:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Lcom/journeyapps/barcodescanner/ScanOptions;",
            ">;"
        }
    .end annotation
.end field

.field private updateDialog:Landroidx/appcompat/app/AlertDialog;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 49
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    .line 54
    new-instance v0, Lcom/journeyapps/barcodescanner/ScanContract;

    invoke-direct {v0}, Lcom/journeyapps/barcodescanner/ScanContract;-><init>()V

    check-cast v0, Landroidx/activity/result/contract/ActivityResultContract;

    new-instance v1, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda0;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    invoke-virtual {p0, v0, v1}, Lcom/sekolah/ujianbrowser/MainActivity;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->scanLauncher:Landroidx/activity/result/ActivityResultLauncher;

    .line 145
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->downloadId:J

    .line 148
    new-instance v0, Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;

    invoke-direct {v0, p0}, Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    iput-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->onDownloadDone:Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;

    .line 49
    return-void
.end method

.method public static final synthetic access$getDownloadId$p(Lcom/sekolah/ujianbrowser/MainActivity;)J
    .locals 2
    .param p0, "$this"    # Lcom/sekolah/ujianbrowser/MainActivity;

    .line 49
    iget-wide v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->downloadId:J

    return-wide v0
.end method

.method public static final synthetic access$installDownloaded(Lcom/sekolah/ujianbrowser/MainActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/sekolah/ujianbrowser/MainActivity;

    .line 49
    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->installDownloaded()V

    return-void
.end method

.method private final checkUpdate(Lkotlin/jvm/functions/Function0;)V
    .locals 2
    .param p1, "onDone"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 158
    const-string v0, "https://raw.githubusercontent.com/aan228/ujian-mtsn6/main/version.txt"

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "https://raw.githubusercontent.com/aan228/ujian-mtsn6/main/Ujian-MTsN6.apk"

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 162
    new-instance v0, Ljava/lang/Thread;

    .line 182
    new-instance v1, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda14;

    invoke-direct {v1, p0, p1}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda14;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;Lkotlin/jvm/functions/Function0;)V

    .line 162
    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 182
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 183
    return-void

    .line 159
    :cond_0
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda13;

    invoke-direct {v1, p1}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda13;-><init>(Lkotlin/jvm/functions/Function0;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 160
    return-void
.end method

.method static final checkUpdate$lambda$10(Lcom/sekolah/ujianbrowser/MainActivity;Lkotlin/jvm/functions/Function0;)V
    .locals 14
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "$onDone"    # Lkotlin/jvm/functions/Function0;

    .line 163
    new-instance v0, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    move-object v3, v0

    .local v3, "remote":Lkotlin/jvm/internal/Ref$LongRef;
    const-wide/16 v0, -0x1

    iput-wide v0, v3, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 164
    nop

    .line 165
    :try_start_0
    new-instance v2, Ljava/net/URL;

    const-string v4, "https://raw.githubusercontent.com/aan228/ujian-mtsn6/main/version.txt"

    invoke-direct {v2, v4}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    const-string v4, "null cannot be cast to non-null type java.net.HttpURLConnection"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Ljava/net/HttpURLConnection;

    .line 166
    .local v2, "conn":Ljava/net/HttpURLConnection;
    const/16 v4, 0x1388

    invoke-virtual {v2, v4}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 167
    invoke-virtual {v2, v4}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 168
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    const-string v5, "getInputStream(...)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v5, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    new-instance v6, Ljava/io/InputStreamReader;

    invoke-direct {v6, v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    check-cast v6, Ljava/io/Reader;

    instance-of v4, v6, Ljava/io/BufferedReader;

    if-eqz v4, :cond_0

    check-cast v6, Ljava/io/BufferedReader;

    goto :goto_0

    :cond_0
    new-instance v4, Ljava/io/BufferedReader;

    const/16 v5, 0x2000

    invoke-direct {v4, v6, v5}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    move-object v6, v4

    :goto_0
    check-cast v6, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v4, v6

    check-cast v4, Ljava/io/BufferedReader;

    .line 342
    .local v4, "it\\1":Ljava/io/BufferedReader;
    const/4 v5, 0x0

    .line 168
    .local v5, "$i$a$-use-MainActivity$checkUpdate$2$1\\1\\168\\0":I
    move-object v7, v4

    check-cast v7, Ljava/io/Reader;

    invoke-static {v7}, Lkotlin/io/TextStreamsKt;->readText(Ljava/io/Reader;)Ljava/lang/String;

    move-result-object v8
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v4    # "it\\1":Ljava/io/BufferedReader;
    .end local v5    # "$i$a$-use-MainActivity$checkUpdate$2$1\\1\\168\\0":I
    const/4 v4, 0x0

    :try_start_2
    invoke-static {v6, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 169
    const-string v9, "\ufeff"

    const-string v10, ""

    const/4 v12, 0x4

    const/4 v13, 0x0

    const/4 v11, 0x0

    invoke-static/range {v8 .. v13}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v4

    .line 168
    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    goto :goto_1

    .line 169
    :cond_1
    nop

    .line 168
    :goto_1
    iput-wide v0, v3, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 170
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .end local v2    # "conn":Ljava/net/HttpURLConnection;
    goto :goto_2

    .line 168
    .restart local v2    # "conn":Ljava/net/HttpURLConnection;
    :catchall_0
    move-exception v0

    move-object v1, v0

    .end local v2    # "conn":Ljava/net/HttpURLConnection;
    .end local v3    # "remote":Lkotlin/jvm/internal/Ref$LongRef;
    .end local p0    # "this$0":Lcom/sekolah/ujianbrowser/MainActivity;
    .end local p1    # "$onDone":Lkotlin/jvm/functions/Function0;
    :try_start_3
    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v2    # "conn":Ljava/net/HttpURLConnection;
    .restart local v3    # "remote":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local p0    # "this$0":Lcom/sekolah/ujianbrowser/MainActivity;
    .restart local p1    # "$onDone":Lkotlin/jvm/functions/Function0;
    :catchall_1
    move-exception v0

    :try_start_4
    invoke-static {v6, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v3    # "remote":Lkotlin/jvm/internal/Ref$LongRef;
    .end local p0    # "this$0":Lcom/sekolah/ujianbrowser/MainActivity;
    .end local p1    # "$onDone":Lkotlin/jvm/functions/Function0;
    throw v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 171
    .end local v2    # "conn":Ljava/net/HttpURLConnection;
    .restart local v3    # "remote":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local p0    # "this$0":Lcom/sekolah/ujianbrowser/MainActivity;
    .restart local p1    # "$onDone":Lkotlin/jvm/functions/Function0;
    :catch_0
    move-exception v0

    .line 173
    :goto_2
    nop

    .line 174
    :try_start_5
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/content/pm/PackageInfoCompat;->getLongVersionCode(Landroid/content/pm/PackageInfo;)J

    move-result-wide v0
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    move-wide v4, v0

    goto :goto_3

    .line 175
    :catch_1
    move-exception v0

    .line 176
    .local v0, "e":Ljava/lang/Exception;
    const-wide v1, 0x7fffffffffffffffL

    move-wide v4, v1

    .line 173
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_3
    nop

    .line 178
    .local v4, "local":J
    new-instance v1, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;

    move-object v2, p0

    move-object v6, p1

    .end local p0    # "this$0":Lcom/sekolah/ujianbrowser/MainActivity;
    .end local p1    # "$onDone":Lkotlin/jvm/functions/Function0;
    .local v2, "this$0":Lcom/sekolah/ujianbrowser/MainActivity;
    .local v6, "$onDone":Lkotlin/jvm/functions/Function0;
    invoke-direct/range {v1 .. v6}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/jvm/functions/Function0;)V

    invoke-virtual {v2, v1}, Lcom/sekolah/ujianbrowser/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 182
    return-void
.end method

.method static final checkUpdate$lambda$10$lambda$9(Lcom/sekolah/ujianbrowser/MainActivity;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/jvm/functions/Function0;)V
    .locals 2
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "$remote"    # Lkotlin/jvm/internal/Ref$LongRef;
    .param p2, "$local"    # J
    .param p4, "$onDone"    # Lkotlin/jvm/functions/Function0;

    .line 179
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_1

    .line 180
    iget-wide v0, p1, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    cmp-long v0, v0, p2

    if-lez v0, :cond_0

    invoke-direct {p0, p4}, Lcom/sekolah/ujianbrowser/MainActivity;->showUpdateDialog(Lkotlin/jvm/functions/Function0;)V

    goto :goto_0

    :cond_0
    invoke-interface {p4}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    .line 181
    :goto_0
    return-void

    .line 179
    :cond_1
    return-void
.end method

.method static final checkUpdate$lambda$7(Lkotlin/jvm/functions/Function0;)V
    .locals 0
    .param p0, "$onDone"    # Lkotlin/jvm/functions/Function0;

    .line 159
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    return-void
.end method

.method private final confirmThenStart(Ljava/lang/String;)V
    .locals 9
    .param p1, "url"    # Ljava/lang/String;

    .line 288
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 289
    .local v0, "dp":F
    const/high16 v1, 0x41a00000    # 20.0f

    mul-float/2addr v1, v0

    float-to-int v1, v1

    .line 291
    .local v1, "pad":I
    new-instance v2, Landroid/widget/LinearLayout;

    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    invoke-direct {v2, v3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 292
    .local v2, "box":Landroid/widget/LinearLayout;
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 293
    div-int/lit8 v3, v1, 0x2

    const/4 v4, 0x0

    invoke-virtual {v2, v1, v3, v1, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 295
    new-instance v3, Landroid/widget/TextView;

    move-object v4, p0

    check-cast v4, Landroid/content/Context;

    invoke-direct {v3, v4}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 296
    .local v3, "rules":Landroid/widget/TextView;
    nop

    .line 297
    const-string v4, "1. Saat ujian dimulai, aplikasi akan DIKUNCI. Akan muncul pesan \"Sematkan layar\" (App is pinned). Tekan MULAI / OK / MENGERTI. Jika ditolak, soal tidak akan tampil.\n\n2. Dilarang membuka aplikasi lain, keluar paksa, atau melepas kunci layar. Pelanggaran membunyikan alarm keras dan diketahui pengawas.\n\n3. Aplikasi tidak bisa ditutup selama 60 menit pertama. Setelah itu hanya bisa ditutup dengan kode dari guru.\n\n4. Screenshot dan rekam layar dinonaktifkan.\n\n5. Jika ada masalah, angkat tangan dan hubungi pengawas."

    check-cast v4, Ljava/lang/CharSequence;

    .line 296
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 305
    const/high16 v4, 0x41600000    # 14.0f

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 306
    move-object v4, v3

    check-cast v4, Landroid/view/View;

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 308
    new-instance v4, Landroid/widget/CheckBox;

    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/widget/CheckBox;-><init>(Landroid/content/Context;)V

    .line 309
    .local v4, "cb":Landroid/widget/CheckBox;
    const-string v5, "Saya sudah membaca dan menyetujui aturan di atas."

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v4, v5}, Landroid/widget/CheckBox;->setText(Ljava/lang/CharSequence;)V

    .line 310
    move-object v5, v4

    check-cast v5, Landroid/view/View;

    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 312
    new-instance v5, Landroid/widget/ScrollView;

    move-object v6, p0

    check-cast v6, Landroid/content/Context;

    invoke-direct {v5, v6}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 313
    .local v5, "scroll":Landroid/widget/ScrollView;
    move-object v6, v2

    check-cast v6, Landroid/view/View;

    invoke-virtual {v5, v6}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 315
    new-instance v6, Landroidx/appcompat/app/AlertDialog$Builder;

    move-object v7, p0

    check-cast v7, Landroid/content/Context;

    invoke-direct {v6, v7}, Landroidx/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 316
    const-string v7, "Aturan ujian"

    check-cast v7, Ljava/lang/CharSequence;

    invoke-virtual {v6, v7}, Landroidx/appcompat/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v6

    .line 317
    move-object v7, v5

    check-cast v7, Landroid/view/View;

    invoke-virtual {v6, v7}, Landroidx/appcompat/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v6

    .line 318
    const-string v7, "Mulai ujian"

    check-cast v7, Ljava/lang/CharSequence;

    new-instance v8, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda8;

    invoke-direct {v8, p0, p1}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda8;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v6, v7, v8}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v6

    .line 319
    const-string v7, "Batal"

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v8, 0x0

    invoke-virtual {v6, v7, v8}, Landroidx/appcompat/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v6

    .line 320
    invoke-virtual {v6}, Landroidx/appcompat/app/AlertDialog$Builder;->create()Landroidx/appcompat/app/AlertDialog;

    move-result-object v6

    const-string v7, "create(...)"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 315
    nop

    .line 321
    .local v6, "dialog":Landroidx/appcompat/app/AlertDialog;
    new-instance v7, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda9;

    invoke-direct {v7, v6}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda9;-><init>(Landroidx/appcompat/app/AlertDialog;)V

    invoke-virtual {v6, v7}, Landroidx/appcompat/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    .line 324
    new-instance v7, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda10;

    invoke-direct {v7, v6}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda10;-><init>(Landroidx/appcompat/app/AlertDialog;)V

    invoke-virtual {v4, v7}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 327
    invoke-virtual {v6}, Landroidx/appcompat/app/AlertDialog;->show()V

    .line 328
    return-void
.end method

.method static final confirmThenStart$lambda$14(Lcom/sekolah/ujianbrowser/MainActivity;Ljava/lang/String;Landroid/content/DialogInterface;I)V
    .locals 0
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "$url"    # Ljava/lang/String;

    .line 318
    invoke-direct {p0, p1}, Lcom/sekolah/ujianbrowser/MainActivity;->launchExam(Ljava/lang/String;)V

    return-void
.end method

.method static final confirmThenStart$lambda$15(Landroidx/appcompat/app/AlertDialog;Landroid/content/DialogInterface;)V
    .locals 2
    .param p0, "$dialog"    # Landroidx/appcompat/app/AlertDialog;
    .param p1, "it"    # Landroid/content/DialogInterface;

    .line 322
    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 323
    return-void
.end method

.method static final confirmThenStart$lambda$16(Landroidx/appcompat/app/AlertDialog;Landroid/widget/CompoundButton;Z)V
    .locals 1
    .param p0, "$dialog"    # Landroidx/appcompat/app/AlertDialog;
    .param p2, "checked"    # Z

    const-string v0, "<unused var>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 325
    const/4 p1, -0x1

    invoke-virtual {p0, p1}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setEnabled(Z)V

    .line 326
    :cond_0
    return-void
.end method

.method private final currentLink()Ljava/lang/String;
    .locals 2

    .line 269
    const-string v0, "cbt26.mtsn6kbm.my.id"

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->etLink:Landroid/widget/EditText;

    if-nez v0, :cond_0

    const-string v0, "etLink"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    return-object v0
.end method

.method private final installDownloaded()V
    .locals 11

    .line 240
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->updateDialog:Landroidx/appcompat/app/AlertDialog;

    .line 241
    .local v0, "d":Landroidx/appcompat/app/AlertDialog;
    nop

    .line 242
    const/4 v1, -0x1

    const/4 v2, 0x1

    :try_start_0
    const-string v3, "download"

    invoke-virtual {p0, v3}, Lcom/sekolah/ujianbrowser/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    const-string v4, "null cannot be cast to non-null type android.app.DownloadManager"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v3, Landroid/app/DownloadManager;

    .line 243
    .local v3, "dm":Landroid/app/DownloadManager;
    const/4 v4, 0x0

    .line 244
    .local v4, "ok":Z
    new-instance v5, Landroid/app/DownloadManager$Query;

    invoke-direct {v5}, Landroid/app/DownloadManager$Query;-><init>()V

    iget-wide v6, p0, Lcom/sekolah/ujianbrowser/MainActivity;->downloadId:J

    new-array v8, v2, [J

    const/4 v9, 0x0

    aput-wide v6, v8, v9

    invoke-virtual {v5, v8}, Landroid/app/DownloadManager$Query;->setFilterById([J)Landroid/app/DownloadManager$Query;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/app/DownloadManager;->query(Landroid/app/DownloadManager$Query;)Landroid/database/Cursor;

    move-result-object v5

    check-cast v5, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v6, v5

    check-cast v6, Landroid/database/Cursor;

    .local v6, "c\\1":Landroid/database/Cursor;
    const/4 v7, 0x0

    .line 245
    .local v7, "$i$a$-use-MainActivity$installDownloaded$1\\1\\244\\0":I
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v8

    if-eqz v8, :cond_1

    .line 246
    const-string v8, "status"

    invoke-interface {v6, v8}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v8

    invoke-interface {v6, v8}, Landroid/database/Cursor;->getInt(I)I

    move-result v8

    .line 247
    .local v8, "st\\1":I
    const/16 v10, 0x8

    if-ne v8, v10, :cond_0

    move v9, v2

    :cond_0
    move v4, v9

    .line 249
    .end local v8    # "st\\1":I
    :cond_1
    nop

    .end local v6    # "c\\1":Landroid/database/Cursor;
    .end local v7    # "$i$a$-use-MainActivity$installDownloaded$1\\1\\244\\0":I
    sget-object v6, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 244
    const/4 v6, 0x0

    :try_start_2
    invoke-static {v5, v6}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 250
    if-eqz v4, :cond_2

    iget-wide v5, p0, Lcom/sekolah/ujianbrowser/MainActivity;->downloadId:J

    invoke-virtual {v3, v5, v6}, Landroid/app/DownloadManager;->getUriForDownloadedFile(J)Landroid/net/Uri;

    move-result-object v6

    .line 251
    .local v6, "uri":Landroid/net/Uri;
    :cond_2
    if-nez v6, :cond_5

    .line 252
    if-eqz v0, :cond_3

    const-string v5, "Unduhan gagal. Periksa internet, lalu tekan Perbarui lagi."

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v0, v5}, Landroidx/appcompat/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 253
    :cond_3
    if-eqz v0, :cond_4

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v5

    if-eqz v5, :cond_4

    invoke-virtual {v5, v2}, Landroid/widget/Button;->setEnabled(Z)V

    .line 254
    :cond_4
    return-void

    .line 256
    :cond_5
    new-instance v5, Landroid/content/Intent;

    const-string v7, "android.intent.action.VIEW"

    invoke-direct {v5, v7}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 257
    .local v5, "install":Landroid/content/Intent;
    const-string v7, "application/vnd.android.package-archive"

    invoke-virtual {v5, v6, v7}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 258
    const v7, 0x10000001

    invoke-virtual {v5, v7}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 259
    if-eqz v0, :cond_6

    const-string v7, "Tekan Pasang pada layar yang muncul. Setelah selesai, buka aplikasi lagi."

    check-cast v7, Ljava/lang/CharSequence;

    invoke-virtual {v0, v7}, Landroidx/appcompat/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 260
    :cond_6
    if-eqz v0, :cond_7

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v7

    if-eqz v7, :cond_7

    invoke-virtual {v7, v2}, Landroid/widget/Button;->setEnabled(Z)V

    .line 261
    :cond_7
    invoke-virtual {p0, v5}, Lcom/sekolah/ujianbrowser/MainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .end local v3    # "dm":Landroid/app/DownloadManager;
    .end local v4    # "ok":Z
    .end local v5    # "install":Landroid/content/Intent;
    .end local v6    # "uri":Landroid/net/Uri;
    goto :goto_0

    .line 244
    .restart local v3    # "dm":Landroid/app/DownloadManager;
    .restart local v4    # "ok":Z
    :catchall_0
    move-exception v6

    .end local v0    # "d":Landroidx/appcompat/app/AlertDialog;
    .end local v3    # "dm":Landroid/app/DownloadManager;
    .end local v4    # "ok":Z
    :try_start_3
    throw v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v0    # "d":Landroidx/appcompat/app/AlertDialog;
    .restart local v3    # "dm":Landroid/app/DownloadManager;
    .restart local v4    # "ok":Z
    :catchall_1
    move-exception v7

    :try_start_4
    invoke-static {v5, v6}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v0    # "d":Landroidx/appcompat/app/AlertDialog;
    throw v7
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 262
    .end local v3    # "dm":Landroid/app/DownloadManager;
    .end local v4    # "ok":Z
    .restart local v0    # "d":Landroidx/appcompat/app/AlertDialog;
    :catch_0
    move-exception v3

    .line 263
    .local v3, "e":Ljava/lang/Exception;
    if-eqz v0, :cond_8

    const-string v4, "Gagal membuka pemasang. Tekan Perbarui lagi, atau unduh manual dari link guru."

    check-cast v4, Ljava/lang/CharSequence;

    invoke-virtual {v0, v4}, Landroidx/appcompat/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 264
    :cond_8
    if-eqz v0, :cond_9

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v1

    if-eqz v1, :cond_9

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setEnabled(Z)V

    .line 266
    .end local v3    # "e":Ljava/lang/Exception;
    :cond_9
    :goto_0
    return-void
.end method

.method private final launchExam(Ljava/lang/String;)V
    .locals 3
    .param p1, "url"    # Ljava/lang/String;

    .line 281
    new-instance v0, Landroid/content/Intent;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 282
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "url"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 283
    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 284
    return-void
.end method

.method private final normalizeUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "raw"    # Ljava/lang/String;

    .line 331
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 332
    .local v0, "s":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    move v1, v3

    :goto_0
    const/4 v4, 0x0

    if-eqz v1, :cond_1

    return-object v4

    .line 333
    :cond_1
    const-string v1, "http://"

    invoke-static {v0, v1, v2}, Lkotlin/text/StringsKt;->startsWith(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v1

    const/4 v5, 0x2

    if-nez v1, :cond_3

    const-string v1, "https://"

    invoke-static {v0, v1, v2}, Lkotlin/text/StringsKt;->startsWith(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v6

    if-nez v6, :cond_3

    .line 334
    move-object v6, v0

    check-cast v6, Ljava/lang/CharSequence;

    const-string v7, "://"

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v6, v7, v3, v5, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    return-object v4

    .line 335
    :cond_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 337
    :cond_3
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v1

    .line 338
    .local v1, "host":Ljava/lang/String;
    move-object v6, v1

    check-cast v6, Ljava/lang/CharSequence;

    if-eqz v6, :cond_4

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_4

    move v2, v3

    :cond_4
    if-nez v2, :cond_5

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const-string v6, "."

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v2, v6, v3, v5, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    move-object v4, v0

    :cond_5
    return-object v4
.end method

.method static final onCreate$lambda$1(Lcom/sekolah/ujianbrowser/MainActivity;Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p2, "actionId"    # I

    .line 80
    const/4 p1, 0x2

    if-ne p2, p1, :cond_0

    .line 81
    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->currentLink()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/sekolah/ujianbrowser/MainActivity;->startExam(Ljava/lang/String;)V

    .line 82
    const/4 p1, 0x1

    goto :goto_0

    .line 84
    :cond_0
    const/4 p1, 0x0

    .line 85
    :goto_0
    return p1
.end method

.method static final onCreate$lambda$2(Lcom/sekolah/ujianbrowser/MainActivity;Landroid/view/View;)V
    .locals 1
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 89
    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->currentLink()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->startExam(Ljava/lang/String;)V

    .line 90
    return-void
.end method

.method static final onCreate$lambda$3(Lcom/sekolah/ujianbrowser/MainActivity;Landroid/view/View;)V
    .locals 4
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 93
    new-instance v0, Lcom/journeyapps/barcodescanner/ScanOptions;

    invoke-direct {v0}, Lcom/journeyapps/barcodescanner/ScanOptions;-><init>()V

    .line 94
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "QR_CODE"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    invoke-virtual {v0, v1}, Lcom/journeyapps/barcodescanner/ScanOptions;->setDesiredBarcodeFormats([Ljava/lang/String;)Lcom/journeyapps/barcodescanner/ScanOptions;

    move-result-object v0

    .line 95
    const-string v1, "Arahkan kamera ke QR code ujian"

    invoke-virtual {v0, v1}, Lcom/journeyapps/barcodescanner/ScanOptions;->setPrompt(Ljava/lang/String;)Lcom/journeyapps/barcodescanner/ScanOptions;

    move-result-object v0

    .line 96
    invoke-virtual {v0, v3}, Lcom/journeyapps/barcodescanner/ScanOptions;->setBeepEnabled(Z)Lcom/journeyapps/barcodescanner/ScanOptions;

    move-result-object v0

    .line 97
    invoke-virtual {v0, v3}, Lcom/journeyapps/barcodescanner/ScanOptions;->setOrientationLocked(Z)Lcom/journeyapps/barcodescanner/ScanOptions;

    move-result-object v0

    .line 93
    nop

    .line 98
    .local v0, "options":Lcom/journeyapps/barcodescanner/ScanOptions;
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/MainActivity;->scanLauncher:Landroidx/activity/result/ActivityResultLauncher;

    invoke-virtual {v1, v0}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    .line 99
    return-void
.end method

.method static final onCreate$lambda$5(Lcom/sekolah/ujianbrowser/MainActivity;Landroid/view/View;)V
    .locals 9
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 102
    sget-object v0, Lcom/sekolah/ujianbrowser/ExamLock;->INSTANCE:Lcom/sekolah/ujianbrowser/ExamLock;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/ExamLock;->remainingMs(Landroid/content/Context;)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    .line 104
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    .line 106
    sget-object v1, Lcom/sekolah/ujianbrowser/ExamLock;->INSTANCE:Lcom/sekolah/ujianbrowser/ExamLock;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/sekolah/ujianbrowser/ExamLock;->remainingText(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Ujian masih berlangsung. Aplikasi bisa ditutup dalam "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    .line 107
    nop

    .line 103
    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    .line 108
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 110
    :cond_0
    sget-object v1, Lcom/sekolah/ujianbrowser/AdminCode;->INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

    move-object v2, p0

    check-cast v2, Landroid/app/Activity;

    new-instance v6, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v6, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda1;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    const/16 v7, 0xc

    const/4 v8, 0x0

    const-string v3, "Kode admin untuk keluar aplikasi"

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v1 .. v8}, Lcom/sekolah/ujianbrowser/AdminCode;->prompt$default(Lcom/sekolah/ujianbrowser/AdminCode;Landroid/app/Activity;Ljava/lang/String;Lkotlin/jvm/functions/Function0;ZLkotlin/jvm/functions/Function0;ILjava/lang/Object;)V

    .line 114
    :goto_0
    return-void
.end method

.method static final onCreate$lambda$5$lambda$4(Lcom/sekolah/ujianbrowser/MainActivity;)Lkotlin/Unit;
    .locals 1
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;

    .line 111
    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->finishAffinity()V

    .line 112
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method static final onCreate$lambda$6(Lcom/sekolah/ujianbrowser/MainActivity;)Lkotlin/Unit;
    .locals 2
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;

    .line 121
    const-string v0, "cbt26.mtsn6kbm.my.id"

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-direct {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->startExam(Ljava/lang/String;)V

    .line 122
    :cond_0
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method static final scanLauncher$lambda$0(Lcom/sekolah/ujianbrowser/MainActivity;Lcom/journeyapps/barcodescanner/ScanIntentResult;)V
    .locals 3
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "result"    # Lcom/journeyapps/barcodescanner/ScanIntentResult;

    .line 55
    invoke-virtual {p1}, Lcom/journeyapps/barcodescanner/ScanIntentResult;->getContents()Ljava/lang/String;

    move-result-object v0

    .line 56
    .local v0, "text":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 57
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/MainActivity;->etLink:Landroid/widget/EditText;

    if-nez v1, :cond_0

    const-string v1, "etLink"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_0
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 58
    invoke-direct {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->startExam(Ljava/lang/String;)V

    .line 60
    :cond_1
    return-void
.end method

.method private final showUpdateDialog(Lkotlin/jvm/functions/Function0;)V
    .locals 4
    .param p1, "onDone"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 186
    new-instance v0, Landroidx/appcompat/app/AlertDialog$Builder;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-direct {v0, v1}, Landroidx/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 187
    const-string v1, "Versi baru tersedia"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 189
    const-string v1, "Aplikasi ujian perlu diperbarui. Tekan Perbarui, tunggu unduhan selesai (sekitar 8 MB), lalu tekan Pasang."

    check-cast v1, Ljava/lang/CharSequence;

    .line 188
    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 192
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog$Builder;->setCancelable(Z)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 193
    const-string v1, "Perbarui"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 186
    nop

    .line 194
    .local v0, "b":Landroidx/appcompat/app/AlertDialog$Builder;
    const-string v1, "Lewati"

    check-cast v1, Ljava/lang/CharSequence;

    new-instance v2, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda11;

    invoke-direct {v2, p1}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda11;-><init>(Lkotlin/jvm/functions/Function0;)V

    invoke-virtual {v0, v1, v2}, Landroidx/appcompat/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 195
    invoke-virtual {v0}, Landroidx/appcompat/app/AlertDialog$Builder;->create()Landroidx/appcompat/app/AlertDialog;

    move-result-object v1

    const-string v2, "create(...)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 196
    .local v1, "d":Landroidx/appcompat/app/AlertDialog;
    invoke-virtual {v1}, Landroidx/appcompat/app/AlertDialog;->show()V

    .line 197
    iput-object v1, p0, Lcom/sekolah/ujianbrowser/MainActivity;->updateDialog:Landroidx/appcompat/app/AlertDialog;

    .line 198
    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v2

    new-instance v3, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda12;

    invoke-direct {v3, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda12;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 199
    return-void
.end method

.method static final showUpdateDialog$lambda$11(Lkotlin/jvm/functions/Function0;Landroid/content/DialogInterface;I)V
    .locals 0
    .param p0, "$onDone"    # Lkotlin/jvm/functions/Function0;

    .line 194
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    return-void
.end method

.method static final showUpdateDialog$lambda$12(Lcom/sekolah/ujianbrowser/MainActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 198
    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->startUpdate()V

    return-void
.end method

.method private final startExam(Ljava/lang/String;)V
    .locals 4
    .param p1, "raw"    # Ljava/lang/String;

    .line 272
    invoke-direct {p0, p1}, Lcom/sekolah/ujianbrowser/MainActivity;->normalizeUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 273
    .local v0, "url":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 274
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-string v2, "Link ujian tidak valid"

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 275
    return-void

    .line 277
    :cond_0
    invoke-direct {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->confirmThenStart(Ljava/lang/String;)V

    .line 278
    return-void
.end method

.method private final startUpdate()V
    .locals 9

    .line 202
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->updateDialog:Landroidx/appcompat/app/AlertDialog;

    if-nez v0, :cond_0

    return-void

    .line 204
    .local v0, "d":Landroidx/appcompat/app/AlertDialog;
    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/pm/PackageManager;->canRequestPackageInstalls()Z

    move-result v1

    if-nez v1, :cond_1

    .line 205
    nop

    .line 206
    const-string v1, "Izinkan aplikasi ini memasang pembaruan: aktifkan tombolnya, lalu kembali ke sini dan tekan Perbarui lagi."

    check-cast v1, Ljava/lang/CharSequence;

    .line 205
    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 209
    nop

    .line 210
    new-instance v1, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/sekolah/ujianbrowser/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "package:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    const-string v3, "android.settings.MANAGE_UNKNOWN_APP_SOURCES"

    invoke-direct {v1, v3, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 209
    invoke-virtual {p0, v1}, Lcom/sekolah/ujianbrowser/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 212
    return-void

    .line 214
    :cond_1
    nop

    .line 215
    const/4 v1, -0x1

    const/4 v2, 0x1

    :try_start_0
    const-string v3, "download"

    invoke-virtual {p0, v3}, Lcom/sekolah/ujianbrowser/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    const-string v4, "null cannot be cast to non-null type android.app.DownloadManager"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v3, Landroid/app/DownloadManager;

    .line 216
    .local v3, "dm":Landroid/app/DownloadManager;
    new-instance v4, Landroid/app/DownloadManager$Request;

    const-string v5, "https://raw.githubusercontent.com/aan228/ujian-mtsn6/main/Ujian-MTsN6.apk"

    invoke-static {v5}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v5

    invoke-direct {v4, v5}, Landroid/app/DownloadManager$Request;-><init>(Landroid/net/Uri;)V

    .line 217
    const-string v5, "Memperbarui aplikasi ujian"

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v4, v5}, Landroid/app/DownloadManager$Request;->setTitle(Ljava/lang/CharSequence;)Landroid/app/DownloadManager$Request;

    move-result-object v4

    .line 218
    const-string v5, "application/vnd.android.package-archive"

    invoke-virtual {v4, v5}, Landroid/app/DownloadManager$Request;->setMimeType(Ljava/lang/String;)Landroid/app/DownloadManager$Request;

    move-result-object v4

    .line 219
    invoke-virtual {v4, v2}, Landroid/app/DownloadManager$Request;->setNotificationVisibility(I)Landroid/app/DownloadManager$Request;

    move-result-object v4

    .line 220
    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    sget-object v6, Landroid/os/Environment;->DIRECTORY_DOWNLOADS:Ljava/lang/String;

    const-string v7, "Ujian-MTsN6-update.apk"

    invoke-virtual {v4, v5, v6, v7}, Landroid/app/DownloadManager$Request;->setDestinationInExternalFilesDir(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Landroid/app/DownloadManager$Request;

    move-result-object v4

    .line 216
    nop

    .line 221
    .local v4, "req":Landroid/app/DownloadManager$Request;
    iget-boolean v5, p0, Lcom/sekolah/ujianbrowser/MainActivity;->receiverRegistered:Z

    if-nez v5, :cond_2

    .line 223
    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    .line 224
    iget-object v6, p0, Lcom/sekolah/ujianbrowser/MainActivity;->onDownloadDone:Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;

    check-cast v6, Landroid/content/BroadcastReceiver;

    .line 225
    new-instance v7, Landroid/content/IntentFilter;

    const-string v8, "android.intent.action.DOWNLOAD_COMPLETE"

    invoke-direct {v7, v8}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 226
    nop

    .line 222
    const/4 v8, 0x2

    invoke-static {v5, v6, v7, v8}, Landroidx/core/content/ContextCompat;->registerReceiver(Landroid/content/Context;Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;

    .line 228
    iput-boolean v2, p0, Lcom/sekolah/ujianbrowser/MainActivity;->receiverRegistered:Z

    .line 230
    :cond_2
    invoke-virtual {v3, v4}, Landroid/app/DownloadManager;->enqueue(Landroid/app/DownloadManager$Request;)J

    move-result-wide v5

    iput-wide v5, p0, Lcom/sekolah/ujianbrowser/MainActivity;->downloadId:J

    .line 231
    const-string v5, "Mengunduh pembaruan... Jangan tutup aplikasi."

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v0, v5}, Landroidx/appcompat/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 232
    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Landroid/widget/Button;->setEnabled(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v3    # "dm":Landroid/app/DownloadManager;
    .end local v4    # "req":Landroid/app/DownloadManager$Request;
    goto :goto_0

    .line 233
    :catch_0
    move-exception v3

    .line 234
    .local v3, "e":Ljava/lang/Exception;
    const-string v4, "Gagal memulai unduhan. Periksa internet, lalu tekan Perbarui lagi."

    check-cast v4, Ljava/lang/CharSequence;

    invoke-virtual {v0, v4}, Landroidx/appcompat/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 235
    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setEnabled(Z)V

    .line 237
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 63
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 64
    sget v0, Lcom/sekolah/ujianbrowser/R$layout;->activity_main:I

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->setContentView(I)V

    .line 66
    sget v0, Lcom/sekolah/ujianbrowser/R$id;->etLink:I

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const-string v1, "findViewById(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->etLink:Landroid/widget/EditText;

    .line 69
    if-nez p1, :cond_0

    sget-object v0, Lcom/sekolah/ujianbrowser/ExamLock;->INSTANCE:Lcom/sekolah/ujianbrowser/ExamLock;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/ExamLock;->clear(Landroid/content/Context;)V

    .line 72
    :cond_0
    const-string v0, "cbt26.mtsn6kbm.my.id"

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x0

    const-string v3, "etLink"

    if-nez v1, :cond_3

    .line 73
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/MainActivity;->etLink:Landroid/widget/EditText;

    if-nez v1, :cond_1

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_1
    check-cast v0, Ljava/lang/CharSequence;

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 74
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->etLink:Landroid/widget/EditText;

    if-nez v0, :cond_2

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v2

    :cond_2
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    .line 75
    sget v0, Lcom/sekolah/ujianbrowser/R$id;->btnScan:I

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    .line 79
    :cond_3
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->etLink:Landroid/widget/EditText;

    if-nez v0, :cond_4

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    move-object v2, v0

    :goto_0
    new-instance v0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda2;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    .line 88
    sget v0, Lcom/sekolah/ujianbrowser/R$id;->btnCari:I

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    new-instance v1, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda3;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 92
    sget v0, Lcom/sekolah/ujianbrowser/R$id;->btnScan:I

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    new-instance v1, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda4;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 101
    sget v0, Lcom/sekolah/ujianbrowser/R$id;->btnKeluar:I

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    new-instance v1, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda5;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 116
    sget-object v0, Lcom/sekolah/ujianbrowser/AdminCode;->INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/AdminCode;->refresh(Landroid/content/Context;)V

    .line 119
    if-nez p1, :cond_5

    .line 120
    new-instance v0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda6;

    invoke-direct {v0, p0}, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda6;-><init>(Lcom/sekolah/ujianbrowser/MainActivity;)V

    invoke-direct {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->checkUpdate(Lkotlin/jvm/functions/Function0;)V

    .line 124
    :cond_5
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .line 127
    iget-boolean v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->receiverRegistered:Z

    if-eqz v0, :cond_0

    .line 128
    nop

    .line 129
    :try_start_0
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->onDownloadDone:Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;

    check-cast v0, Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/MainActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 130
    :catch_0
    move-exception v0

    .line 132
    :goto_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sekolah/ujianbrowser/MainActivity;->receiverRegistered:Z

    .line 134
    :cond_0
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onDestroy()V

    .line 135
    return-void
.end method

.method protected onResume()V
    .locals 2

    .line 138
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onResume()V

    .line 139
    sget-object v0, Lcom/sekolah/ujianbrowser/AdminCode;->INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/AdminCode;->refresh(Landroid/content/Context;)V

    .line 140
    return-void
.end method
