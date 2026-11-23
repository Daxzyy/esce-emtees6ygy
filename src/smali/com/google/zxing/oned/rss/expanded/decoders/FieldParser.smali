.class final Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;
.super Ljava/lang/Object;
.source "FieldParser.java"


# static fields
.field private static final FOUR_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final THREE_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final THREE_DIGIT_PLUS_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final TWO_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final VARIABLE_LENGTH:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 88

    .line 37
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 39
    nop

    .line 44
    const/16 v0, 0x12

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "00"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v2

    .line 45
    const/16 v3, 0xe

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const-string v5, "01"

    filled-new-array {v5, v4}, [Ljava/lang/Object;

    move-result-object v5

    .line 46
    const-string v6, "02"

    filled-new-array {v6, v4}, [Ljava/lang/Object;

    move-result-object v6

    sget-object v7, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 48
    const/16 v8, 0x14

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    const-string v10, "10"

    filled-new-array {v10, v7, v9}, [Ljava/lang/Object;

    move-result-object v7

    .line 49
    const/4 v10, 0x6

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    const-string v12, "11"

    filled-new-array {v12, v11}, [Ljava/lang/Object;

    move-result-object v12

    .line 50
    const-string v13, "12"

    filled-new-array {v13, v11}, [Ljava/lang/Object;

    move-result-object v13

    .line 51
    const-string v14, "13"

    filled-new-array {v14, v11}, [Ljava/lang/Object;

    move-result-object v14

    .line 52
    const-string v15, "15"

    filled-new-array {v15, v11}, [Ljava/lang/Object;

    move-result-object v15

    .line 53
    move/from16 v16, v3

    const-string v3, "17"

    filled-new-array {v3, v11}, [Ljava/lang/Object;

    move-result-object v3

    .line 55
    const/16 v17, 0x2

    move/from16 v18, v8

    invoke-static/range {v17 .. v17}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    move/from16 v19, v10

    const-string v10, "20"

    filled-new-array {v10, v8}, [Ljava/lang/Object;

    move-result-object v10

    move/from16 v20, v0

    sget-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 56
    move-object/from16 v21, v2

    const-string v2, "21"

    filled-new-array {v2, v0, v9}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 57
    const/16 v22, 0x1d

    move-object/from16 v23, v0

    invoke-static/range {v22 .. v22}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    move-object/from16 v22, v3

    const-string v3, "22"

    filled-new-array {v3, v2, v0}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 59
    const/16 v24, 0x8

    invoke-static/range {v24 .. v24}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    move-object/from16 v25, v0

    const-string v0, "30"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 60
    move-object/from16 v26, v0

    const-string v0, "37"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 63
    const/16 v27, 0x1e

    invoke-static/range {v27 .. v27}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    move-object/from16 v28, v0

    const-string v0, "90"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 64
    move-object/from16 v29, v0

    const-string v0, "91"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 65
    move-object/from16 v30, v0

    const-string v0, "92"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 66
    move-object/from16 v31, v0

    const-string v0, "93"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 67
    move-object/from16 v32, v0

    const-string v0, "94"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 68
    move-object/from16 v33, v0

    const-string v0, "95"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 69
    move-object/from16 v34, v0

    const-string v0, "96"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 70
    move-object/from16 v35, v0

    const-string v0, "97"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 71
    move-object/from16 v36, v0

    const-string v0, "98"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 72
    move-object/from16 v37, v0

    const-string v0, "99"

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    const/16 v2, 0x18

    new-array v2, v2, [[Ljava/lang/Object;

    const/16 v38, 0x0

    aput-object v21, v2, v38

    const/16 v21, 0x1

    aput-object v5, v2, v21

    aput-object v6, v2, v17

    const/4 v5, 0x3

    .line 97
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 72
    aput-object v7, v2, v5

    const/4 v7, 0x4

    aput-object v12, v2, v7

    const/4 v12, 0x5

    aput-object v13, v2, v12

    aput-object v14, v2, v19

    const/4 v13, 0x7

    aput-object v15, v2, v13

    aput-object v22, v2, v24

    const/16 v14, 0x9

    aput-object v10, v2, v14

    const/16 v10, 0xa

    .line 171
    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    .line 72
    aput-object v23, v2, v10

    const/16 v22, 0xb

    aput-object v25, v2, v22

    const/16 v23, 0xc

    aput-object v26, v2, v23

    const/16 v25, 0xd

    .line 90
    move/from16 v26, v5

    invoke-static/range {v25 .. v25}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 72
    aput-object v28, v2, v25

    aput-object v29, v2, v16

    const/16 v28, 0xf

    .line 96
    move/from16 v29, v7

    invoke-static/range {v28 .. v28}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    .line 72
    aput-object v30, v2, v28

    const/16 v30, 0x10

    aput-object v31, v2, v30

    const/16 v31, 0x11

    .line 83
    move/from16 v39, v10

    invoke-static/range {v31 .. v31}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    .line 72
    aput-object v32, v2, v31

    aput-object v33, v2, v20

    const/16 v32, 0x13

    aput-object v34, v2, v32

    aput-object v35, v2, v18

    const/16 v33, 0x15

    aput-object v36, v2, v33

    const/16 v33, 0x16

    aput-object v37, v2, v33

    const/16 v33, 0x17

    aput-object v0, v2, v33

    sput-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->TWO_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    .line 75
    sget-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 78
    const-string v2, "240"

    filled-new-array {v2, v0, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 79
    move/from16 v33, v12

    const-string v12, "241"

    filled-new-array {v12, v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    sget-object v12, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 80
    move/from16 v34, v13

    const-string v13, "242"

    filled-new-array {v13, v12, v11}, [Ljava/lang/Object;

    move-result-object v12

    sget-object v13, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 81
    move/from16 v35, v14

    const-string v14, "250"

    filled-new-array {v14, v13, v3}, [Ljava/lang/Object;

    move-result-object v13

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 82
    move-object/from16 v36, v0

    const-string v0, "251"

    filled-new-array {v0, v14, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 83
    move-object/from16 v37, v0

    const-string v0, "253"

    filled-new-array {v0, v14, v10}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 84
    move-object/from16 v40, v0

    const-string v0, "254"

    filled-new-array {v0, v14, v9}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 86
    move-object/from16 v41, v0

    const-string v0, "400"

    filled-new-array {v0, v14, v3}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 87
    move-object/from16 v42, v0

    const-string v0, "401"

    filled-new-array {v0, v14, v3}, [Ljava/lang/Object;

    move-result-object v0

    .line 88
    const-string v14, "402"

    filled-new-array {v14, v10}, [Ljava/lang/Object;

    move-result-object v10

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 89
    move-object/from16 v43, v0

    const-string v0, "403"

    filled-new-array {v0, v14, v3}, [Ljava/lang/Object;

    move-result-object v0

    .line 90
    const-string v14, "410"

    filled-new-array {v14, v5}, [Ljava/lang/Object;

    move-result-object v14

    .line 91
    move-object/from16 v44, v0

    const-string v0, "411"

    filled-new-array {v0, v5}, [Ljava/lang/Object;

    move-result-object v0

    .line 92
    move-object/from16 v45, v0

    const-string v0, "412"

    filled-new-array {v0, v5}, [Ljava/lang/Object;

    move-result-object v0

    .line 93
    move-object/from16 v46, v0

    const-string v0, "413"

    filled-new-array {v0, v5}, [Ljava/lang/Object;

    move-result-object v0

    .line 94
    move-object/from16 v47, v0

    const-string v0, "414"

    filled-new-array {v0, v5}, [Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v48, v0

    sget-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 95
    move-object/from16 v49, v2

    const-string v2, "420"

    filled-new-array {v2, v0, v9}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 96
    move-object/from16 v50, v0

    const-string v0, "421"

    filled-new-array {v0, v2, v7}, [Ljava/lang/Object;

    move-result-object v0

    .line 97
    const-string v2, "422"

    filled-new-array {v2, v6}, [Ljava/lang/Object;

    move-result-object v2

    move-object/from16 v51, v0

    sget-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 98
    move-object/from16 v52, v2

    const-string v2, "423"

    filled-new-array {v2, v0, v7}, [Ljava/lang/Object;

    move-result-object v0

    .line 99
    const-string v2, "424"

    filled-new-array {v2, v6}, [Ljava/lang/Object;

    move-result-object v2

    .line 100
    move-object/from16 v53, v0

    const-string v0, "425"

    filled-new-array {v0, v6}, [Ljava/lang/Object;

    move-result-object v0

    .line 101
    move-object/from16 v54, v0

    const-string v0, "426"

    filled-new-array {v0, v6}, [Ljava/lang/Object;

    move-result-object v0

    const/16 v6, 0x17

    new-array v6, v6, [[Ljava/lang/Object;

    aput-object v36, v6, v38

    aput-object v49, v6, v21

    aput-object v12, v6, v17

    aput-object v13, v6, v26

    aput-object v37, v6, v29

    aput-object v40, v6, v33

    aput-object v41, v6, v19

    aput-object v42, v6, v34

    aput-object v43, v6, v24

    aput-object v10, v6, v35

    aput-object v44, v6, v39

    aput-object v14, v6, v22

    aput-object v45, v6, v23

    aput-object v46, v6, v25

    aput-object v47, v6, v16

    aput-object v48, v6, v28

    aput-object v50, v6, v30

    aput-object v51, v6, v31

    aput-object v52, v6, v20

    aput-object v53, v6, v32

    aput-object v2, v6, v18

    const/16 v2, 0x15

    aput-object v54, v6, v2

    const/16 v2, 0x16

    aput-object v0, v6, v2

    sput-object v6, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    .line 104
    nop

    .line 107
    const-string v0, "310"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 108
    const-string v2, "311"

    filled-new-array {v2, v11}, [Ljava/lang/Object;

    move-result-object v2

    .line 109
    const-string v6, "312"

    filled-new-array {v6, v11}, [Ljava/lang/Object;

    move-result-object v6

    .line 110
    const-string v10, "313"

    filled-new-array {v10, v11}, [Ljava/lang/Object;

    move-result-object v10

    .line 111
    const-string v12, "314"

    filled-new-array {v12, v11}, [Ljava/lang/Object;

    move-result-object v12

    .line 112
    const-string v13, "315"

    filled-new-array {v13, v11}, [Ljava/lang/Object;

    move-result-object v13

    .line 113
    const-string v14, "316"

    filled-new-array {v14, v11}, [Ljava/lang/Object;

    move-result-object v14

    .line 114
    move-object/from16 v36, v0

    const-string v0, "320"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 115
    move-object/from16 v37, v0

    const-string v0, "321"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 116
    move-object/from16 v40, v0

    const-string v0, "322"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 117
    move-object/from16 v41, v0

    const-string v0, "323"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 118
    move-object/from16 v42, v0

    const-string v0, "324"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 119
    move-object/from16 v43, v0

    const-string v0, "325"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 120
    move-object/from16 v44, v0

    const-string v0, "326"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 121
    move-object/from16 v45, v0

    const-string v0, "327"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 122
    move-object/from16 v46, v0

    const-string v0, "328"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 123
    move-object/from16 v47, v0

    const-string v0, "329"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 124
    move-object/from16 v48, v0

    const-string v0, "330"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 125
    move-object/from16 v49, v0

    const-string v0, "331"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 126
    move-object/from16 v50, v0

    const-string v0, "332"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 127
    move-object/from16 v51, v0

    const-string v0, "333"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 128
    move-object/from16 v52, v0

    const-string v0, "334"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 129
    move-object/from16 v53, v0

    const-string v0, "335"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 130
    move-object/from16 v54, v0

    const-string v0, "336"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 131
    move-object/from16 v55, v0

    const-string v0, "340"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 132
    move-object/from16 v56, v0

    const-string v0, "341"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 133
    move-object/from16 v57, v0

    const-string v0, "342"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 134
    move-object/from16 v58, v0

    const-string v0, "343"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 135
    move-object/from16 v59, v0

    const-string v0, "344"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 136
    move-object/from16 v60, v0

    const-string v0, "345"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 137
    move-object/from16 v61, v0

    const-string v0, "346"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 138
    move-object/from16 v62, v0

    const-string v0, "347"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 139
    move-object/from16 v63, v0

    const-string v0, "348"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 140
    move-object/from16 v64, v0

    const-string v0, "349"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 141
    move-object/from16 v65, v0

    const-string v0, "350"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 142
    move-object/from16 v66, v0

    const-string v0, "351"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 143
    move-object/from16 v67, v0

    const-string v0, "352"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 144
    move-object/from16 v68, v0

    const-string v0, "353"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 145
    move-object/from16 v69, v0

    const-string v0, "354"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 146
    move-object/from16 v70, v0

    const-string v0, "355"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 147
    move-object/from16 v71, v0

    const-string v0, "356"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 148
    move-object/from16 v72, v0

    const-string v0, "357"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 149
    move-object/from16 v73, v0

    const-string v0, "360"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 150
    move-object/from16 v74, v0

    const-string v0, "361"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 151
    move-object/from16 v75, v0

    const-string v0, "362"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 152
    move-object/from16 v76, v0

    const-string v0, "363"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 153
    move-object/from16 v77, v0

    const-string v0, "364"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 154
    move-object/from16 v78, v0

    const-string v0, "365"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 155
    move-object/from16 v79, v0

    const-string v0, "366"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 156
    move-object/from16 v80, v0

    const-string v0, "367"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 157
    move-object/from16 v81, v0

    const-string v0, "368"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    .line 158
    move-object/from16 v82, v0

    const-string v0, "369"

    filled-new-array {v0, v11}, [Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v83, v0

    sget-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 159
    move-object/from16 v84, v2

    const-string v2, "390"

    filled-new-array {v2, v0, v7}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 160
    move-object/from16 v85, v0

    const-string v0, "391"

    filled-new-array {v0, v2, v1}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 161
    move-object/from16 v86, v0

    const-string v0, "392"

    filled-new-array {v0, v2, v7}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 162
    const-string v7, "393"

    filled-new-array {v7, v2, v1}, [Ljava/lang/Object;

    move-result-object v2

    sget-object v7, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 163
    move-object/from16 v87, v0

    const-string v0, "703"

    filled-new-array {v0, v7, v3}, [Ljava/lang/Object;

    move-result-object v0

    const/16 v7, 0x39

    new-array v7, v7, [[Ljava/lang/Object;

    aput-object v36, v7, v38

    aput-object v84, v7, v21

    aput-object v6, v7, v17

    aput-object v10, v7, v26

    aput-object v12, v7, v29

    aput-object v13, v7, v33

    aput-object v14, v7, v19

    aput-object v37, v7, v34

    aput-object v40, v7, v24

    aput-object v41, v7, v35

    aput-object v42, v7, v39

    aput-object v43, v7, v22

    aput-object v44, v7, v23

    aput-object v45, v7, v25

    aput-object v46, v7, v16

    aput-object v47, v7, v28

    aput-object v48, v7, v30

    aput-object v49, v7, v31

    aput-object v50, v7, v20

    aput-object v51, v7, v32

    aput-object v52, v7, v18

    const/16 v6, 0x15

    aput-object v53, v7, v6

    const/16 v6, 0x16

    aput-object v54, v7, v6

    const/16 v6, 0x17

    aput-object v55, v7, v6

    const/16 v6, 0x18

    aput-object v56, v7, v6

    const/16 v6, 0x19

    aput-object v57, v7, v6

    const/16 v6, 0x1a

    aput-object v58, v7, v6

    const/16 v6, 0x1b

    aput-object v59, v7, v6

    const/16 v6, 0x1c

    aput-object v60, v7, v6

    const/16 v6, 0x1d

    aput-object v61, v7, v6

    aput-object v62, v7, v27

    const/16 v6, 0x1f

    aput-object v63, v7, v6

    const/16 v6, 0x20

    aput-object v64, v7, v6

    const/16 v6, 0x21

    aput-object v65, v7, v6

    const/16 v6, 0x22

    aput-object v66, v7, v6

    const/16 v6, 0x23

    aput-object v67, v7, v6

    const/16 v6, 0x24

    aput-object v68, v7, v6

    const/16 v6, 0x25

    aput-object v69, v7, v6

    const/16 v6, 0x26

    aput-object v70, v7, v6

    const/16 v6, 0x27

    aput-object v71, v7, v6

    const/16 v6, 0x28

    aput-object v72, v7, v6

    const/16 v6, 0x29

    aput-object v73, v7, v6

    const/16 v6, 0x2a

    aput-object v74, v7, v6

    const/16 v6, 0x2b

    aput-object v75, v7, v6

    const/16 v6, 0x2c

    aput-object v76, v7, v6

    const/16 v6, 0x2d

    aput-object v77, v7, v6

    const/16 v6, 0x2e

    aput-object v78, v7, v6

    const/16 v6, 0x2f

    aput-object v79, v7, v6

    const/16 v6, 0x30

    aput-object v80, v7, v6

    const/16 v6, 0x31

    aput-object v81, v7, v6

    const/16 v6, 0x32

    aput-object v82, v7, v6

    const/16 v6, 0x33

    aput-object v83, v7, v6

    const/16 v6, 0x34

    aput-object v85, v7, v6

    const/16 v6, 0x35

    aput-object v86, v7, v6

    const/16 v6, 0x36

    aput-object v87, v7, v6

    const/16 v6, 0x37

    aput-object v2, v7, v6

    const/16 v2, 0x38

    aput-object v0, v7, v2

    sput-object v7, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_PLUS_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    .line 166
    nop

    .line 169
    const-string v0, "7001"

    filled-new-array {v0, v5}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 170
    const-string v5, "7002"

    filled-new-array {v5, v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    .line 171
    const-string v5, "7003"

    filled-new-array {v5, v15}, [Ljava/lang/Object;

    move-result-object v5

    .line 173
    const-string v6, "8001"

    filled-new-array {v6, v4}, [Ljava/lang/Object;

    move-result-object v4

    sget-object v6, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 174
    const-string v7, "8002"

    filled-new-array {v7, v6, v9}, [Ljava/lang/Object;

    move-result-object v6

    sget-object v7, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 175
    const-string v9, "8003"

    filled-new-array {v9, v7, v3}, [Ljava/lang/Object;

    move-result-object v7

    sget-object v9, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 176
    const-string v10, "8004"

    filled-new-array {v10, v9, v3}, [Ljava/lang/Object;

    move-result-object v9

    .line 177
    const-string v10, "8005"

    filled-new-array {v10, v11}, [Ljava/lang/Object;

    move-result-object v10

    .line 178
    const-string v12, "8006"

    filled-new-array {v12, v1}, [Ljava/lang/Object;

    move-result-object v12

    sget-object v13, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 179
    const-string v14, "8007"

    filled-new-array {v14, v13, v3}, [Ljava/lang/Object;

    move-result-object v3

    sget-object v13, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 180
    invoke-static/range {v23 .. v23}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    move-object/from16 v18, v0

    const-string v0, "8008"

    filled-new-array {v0, v13, v14}, [Ljava/lang/Object;

    move-result-object v0

    .line 181
    const-string v13, "8018"

    filled-new-array {v13, v1}, [Ljava/lang/Object;

    move-result-object v1

    sget-object v13, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 182
    const/16 v14, 0x19

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    move-object/from16 v27, v0

    const-string v0, "8020"

    filled-new-array {v0, v13, v14}, [Ljava/lang/Object;

    move-result-object v0

    .line 183
    const-string v13, "8100"

    filled-new-array {v13, v11}, [Ljava/lang/Object;

    move-result-object v11

    .line 184
    const-string v13, "8101"

    filled-new-array {v13, v15}, [Ljava/lang/Object;

    move-result-object v13

    .line 185
    const-string v14, "8102"

    filled-new-array {v14, v8}, [Ljava/lang/Object;

    move-result-object v8

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 186
    const/16 v15, 0x46

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    move-object/from16 v32, v0

    const-string v0, "8110"

    filled-new-array {v0, v14, v15}, [Ljava/lang/Object;

    move-result-object v0

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    .line 187
    const/16 v15, 0x46

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    move-object/from16 v36, v0

    const-string v0, "8200"

    filled-new-array {v0, v14, v15}, [Ljava/lang/Object;

    move-result-object v0

    move/from16 v14, v20

    new-array v14, v14, [[Ljava/lang/Object;

    aput-object v18, v14, v38

    aput-object v2, v14, v21

    aput-object v5, v14, v17

    aput-object v4, v14, v26

    aput-object v6, v14, v29

    aput-object v7, v14, v33

    aput-object v9, v14, v19

    aput-object v10, v14, v34

    aput-object v12, v14, v24

    aput-object v3, v14, v35

    aput-object v27, v14, v39

    aput-object v1, v14, v22

    aput-object v32, v14, v23

    aput-object v11, v14, v25

    aput-object v13, v14, v16

    aput-object v8, v14, v28

    aput-object v36, v14, v30

    aput-object v0, v14, v31

    sput-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->FOUR_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    .line 166
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 190
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 191
    return-void
.end method

.method static parseFieldsInGeneralPurpose(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/zxing/NotFoundException;
        }
    .end annotation

    .line 194
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 195
    const/4 p0, 0x0

    return-object p0

    .line 200
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_f

    .line 204
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 206
    sget-object v3, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->TWO_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v4, v3

    move v5, v0

    :goto_0
    const/4 v6, 0x1

    if-ge v5, v4, :cond_3

    aget-object v7, v3, v5

    .line 207
    aget-object v8, v7, v0

    invoke-virtual {v8, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 208
    aget-object v0, v7, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_1

    .line 209
    aget-object v0, v7, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v1, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 211
    :cond_1
    aget-object v0, v7, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v1, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 206
    :cond_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 215
    :cond_3
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x3

    if-lt v2, v3, :cond_e

    .line 219
    invoke-virtual {p0, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 221
    sget-object v4, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v5, v4

    move v7, v0

    :goto_1
    if-ge v7, v5, :cond_6

    aget-object v8, v4, v7

    .line 222
    aget-object v9, v8, v0

    invoke-virtual {v9, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 223
    aget-object v0, v8, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_4

    .line 224
    aget-object v0, v8, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v3, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 226
    :cond_4
    aget-object v0, v8, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v3, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 221
    :cond_5
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 231
    :cond_6
    sget-object v3, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_PLUS_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v4, v3

    move v5, v0

    :goto_2
    const/4 v7, 0x4

    if-ge v5, v4, :cond_9

    aget-object v8, v3, v5

    .line 232
    aget-object v9, v8, v0

    invoke-virtual {v9, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_8

    .line 233
    aget-object v0, v8, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_7

    .line 234
    aget-object v0, v8, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 236
    :cond_7
    aget-object v0, v8, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 231
    :cond_8
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 240
    :cond_9
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-lt v2, v7, :cond_d

    .line 244
    invoke-virtual {p0, v0, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 246
    sget-object v3, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->FOUR_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v4, v3

    move v5, v0

    :goto_3
    if-ge v5, v4, :cond_c

    aget-object v8, v3, v5

    .line 247
    aget-object v9, v8, v0

    invoke-virtual {v9, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_b

    .line 248
    aget-object v0, v8, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_a

    .line 249
    aget-object v0, v8, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 251
    :cond_a
    aget-object v0, v8, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 246
    :cond_b
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 255
    :cond_c
    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    .line 241
    :cond_d
    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    .line 216
    :cond_e
    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    .line 201
    :cond_f
    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0
.end method

.method private static processFixedAI(IILjava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "aiSize"    # I
    .param p1, "fieldSize"    # I
    .param p2, "rawInformation"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/zxing/NotFoundException;
        }
    .end annotation

    .line 259
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lt v0, p0, :cond_2

    .line 263
    const/4 v0, 0x0

    invoke-virtual {p2, v0, p0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 265
    .local v0, "ai":Ljava/lang/String;
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    add-int v2, p0, p1

    if-lt v1, v2, :cond_1

    .line 269
    add-int v1, p0, p1

    invoke-virtual {p2, p0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 270
    .local v1, "field":Ljava/lang/String;
    add-int v2, p0, p1

    invoke-virtual {p2, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 271
    .local v2, "remaining":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "("

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x29

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 272
    .local v3, "result":Ljava/lang/String;
    invoke-static {v2}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->parseFieldsInGeneralPurpose(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    .line 273
    .local v5, "parsedAI":Ljava/lang/String;
    move-object v5, v4

    if-nez v4, :cond_0

    return-object v3

    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 266
    .end local v1    # "field":Ljava/lang/String;
    .end local v2    # "remaining":Ljava/lang/String;
    .end local v3    # "result":Ljava/lang/String;
    .end local v5    # "parsedAI":Ljava/lang/String;
    :cond_1
    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object v1

    throw v1

    .line 260
    .end local v0    # "ai":Ljava/lang/String;
    :cond_2
    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object v0

    throw v0
.end method

.method private static processVariableAI(IILjava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p0, "aiSize"    # I
    .param p1, "variableFieldSize"    # I
    .param p2, "rawInformation"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/zxing/NotFoundException;
        }
    .end annotation

    .line 278
    const/4 v0, 0x0

    invoke-virtual {p2, v0, p0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 279
    .local v0, "ai":Ljava/lang/String;
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    add-int v2, p0, p1

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 280
    .local v1, "maxSize":I
    invoke-virtual {p2, p0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 281
    .local v2, "field":Ljava/lang/String;
    invoke-virtual {p2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    .line 282
    .local v3, "remaining":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "("

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x29

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 283
    .local v4, "result":Ljava/lang/String;
    invoke-static {v3}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->parseFieldsInGeneralPurpose(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    .line 284
    .local v6, "parsedAI":Ljava/lang/String;
    move-object v6, v5

    if-nez v5, :cond_0

    return-object v4

    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    return-object v5
.end method
