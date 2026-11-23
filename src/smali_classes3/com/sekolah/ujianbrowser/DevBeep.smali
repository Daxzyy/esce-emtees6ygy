.class public final Lcom/sekolah/ujianbrowser/DevBeep;
.super Ljava/lang/Object;
.source "DevBeep.kt"

.implements Ljava/lang/Runnable;


.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public run()V
    .locals 18

    const/16 v0, 0x5622

    :try_start_0
    const/4 v2, 0x4

    const/4 v3, 0x2

    invoke-static {v0, v2, v3}, Landroid/media/AudioTrack;->getMinBufferSize(III)I

    move-result v4

    invoke-static {v4, v0}, Ljava/lang/Math;->max(II)I

    move-result v4

    new-instance v10, Landroid/media/AudioTrack;

    const/4 v11, 0x3

    move v12, v0

    const/4 v13, 0x4

    const/4 v14, 0x2

    move v15, v4

    const/16 v16, 0x1

    invoke-direct/range {v10 .. v16}, Landroid/media/AudioTrack;-><init>(IIIIII)V

    move-object v1, v10

    invoke-virtual {v1}, Landroid/media/AudioTrack;->play()V

    div-int/lit8 v2, v0, 0xa

    new-array v3, v2, [S

    const-wide/16 v6, 0x0

    const-wide v13, 0x401921fb54442d18L

    const/4 v5, 0x0

    const/4 v4, 0x0

    :chunk_loop
    const/16 v8, 0xa

    if-ge v4, v8, :chunk_done

    const/4 v8, 0x0

    :sample_loop
    if-ge v8, v2, :sample_done

    int-to-double v9, v5

    int-to-double v15, v0

    div-double/2addr v9, v15

    const-wide/high16 v11, 0x3fe0000000000000L

    cmpg-double v17, v9, v11

    const-wide/high16 v11, 0x4000000000000000L

    if-gez v17, :sweep_down

    mul-double/2addr v11, v9

    goto :sweep_done

    :sweep_down
    const-wide/high16 v15, 0x3ff0000000000000L

    sub-double/2addr v15, v9

    mul-double/2addr v11, v15

    :sweep_done
    const-wide/high16 v15, 0x4089000000000000L

    mul-double/2addr v11, v15

    const-wide v15, 0x4085e00000000000L

    add-double/2addr v11, v15

    mul-double/2addr v11, v13

    int-to-double v15, v0

    div-double/2addr v11, v15

    add-double/2addr v6, v11

    cmpl-double v17, v6, v13

    if-lez v17, :phase_ok

    sub-double/2addr v6, v13

    :phase_ok
    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v11

    const-wide v15, 0x40bf400000000000L

    mul-double/2addr v11, v15

    double-to-int v15, v11

    int-to-short v15, v15

    aput-short v15, v3, v8

    add-int/lit8 v5, v5, 0x1

    rem-int/2addr v5, v0

    add-int/lit8 v8, v8, 0x1

    goto :sample_loop

    :sample_done
    const/4 v8, 0x0

    invoke-virtual {v1, v3, v8, v2}, Landroid/media/AudioTrack;->write([SII)I

    add-int/lit8 v4, v4, 0x1

    goto :chunk_loop

    :chunk_done
    invoke-virtual {v1}, Landroid/media/AudioTrack;->stop()V

    invoke-virtual {v1}, Landroid/media/AudioTrack;->release()V

    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    return-void
.end method
