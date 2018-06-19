//
//  BaseWebViewController.m
//  Demo
//
//  Created by 颜程 on 2018/6/7.
//  Copyright © 2018年 818. All rights reserved.
//

#import "BaseWebViewController.h"
@interface BaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@end

@implementation BaseWebViewController

-(void)setConfig:(WKWebViewConfiguration *)config {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    [config.userContentController addScriptMessageHandler:self name:@"test"];
    [config.userContentController addScriptMessageHandler:self name:@"passValue"];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.config?self.config:config];
    [self.view addSubview:_webView];
    _webView.UIDelegate = self;
    _webView.backgroundColor = [UIColor redColor];
    _webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.url]]];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.naviTitle = self.webView.title;
    }
}

-(void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
