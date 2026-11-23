.class public final synthetic Lcom/google/zxing/client/android/BeepManager$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/media/MediaPlayer$OnErrorListener;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/google/zxing/client/android/BeepManager;"
    method = "lambda$playBeepSound$1"
    proto = "(Landroid/media/MediaPlayer;II)Z"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x1c
    versionHash = "64bbee9deb17f2433a2f464e7880a82f306bf117c38a5da5e35bd2560d29022a"
.end annotation


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onError(Landroid/media/MediaPlayer;II)Z
    .locals 0

    .line 0
    invoke-static {p1, p2, p3}, Lcom/google/zxing/client/android/BeepManager;->lambda$playBeepSound$1(Landroid/media/MediaPlayer;II)Z

    move-result p1

    return p1
.end method
