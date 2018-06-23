//
//  Custom.m
//  Demo
//
//  Created by 颜程 on 2018/6/20.
//  Copyright © 2018年 818. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.userInteractionEnabled || [self isHidden] || self.alpha <= 0.01) {
        return nil;
    }
    
    if ([self pointInside:point withEvent:event]) {
        __block UIView *hit = nil;
        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint convertPoint = [self convertPoint:point toView:obj];
            
            hit = [obj hitTest:convertPoint withEvent:event];
            
            if (hit) {
                *stop = YES;
            }
        }];
        if (hit) {
            return hit;
        }else{
            return self;
        }
    }else {
        return nil;
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    
    CGFloat x2 = self.frame.size.width/2;
    CGFloat y2 = self.frame.size.height/2;
    
    double dis = sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
    
    if (dis <= self.frame.size.width/2) {
        return YES;
    }
    else{
        return NO;
    }
}
@end
