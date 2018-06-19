//
//  MD5ViewController.m
//  Demo
//
//  Created by 818 on 2018/5/17.
//  Copyright © 2018年 818. All rights reserved.
//

#import "MD5ViewController.h"
#import "MD5Util.h"
@interface MD5ViewController ()

@end

@implementation MD5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *md5Str = [[MD5Util alloc] md5:@"000000"];
    YCLog(@"md5 encription result: %@",md5Str);
    NSDictionary *dic = @{@"2":@"1"};
    NSString *str = nil;
    YCLog(@"%@",[dic objectForKey:str]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
