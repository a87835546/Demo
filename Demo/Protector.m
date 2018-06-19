//
//  Protector.m
//  Demo
//
//  Created by 818 on 2018/5/15.
//  Copyright © 2018年 818. All rights reserved.
//

#import "Protector.h"
#import <objc/runtime.h>
@implementation Protector
-(id)forwardingTargetForSelector:(SEL)aSelector {
    Class Cls = NSClassFromString(@"Protector");
    if (!Cls) {
        Cls = objc_allocateClassPair([NSObject class], "Protector", 0);
        objc_registerClassPair(Cls);
    }
    NSString *selectorStr = NSStringFromSelector(aSelector);
    class_addMethod(Cls, aSelector, [self safeImplementation:aSelector], [selectorStr UTF8String]);
    Class Protector = [Cls class];
    id instance = [[Protector alloc] init];
    return instance;
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


@end
