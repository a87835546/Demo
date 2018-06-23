//
//  YCAlertView.m
//  Demo
//
//  Created by 818 on 2018/6/20.
//  Copyright © 2018年 818. All rights reserved.
//

#import "YCAlertView.h"

@interface YCAlertView()
@property (nonatomic,copy) YCAlertViewCancel cancel;
@property (nonatomic,copy) YCAlertViewEnsure ensure;

@end

@implementation YCAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame systemAlertWithTitle:(NSString *)title cancel:(YCAlertViewCancel)cancel ensure:(YCAlertViewEnsure)ensure;
{
    self = [super initWithFrame:frame];
    if (self) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                self.cancel();
            }
        }];
        UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (ensure) {
                self.ensure();
            }
        }];
        
        [alert addAction:cancel];
        [alert addAction:ensure];
        
        [self addSubview:alert];
        
        
    }
    return self;
}
@end
