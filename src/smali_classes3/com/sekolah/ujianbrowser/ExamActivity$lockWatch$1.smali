.class public final Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;
.super Ljava/lang/Object;
.source "ExamActivity.kt"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sekolah/ujianbrowser/ExamActivity;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0011\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016\u00a8\u0006\u0004"
    }
    d2 = {
        "com/sekolah/ujianbrowser/ExamActivity$lockWatch$1",
        "Ljava/lang/Runnable;",
        "run",
        "",
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
.field final synthetic this$0:Lcom/sekolah/ujianbrowser/ExamActivity;


# direct methods
.method constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/sekolah/ujianbrowser/ExamActivity;

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    .line 353
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7


    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z
    if-eqz v0, :dev_mode_orig
    return-void
    :dev_mode_orig

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-virtual {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->devVolCheck()V

    .line 355
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/ExamActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.app.ActivityManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/app/ActivityManager;

    .line 356
    .local v0, "am":Landroid/app/ActivityManager;
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getLockTaskModeState()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    move v1, v3

    .line 357
    .local v1, "locked":Z
    :goto_0
    if-nez v1, :cond_1

    iget-object v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v4}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getLockBypassed$p(Lcom/sekolah/ujianbrowser/ExamActivity;)Z

    move-result v4

    if-nez v4, :cond_1

    move v2, v3

    .line 358
    .local v2, "pinOk":Z
    :cond_1
    iget-object v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v4}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getWebView$p(Lcom/sekolah/ujianbrowser/ExamActivity;)Landroid/webkit/WebView;

    move-result-object v4

    if-nez v4, :cond_2

    const-string v4, "webView"

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v4, 0x0

    :cond_2
    if-eqz v2, :cond_3

    move v5, v3

    goto :goto_1

    :cond_3
    const/4 v5, 0x4

    :goto_1
    invoke-virtual {v4, v5}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 359
    iget-object v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v4}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getGateView$p(Lcom/sekolah/ujianbrowser/ExamActivity;)Landroid/widget/LinearLayout;

    move-result-object v4

    const/16 v5, 0x8

    if-eqz v4, :cond_5

    if-eqz v2, :cond_4

    move v6, v5

    goto :goto_2

    :cond_4
    move v6, v3

    :goto_2
    invoke-virtual {v4, v6}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 360
    :cond_5
    iget-object v4, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v4}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getReloadBtn$p(Lcom/sekolah/ujianbrowser/ExamActivity;)Landroid/widget/TextView;

    move-result-object v4

    if-eqz v4, :cond_7

    if-nez v2, :cond_6

    move v3, v5

    :cond_6
    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 361
    :cond_7
    iget-object v3, p0, Lcom/sekolah/ujianbrowser/ExamActivity$lockWatch$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v3}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getHandler$p(Lcom/sekolah/ujianbrowser/ExamActivity;)Landroid/os/Handler;

    move-result-object v3

    move-object v4, p0

    check-cast v4, Ljava/lang/Runnable;

    const-wide/16 v5, 0xc8

    invoke-virtual {v3, v4, v5, v6}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 362
    return-void
.end method
