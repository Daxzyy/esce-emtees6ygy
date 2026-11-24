.class public final Lcom/sekolah/ujianbrowser/DevBanRunnable;
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
