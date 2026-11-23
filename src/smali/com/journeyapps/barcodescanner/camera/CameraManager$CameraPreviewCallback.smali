.class final Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;
.super Ljava/lang/Object;
.source "CameraManager.java"

# interfaces
.implements Landroid/hardware/Camera$PreviewCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/journeyapps/barcodescanner/camera/CameraManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "CameraPreviewCallback"
.end annotation


# instance fields
.field private callback:Lcom/journeyapps/barcodescanner/camera/PreviewCallback;

.field private resolution:Lcom/journeyapps/barcodescanner/Size;

.field final synthetic this$0:Lcom/journeyapps/barcodescanner/camera/CameraManager;


# direct methods
.method public constructor <init>(Lcom/journeyapps/barcodescanner/camera/CameraManager;)V
    .locals 0

    .line 82
    iput-object p1, p0, Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;->this$0:Lcom/journeyapps/barcodescanner/camera/CameraManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 83
    return-void
.end method


# virtual methods
.method public onPreviewFrame([BLandroid/hardware/Camera;)V
    .locals 9
    .param p1, "data"    # [B
    .param p2, "camera"    # Landroid/hardware/Camera;

    .line 95
    iget-object v1, p0, Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;->resolution:Lcom/journeyapps/barcodescanner/Size;

    .line 96
    .local v1, "cameraResolution":Lcom/journeyapps/barcodescanner/Size;
    iget-object v2, p0, Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;->callback:Lcom/journeyapps/barcodescanner/camera/PreviewCallback;

    .line 97
    .local v2, "callback":Lcom/journeyapps/barcodescanner/camera/PreviewCallback;
    if-eqz v1, :cond_2

    if-eqz v2, :cond_2

    .line 99
    if-eqz p1, :cond_1

    .line 102
    :try_start_0
    invoke-virtual {p2}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v0

    invoke-virtual {v0}, Landroid/hardware/Camera$Parameters;->getPreviewFormat()I

    move-result v0

    move v7, v0

    .line 103
    .local v7, "format":I
    new-instance v3, Lcom/journeyapps/barcodescanner/SourceData;

    iget v5, v1, Lcom/journeyapps/barcodescanner/Size;->width:I

    iget v6, v1, Lcom/journeyapps/barcodescanner/Size;->height:I

    iget-object v0, p0, Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;->this$0:Lcom/journeyapps/barcodescanner/camera/CameraManager;

    invoke-virtual {v0}, Lcom/journeyapps/barcodescanner/camera/CameraManager;->getCameraRotation()I

    move-result v8
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v4, p1

    .end local p1    # "data":[B
    .local v4, "data":[B
    :try_start_1
    invoke-direct/range {v3 .. v8}, Lcom/journeyapps/barcodescanner/SourceData;-><init>([BIIII)V

    .line 105
    .local v3, "source":Lcom/journeyapps/barcodescanner/SourceData;
    iget-object p1, p0, Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;->this$0:Lcom/journeyapps/barcodescanner/camera/CameraManager;

    invoke-static {p1}, Lcom/journeyapps/barcodescanner/camera/CameraManager;->access$000(Lcom/journeyapps/barcodescanner/camera/CameraManager;)Landroid/hardware/Camera$CameraInfo;

    move-result-object p1

    iget p1, p1, Landroid/hardware/Camera$CameraInfo;->facing:I

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    .line 106
    invoke-virtual {v3, v0}, Lcom/journeyapps/barcodescanner/SourceData;->setPreviewMirrored(Z)V

    .line 108
    :cond_0
    invoke-interface {v2, v3}, Lcom/journeyapps/barcodescanner/camera/PreviewCallback;->onPreview(Lcom/journeyapps/barcodescanner/SourceData;)V

    .end local v3    # "source":Lcom/journeyapps/barcodescanner/SourceData;
    .end local v7    # "format":I
    goto :goto_1

    .line 109
    .end local v4    # "data":[B
    .restart local p1    # "data":[B
    :catch_0
    move-exception v0

    move-object v4, p1

    move-object p1, v0

    .end local p1    # "data":[B
    .restart local v4    # "data":[B
    goto :goto_0

    .line 100
    .end local v4    # "data":[B
    .restart local p1    # "data":[B
    :cond_1
    move-object v4, p1

    .end local p1    # "data":[B
    .restart local v4    # "data":[B
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "No preview data received"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    .end local v1    # "cameraResolution":Lcom/journeyapps/barcodescanner/Size;
    .end local v2    # "callback":Lcom/journeyapps/barcodescanner/camera/PreviewCallback;
    .end local v4    # "data":[B
    .end local p2    # "camera":Landroid/hardware/Camera;
    throw p1
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 109
    .restart local v1    # "cameraResolution":Lcom/journeyapps/barcodescanner/Size;
    .restart local v2    # "callback":Lcom/journeyapps/barcodescanner/camera/PreviewCallback;
    .restart local v4    # "data":[B
    .restart local p2    # "camera":Landroid/hardware/Camera;
    :catch_1
    move-exception v0

    move-object p1, v0

    .line 113
    .local p1, "e":Ljava/lang/RuntimeException;
    :goto_0
    invoke-static {}, Lcom/journeyapps/barcodescanner/camera/CameraManager;->access$100()Ljava/lang/String;

    move-result-object v0

    const-string v3, "Camera preview failed"

    invoke-static {v0, v3, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 114
    invoke-interface {v2, p1}, Lcom/journeyapps/barcodescanner/camera/PreviewCallback;->onPreviewError(Ljava/lang/Exception;)V

    .line 115
    .end local p1    # "e":Ljava/lang/RuntimeException;
    :goto_1
    goto :goto_2

    .line 97
    .end local v4    # "data":[B
    .local p1, "data":[B
    :cond_2
    move-object v4, p1

    .line 117
    .end local p1    # "data":[B
    .restart local v4    # "data":[B
    invoke-static {}, Lcom/journeyapps/barcodescanner/camera/CameraManager;->access$100()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Got preview callback, but no handler or resolution available"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 118
    if-eqz v2, :cond_3

    .line 120
    new-instance p1, Ljava/lang/Exception;

    const-string v0, "No resolution available"

    invoke-direct {p1, v0}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-interface {v2, p1}, Lcom/journeyapps/barcodescanner/camera/PreviewCallback;->onPreviewError(Ljava/lang/Exception;)V

    .line 123
    :cond_3
    :goto_2
    return-void
.end method

.method public setCallback(Lcom/journeyapps/barcodescanner/camera/PreviewCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/journeyapps/barcodescanner/camera/PreviewCallback;

    .line 90
    iput-object p1, p0, Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;->callback:Lcom/journeyapps/barcodescanner/camera/PreviewCallback;

    .line 91
    return-void
.end method

.method public setResolution(Lcom/journeyapps/barcodescanner/Size;)V
    .locals 0
    .param p1, "resolution"    # Lcom/journeyapps/barcodescanner/Size;

    .line 86
    iput-object p1, p0, Lcom/journeyapps/barcodescanner/camera/CameraManager$CameraPreviewCallback;->resolution:Lcom/journeyapps/barcodescanner/Size;

    .line 87
    return-void
.end method
