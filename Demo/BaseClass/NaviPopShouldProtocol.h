//
//  NaviPopShouldProtocol.h
//  Demo
//
//  Created by 818 on 2018/6/26.
//  Copyright © 2018年 818. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseNavigationController;
@protocol NaviPopShouldProtocol <NSObject>
- (bool)navigationPopWhenSystemSelected:(BaseNavigationController*)navi;
@end
