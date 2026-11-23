.class Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;
.super Ljava/lang/Object;
.source "ConstraintLayout.java"

# interfaces
.implements Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measurer;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/constraintlayout/widget/ConstraintLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "Measurer"
.end annotation


# instance fields
.field layout:Landroidx/constraintlayout/widget/ConstraintLayout;

.field layoutHeightSpec:I

.field layoutWidthSpec:I

.field paddingBottom:I

.field paddingHeight:I

.field paddingTop:I

.field paddingWidth:I

.field final synthetic this$0:Landroidx/constraintlayout/widget/ConstraintLayout;


# direct methods
.method public constructor <init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroidx/constraintlayout/widget/ConstraintLayout;)V
    .locals 0
    .param p1, "this$0"    # Landroidx/constraintlayout/widget/ConstraintLayout;
    .param p2, "l"    # Landroidx/constraintlayout/widget/ConstraintLayout;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x0
        }
        names = {
            "this$0",
            "l"
        }
    .end annotation

    .line 637
    iput-object p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->this$0:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 638
    iput-object p2, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 639
    return-void
.end method

.method private isSimilarSpec(III)Z
    .locals 6
    .param p1, "lastMeasureSpec"    # I
    .param p2, "spec"    # I
    .param p3, "widgetSize"    # I
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0
        }
        names = {
            "lastMeasureSpec",
            "spec",
            "widgetSize"
        }
    .end annotation

    .line 906
    const/4 v0, 0x1

    if-ne p1, p2, :cond_0

    .line 907
    return v0

    .line 909
    :cond_0
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v1

    .line 910
    .local v1, "lastMode":I
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v2

    .line 911
    .local v2, "lastSize":I
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v3

    .line 912
    .local v3, "mode":I
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v4

    .line 913
    .local v4, "size":I
    const/high16 v5, 0x40000000    # 2.0f

    if-ne v3, v5, :cond_2

    const/high16 v5, -0x80000000

    if-eq v1, v5, :cond_1

    if-nez v1, :cond_2

    :cond_1
    if-ne p3, v4, :cond_2

    .line 916
    return v0

    .line 918
    :cond_2
    const/4 v0, 0x0

    return v0
.end method


# virtual methods
.method public captureLayoutInfo(IIIIII)V
    .locals 0
    .param p1, "widthSpec"    # I
    .param p2, "heightSpec"    # I
    .param p3, "top"    # I
    .param p4, "bottom"    # I
    .param p5, "width"    # I
    .param p6, "height"    # I
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0,
            0x0,
            0x0,
            0x0
        }
        names = {
            "widthSpec",
            "heightSpec",
            "top",
            "bottom",
            "width",
            "height"
        }
    .end annotation

    .line 629
    iput p3, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->paddingTop:I

    .line 630
    iput p4, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->paddingBottom:I

    .line 631
    iput p5, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->paddingWidth:I

    .line 632
    iput p6, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->paddingHeight:I

    .line 633
    iput p1, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutWidthSpec:I

    .line 634
    iput p2, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutHeightSpec:I

    .line 635
    return-void
.end method

.method public final didMeasures()V
    .locals 5

    .line 923
    iget-object v0, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v0}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildCount()I

    move-result v0

    .line 924
    .local v0, "widgetsCount":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_1

    .line 925
    iget-object v2, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v2, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 926
    .local v2, "child":Landroid/view/View;
    instance-of v3, v2, Landroidx/constraintlayout/widget/Placeholder;

    if-eqz v3, :cond_0

    .line 927
    move-object v3, v2

    check-cast v3, Landroidx/constraintlayout/widget/Placeholder;

    iget-object v4, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v4}, Landroidx/constraintlayout/widget/Placeholder;->updatePostMeasure(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 924
    .end local v2    # "child":Landroid/view/View;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 931
    .end local v1    # "i":I
    :cond_1
    iget-object v1, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-static {v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->access$100(Landroidx/constraintlayout/widget/ConstraintLayout;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 932
    .local v1, "helperCount":I
    if-lez v1, :cond_2

    .line 933
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v1, :cond_2

    .line 934
    iget-object v3, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-static {v3}, Landroidx/constraintlayout/widget/ConstraintLayout;->access$100(Landroidx/constraintlayout/widget/ConstraintLayout;)Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/constraintlayout/widget/ConstraintHelper;

    .line 935
    .local v3, "helper":Landroidx/constraintlayout/widget/ConstraintHelper;
    iget-object v4, p0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v4}, Landroidx/constraintlayout/widget/ConstraintHelper;->updatePostMeasure(Landroidx/constraintlayout/widget/ConstraintLayout;)V

    .line 933
    .end local v3    # "helper":Landroidx/constraintlayout/widget/ConstraintHelper;
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 938
    .end local v2    # "i":I
    :cond_2
    return-void
.end method

.method public final measure(Landroidx/constraintlayout/core/widgets/ConstraintWidget;Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;)V
    .locals 30
    .param p1, "widget"    # Landroidx/constraintlayout/core/widgets/ConstraintWidget;
    .param p2, "measure"    # Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "widget",
            "measure"
        }
    .end annotation

    .line 645
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    if-nez v1, :cond_0

    .line 646
    return-void

    .line 648
    :cond_0
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getVisibility()I

    move-result v3

    const/16 v4, 0x8

    const/4 v5, 0x0

    if-ne v3, v4, :cond_1

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->isInPlaceholder()Z

    move-result v3

    if-nez v3, :cond_1

    .line 649
    iput v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredWidth:I

    .line 650
    iput v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredHeight:I

    .line 651
    iput v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredBaseline:I

    .line 652
    return-void

    .line 654
    :cond_1
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getParent()Landroidx/constraintlayout/core/widgets/ConstraintWidget;

    move-result-object v3

    if-nez v3, :cond_2

    .line 655
    return-void

    .line 665
    :cond_2
    iget-object v3, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->horizontalBehavior:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 666
    .local v3, "horizontalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    iget-object v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->verticalBehavior:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    .line 668
    .local v4, "verticalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    iget v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->horizontalDimension:I

    .line 669
    .local v6, "horizontalDimension":I
    iget v7, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->verticalDimension:I

    .line 671
    .local v7, "verticalDimension":I
    const/4 v8, 0x0

    .line 672
    .local v8, "horizontalSpec":I
    const/4 v9, 0x0

    .line 674
    .local v9, "verticalSpec":I
    iget v10, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->paddingTop:I

    iget v11, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->paddingBottom:I

    add-int/2addr v10, v11

    .line 675
    .local v10, "heightPadding":I
    iget v11, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->paddingWidth:I

    .line 677
    .local v11, "widthPadding":I
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getCompanionWidget()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroid/view/View;

    .line 679
    .local v12, "child":Landroid/view/View;
    sget-object v13, Landroidx/constraintlayout/widget/ConstraintLayout$1;->$SwitchMap$androidx$constraintlayout$core$widgets$ConstraintWidget$DimensionBehaviour:[I

    invoke-virtual {v3}, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->ordinal()I

    move-result v14

    aget v13, v13, v14

    const/4 v15, -0x2

    const/4 v14, 0x1

    packed-switch v13, :pswitch_data_0

    goto/16 :goto_3

    .line 695
    :pswitch_0
    iget v13, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutWidthSpec:I

    invoke-static {v13, v11, v15}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v8

    .line 696
    iget v13, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintDefaultWidth:I

    if-ne v13, v14, :cond_3

    move v13, v14

    goto :goto_0

    :cond_3
    const/4 v13, 0x0

    .line 697
    .local v13, "shouldDoWrap":Z
    :goto_0
    iget v14, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    sget v15, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->TRY_GIVEN_DIMENSIONS:I

    if-eq v14, v15, :cond_4

    iget v14, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    sget v15, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->USE_GIVEN_DIMENSIONS:I

    if-eq v14, v15, :cond_4

    goto :goto_3

    .line 703
    :cond_4
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredHeight()I

    move-result v14

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getHeight()I

    move-result v15

    if-ne v14, v15, :cond_5

    const/4 v14, 0x1

    goto :goto_1

    :cond_5
    const/4 v14, 0x0

    .line 704
    .local v14, "otherDimensionStable":Z
    :goto_1
    iget v15, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    sget v5, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->USE_GIVEN_DIMENSIONS:I

    if-eq v15, v5, :cond_7

    if-eqz v13, :cond_7

    if-eqz v13, :cond_6

    if-nez v14, :cond_7

    :cond_6
    instance-of v5, v12, Landroidx/constraintlayout/widget/Placeholder;

    if-nez v5, :cond_7

    .line 708
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->isResolvedHorizontally()Z

    move-result v5

    if-nez v5, :cond_7

    const/4 v5, 0x0

    goto :goto_2

    :cond_7
    const/4 v5, 0x1

    .line 709
    .local v5, "useCurrent":Z
    :goto_2
    if-eqz v5, :cond_8

    .line 710
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getWidth()I

    move-result v15

    move/from16 v18, v5

    const/high16 v5, 0x40000000    # 2.0f

    .end local v5    # "useCurrent":Z
    .local v18, "useCurrent":Z
    invoke-static {v15, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v8

    goto :goto_3

    .line 709
    .end local v18    # "useCurrent":Z
    .restart local v5    # "useCurrent":Z
    :cond_8
    move/from16 v18, v5

    .end local v5    # "useCurrent":Z
    .restart local v18    # "useCurrent":Z
    goto :goto_3

    .line 690
    .end local v13    # "shouldDoWrap":Z
    .end local v14    # "otherDimensionStable":Z
    .end local v18    # "useCurrent":Z
    :pswitch_1
    iget v5, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutWidthSpec:I

    .line 691
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getHorizontalMargin()I

    move-result v13

    add-int/2addr v13, v11

    .line 690
    const/4 v14, -0x1

    invoke-static {v5, v13, v14}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v8

    .line 693
    goto :goto_3

    .line 685
    :pswitch_2
    iget v5, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutWidthSpec:I

    const/4 v13, -0x2

    invoke-static {v5, v11, v13}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v8

    .line 687
    goto :goto_3

    .line 681
    :pswitch_3
    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v6, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v8

    .line 683
    nop

    .line 717
    :goto_3
    sget-object v5, Landroidx/constraintlayout/widget/ConstraintLayout$1;->$SwitchMap$androidx$constraintlayout$core$widgets$ConstraintWidget$DimensionBehaviour:[I

    invoke-virtual {v4}, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->ordinal()I

    move-result v13

    aget v5, v5, v13

    packed-switch v5, :pswitch_data_1

    goto/16 :goto_7

    .line 734
    :pswitch_4
    iget v5, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutHeightSpec:I

    const/4 v13, -0x2

    invoke-static {v5, v10, v13}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v9

    .line 736
    iget v5, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintDefaultHeight:I

    const/4 v13, 0x1

    if-ne v5, v13, :cond_9

    const/4 v5, 0x1

    goto :goto_4

    :cond_9
    const/4 v5, 0x0

    .line 737
    .local v5, "shouldDoWrap":Z
    :goto_4
    iget v13, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    sget v14, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->TRY_GIVEN_DIMENSIONS:I

    if-eq v13, v14, :cond_a

    iget v13, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    sget v14, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->USE_GIVEN_DIMENSIONS:I

    if-eq v13, v14, :cond_a

    goto :goto_7

    .line 743
    :cond_a
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredWidth()I

    move-result v13

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getWidth()I

    move-result v14

    if-ne v13, v14, :cond_b

    const/4 v13, 0x1

    goto :goto_5

    :cond_b
    const/4 v13, 0x0

    .line 744
    .local v13, "otherDimensionStable":Z
    :goto_5
    iget v14, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    sget v15, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->USE_GIVEN_DIMENSIONS:I

    if-eq v14, v15, :cond_d

    if-eqz v5, :cond_d

    if-eqz v5, :cond_c

    if-nez v13, :cond_d

    :cond_c
    instance-of v14, v12, Landroidx/constraintlayout/widget/Placeholder;

    if-nez v14, :cond_d

    .line 748
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->isResolvedVertically()Z

    move-result v14

    if-nez v14, :cond_d

    const/4 v14, 0x0

    goto :goto_6

    :cond_d
    const/4 v14, 0x1

    .line 749
    .local v14, "useCurrent":Z
    :goto_6
    if-eqz v14, :cond_e

    .line 750
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getHeight()I

    move-result v15

    move/from16 v16, v5

    const/high16 v5, 0x40000000    # 2.0f

    .end local v5    # "shouldDoWrap":Z
    .local v16, "shouldDoWrap":Z
    invoke-static {v15, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v9

    goto :goto_7

    .line 749
    .end local v16    # "shouldDoWrap":Z
    .restart local v5    # "shouldDoWrap":Z
    :cond_e
    move/from16 v16, v5

    .end local v5    # "shouldDoWrap":Z
    .restart local v16    # "shouldDoWrap":Z
    goto :goto_7

    .line 729
    .end local v13    # "otherDimensionStable":Z
    .end local v14    # "useCurrent":Z
    .end local v16    # "shouldDoWrap":Z
    :pswitch_5
    iget v5, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutHeightSpec:I

    .line 730
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getVerticalMargin()I

    move-result v13

    add-int/2addr v13, v10

    .line 729
    const/4 v14, -0x1

    invoke-static {v5, v13, v14}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v9

    .line 732
    goto :goto_7

    .line 723
    :pswitch_6
    iget v5, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->layoutHeightSpec:I

    const/4 v13, -0x2

    invoke-static {v5, v10, v13}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v9

    .line 726
    goto :goto_7

    .line 719
    :pswitch_7
    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v7, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v9

    .line 721
    nop

    .line 757
    :goto_7
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getParent()Landroidx/constraintlayout/core/widgets/ConstraintWidget;

    move-result-object v5

    check-cast v5, Landroidx/constraintlayout/core/widgets/ConstraintWidgetContainer;

    .line 758
    .local v5, "container":Landroidx/constraintlayout/core/widgets/ConstraintWidgetContainer;
    if-eqz v5, :cond_10

    iget-object v13, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->this$0:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-static {v13}, Landroidx/constraintlayout/widget/ConstraintLayout;->access$000(Landroidx/constraintlayout/widget/ConstraintLayout;)I

    move-result v13

    const/16 v14, 0x100

    invoke-static {v13, v14}, Landroidx/constraintlayout/core/widgets/Optimizer;->enabled(II)Z

    move-result v13

    if-eqz v13, :cond_10

    .line 759
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredWidth()I

    move-result v13

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getWidth()I

    move-result v14

    if-ne v13, v14, :cond_10

    .line 762
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredWidth()I

    move-result v13

    invoke-virtual {v5}, Landroidx/constraintlayout/core/widgets/ConstraintWidgetContainer;->getWidth()I

    move-result v14

    if-ge v13, v14, :cond_10

    .line 763
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredHeight()I

    move-result v13

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getHeight()I

    move-result v14

    if-ne v13, v14, :cond_10

    .line 764
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredHeight()I

    move-result v13

    invoke-virtual {v5}, Landroidx/constraintlayout/core/widgets/ConstraintWidgetContainer;->getHeight()I

    move-result v14

    if-ge v13, v14, :cond_10

    .line 765
    invoke-virtual {v12}, Landroid/view/View;->getBaseline()I

    move-result v13

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getBaselineDistance()I

    move-result v14

    if-ne v13, v14, :cond_10

    .line 766
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->isMeasureRequested()Z

    move-result v13

    if-nez v13, :cond_10

    .line 768
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getLastHorizontalMeasureSpec()I

    move-result v13

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getWidth()I

    move-result v14

    invoke-direct {v0, v13, v8, v14}, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->isSimilarSpec(III)Z

    move-result v13

    if-eqz v13, :cond_f

    .line 769
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getLastVerticalMeasureSpec()I

    move-result v13

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getHeight()I

    move-result v14

    invoke-direct {v0, v13, v9, v14}, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->isSimilarSpec(III)Z

    move-result v13

    if-eqz v13, :cond_f

    const/4 v13, 0x1

    goto :goto_8

    :cond_f
    const/4 v13, 0x0

    .line 770
    .local v13, "similar":Z
    :goto_8
    if-eqz v13, :cond_10

    .line 771
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getWidth()I

    move-result v14

    iput v14, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredWidth:I

    .line 772
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getHeight()I

    move-result v14

    iput v14, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredHeight:I

    .line 773
    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getBaselineDistance()I

    move-result v14

    iput v14, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredBaseline:I

    .line 778
    return-void

    .line 783
    .end local v13    # "similar":Z
    :cond_10
    sget-object v13, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    if-ne v3, v13, :cond_11

    const/4 v13, 0x1

    goto :goto_9

    :cond_11
    const/4 v13, 0x0

    .line 784
    .local v13, "horizontalMatchConstraints":Z
    :goto_9
    sget-object v14, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_CONSTRAINT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    if-ne v4, v14, :cond_12

    const/4 v14, 0x1

    goto :goto_a

    :cond_12
    const/4 v14, 0x0

    .line 786
    .local v14, "verticalMatchConstraints":Z
    :goto_a
    sget-object v15, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    if-eq v4, v15, :cond_13

    sget-object v15, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    if-eq v4, v15, :cond_13

    const/4 v15, 0x0

    goto :goto_b

    :cond_13
    const/4 v15, 0x1

    .line 788
    .local v15, "verticalDimensionKnown":Z
    :goto_b
    move-object/from16 v16, v4

    .end local v4    # "verticalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    .local v16, "verticalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    sget-object v4, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->MATCH_PARENT:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    if-eq v3, v4, :cond_14

    sget-object v4, Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;->FIXED:Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;

    if-eq v3, v4, :cond_14

    const/4 v4, 0x0

    goto :goto_c

    :cond_14
    const/4 v4, 0x1

    .line 790
    .local v4, "horizontalDimensionKnown":Z
    :goto_c
    const/16 v18, 0x0

    if-eqz v13, :cond_15

    move-object/from16 v19, v3

    .end local v3    # "horizontalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    .local v19, "horizontalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    iget v3, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mDimensionRatio:F

    cmpl-float v3, v3, v18

    if-lez v3, :cond_16

    const/4 v3, 0x1

    goto :goto_d

    .end local v19    # "horizontalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    .restart local v3    # "horizontalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    :cond_15
    move-object/from16 v19, v3

    .end local v3    # "horizontalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    .restart local v19    # "horizontalBehavior":Landroidx/constraintlayout/core/widgets/ConstraintWidget$DimensionBehaviour;
    :cond_16
    const/4 v3, 0x0

    .line 791
    .local v3, "horizontalUseRatio":Z
    :goto_d
    if-eqz v14, :cond_17

    move/from16 v20, v3

    .end local v3    # "horizontalUseRatio":Z
    .local v20, "horizontalUseRatio":Z
    iget v3, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mDimensionRatio:F

    cmpl-float v3, v3, v18

    if-lez v3, :cond_18

    const/4 v3, 0x1

    goto :goto_e

    .end local v20    # "horizontalUseRatio":Z
    .restart local v3    # "horizontalUseRatio":Z
    :cond_17
    move/from16 v20, v3

    .end local v3    # "horizontalUseRatio":Z
    .restart local v20    # "horizontalUseRatio":Z
    :cond_18
    const/4 v3, 0x0

    .line 793
    .local v3, "verticalUseRatio":Z
    :goto_e
    if-nez v12, :cond_19

    .line 794
    return-void

    .line 796
    :cond_19
    invoke-virtual {v12}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v18

    move/from16 v21, v3

    .end local v3    # "verticalUseRatio":Z
    .local v21, "verticalUseRatio":Z
    move-object/from16 v3, v18

    check-cast v3, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 798
    .local v3, "params":Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;
    const/16 v18, 0x0

    .line 799
    .local v18, "width":I
    const/16 v22, 0x0

    .line 800
    .local v22, "height":I
    const/16 v23, 0x0

    .line 802
    .local v23, "baseline":I
    move/from16 v24, v4

    .end local v4    # "horizontalDimensionKnown":Z
    .local v24, "horizontalDimensionKnown":Z
    iget v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    move-object/from16 v25, v5

    .end local v5    # "container":Landroidx/constraintlayout/core/widgets/ConstraintWidgetContainer;
    .local v25, "container":Landroidx/constraintlayout/core/widgets/ConstraintWidgetContainer;
    sget v5, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->TRY_GIVEN_DIMENSIONS:I

    if-eq v4, v5, :cond_1a

    iget v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measureStrategy:I

    sget v5, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->USE_GIVEN_DIMENSIONS:I

    if-eq v4, v5, :cond_1a

    if-eqz v13, :cond_1a

    iget v4, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintDefaultWidth:I

    if-nez v4, :cond_1a

    if-eqz v14, :cond_1a

    iget v4, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintDefaultHeight:I

    if-nez v4, :cond_1a

    move/from16 v27, v7

    move/from16 v7, v18

    move/from16 v0, v22

    move/from16 v4, v23

    move/from16 v22, v6

    goto/16 :goto_14

    .line 807
    :cond_1a
    instance-of v4, v12, Landroidx/constraintlayout/widget/VirtualLayout;

    if-eqz v4, :cond_1b

    instance-of v4, v1, Landroidx/constraintlayout/core/widgets/VirtualLayout;

    if-eqz v4, :cond_1b

    .line 808
    move-object v4, v1

    check-cast v4, Landroidx/constraintlayout/core/widgets/VirtualLayout;

    .line 809
    .local v4, "layout":Landroidx/constraintlayout/core/widgets/VirtualLayout;
    move-object v5, v12

    check-cast v5, Landroidx/constraintlayout/widget/VirtualLayout;

    invoke-virtual {v5, v4, v8, v9}, Landroidx/constraintlayout/widget/VirtualLayout;->onMeasure(Landroidx/constraintlayout/core/widgets/VirtualLayout;II)V

    .line 810
    .end local v4    # "layout":Landroidx/constraintlayout/core/widgets/VirtualLayout;
    goto :goto_f

    .line 811
    :cond_1b
    invoke-virtual {v12, v8, v9}, Landroid/view/View;->measure(II)V

    .line 813
    :goto_f
    invoke-virtual {v1, v8, v9}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->setLastMeasureSpec(II)V

    .line 815
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredWidth()I

    move-result v4

    .line 816
    .local v4, "w":I
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredHeight()I

    move-result v5

    .line 817
    .local v5, "h":I
    invoke-virtual {v12}, Landroid/view/View;->getBaseline()I

    move-result v23

    .line 819
    move/from16 v26, v4

    .line 820
    .end local v18    # "width":I
    .local v26, "width":I
    move/from16 v18, v5

    .line 827
    .end local v22    # "height":I
    .local v18, "height":I
    move/from16 v22, v6

    .end local v6    # "horizontalDimension":I
    .local v22, "horizontalDimension":I
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMinWidth:I

    if-lez v6, :cond_1c

    .line 828
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMinWidth:I

    move/from16 v27, v7

    move/from16 v7, v26

    .end local v26    # "width":I
    .local v7, "width":I
    .local v27, "verticalDimension":I
    invoke-static {v6, v7}, Ljava/lang/Math;->max(II)I

    move-result v26

    move/from16 v7, v26

    .end local v7    # "width":I
    .restart local v26    # "width":I
    goto :goto_10

    .line 827
    .end local v27    # "verticalDimension":I
    .local v7, "verticalDimension":I
    :cond_1c
    move/from16 v27, v7

    move/from16 v7, v26

    .line 830
    .end local v26    # "width":I
    .local v7, "width":I
    .restart local v27    # "verticalDimension":I
    :goto_10
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMaxWidth:I

    if-lez v6, :cond_1d

    .line 831
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMaxWidth:I

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 833
    :cond_1d
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMinHeight:I

    if-lez v6, :cond_1e

    .line 834
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMinHeight:I

    move/from16 v26, v8

    move/from16 v8, v18

    .end local v18    # "height":I
    .local v8, "height":I
    .local v26, "horizontalSpec":I
    invoke-static {v6, v8}, Ljava/lang/Math;->max(II)I

    move-result v18

    move/from16 v8, v18

    .end local v8    # "height":I
    .restart local v18    # "height":I
    goto :goto_11

    .line 833
    .end local v26    # "horizontalSpec":I
    .local v8, "horizontalSpec":I
    :cond_1e
    move/from16 v26, v8

    move/from16 v8, v18

    .line 836
    .end local v18    # "height":I
    .local v8, "height":I
    .restart local v26    # "horizontalSpec":I
    :goto_11
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMaxHeight:I

    if-lez v6, :cond_1f

    .line 837
    iget v6, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mMatchConstraintMaxHeight:I

    invoke-static {v6, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 840
    :cond_1f
    iget-object v6, v0, Landroidx/constraintlayout/widget/ConstraintLayout$Measurer;->this$0:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-static {v6}, Landroidx/constraintlayout/widget/ConstraintLayout;->access$000(Landroidx/constraintlayout/widget/ConstraintLayout;)I

    move-result v6

    const/4 v0, 0x1

    invoke-static {v6, v0}, Landroidx/constraintlayout/core/widgets/Optimizer;->enabled(II)Z

    move-result v6

    .line 841
    .local v6, "optimizeDirect":Z
    if-nez v6, :cond_21

    .line 842
    if-eqz v20, :cond_20

    if-eqz v15, :cond_20

    .line 843
    const/high16 v18, 0x3f000000    # 0.5f

    iget v0, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mDimensionRatio:F

    .line 844
    .local v0, "ratio":F
    move/from16 v28, v0

    .end local v0    # "ratio":F
    .local v28, "ratio":F
    int-to-float v0, v8

    mul-float v0, v0, v28

    add-float v0, v0, v18

    float-to-int v0, v0

    .line 845
    .end local v7    # "width":I
    .end local v28    # "ratio":F
    .local v0, "width":I
    move v7, v0

    goto :goto_12

    .line 842
    .end local v0    # "width":I
    .restart local v7    # "width":I
    :cond_20
    const/high16 v18, 0x3f000000    # 0.5f

    .line 845
    if-eqz v21, :cond_21

    if-eqz v24, :cond_21

    .line 846
    iget v0, v1, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->mDimensionRatio:F

    .line 847
    .local v0, "ratio":F
    move/from16 v28, v0

    .end local v0    # "ratio":F
    .restart local v28    # "ratio":F
    int-to-float v0, v7

    div-float v0, v0, v28

    add-float v0, v0, v18

    float-to-int v0, v0

    move v8, v0

    .line 851
    .end local v28    # "ratio":F
    :cond_21
    :goto_12
    if-ne v4, v7, :cond_22

    if-ne v5, v8, :cond_22

    move v0, v8

    move/from16 v4, v23

    move/from16 v8, v26

    goto :goto_14

    .line 852
    :cond_22
    if-eq v4, v7, :cond_23

    .line 853
    const/high16 v0, 0x40000000    # 2.0f

    invoke-static {v7, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v17

    move/from16 v29, v17

    .end local v26    # "horizontalSpec":I
    .local v17, "horizontalSpec":I
    goto :goto_13

    .line 852
    .end local v17    # "horizontalSpec":I
    .restart local v26    # "horizontalSpec":I
    :cond_23
    const/high16 v0, 0x40000000    # 2.0f

    move/from16 v29, v26

    .line 855
    .end local v26    # "horizontalSpec":I
    .local v29, "horizontalSpec":I
    :goto_13
    if-eq v5, v8, :cond_24

    .line 856
    invoke-static {v8, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v9

    .line 858
    :cond_24
    move/from16 v0, v29

    .end local v29    # "horizontalSpec":I
    .local v0, "horizontalSpec":I
    invoke-virtual {v12, v0, v9}, Landroid/view/View;->measure(II)V

    .line 860
    invoke-virtual {v1, v0, v9}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->setLastMeasureSpec(II)V

    .line 861
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredWidth()I

    move-result v18

    .line 862
    .end local v7    # "width":I
    .local v18, "width":I
    invoke-virtual {v12}, Landroid/view/View;->getMeasuredHeight()I

    move-result v7

    .line 863
    .end local v8    # "height":I
    .local v7, "height":I
    invoke-virtual {v12}, Landroid/view/View;->getBaseline()I

    move-result v23

    move v8, v0

    move v0, v7

    move/from16 v7, v18

    move/from16 v4, v23

    .line 872
    .end local v5    # "h":I
    .end local v6    # "optimizeDirect":Z
    .end local v18    # "width":I
    .end local v23    # "baseline":I
    .local v0, "height":I
    .local v4, "baseline":I
    .local v7, "width":I
    .local v8, "horizontalSpec":I
    :goto_14
    const/4 v5, -0x1

    if-eq v4, v5, :cond_25

    const/4 v5, 0x1

    goto :goto_15

    :cond_25
    const/4 v5, 0x0

    .line 874
    .local v5, "hasBaseline":Z
    :goto_15
    iget v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->horizontalDimension:I

    if-ne v7, v6, :cond_26

    iget v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->verticalDimension:I

    if-ne v0, v6, :cond_26

    const/4 v6, 0x0

    goto :goto_16

    :cond_26
    const/4 v6, 0x1

    :goto_16
    iput-boolean v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredNeedsSolverPass:Z

    .line 876
    iget-boolean v6, v3, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->needsBaseline:Z

    if-eqz v6, :cond_27

    .line 877
    const/4 v5, 0x1

    .line 879
    :cond_27
    if-eqz v5, :cond_28

    const/4 v6, -0x1

    if-eq v4, v6, :cond_28

    invoke-virtual {v1}, Landroidx/constraintlayout/core/widgets/ConstraintWidget;->getBaselineDistance()I

    move-result v6

    if-eq v6, v4, :cond_28

    .line 880
    const/4 v6, 0x1

    iput-boolean v6, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredNeedsSolverPass:Z

    .line 882
    :cond_28
    iput v7, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredWidth:I

    .line 883
    iput v0, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredHeight:I

    .line 884
    iput-boolean v5, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredHasBaseline:Z

    .line 885
    iput v4, v2, Landroidx/constraintlayout/core/widgets/analyzer/BasicMeasure$Measure;->measuredBaseline:I

    .line 892
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
    .end packed-switch
.end method
