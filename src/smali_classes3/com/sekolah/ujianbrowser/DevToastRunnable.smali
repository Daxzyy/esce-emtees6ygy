.class public final Lcom/sekolah/ujianbrowser/DevToastRunnable;
.super Ljava/lang/Object;
.source "DevToastRunnable.kt"

.implements Ljava/lang/Runnable;


.field private final activity:Lcom/sekolah/ujianbrowser/ExamActivity;


.method public constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevToastRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    return-void
.end method

.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevToastRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    :try_start_0
    const-string v1, "Spesifikasi perangkat (model, chipset, RAM, penyimpanan) dikirim ke Firebase untuk pengelolaan akses aplikasi."

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
