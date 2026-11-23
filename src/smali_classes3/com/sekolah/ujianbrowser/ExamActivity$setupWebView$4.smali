.class public final Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;
.super Landroid/webkit/WebChromeClient;
.source "ExamActivity.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sekolah/ujianbrowser/ExamActivity;->setupWebView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J0\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u00072\u0008\u0010\u0008\u001a\u0004\u0018\u00010\u00072\u0008\u0010\t\u001a\u0004\u0018\u00010\nH\u0016J0\u0010\u000b\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u00072\u0008\u0010\u0008\u001a\u0004\u0018\u00010\u00072\u0008\u0010\t\u001a\u0004\u0018\u00010\nH\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/sekolah/ujianbrowser/ExamActivity$setupWebView$4",
        "Landroid/webkit/WebChromeClient;",
        "onJsAlert",
        "",
        "view",
        "Landroid/webkit/WebView;",
        "url",
        "",
        "message",
        "result",
        "Landroid/webkit/JsResult;",
        "onJsConfirm",
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
.field final synthetic this$0:Lcom/sekolah/ujianbrowser/ExamActivity;


# direct methods
.method constructor <init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/sekolah/ujianbrowser/ExamActivity;

    iput-object p1, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    .line 160
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    return-void
.end method

.method static final onJsAlert$lambda$0(Landroid/webkit/JsResult;Landroid/content/DialogInterface;I)V
    .locals 0
    .param p0, "$result"    # Landroid/webkit/JsResult;

    .line 170
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/webkit/JsResult;->confirm()V

    :cond_0
    return-void
.end method

.method static final onJsAlert$lambda$1(Landroid/webkit/JsResult;Landroid/content/DialogInterface;)V
    .locals 0
    .param p0, "$result"    # Landroid/webkit/JsResult;
    .param p1, "it"    # Landroid/content/DialogInterface;

    .line 171
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/webkit/JsResult;->cancel()V

    :cond_0
    return-void
.end method

.method static final onJsAlert$lambda$2(Lcom/sekolah/ujianbrowser/ExamActivity;Landroid/content/DialogInterface;)V
    .locals 1
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/ExamActivity;
    .param p1, "it"    # Landroid/content/DialogInterface;

    .line 172
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$setDialogOpen$p(Lcom/sekolah/ujianbrowser/ExamActivity;Z)V

    return-void
.end method

.method static final onJsConfirm$lambda$3(Landroid/webkit/JsResult;Landroid/content/DialogInterface;I)V
    .locals 0
    .param p0, "$result"    # Landroid/webkit/JsResult;

    .line 186
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/webkit/JsResult;->confirm()V

    :cond_0
    return-void
.end method

.method static final onJsConfirm$lambda$4(Landroid/webkit/JsResult;Landroid/content/DialogInterface;I)V
    .locals 0
    .param p0, "$result"    # Landroid/webkit/JsResult;

    .line 187
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/webkit/JsResult;->cancel()V

    :cond_0
    return-void
.end method

.method static final onJsConfirm$lambda$5(Landroid/webkit/JsResult;Landroid/content/DialogInterface;)V
    .locals 0
    .param p0, "$result"    # Landroid/webkit/JsResult;
    .param p1, "it"    # Landroid/content/DialogInterface;

    .line 188
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/webkit/JsResult;->cancel()V

    :cond_0
    return-void
.end method

.method static final onJsConfirm$lambda$6(Lcom/sekolah/ujianbrowser/ExamActivity;Landroid/content/DialogInterface;)V
    .locals 1
    .param p0, "this$0"    # Lcom/sekolah/ujianbrowser/ExamActivity;
    .param p1, "it"    # Landroid/content/DialogInterface;

    .line 189
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$setDialogOpen$p(Lcom/sekolah/ujianbrowser/ExamActivity;Z)V

    return-void
.end method


# virtual methods
.method public onJsAlert(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsResult;)Z
    .locals 4
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/webkit/JsResult;

    .line 167
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$setDialogOpen$p(Lcom/sekolah/ujianbrowser/ExamActivity;Z)V

    .line 168
    new-instance v0, Landroidx/appcompat/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    check-cast v2, Landroid/content/Context;

    invoke-direct {v0, v2}, Landroidx/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 169
    move-object v2, p3

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v0, v2}, Landroidx/appcompat/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 170
    const-string v2, "OK"

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v3, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda0;

    invoke-direct {v3, p4}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda0;-><init>(Landroid/webkit/JsResult;)V

    invoke-virtual {v0, v2, v3}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 171
    new-instance v2, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda1;

    invoke-direct {v2, p4}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda1;-><init>(Landroid/webkit/JsResult;)V

    invoke-virtual {v0, v2}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 172
    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    new-instance v3, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda2;

    invoke-direct {v3, v2}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda2;-><init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V

    invoke-virtual {v0, v3}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 173
    invoke-virtual {v0}, Landroidx/appcompat/app/AlertDialog$Builder;->show()Landroidx/appcompat/app/AlertDialog;

    .line 174
    return v1
.end method

.method public onJsConfirm(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsResult;)Z
    .locals 4
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/webkit/JsResult;

    .line 183
    iget-object v0, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/sekolah/ujianbrowser/ExamActivity;->access$setDialogOpen$p(Lcom/sekolah/ujianbrowser/ExamActivity;Z)V

    .line 184
    new-instance v0, Landroidx/appcompat/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    check-cast v2, Landroid/content/Context;

    invoke-direct {v0, v2}, Landroidx/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 185
    move-object v2, p3

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v0, v2}, Landroidx/appcompat/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 186
    const-string v2, "OK"

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v3, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda3;

    invoke-direct {v3, p4}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda3;-><init>(Landroid/webkit/JsResult;)V

    invoke-virtual {v0, v2, v3}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 187
    const-string v2, "Batal"

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v3, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda4;

    invoke-direct {v3, p4}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda4;-><init>(Landroid/webkit/JsResult;)V

    invoke-virtual {v0, v2, v3}, Landroidx/appcompat/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 188
    new-instance v2, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda5;

    invoke-direct {v2, p4}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda5;-><init>(Landroid/webkit/JsResult;)V

    invoke-virtual {v0, v2}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 189
    iget-object v2, p0, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4;->this$0:Lcom/sekolah/ujianbrowser/ExamActivity;

    new-instance v3, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda6;

    invoke-direct {v3, v2}, Lcom/sekolah/ujianbrowser/ExamActivity$setupWebView$4$$ExternalSyntheticLambda6;-><init>(Lcom/sekolah/ujianbrowser/ExamActivity;)V

    invoke-virtual {v0, v3}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    move-result-object v0

    .line 190
    invoke-virtual {v0}, Landroidx/appcompat/app/AlertDialog$Builder;->show()Landroidx/appcompat/app/AlertDialog;

    .line 191
    return v1
.end method
