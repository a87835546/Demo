//
//  AESViewController.m
//  Demo
//
//  Created by 818 on 2018/5/17.
//  Copyright © 2018年 818. All rights reserved.
//

#import "AESViewController.h"
#import <AFNetworking.h>
#import "AESCipher.h"
#define KAES_KEY @"1234567890123456"
@interface AESViewController ()

@end

@implementation AESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *encriptionStr = aesEncryptString([self convertToJsonData:@{@"a":@"b",@"1":@"2"}], KAES_KEY);//[AES encrypt:@"000000" password:@"123456"];

    YCLog(@"aes encription:%@",encriptionStr);
    
    NSString *decriptionStr = aesDecryptString(@"WMj3RU7tM0VR5OaiMoLPdtP5gbzacLKs9OK4nVv3Qf5P0Wmilb3xkymnIMyhRTzNmbcymaGr+vIG0Td5PQI4eA==", KAES_KEY);
    YCLog(@"aes decription:%@",decriptionStr);
    [self getDataWithEncryption];
    NSDictionary *dic = @{@"a":@"b",@"aa":@"bb",@"1":@[@{@"11":@{@"aa":@"bb"}},@{@"12":@"00"}]};
    NSString *dicStr = [self convertToJsonData:dic];
    YCLog(@"dic:%@\n string:%@",dic,dicStr);
    NSDictionary *d = [self dictionaryWithJsonString:dicStr];
    YCLog(@"%@",[d objectForKey:@"1"]);
}



#pragma mark -- 公钥加密 传送数据给后台
-(void)getDataWithEncryption {
    //使用AES 加密算法 加密000000 密码是123456
    NSString *encriptionStr = aesEncryptString([self convertToJsonData:@{@"a":@"b",@"1":@"2"}], KAES_KEY);//[AES encrypt:@"000000" password:@"123456"];
    YCLog(@"aes encription:%@",encriptionStr);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    encriptionStr = [encriptionStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:[NSString stringWithFormat:@"http://192.168.1.17:8050/api-a/user/login"] parameters:@{@"r":@"WMj3RU7tM0VR5OaiMoLPdtP5gbzacLKs9OK4nVv3Qf5P0Wmilb3xkymnIMyhRTzNmbcymaGr+vIG0Td5PQI4eA==",@"accessToken":@"123"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YCLog(@"%@",responseObject);
        YCLog(@"%@",aesDecryptString(responseObject[@"r"], KAES_KEY));
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YCLog(@"%@",error.userInfo );
        NSData *data = [error.userInfo  objectForKey: @"com.alamofire.serialization.response.error.data"];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        YCLog("%@",dic[@"result"]);
        NSData *data1 = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.response"];
        YCLog(@"%@",data1);
//        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
//        YCLog(@"%@",response);
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text =dic[@"result"]?dic[@"result"]:@"参数异常";
        
        [hud hideAnimated:YES afterDelay:1];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 字典转换成字符串
-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


#pragma mark - json字符串转换成字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
