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
    .locals 8

    :loop_start
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevNetSync;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-eqz v1, :dev_sync_alive

    return-void

    :dev_sync_alive
    invoke-virtual {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->computeDeviceCode()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    :try_start_0
    move-object v4, v0

    check-cast v4, Landroid/content/Context;

    invoke-static {v4, v2}, Lcom/sekolah/ujianbrowser/DevNet;->pushSpecs(Landroid/content/Context;Ljava/lang/String;)V

    invoke-static {v2}, Lcom/sekolah/ujianbrowser/DevNet;->checkBan(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :dev_sync_unbanned

    new-instance v5, Lcom/sekolah/ujianbrowser/DevBanRunnable;

    invoke-direct {v5, v0, v4}, Lcom/sekolah/ujianbrowser/DevBanRunnable;-><init>(Lcom/sekolah/ujianbrowser/ExamActivity;Ljava/lang/String;)V

    invoke-virtual {v3, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :dev_sync_checked

    :dev_sync_unbanned
    new-instance v5, Lcom/sekolah/ujianbrowser/DevUnbanRunnable;

    invoke-direct {v5, v0}, Lcom/sekolah/ujianbrowser/DevUnbanRunnable;-><init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V

    invoke-virtual {v3, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :dev_sync_checked
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :dev_sync_caught

    goto :dev_sync_sleep

    :dev_sync_caught
    move-exception v4

    :dev_sync_sleep
    :try_start_1
    const-wide/16 v6, 0xbb8

    invoke-static {v6, v7}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :dev_sync_interrupted

    goto :loop_start

    :dev_sync_interrupted
    move-exception v6

    return-void
.end method
