//
//  ChainManager.h
//  Demo
//
//  Created by 818 on 2018/6/27.
//  Copyright © 2018年 818. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChainManager : NSObject
+(void)saveToken:(NSString *)token;

+(NSString *)getToken;
@end
