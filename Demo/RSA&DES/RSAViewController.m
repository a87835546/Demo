//
//  RSAViewController.m
//  Demo
//
//  Created by 818 on 2018/5/17.
//  Copyright © 2018年 818. All rights reserved.
//

#import "RSAViewController.h"
#import <AFNetworking.h>
#import "RSAUtil.h"
@interface RSAViewController ()


@end
@implementation RSAViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"公钥加密",@"私钥校验"];
}

#pragma mark -- 公钥加密 传送数据给后台
-(void)getDataWithEncryption {
    //使用RSA 加密算法 加密123456
    NSString *encriptionStr = [RSAUtil encryptString:@"123456" publicKey:@""];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YCLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YCLog(@"%@",error);
    }];
}

#pragma mark -- 私钥宵夜 后台加密后数据传送给我。我来校验（java -- > app）
- (void)getDataWithCheckout{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YCLog(@"%@",responseObject);
        NSString *decriptionStr = [RSAUtil decryptString:@"" publicKey:@""];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YCLog(@"%@",error);
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self getDataWithEncryption];
    }else {
        [self getDataWithCheckout];
    }
    
}

@end
