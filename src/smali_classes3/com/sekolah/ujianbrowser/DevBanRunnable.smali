.class public final Lcom/sekolah/ujianbrowser/DevBanRunnable;
.super Ljava/lang/Object;
.source "DevBanRunnable.kt"

.implements Ljava/lang/Runnable;


# instance fields
.field private final activity:Lcom/sekolah/ujianbrowser/ExamActivity;


# direct methods
.method public constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/DevBanRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/sekolah/ujianbrowser/DevBanRunnable;->activity:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-virtual {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->showBanScreen()V

    return-void
.end method
