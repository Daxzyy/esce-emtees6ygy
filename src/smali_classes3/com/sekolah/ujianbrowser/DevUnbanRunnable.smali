.class public final Lcom/sekolah/ujianbrowser/DevUnbanRunnable;
.super Ljava/lang/Object;
.source "DevUnbanRunnable.kt"

.implements Ljava/lang/Runnable;


.field private final activity:Lcom/sekolah/ujianbrowser/ExamActivity;


.method public constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevUnbanRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    return-void
.end method

.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevUnbanRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-virtual {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->hideBanScreen()V

    return-void
.end method
