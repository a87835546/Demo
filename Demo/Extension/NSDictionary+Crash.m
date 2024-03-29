//
//  NSDictionary+Crash.m
//  Demo
//
//  Created by 818 on 2018/5/15.
//  Copyright © 2018年 818. All rights reserved.
//

#import "NSDictionary+Crash.h"
#import <objc/runtime.h>
@implementation NSDictionary (Crash)

- (void)swizzeMethod:(SEL)origSelector withMethod:(SEL)newSelector

{
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);//Method是运行时库的类
    
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class, origSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else{
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
    
}
- (void)safe_setObject:(id)value forKey:(NSString* )key{
    
    if (value) {
        
        [self safe_setObject:value forKey:key];
        
    }else{
        
        NSLog(@"[NSMutableDictionary setObject: forKey:%@]值不能为空;",key);
        
    }
    
}

- (void)safe_removeObjectForKey:(NSString *)key{
    
    if ([self objectForKey:key]) {
        
        [self safe_removeObjectForKey:key];
        
    }else{
        
        NSLog(@"[NSMutableDictionary setObject: forKey:%@]值不能为空;",key);
        
    }
    
}

- (void)safe_objectForKey:(NSString *)key {
    if (key) {
        [self objectForKey:key];
    }else{
        YCLog(@"[NSMutableDictionary objectForKey: forKey:%@]值不能为空;",key);
    }
}

+ (void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        id obj = [[self alloc]init];
        
        [obj swizzeMethod:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:forKey:)];
        
        [obj swizzeMethod:@selector(removeObjectForKey:) withMethod:@selector(safe_removeObjectForKey:)];
        
//        [obj swizzeMethod:@selector(objectForKey:) withMethod:@selector(safe_objectForKey:)];
        
    });
    
}


@end
