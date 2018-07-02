//
//  ChainManager.m
//  Demo
//
//  Created by 818 on 2018/6/27.
//  Copyright © 2018年 818. All rights reserved.
//

#import "ChainManager.h"
#import <Security/Security.h>
#import <SAMKeychain.h>
@implementation ChainManager
NSString *const TOKEN_KEY = @"token";
NSString *const USER_KEY = @"user_id";
NSString *const kINVITATION_CODE = @"INVITATION_CODE";
NSString *const kUSER_NAME = @"USER_NAME";
NSString *const kWALLET_ADDRESS = @"WALLET_ADDRESS";
NSString *const kWALLET_ID = @"WALLET_ID";
NSString *const kSERVICE = @"111111";
NSString *const kACCOUNT = @"111111";

+(void)saveToken:(NSString *)token
{
    BOOL success =  [SAMKeychain setPassword:token forService:kSERVICE account:kACCOUNT];
    
    if (success) {
        YCLog(@"success");
    }
}
+(NSString *)getToken
{
    NSError *error = nil;
    SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
    query.service = kSERVICE;
    query.account = kACCOUNT;
    [query fetch:&error];
    
    if ([error code] == errSecItemNotFound) {
        NSLog(@"Password not found");
    } else if (error != nil) {
        NSLog(@"Some other error occurred: %@", [error localizedDescription]);
    }else{
        NSLog(@"%@",query.password);
    }
    return query.password;
}
@end
