.class public final Lcom/sekolah/ujianbrowser/ExamActivity$onCreate$1;
.super Landroidx/activity/OnBackPressedCallback;
.source "ExamActivity.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sekolah/ujianbrowser/ExamActivity;->onCreate(Landroid/os/Bundle;)V
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
        "com/sekolah/ujianbrowser/ExamActivity$onCreate$1",
        "Landroidx/activity/OnBackPressedCallback;",
        "handleOnBackPressed",
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
    .locals 1
    .param p1, "$receiver"    # Lcom/sekolah/ujianbrowser/ExamActivity;

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/ExamActivity$onCreate$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    .line 95
    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z

    if-eqz v0, :dev_mode_cb_default

    const/4 v0, 0x0

    goto :dev_mode_cb_done

    :dev_mode_cb_default

    const/4 v0, 0x1

    :dev_mode_cb_done

    invoke-direct {p0, v0}, Landroidx/activity/OnBackPressedCallback;-><init>(Z)V

    return-void
.end method


# virtual methods
.method public handleOnBackPressed()V
    .locals 1

    .line 97
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$onCreate$1;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    invoke-static {v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$askExit(Lcom/sekolah/ujianbrowser/ExamActivity;)V

    .line 98
    return-void
.end method
