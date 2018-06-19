//
//  CunstomTabBar.h
//  Demo
//
//  Created by 818 on 2018/5/18.
//  Copyright © 2018年 818. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^tabBarClick) (NSInteger tag);
@interface CustomTabBar : UITabBar
@property(nonatomic, copy) tabBarClick click;
@end
