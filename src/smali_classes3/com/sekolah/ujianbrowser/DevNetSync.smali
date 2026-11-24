.class public final Lcom/sekolah/ujianbrowser/DevNetSync;
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
