.class public final Lcom/sekolah/ujianbrowser/ChipsetKt;
.super Ljava/lang/Object;
.source "ChipsetKt.kt"

# static fields
.field private static final CHIPMAP:Ljava/util/HashMap;

# static initializer
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/sekolah/ujianbrowser/ChipsetKt;->CHIPMAP:Ljava/util/HashMap;

    const-string v1, "MT6833"
    const-string v2, "Dimensity 700"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6873"
    const-string v2, "Dimensity 800"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6875"
    const-string v2, "Dimensity 820"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6877"
    const-string v2, "Dimensity 900"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6878"
    const-string v2, "Dimensity 7300"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6879"
    const-string v2, "Dimensity 7030"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6886"
    const-string v2, "Dimensity 7200"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6889"
    const-string v2, "Dimensity 1000+"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6891"
    const-string v2, "Dimensity 1100"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6893"
    const-string v2, "Dimensity 1200"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6895Z"
    const-string v2, "Dimensity 8100"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6896"
    const-string v2, "Dimensity 8200"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6897"
    const-string v2, "Dimensity 8300"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6899"
    const-string v2, "Dimensity 8400"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6983"
    const-string v2, "Dimensity 9000"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6985"
    const-string v2, "Dimensity 9200"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6989"
    const-string v2, "Dimensity 9300"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6991"
    const-string v2, "Dimensity 9400"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "MT6993"
    const-string v2, "Dimensity 9500"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E7570"
    const-string v2, "Exynos 7570"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E8535"
    const-string v2, "Exynos 1330"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E8825"
    const-string v2, "Exynos 1280"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E8835"
    const-string v2, "Exynos 1380"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E8845"
    const-string v2, "Exynos 1480"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E8855"
    const-string v2, "Exynos 1580"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E8895"
    const-string v2, "Exynos 8895"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9610"
    const-string v2, "Exynos 9610"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9611"
    const-string v2, "Exynos 9611"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9630"
    const-string v2, "Exynos 980"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9810"
    const-string v2, "Exynos 9810"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9815"
    const-string v2, "Exynos 1080"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9820"
    const-string v2, "Exynos 9820"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9825"
    const-string v2, "Exynos 9825"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9830"
    const-string v2, "Exynos 990"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9840"
    const-string v2, "Exynos 2100"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9925"
    const-string v2, "Exynos 2200"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9945"
    const-string v2, "Exynos 2400"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9955"
    const-string v2, "Exynos 2500"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5E9965"
    const-string v2, "Exynos 2600"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5P9845"
    const-string v2, "Tensor G1"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5P9855"
    const-string v2, "Tensor G2"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5P9865"
    const-string v2, "Tensor G3"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "S5P9875"
    const-string v2, "Tensor G4"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM4350"
    const-string v2, "Snapdragon 480"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM4450"
    const-string v2, "Snapdragon 4 Gen 1"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM4550"
    const-string v2, "Snapdragon 4 Gen 2"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM6150"
    const-string v2, "Dimensity 675"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM6225"
    const-string v2, "Dimensity 680"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM6375"
    const-string v2, "Dimensity 695"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM6450"
    const-string v2, "Dimensity 6 Gen 1"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM7150"
    const-string v2, "Snapdragon 730"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM7150-AC"
    const-string v2, "Snapdragon 730G"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM7325"
    const-string v2, "Snapdragon 778G"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM7350"
    const-string v2, "Snapdragon 780G"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM7450"
    const-string v2, "Snapdragon 7 Gen 1"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM7475"
    const-string v2, "Snapdragon 7+ Gen 2"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM7675"
    const-string v2, "Snapdragon 7 Gen 3"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8150"
    const-string v2, "Snapdragon 855"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8150-AC"
    const-string v2, "Snapdragon 855+"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8150-AD"
    const-string v2, "Snapdragon 860"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8250"
    const-string v2, "Snapdragon 865"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8250-AB"
    const-string v2, "Snapdragon 865+"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8250-AC"
    const-string v2, "Snapdragon 870"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8350"
    const-string v2, "Snapdragon 888"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8350-AC"
    const-string v2, "Snapdragon 888+"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8450"
    const-string v2, "Snapdragon 8 Gen 1"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8475"
    const-string v2, "Snapdragon 8+ Gen 1"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8550"
    const-string v2, "Snapdragon 8 Gen 2"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8550-AC"
    const-string v2, "Snapdragon 8 Gen 2 for Galaxy"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8635"
    const-string v2, "Snapdragon 8s Gen 3"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8650"
    const-string v2, "Snapdragon 8 Gen 3"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8650-AC"
    const-string v2, "Snapdragon 8 Gen 3 for Galaxy"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8735"
    const-string v2, "Snapdragon 8s Gen 4"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8750"
    const-string v2, "Snapdragon 8 Elite"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8845"
    const-string v2, "Snapdragon 8 Gen 5"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "SM8850"
    const-string v2, "Snapdragon 8 Elite Gen 5"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "UMS9230"
    const-string v2, "Tiger T606"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "UMS9230E"
    const-string v2, "Tiger T615"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "UMS9230H"
    const-string v2, "Tiger T612"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "UMS9230S"
    const-string v2, "Tiger T620"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    const-string v1, "UMS9230T"
    const-string v2, "Tiger T616"
    invoke-static {v0, v1, v2}, Lcom/sekolah/ujianbrowser/ChipsetKt;->devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

# direct methods
.method public static final detectChipset(Landroid/content/Context;)Ljava/lang/String;
    .locals 6
    .param p0, "ctx"    # Landroid/content/Context;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/4 v1, 0x0
    const/16 v2, 0x1f
    if-lt v0, v2, :dev_chip_def
    sget-object v3, Landroid/os/Build;->SOC_MODEL:Ljava/lang/String;
    if-eqz v3, :dev_chip_def
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v3
    if-eqz v3, :dev_chip_def
    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual {v3, v4}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object v3
    sget-object v4, Lcom/sekolah/ujianbrowser/ChipsetKt;->CHIPMAP:Ljava/util/HashMap;
    invoke-virtual {v4, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v4
    if-eqz v4, :dev_chip_def
    return-object v4
    :dev_chip_def
    const-string v4, "Tidak diketahui"
    return-object v4
.end method

.method public static final devPut(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "map"    # Ljava/util/HashMap;
    .param p1, "k"    # Ljava/lang/String;
    .param p2, "v"    # Ljava/lang/String;
    invoke-virtual {p0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    return-void
.end method