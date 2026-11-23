.class public final Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;
.super Landroid/content/BroadcastReceiver;
.source "MainActivity.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sekolah/ujianbrowser/MainActivity;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001d\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016\u00a8\u0006\u0008"
    }
    d2 = {
        "com/sekolah/ujianbrowser/MainActivity$onDownloadDone$1",
        "Landroid/content/BroadcastReceiver;",
        "onReceive",
        "",
        "c",
        "Landroid/content/Context;",
        "i",
        "Landroid/content/Intent;",
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
.field final synthetic this$0:Lcom/sekolah/ujianbrowser/MainActivity;


# direct methods
.method constructor <init>(Lcom/sekolah/ujianbrowser/MainActivity;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/sekolah/ujianbrowser/MainActivity;

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;->this$0:Lcom/sekolah/ujianbrowser/MainActivity;

    .line 148
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4
    .param p1, "c"    # Landroid/content/Context;
    .param p2, "i"    # Landroid/content/Intent;

    const-string v0, "c"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "i"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 150
    const-string v0, "extra_download_id"

    const-wide/16 v1, -0x1

    invoke-virtual {p2, v0, v1, v2}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v0

    .line 151
    .local v0, "id":J
    iget-object v2, p0, Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;->this$0:Lcom/sekolah/ujianbrowser/MainActivity;

    invoke-static {v2}, Lcom/sekolah/ujianbrowser/MainActivity;->access$getDownloadId$p(Lcom/sekolah/ujianbrowser/MainActivity;)J

    move-result-wide v2

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/MainActivity$onDownloadDone$1;->this$0:Lcom/sekolah/ujianbrowser/MainActivity;

    invoke-static {v2}, Lcom/sekolah/ujianbrowser/MainActivity;->access$installDownloaded(Lcom/sekolah/ujianbrowser/MainActivity;)V

    .line 152
    :cond_0
    return-void
.end method
