//
//  UIViewController+PopBackAction.h
//  Demo
//
//  Created by 818 on 2018/6/26.
//  Copyright © 2018年 818. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UINavigationController (PopAction)

@end


@protocol PopBackActionProtocol <NSObject>
@optional
- (BOOL)navigationShouldPopOnBackButton;
@end
@interface UIViewController (PopBackAction)<PopBackActionProtocol>

@end
