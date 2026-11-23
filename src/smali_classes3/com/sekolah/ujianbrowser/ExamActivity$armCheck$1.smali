.class public final Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;
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
        "com/sekolah/ujianbrowser/ExamActivity$armCheck$1",
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

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6


    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z
    if-eqz v0, :dev_mode_orig
    return-void
    :dev_mode_orig

    .line 66
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Lcom/sekolah/ujianbrowser/ExamActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.app.ActivityManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/app/ActivityManager;

    .line 67
    .local v0, "am":Landroid/app/ActivityManager;
    iget-object v1, p0, Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v2}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getWaitedMs$p(Lcom/sekolah/ujianbrowser/ExamActivity;)I

    move-result v2

    add-int/lit16 v2, v2, 0x1f4

    invoke-static {v1, v2}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$setWaitedMs$p(Lcom/sekolah/ujianbrowser/ExamActivity;I)V

    .line 68
    invoke-virtual {v0}, Landroid/app/ActivityManager;->getLockTaskModeState()I

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 69
    .local v1, "locked":Z
    :goto_0
    if-nez v1, :cond_1

    iget-object v3, p0, Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v3}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getWaitedMs$p(Lcom/sekolah/ujianbrowser/ExamActivity;)I

    move-result v3

    const/16 v4, 0x7530

    if-ge v3, v4, :cond_1

    .line 72
    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v2}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$getHandler$p(Lcom/sekolah/ujianbrowser/ExamActivity;)Landroid/os/Handler;

    move-result-object v2

    move-object v3, p0

    check-cast v3, Ljava/lang/Runnable;

    const-wide/16 v4, 0x1f4

    invoke-virtual {v2, v3, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_1

    .line 70
    :cond_1
    iget-object v3, p0, Lcom/sekolah/ujianbrowser/ExamActivity$armCheck$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v3, v2}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$setArmed$p(Lcom/sekolah/ujianbrowser/ExamActivity;Z)V

    .line 74
    :goto_1
    return-void
.end method
