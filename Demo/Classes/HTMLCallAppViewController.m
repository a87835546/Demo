//
//  HTMLCallAppViewController.m
//  Demo
//
//  Created by 818 on 2018/6/7.
//  Copyright © 2018年 818. All rights reserved.
//

#import "HTMLCallAppViewController.h"
#import <WebKit/WebKit.h>
#import "BaseWebViewController.h"
@interface HTMLCallAppViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) WKWebView *webView;
@property (assign, nonatomic) BOOL allowZoom;
@end

@implementation HTMLCallAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allowZoom = YES;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [btn setTitle:@"app call js" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(callJs) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    [config.userContentController addScriptMessageHandler:self name:@"test"];
    [config.userContentController addScriptMessageHandler:self name:@"passValue"];

    NSString *url = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    
    YCLog(@"%@",url);
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.197:8080/#"]]];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];

}

#pragma mark -- APP 向HTML 注入 JS
- (void)callJs {
    [self.webView evaluateJavaScript:@"document.querySelector('#btn').style.color='red'" completionHandler:^(id _Nullable respons, NSError * _Nullable error) {
        YCLog(@"%@",error.userInfo);
    }];
    [self.webView evaluateJavaScript:@"passValue()" completionHandler:^(id _Nullable respones, NSError * _Nullable error) {
        YCLog(@"%@",error.userInfo);
    }];

}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqual:@"test"]) {
//        YCLog(@"已经获取到了js传过来的方法 %@",message.body);
        ULog(@"已经获取到了js传过来的方法 %@",message.body);
    }else if ([message.name isEqualToString:@"passValue"]){
        ULog(@"输入框的值：%@",message.body);
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.allowZoom) {
        return nil;
    }else {
        return self.webView.scrollView.subviews.firstObject;
    }
}
#pragma mark -- WKUIDelegate

- (void)webViewDidClose:(WKWebView *)webView {
    YCLog(@"web did close");
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    
}

#pragma mark  -- WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    YCLog(@"html loading finish");

}


- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    YCLog(@"html loading fail ,result:%@",error.userInfo);
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
{
    YCLog(@"%@",navigation);

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);

    YCLog(@"%@",navigationAction.request.URL);
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
//        [self.webView loadRequest:navigationAction.request];
//        BaseWebViewController *web = [[BaseWebViewController alloc] init];
//        web.url = navigationAction.request.URL.absoluteString;
//        [self.navigationController pushViewController:web animated:nil];
        [self.webView loadRequest:navigationAction.request];

    }
    if (navigationAction.targetFrame == nil) {
//        [self.webView loadRequest:navigationAction.request];
    }
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
{
    decisionHandler(WKNavigationResponsePolicyAllow);
    YCLog(@"%@",navigationResponse.response.URL);
}
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//
//    [config.userContentController addScriptMessageHandler:self name:@"test"];
//    [config.userContentController addScriptMessageHandler:self name:@"passValue"];
////    BaseWebViewController *web = [[BaseWebViewController alloc] init];
////    web.config = config;
////    web.url = navigationAction.request.URL.absoluteString;
//    WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
//    [web loadRequest:navigationAction.request];
//    return web;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"test"];
    [_webView removeObserver:self forKeyPath:@"title"];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    YCLog(@"%@",keyPath);
    if([keyPath isEqualToString:@"title"]){
        self.navigationItem.title = self.webView.title;
    }
}

@end
