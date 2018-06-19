//
//  BaseWebViewController.h
//  Demo
//
//  Created by 颜程 on 2018/6/7.
//  Copyright © 2018年 818. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWebViewController : BaseViewController
@property (copy, nonatomic) NSString *url;
@property(strong, nonatomic)WKWebView *webView;
@property(strong, nonatomic) WKWebViewConfiguration *config;
@end
