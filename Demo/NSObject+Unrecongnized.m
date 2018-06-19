//
//  NSObject+Unrecongnized.m
//  Demo
//
//  Created by 818 on 2018/5/15.
//  Copyright © 2018年 818. All rights reserved.
//

#import "NSObject+Unrecongnized.h"
#import <objc/runtime.h>
@implementation NSObject (Unrecongnized)
// 重写消息转发方法
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSString *selectorStr = NSStringFromSelector(aSelector);
    // 做一次类的判断，只对 UIResponder 和 NSNull 有效
    if ([[self class] isSubclassOfClass: NSClassFromString(@"UIResponder")] ||
        [self isKindOfClass: [NSNull class]])
    {
        YCLog(@"PROTECTOR: -[%@ %@]", [self class], selectorStr);
        YCLog(@"PROTECTOR: unrecognized selector \"%@\" sent to instance: %p", selectorStr, self);
        // 查看调用栈
        YCLog(@"PROTECTOR: call stack: %@", [NSThread callStackSymbols]);
        
        // 对保护器插入该方法的实现
        Class protectorCls = NSClassFromString(@"Protector");
        if (!protectorCls)
        {
            protectorCls = objc_allocateClassPair([NSObject class], "Protector", 0);
            objc_registerClassPair(protectorCls);
        }
        
        // 在该类里面添加方法
        class_addMethod(protectorCls, aSelector, [self safeImplementation:aSelector],
                            [selectorStr UTF8String]);
            
        Class Protector = [protectorCls class];
        id instance = [[Protector alloc] init];
        
        return instance;
    }
    else
    {
        return nil;
    }
}

// 一个安全的方法实现
- (IMP)safeImplementation:(SEL)aSelector
{
    IMP imp = imp_implementationWithBlock(^()
      {
          YCLog(@"PROTECTOR: %@ Done", NSStringFromSelector(aSelector));
      });
    return imp;
}



+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    if (!originalMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(originalSelector)];
        *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(swizzledSelector)];
        *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return YES;
}

@end
