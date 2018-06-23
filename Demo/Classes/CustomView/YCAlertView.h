//
//  YCAlertView.h
//  Demo
//
//  Created by 818 on 2018/6/20.
//  Copyright © 2018年 818. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YCAlertViewCancel)(void);
typedef void (^YCAlertViewEnsure)(void);
@interface YCAlertView : UIView

-(instancetype)initWithFrame:(CGRect)frame systemAlertWithTitle:(NSString *)title cancel:(YCAlertViewCancel)cancel ensure:(YCAlertViewEnsure)ensure;
@end
