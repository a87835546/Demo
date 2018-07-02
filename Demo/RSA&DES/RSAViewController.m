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

NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEChqe80lJLTTkJD3X3Lyd7Fj+\nzuOhDZkjuLNPog3YR20e5JcrdqI9IFzNbACY/GQVhbnbvBqYgyql8DfPCGXpn0+X\nNSxELIUw9Vh32QuhGNr3/TBpechrVeVpFPLwyaYNEk1CawgHCeQqf5uaqiaoBDOT\nqeox88Lc1ld7MsfggQIDAQAB\n-----END PUBLIC KEY-----";
NSString *privkey = @"-----BEGIN RSA PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMQKGp7zSUktNOQk\nPdfcvJ3sWP7O46ENmSO4s0+iDdhHbR7klyt2oj0gXM1sAJj8ZBWFudu8GpiDKqXw\nN88IZemfT5c1LEQshTD1WHfZC6EY2vf9MGl5yGtV5WkU8vDJpg0STUJrCAcJ5Cp/\nm5qqJqgEM5Op6jHzwtzWV3syx+CBAgMBAAECgYEApSzqPzE3d3uqi+tpXB71oY5J\ncfB55PIjLPDrzFX7mlacP6JVKN7dVemVp9OvMTe/UE8LSXRVaFlkLsqXC07FJjhu\nwFXHPdnUf5sanLLdnzt3Mc8vMgUamGJl+er0wdzxM1kPTh0Tmq+DSlu5TlopAHd5\nIqF3DYiORIen3xIwp0ECQQDj6GFaXWzWAu5oUq6j1msTRV3mRZnx8Amxt1ssYM0+\nJLf6QYmpkGFqiQOhHkMgVUwRFqJC8A9EVR1eqabcBXbpAkEA3DQfLVr94vsIWL6+\nVrFcPJW9Xk28CNY6Xnvkin815o2Q0JUHIIIod1eVKCiYDUzZAYAsW0gefJ49sJ4Y\niRJN2QJAKuxeQX2s/NWKfz1rRNIiUnvTBoZ/SvCxcrYcxsvoe9bAi7KCMdxObJkn\nhNXFQLav39wKbV73ESCSqnx7P58L2QJABmhR2+0A5EDvvj1WpokkqPKmfv7+ELfD\nHQq33LvU4q+N3jPn8C85ZDedNHzx57kru1pyb/mKQZANNX10M1DgCQJBAMKn0lEx\nQH2GrkjeWgGVpPZkp0YC+ztNjaUMJmY5g0INUlDgqTWFNftxe8ROvt7JtUvlgtKC\nXdXQrKaEnpebeUQ=\n-----END RSA PRIVATE KEY-----";

NSString *key = @"MIIEIjANBgkqhkiG9w0BAQEFAAOCBA8AMIIECgKCBAEA1EpjV6zKJR0AnEBq/FzMwIN7Um2i/BwAvQmMsDRq9aXWHU5h00sgizShJVWVYOBv94JG4R31hBvv0VdQ9I8GbRnO7919/9eCOFXqWBLF516e7UPFmY3oWGU8bfGTs66uhzfG5vIKSgovhPAfXgI/sPkUfvbyT8Rw/rbFsmSRDiN9wrdlyeGC6cMbvHXlP83niRTeX1mtMLwOKn7VWaAUAF/lrDwpJBxTr9gLIpkLP0i6lSX3JsCbPce0vBM22iWpzCeyFFZJeT7L6Z/VhWdwbP6u6jB4kO4w1v/Od25I/z3b/DsXuNGct/mytta5DfzGdNXffuO6omXo3UKSr7qQJ2ZkvMoai/Twn2yyEz4ZfPjSgMmUWdFBxw8obCvELMlWubdSRYoQhXMK8UP+NcmSFmS7JokJRywB6uJBwUY5peVyi/7TY3p+dExg1ec79iem1GrUvcVvpdtj+Ming6e7fBif7baI+cH2mRTyZ97dfmxbUkxmQIkibWUW3iIlFQ5yMDCcRkwqB9/R3WGzGCz+LJVXUjc1n2/2/DUqARTuQg13VPJATn9F/Ty4gy7Fti+Y9iwMb1FX7npb1wZtHDRdg5sbwl5Xsbj609PeeC9IMlWO+BcExBrbgeTTVgaY3EUDKgTa9/T8Ypq+W48RvcKo51qQTgKsJSOWYuRcYSBgsgILd/iIF4JNM7hZrjHW1ori2cCn52u5l0sn5kfqUVs9L2dXrHIXkbLryLuuSvHXcC8LCKdMbpwr2qwWOJ48cDRXzgFGpQJxiyigNFYLSMpUAFs/xKLb6N5ZtSUU6KGpGjUWefvA1rbJ9JVgVoUW4rCYTATkXMXai5T0umGKDaR/uPMgpny4OrdGripdkxEFkCZBm4ggGPt3lu5OeL4jnUTr1s/RSdD0D5vhtkwAfZyI9meycs8TdYKd20VqZU37WXgH1LU+8shR79hZftkxs34dh54YNUUJT9s7oIb2CD5xFrGloMG9/psnPMDp999oVoX+dqrP4aCM9z3v3+8U72yyXTDv6zZ+AMcArkd6Ov6OTs7E/0DGkWhBmhx8IYX9g65hxdtlZf9RWK2iLisvw0BFD4aUGxPy8OoI26nR029kkbWe9+hecD7iItr/qNwcA/yH3/VvSX7vwJ8iG8ViG2GRaGiz+UJWnFQQxhiG8wHyCWPlWInpa9uDW0T3m72EbBgIbvruyyFo83k/gfNa8t6sNgFObhuWl7utiXk53sjfCIHxAcQmCDSv+v7XTQo5s7SkoPnmpYMIk99oCR+UqrCbFuJDN2Xw7ULH0f3qrhbtTBu9KAUZtRXNa9NxnCLkRkjhko50QNSQgAZ0HPdpXTmKLlE8SBb4vn7uZroNxFm0hQIDAQAB";
@interface RSAViewController ()

@property (nonatomic,copy) NSString *encriptionStr;

@end
@implementation RSAViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"公钥加密",@"私钥校验"];
}

#pragma mark -- 公钥加密 传送数据给后台
-(void)getDataWithEncryption {
    NSDictionary *dic = @{@"password":@"123456",@"username":@"123456"};
    //使用RSA 加密算法 加密123456
    NSString *encriptionStr = [RSAUtil encryptString:@"12345612323121234561232123456123212345612321234561232123456123212345612321234561232123456123212345611234561232312123456123212345612321234561232123456123212345612321234561232123456123212345612321234561123456123231212345612321234561232123456123212345612321234561232123456123212345612321234561232123456112345612323121234561232123456123212345612321234561232123456123212345612321234561232123456123212345611234561232312123456123212345612321234561232123456123212345612321234561232123456123212345612321234561123456123231212345612321234561232123456123212345612321234561232123456123212345612321234561232123456112345612323121234561232123456123212345612321234561232123456123212345612321234561232123456123212345611234561232312123456123212345612321234561232123456123212345612321234561232123456123212345612321234561123456123231212345612321234561232123456123212345612321234561232123456123212345612321234561232123456112345612323121234561232123456123212345612321234561232123456123212345612321234561232123456123212345611234561232312123456123212345612321234561232123456123212345612321234561232123456123212345612321234561123456123231212345612321234561232123456123212345612321234561232123456123212345612321234561232123456112345612323121234561232123456123212345612321234561232123456123212345612321234561232123456123212345611234561232312123456123212345612321234561232123456123212345612321234561232123456123212345612321234561123456123231212345612321234561232123456123212345612321234561232123456123212345612321234561232123456112345612323121234561232123456123212345612321234561232123456123212345612321234561232123456123212345611234561232312123456123212345612321234561232123456123212345612321234561232123456123212345612321234561123456123231212345612321234561232123456123212345612321234561232123456123212345612321234561232123456112345612323121234561232123456123212345612321234561232123456123212345612321234561232123456123212345611234561232312123456123212345612321234561232123456123212345612321234561232123456123212345612321234561" publicKey:pubkey];
    YCLog(@"%@",encriptionStr);
    self.encriptionStr = encriptionStr;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    encriptionStr = [RSAUtil encryptString:[self convertToJsonData:dic] publicKey:key];
    [manager POST:@"http://192.168.0.186:8050/bbus/user/login" parameters:@{@"r":encriptionStr} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YCLog(@"%@",responseObject);
            NSDictionary *tempDic = [NSDictionary dictionary];
            if ([responseObject objectForKey:@"r"]) {
                
                NSString *str = [responseObject objectForKey:@"r"];
                str = [RSAUtil decryptString:str publicKey:key];
                tempDic = [self dictionaryWithJsonString:str];
                YCLog(@"%@",[tempDic objectForKey:@"statusMsg"]);
            }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YCLog(@"%@",error);
    }];
}

#pragma mark -- 私钥校验 后台加密后数据传送给我。我来校验（java -- > app）
- (void)getDataWithCheckout{
    NSString *decriptionStr = [RSAUtil decryptString:self.encriptionStr privateKey:privkey];
    YCLog(@"%@",decriptionStr);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YCLog(@"%@",responseObject);

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


#pragma mark - 字典转换成字符串
-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        YCLog(@"%@",error);
        
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
        YCLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
