//
//  UploadFileViewController.m
//  Demo
//
//  Created by 818 on 2018/6/1.
//  Copyright © 2018年 818. All rights reserved.
//

#import "UploadFileViewController.h"
#import <AFNetworking.h>
@interface UploadFileViewController ()

@end

@implementation UploadFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)uploadFile {
    AFHTTPSessionManager  *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSURL *url = [NSURL URLWithString:@""];
    [manager POST:url parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:nil name:@"file" fileName:@"1.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
