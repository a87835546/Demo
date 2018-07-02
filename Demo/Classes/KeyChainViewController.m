//
//  KeyChainViewController.m
//  Demo
//
//  Created by 818 on 2018/6/27.
//  Copyright © 2018年 818. All rights reserved.
//

#import "KeyChainViewController.h"
#import <Security/Security.h>
#import <SAMKeychain.h>
@interface KeyChainViewController ()
@property (nonatomic,strong) NSMutableDictionary *chainDic;

@end

@implementation KeyChainViewController
-(NSMutableDictionary *)chainDic {
    if (!_chainDic) {
        _chainDic = [NSMutableDictionary dictionary];
    }
    return _chainDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    BOOL success =  [SAMKeychain setPassword:@"123456" forService:@"111111" account:@"222222"];
    if (success) {
        YCLog(@"success");
    }
    
    NSError *error = nil;
    SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
    query.service = @"111111";
    query.account = @"222222";
    [query fetch:&error];

    if ([error code] == errSecItemNotFound) {
        NSLog(@"Password not found");
    } else if (error != nil) {
        NSLog(@"Some other error occurred: %@", [error localizedDescription]);
    }else{
        NSLog(@"%@",query.password);
    }
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
