.class public final Lcom/journeyapps/barcodescanner/ScanIntentResult;
.super Ljava/lang/Object;
.source "ScanIntentResult.java"


# instance fields
.field private final barcodeImagePath:Ljava/lang/String;

.field private final contents:Ljava/lang/String;

.field private final errorCorrectionLevel:Ljava/lang/String;

.field private final formatName:Ljava/lang/String;

.field private final orientation:Ljava/lang/Integer;

.field private final originalIntent:Landroid/content/Intent;

.field private final rawBytes:[B


# direct methods
.method constructor <init>()V
    .locals 8

    .line 43
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v7}, Lcom/journeyapps/barcodescanner/ScanIntentResult;-><init>(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Landroid/content/Intent;)V

    .line 44
    return-void
.end method

.method constructor <init>(Landroid/content/Intent;)V
    .locals 8
    .param p1, "intent"    # Landroid/content/Intent;

    .line 47
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v7, p1

    .end local p1    # "intent":Landroid/content/Intent;
    .local v7, "intent":Landroid/content/Intent;
    invoke-direct/range {v0 .. v7}, Lcom/journeyapps/barcodescanner/ScanIntentResult;-><init>(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Landroid/content/Intent;)V

    .line 48
    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Landroid/content/Intent;)V
    .locals 0
    .param p1, "contents"    # Ljava/lang/String;
    .param p2, "formatName"    # Ljava/lang/String;
    .param p3, "rawBytes"    # [B
    .param p4, "orientation"    # Ljava/lang/Integer;
    .param p5, "errorCorrectionLevel"    # Ljava/lang/String;
    .param p6, "barcodeImagePath"    # Ljava/lang/String;
    .param p7, "originalIntent"    # Landroid/content/Intent;

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    iput-object p1, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->contents:Ljava/lang/String;

    .line 58
    iput-object p2, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->formatName:Ljava/lang/String;

    .line 59
    iput-object p3, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->rawBytes:[B

    .line 60
    iput-object p4, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->orientation:Ljava/lang/Integer;

    .line 61
    iput-object p5, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->errorCorrectionLevel:Ljava/lang/String;

    .line 62
    iput-object p6, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->barcodeImagePath:Ljava/lang/String;

    .line 63
    iput-object p7, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->originalIntent:Landroid/content/Intent;

    .line 64
    return-void
.end method

.method public static parseActivityResult(ILandroid/content/Intent;)Lcom/journeyapps/barcodescanner/ScanIntentResult;
    .locals 9
    .param p0, "resultCode"    # I
    .param p1, "intent"    # Landroid/content/Intent;

    .line 137
    const/4 v0, -0x1

    if-ne p0, v0, :cond_1

    .line 138
    const-string v0, "SCAN_RESULT"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 139
    .local v2, "contents":Ljava/lang/String;
    const-string v0, "SCAN_RESULT_FORMAT"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 140
    .local v3, "formatName":Ljava/lang/String;
    const-string v0, "SCAN_RESULT_BYTES"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getByteArrayExtra(Ljava/lang/String;)[B

    move-result-object v4

    .line 141
    .local v4, "rawBytes":[B
    const-string v0, "SCAN_RESULT_ORIENTATION"

    const/high16 v1, -0x80000000

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 142
    .local v0, "intentOrientation":I
    if-ne v0, v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    :goto_0
    move-object v5, v1

    .line 143
    .local v5, "orientation":Ljava/lang/Integer;
    const-string v1, "SCAN_RESULT_ERROR_CORRECTION_LEVEL"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 144
    .local v6, "errorCorrectionLevel":Ljava/lang/String;
    const-string v1, "SCAN_RESULT_IMAGE_PATH"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 145
    .local v7, "barcodeImagePath":Ljava/lang/String;
    new-instance v1, Lcom/journeyapps/barcodescanner/ScanIntentResult;

    move-object v8, p1

    .end local p1    # "intent":Landroid/content/Intent;
    .local v8, "intent":Landroid/content/Intent;
    invoke-direct/range {v1 .. v8}, Lcom/journeyapps/barcodescanner/ScanIntentResult;-><init>(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Landroid/content/Intent;)V

    return-object v1

    .line 153
    .end local v0    # "intentOrientation":I
    .end local v2    # "contents":Ljava/lang/String;
    .end local v3    # "formatName":Ljava/lang/String;
    .end local v4    # "rawBytes":[B
    .end local v5    # "orientation":Ljava/lang/Integer;
    .end local v6    # "errorCorrectionLevel":Ljava/lang/String;
    .end local v7    # "barcodeImagePath":Ljava/lang/String;
    .end local v8    # "intent":Landroid/content/Intent;
    .restart local p1    # "intent":Landroid/content/Intent;
    :cond_1
    move-object v8, p1

    .end local p1    # "intent":Landroid/content/Intent;
    .restart local v8    # "intent":Landroid/content/Intent;
    new-instance p1, Lcom/journeyapps/barcodescanner/ScanIntentResult;

    invoke-direct {p1, v8}, Lcom/journeyapps/barcodescanner/ScanIntentResult;-><init>(Landroid/content/Intent;)V

    return-object p1
.end method


# virtual methods
.method public getBarcodeImagePath()Ljava/lang/String;
    .locals 1

    .line 105
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->barcodeImagePath:Ljava/lang/String;

    return-object v0
.end method

.method public getContents()Ljava/lang/String;
    .locals 1

    .line 70
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->contents:Ljava/lang/String;

    return-object v0
.end method

.method public getErrorCorrectionLevel()Ljava/lang/String;
    .locals 1

    .line 98
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->errorCorrectionLevel:Ljava/lang/String;

    return-object v0
.end method

.method public getFormatName()Ljava/lang/String;
    .locals 1

    .line 77
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->formatName:Ljava/lang/String;

    return-object v0
.end method

.method public getOrientation()Ljava/lang/Integer;
    .locals 1

    .line 91
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->orientation:Ljava/lang/Integer;

    return-object v0
.end method

.method public getOriginalIntent()Landroid/content/Intent;
    .locals 1

    .line 112
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->originalIntent:Landroid/content/Intent;

    return-object v0
.end method

.method public getRawBytes()[B
    .locals 1

    .line 84
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->rawBytes:[B

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 117
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->rawBytes:[B

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->rawBytes:[B

    array-length v0, v0

    .line 118
    .local v0, "rawBytesLength":I
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Format: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->formatName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "Contents: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->contents:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "Raw bytes: ("

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " bytes)\nOrientation: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->orientation:Ljava/lang/Integer;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "EC level: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->errorCorrectionLevel:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "Barcode image: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->barcodeImagePath:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "Original intent: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/journeyapps/barcodescanner/ScanIntentResult;->originalIntent:Landroid/content/Intent;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
