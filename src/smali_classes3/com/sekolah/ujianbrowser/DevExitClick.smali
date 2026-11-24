.class public final Lcom/sekolah/ujianbrowser/DevExitClick;
.super Ljava/lang/Object;
.source "DevExitClick.kt"

.implements Landroid/view/View$OnClickListener;


.field private final activity:Landroid/app/Activity;


.method public constructor <init>(Landroid/app/Activity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevExitClick;->activity:Landroid/app/Activity;

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevExitClick;->activity:Landroid/app/Activity;

    :try_start_0
    invoke-virtual {v0}, Landroid/app/Activity;->stopLockTask()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    return-void
.end method
