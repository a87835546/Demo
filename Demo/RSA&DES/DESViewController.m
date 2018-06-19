//
//  DESViewController.m
//  Demo
//
//  Created by 818 on 2018/5/17.
//  Copyright © 2018年 818. All rights reserved.
//

#import "DESViewController.h"
#import <AFNetworking.h>
#import "DES3Util.h"
@interface DESViewController()<UITextFieldDelegate>
{
    NSString *_content;
    UITextView *_textView;
}
@end
@implementation DESViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 200, 40)];
    textField.delegate = self;
    textField.placeholder = @"输入需要加密的内容";
    textField.backgroundColor = YCRandomColor;
    [self.view addSubview:textField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(240, 100, 80, 40)];
    [btn setTitle:@"加密" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(desEncription) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:YCRandomColor];
    [self.view addSubview:btn];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 300, 300, 300)];
    _textView.backgroundColor = YCRandomColor;
    [self.view addSubview:_textView];
    YCLog(@"des encription result:%@",[DES3Util encryptUseDES:@"000000" key:@"12346"]);
}

#pragma mark -- 使用des加密 密码是123456
- (void)desEncription{
    NSString *encriptionStr = [DES3Util encryptUseDES:_content key:@"123456"];
    _textView.text = encriptionStr;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    _content = textField.text;
}

-(void)getData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YCLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YCLog(@"%@",error);
    }];
}

@end
