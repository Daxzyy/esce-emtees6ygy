.class public final Lcom/sekolah/ujianbrowser/AdminCode;
.super Ljava/lang/Object;
.source "AdminCode.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000Z\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0010$\n\u0002\u0010\u0008\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0016\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\t\u0008\u0002\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0008\u0010\u0010\u001a\u00020\u0007H\u0002J\u0018\u0010\u0011\u001a\n \u0013*\u0004\u0018\u00010\u00120\u00122\u0006\u0010\u0014\u001a\u00020\u0015H\u0002J\u000e\u0010\u0016\u001a\u00020\u00172\u0006\u0010\u0014\u001a\u00020\u0015J\u0010\u0010\u0018\u001a\u00020\u00072\u0006\u0010\u0019\u001a\u00020\u0017H\u0002J \u0010\u001a\u001a\u00020\u001b2\u0006\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u001c\u001a\u00020\u00072\u0008\u0008\u0002\u0010\u001d\u001a\u00020\u001bJ\u000e\u0010\u001e\u001a\u00020\u001f2\u0006\u0010\u0014\u001a\u00020\u0015J>\u0010 \u001a\u00020\u001f2\u0006\u0010!\u001a\u00020\"2\u0006\u0010#\u001a\u00020\u00072\u000e\u0008\u0002\u0010$\u001a\u0008\u0012\u0004\u0012\u00020\u001f0%2\u0008\u0008\u0002\u0010\u001d\u001a\u00020\u001b2\u000c\u0010&\u001a\u0008\u0012\u0004\u0012\u00020\u001f0%R\u001a\u0010\u0004\u001a\u000e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00070\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/sekolah/ujianbrowser/AdminCode;",
        "",
        "<init>",
        "()V",
        "CODE_BY_DAY",
        "",
        "",
        "",
        "MASTER_CODE",
        "MAX_FAILS",
        "LOCK_STEPS_MS",
        "",
        "PREFS",
        "K_FAILS",
        "K_LEVEL",
        "K_LOCK_UNTIL",
        "expectedCode",
        "prefs",
        "Landroid/content/SharedPreferences;",
        "kotlin.jvm.PlatformType",
        "ctx",
        "Landroid/content/Context;",
        "lockedMs",
        "",
        "waitText",
        "ms",
        "verify",
        "",
        "input",
        "master",
        "refresh",
        "",
        "prompt",
        "activity",
        "Landroid/app/Activity;",
        "title",
        "onDismiss",
        "Lkotlin/Function0;",
        "onSuccess",
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


# static fields
.field private static final CODE_BY_DAY:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static final INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

.field private static final K_FAILS:Ljava/lang/String; = "fails"

.field private static final K_LEVEL:Ljava/lang/String; = "level"

.field private static final K_LOCK_UNTIL:Ljava/lang/String; = "lock_until"

.field private static final LOCK_STEPS_MS:[J

.field private static final MASTER_CODE:Ljava/lang/String; = "97683106"

.field private static final MAX_FAILS:I = 0x5

.field private static final PREFS:Ljava/lang/String; = "ujian_admin"


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Lcom/sekolah/ujianbrowser/AdminCode;

    invoke-direct {v0}, Lcom/sekolah/ujianbrowser/AdminCode;-><init>()V

    sput-object v0, Lcom/sekolah/ujianbrowser/AdminCode;->INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

    .line 20
    nop

    .line 21
    const/4 v0, 0x7

    new-array v1, v0, [Lkotlin/Pair;

    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "112530"

    invoke-static {v3, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v1, v4

    .line 22
    const/4 v3, 0x3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const-string v5, "363512"

    invoke-static {v4, v5}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v4

    const/4 v5, 0x1

    aput-object v4, v1, v5

    .line 21
    nop

    .line 23
    const/4 v4, 0x4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const-string v7, "362584"

    invoke-static {v6, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    aput-object v6, v1, v2

    .line 21
    nop

    .line 24
    const/4 v2, 0x5

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const-string v7, "890570"

    invoke-static {v6, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    aput-object v6, v1, v3

    .line 21
    nop

    .line 25
    const/4 v3, 0x6

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const-string v7, "160775"

    invoke-static {v6, v7}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v6

    aput-object v6, v1, v4

    .line 21
    nop

    .line 26
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v4, "980643"

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    aput-object v0, v1, v2

    .line 21
    nop

    .line 27
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v4, "483479"

    invoke-static {v0, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v0

    aput-object v0, v1, v3

    .line 21
    nop

    .line 20
    invoke-static {v1}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/sekolah/ujianbrowser/AdminCode;->CODE_BY_DAY:Ljava/util/Map;

    .line 39
    new-array v0, v2, [J

    fill-array-data v0, :array_0

    sput-object v0, Lcom/sekolah/ujianbrowser/AdminCode;->LOCK_STEPS_MS:[J

    return-void

    :array_0
    .array-data 8
        0xea60
        0x1d4c0
        0x493e0
        0x927c0
        0xdbba0
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final expectedCode()Ljava/lang/String;
    .locals 3

    .line 48
    const-string v0, "Asia/Jakarta"

    invoke-static {v0}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-static {v0, v1}, Ljava/util/Calendar;->getInstance(Ljava/util/TimeZone;Ljava/util/Locale;)Ljava/util/Calendar;

    move-result-object v0

    .line 49
    .local v0, "cal":Ljava/util/Calendar;
    sget-object v1, Lcom/sekolah/ujianbrowser/AdminCode;->CODE_BY_DAY:Ljava/util/Map;

    const/4 v2, 0x7

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    if-nez v1, :cond_0

    sget-object v1, Lcom/sekolah/ujianbrowser/AdminCode;->CODE_BY_DAY:Ljava/util/Map;

    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lkotlin/collections/MapsKt;->getValue(Ljava/util/Map;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    :cond_0
    return-object v1
.end method

.method private final prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2
    .param p1, "ctx"    # Landroid/content/Context;

    .line 52
    const-string v0, "ujian_admin"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic prompt$default(Lcom/sekolah/ujianbrowser/AdminCode;Landroid/app/Activity;Ljava/lang/String;Lkotlin/jvm/functions/Function0;ZLkotlin/jvm/functions/Function0;ILjava/lang/Object;)V
    .locals 6

    .line 94
    and-int/lit8 p7, p6, 0x4

    if-eqz p7, :cond_0

    .line 97
    new-instance p3, Lcom/sekolah/ujianbrowser/AdminCode$$ExternalSyntheticLambda2;

    invoke-direct {p3}, Lcom/sekolah/ujianbrowser/AdminCode$$ExternalSyntheticLambda2;-><init>()V

    move-object v3, p3

    goto :goto_0

    .line 94
    :cond_0
    move-object v3, p3

    :goto_0
    and-int/lit8 p6, p6, 0x8

    if-eqz p6, :cond_1

    .line 98
    const/4 p4, 0x0

    move v4, p4

    goto :goto_1

    .line 94
    :cond_1
    move v4, p4

    :goto_1
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/sekolah/ujianbrowser/AdminCode;->prompt(Landroid/app/Activity;Ljava/lang/String;Lkotlin/jvm/functions/Function0;ZLkotlin/jvm/functions/Function0;)V

    return-void
.end method

.method static final prompt$lambda$0()Lkotlin/Unit;
    .locals 1

    .line 97
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method static final prompt$lambda$1(Landroid/app/Activity;Landroid/widget/EditText;ZLkotlin/jvm/functions/Function0;Landroid/content/DialogInterface;I)V
    .locals 5
    .param p0, "$activity"    # Landroid/app/Activity;
    .param p1, "$input"    # Landroid/widget/EditText;
    .param p2, "$master"    # Z
    .param p3, "$onSuccess"    # Lkotlin/jvm/functions/Function0;

    .line 125
    sget-object p4, Lcom/sekolah/ujianbrowser/AdminCode;->INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

    move-object p5, p0

    check-cast p5, Landroid/content/Context;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p4, p5, v0, p2}, Lcom/sekolah/ujianbrowser/AdminCode;->verify(Landroid/content/Context;Ljava/lang/String;Z)Z

    move-result p4

    if-eqz p4, :cond_0

    .line 126
    invoke-interface {p3}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    goto/16 :goto_0

    .line 128
    :cond_0
    sget-object p4, Lcom/sekolah/ujianbrowser/AdminCode;->INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

    move-object p5, p0

    check-cast p5, Landroid/content/Context;

    invoke-virtual {p4, p5}, Lcom/sekolah/ujianbrowser/AdminCode;->lockedMs(Landroid/content/Context;)J

    move-result-wide p4

    .line 129
    .local p4, "locked":J
    const-wide/16 v0, 0x0

    cmp-long v0, p4, v0

    const/4 v1, 0x1

    if-lez v0, :cond_1

    .line 131
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    .line 132
    sget-object v2, Lcom/sekolah/ujianbrowser/AdminCode;->INSTANCE:Lcom/sekolah/ujianbrowser/AdminCode;

    invoke-direct {v2, p4, p5}, Lcom/sekolah/ujianbrowser/AdminCode;->waitText(J)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Terlalu banyak percobaan salah. Dikunci "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    .line 133
    nop

    .line 130
    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    .line 134
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 136
    :cond_1
    const/16 v0, 0x8

    new-array v0, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, ""

    aput-object v3, v0, v2

    const-string v2, "Minggu"

    aput-object v2, v0, v1

    const/4 v2, 0x2

    const-string v3, "Senin"

    aput-object v3, v0, v2

    const/4 v2, 0x3

    const-string v3, "Selasa"

    aput-object v3, v0, v2

    const/4 v2, 0x4

    const-string v3, "Rabu"

    aput-object v3, v0, v2

    const/4 v2, 0x5

    const-string v3, "Kamis"

    aput-object v3, v0, v2

    const/4 v2, 0x6

    const-string v3, "Jumat"

    aput-object v3, v0, v2

    const-string v2, "Sabtu"

    const/4 v3, 0x7

    aput-object v2, v0, v3

    .line 137
    const-string v2, "Asia/Jakarta"

    invoke-static {v2}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v2

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-static {v2, v4}, Ljava/util/Calendar;->getInstance(Ljava/util/TimeZone;Ljava/util/Locale;)Ljava/util/Calendar;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/util/Calendar;->get(I)I

    move-result v2

    aget-object v0, v0, v2

    .line 136
    nop

    .line 138
    .local v0, "hari":Ljava/lang/String;
    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Kode salah (hari menurut HP: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v2, v3, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 141
    .end local v0    # "hari":Ljava/lang/String;
    .end local p4    # "locked":J
    :goto_0
    return-void
.end method

.method static final prompt$lambda$2(Lkotlin/jvm/functions/Function0;Landroid/content/DialogInterface;)V
    .locals 0
    .param p0, "$onDismiss"    # Lkotlin/jvm/functions/Function0;
    .param p1, "it"    # Landroid/content/DialogInterface;

    .line 143
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    return-void
.end method

.method public static synthetic verify$default(Lcom/sekolah/ujianbrowser/AdminCode;Landroid/content/Context;Ljava/lang/String;ZILjava/lang/Object;)Z
    .locals 0

    .line 66
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_0

    const/4 p3, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/sekolah/ujianbrowser/AdminCode;->verify(Landroid/content/Context;Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method private final waitText(J)Ljava/lang/String;
    .locals 8
    .param p1, "ms"    # J

    .line 62
    const-wide/16 v0, 0x3e7

    add-long/2addr v0, p1

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 63
    .local v0, "s":J
    const-wide/16 v2, 0x3c

    cmp-long v4, v0, v2

    const-string v5, " detik"

    if-ltz v4, :cond_0

    div-long v6, v0, v2

    rem-long v2, v0, v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " menit "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    goto :goto_0

    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    :goto_0
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method


# virtual methods
.method public final lockedMs(Landroid/content/Context;)J
    .locals 10
    .param p1, "ctx"    # Landroid/content/Context;


    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z
    if-eqz v0, :dev_mode_orig
    const-wide/16 v0, 0x0
    return-wide v0
    :dev_mode_orig

    const-string v0, "ctx"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    invoke-direct {p0, p1}, Lcom/sekolah/ujianbrowser/AdminCode;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "lock_until"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 57
    .local v0, "until":J
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sub-long v4, v0, v4

    .line 58
    .local v4, "left":J
    const-wide/16 v6, 0x1

    cmp-long v6, v6, v4

    const/4 v7, 0x0

    if-gtz v6, :cond_0

    sget-object v6, Lcom/sekolah/ujianbrowser/AdminCode;->LOCK_STEPS_MS:[J

    invoke-static {v6}, Lkotlin/collections/ArraysKt;->last([J)J

    move-result-wide v8

    cmp-long v6, v4, v8

    if-gtz v6, :cond_0

    const/4 v7, 0x1

    :cond_0
    if-eqz v7, :cond_1

    move-wide v2, v4

    :cond_1
    return-wide v2
.end method

.method public final prompt(Landroid/app/Activity;Ljava/lang/String;Lkotlin/jvm/functions/Function0;ZLkotlin/jvm/functions/Function0;)V
    .locals 8
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "title"    # Ljava/lang/String;
    .param p3, "onDismiss"    # Lkotlin/jvm/functions/Function0;
    .param p4, "master"    # Z
    .param p5, "onSuccess"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;Z",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "activity"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "title"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onDismiss"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onSuccess"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 101
    move-object v0, p1

    check-cast v0, Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/sekolah/ujianbrowser/AdminCode;->lockedMs(Landroid/content/Context;)J

    move-result-wide v0

    .line 102
    .local v0, "wait":J
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-lez v2, :cond_0

    .line 104
    move-object v2, p1

    check-cast v2, Landroid/content/Context;

    .line 105
    invoke-direct {p0, v0, v1}, Lcom/sekolah/ujianbrowser/AdminCode;->waitText(J)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Terlalu banyak percobaan salah. Coba lagi dalam "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    .line 106
    nop

    .line 103
    const/4 v4, 0x1

    invoke-static {v2, v3, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v2

    .line 107
    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 108
    invoke-interface {p3}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    .line 109
    return-void

    .line 112
    :cond_0
    new-instance v2, Landroid/widget/EditText;

    move-object v3, p1

    check-cast v3, Landroid/content/Context;

    invoke-direct {v2, v3}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 113
    .local v2, "input":Landroid/widget/EditText;
    const/16 v3, 0x12

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setInputType(I)V

    .line 114
    if-eqz p4, :cond_1

    const-string v3, "Kode super admin (8 angka)"

    goto :goto_0

    :cond_1
    const-string v3, "Kode admin (6 angka)"

    :goto_0
    check-cast v3, Ljava/lang/CharSequence;

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 116
    invoke-virtual {p1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    iget v3, v3, Landroid/util/DisplayMetrics;->density:F

    const/high16 v4, 0x41a00000    # 20.0f

    mul-float/2addr v4, v3

    float-to-int v3, v4

    .line 117
    .local v3, "pad":I
    new-instance v4, Landroid/widget/FrameLayout;

    move-object v5, p1

    check-cast v5, Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 118
    .local v4, "box":Landroid/widget/FrameLayout;
    div-int/lit8 v5, v3, 0x2

    const/4 v6, 0x0

    invoke-virtual {v4, v3, v5, v3, v6}, Landroid/widget/FrameLayout;->setPadding(IIII)V

    .line 119
    move-object v5, v2

    check-cast v5, Landroid/view/View;

    invoke-virtual {v4, v5}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 121
    new-instance v5, Landroidx/appcompat/app/AlertDialog$Builder;

    move-object v6, p1

    check-cast v6, Landroid/content/Context;

    invoke-direct {v5, v6}, Landroidx/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 122
    move-object v6, p2

    check-cast v6, Ljava/lang/CharSequence;

    invoke-virtual {v5, v6}, Landroidx/appcompat/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v5

    .line 123
    move-object v6, v4

    check-cast v6, Landroid/view/View;

    invoke-virtual {v5, v6}, Landroidx/appcompat/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v5

    .line 124
    const-string v6, "OK"

    check-cast v6, Ljava/lang/CharSequence;

    new-instance v7, Lcom/sekolah/ujianbrowser/AdminCode$$ExternalSyntheticLambda0;

    invoke-direct {v7, p1, v2, p4, p5}, Lcom/sekolah/ujianbrowser/AdminCode$$ExternalSyntheticLambda0;-><init>(Landroid/app/Activity;Landroid/widget/EditText;ZLkotlin/jvm/functions/Function0;)V

    invoke-virtual {v5, v6, v7}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v5

    .line 142
    const-string v6, "Batal"

    check-cast v6, Ljava/lang/CharSequence;

    const/4 v7, 0x0

    invoke-virtual {v5, v6, v7}, Landroidx/appcompat/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v5

    .line 143
    new-instance v6, Lcom/sekolah/ujianbrowser/AdminCode$$ExternalSyntheticLambda1;

    invoke-direct {v6, p3}, Lcom/sekolah/ujianbrowser/AdminCode$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function0;)V

    invoke-virtual {v5, v6}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v5

    .line 144
    invoke-virtual {v5}, Landroidx/appcompat/app/AlertDialog$Builder;->create()Landroidx/appcompat/app/AlertDialog;

    move-result-object v5

    const-string v6, "create(...)"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 121
    nop

    .line 145
    .local v5, "dialog":Landroidx/appcompat/app/AlertDialog;
    invoke-virtual {v5}, Landroidx/appcompat/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v6

    if-eqz v6, :cond_2

    const/4 v7, 0x4

    invoke-virtual {v6, v7}, Landroid/view/Window;->setSoftInputMode(I)V

    .line 146
    :cond_2
    invoke-virtual {v5}, Landroidx/appcompat/app/AlertDialog;->show()V

    .line 147
    return-void
.end method

.method public final refresh(Landroid/content/Context;)V
    .locals 1
    .param p1, "ctx"    # Landroid/content/Context;

    const-string v0, "ctx"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 91
    return-void
.end method

.method public final verify(Landroid/content/Context;Ljava/lang/String;Z)Z
    .locals 11
    .param p1, "ctx"    # Landroid/content/Context;
    .param p2, "input"    # Ljava/lang/String;
    .param p3, "master"    # Z


    sget-boolean v0, Lcom/sekolah/ujianbrowser/DevMode;->modEnabled:Z
    if-eqz v0, :dev_mode_orig
    const/4 v0, 0x1
    return v0
    :dev_mode_orig

    const-string v0, "ctx"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "input"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    invoke-virtual {p0, p1}, Lcom/sekolah/ujianbrowser/AdminCode;->lockedMs(Landroid/content/Context;)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    const/4 v1, 0x0

    if-lez v0, :cond_0

    return v1

    .line 68
    :cond_0
    invoke-direct {p0, p1}, Lcom/sekolah/ujianbrowser/AdminCode;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 69
    .local v0, "p":Landroid/content/SharedPreferences;
    if-eqz p3, :cond_1

    const-string v2, "97683106"

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lcom/sekolah/ujianbrowser/AdminCode;->expectedCode()Ljava/lang/String;

    move-result-object v2

    .line 70
    .local v2, "expected":Ljava/lang/String;
    :goto_0
    move-object v3, p2

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    const-string v4, "level"

    const/4 v5, 0x1

    const-string v6, "fails"

    if-eqz v3, :cond_2

    .line 71
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v6, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 72
    return v5

    .line 74
    :cond_2
    invoke-interface {v0, v6, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v3

    add-int/2addr v3, v5

    .line 75
    .local v3, "fails":I
    const/4 v7, 0x5

    if-lt v3, v7, :cond_3

    .line 76
    invoke-interface {v0, v4, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v7

    .line 77
    .local v7, "level":I
    sget-object v8, Lcom/sekolah/ujianbrowser/AdminCode;->LOCK_STEPS_MS:[J

    sget-object v9, Lcom/sekolah/ujianbrowser/AdminCode;->LOCK_STEPS_MS:[J

    array-length v9, v9

    sub-int/2addr v9, v5

    invoke-static {v7, v9}, Ljava/lang/Math;->min(II)I

    move-result v5

    aget-wide v9, v8, v5

    .line 78
    .local v9, "lockMs":J
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    .line 79
    invoke-interface {v5, v6, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    .line 80
    add-int/lit8 v6, v7, 0x1

    invoke-interface {v5, v4, v6}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    .line 81
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    add-long/2addr v5, v9

    const-string v8, "lock_until"

    invoke-interface {v4, v8, v5, v6}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    .line 82
    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->apply()V

    .end local v7    # "level":I
    .end local v9    # "lockMs":J
    goto :goto_1

    .line 84
    :cond_3
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    invoke-interface {v4, v6, v3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 86
    :goto_1
    return v1
.end method
