.class public final synthetic Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda6;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;"
    method = "onJsConfirm$lambda$6"
    proto = "(Lcom/sekolah/ujianbrowser/ExamActivity;Landroid/content/DialogInterface;)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x1c
    versionHash = "64bbee9deb17f2433a2f464e7880a82f306bf117c38a5da5e35bd2560d29022a"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/sekolah/ujianbrowser/ExamActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda6;->f$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    return-void
.end method


# virtual methods
.method public final onDismiss(Landroid/content/DialogInterface;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda6;->f$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v0, p1}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->onJsConfirm$lambda$6(Lcom/sekolah/ujianbrowser/ExamActivity;Landroid/content/DialogInterface;)V

    return-void
.end method
