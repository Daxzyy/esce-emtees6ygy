.class public final synthetic Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lcom/sekolah/ujianbrowser/MainActivity;"
    method = "checkUpdate$lambda$10$lambda$9"
    proto = "(Lcom/sekolah/ujianbrowser/MainActivity;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/jvm/functions/Function0;)V"
.end annotation

.annotation build Lcom/android/tools/r8/annotations/SynthesizedClassV2;
    apiLevel = -0x2
    kind = 0x1c
    versionHash = "64bbee9deb17f2433a2f464e7880a82f306bf117c38a5da5e35bd2560d29022a"
.end annotation


# instance fields
.field public final synthetic f$0:Lcom/sekolah/ujianbrowser/MainActivity;

.field public final synthetic f$1:Lkotlin/jvm/internal/Ref$LongRef;

.field public final synthetic f$2:J

.field public final synthetic f$3:Lkotlin/jvm/functions/Function0;


# direct methods
.method public synthetic constructor <init>(Lcom/sekolah/ujianbrowser/MainActivity;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/jvm/functions/Function0;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$0:Lcom/sekolah/ujianbrowser/MainActivity;

    iput-object p2, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$1:Lkotlin/jvm/internal/Ref$LongRef;

    iput-wide p3, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$2:J

    iput-object p5, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$3:Lkotlin/jvm/functions/Function0;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 5

    .line 0
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$0:Lcom/sekolah/ujianbrowser/MainActivity;

    iget-object v1, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$1:Lkotlin/jvm/internal/Ref$LongRef;

    iget-wide v2, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$2:J

    iget-object v4, p0, Lcom/sekolah/ujianbrowser/MainActivity$$ExternalSyntheticLambda7;->f$3:Lkotlin/jvm/functions/Function0;

    invoke-static {v0, v1, v2, v3, v4}, Lcom/sekolah/ujianbrowser/MainActivity;->checkUpdate$lambda$10$lambda$9(Lcom/sekolah/ujianbrowser/MainActivity;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/jvm/functions/Function0;)V

    return-void
.end method
