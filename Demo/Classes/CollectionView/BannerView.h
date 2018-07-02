//
//  BannerView.h
//  Demo
//
//  Created by 颜程 on 2018/6/24.
//  Copyright © 2018年 818. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView
-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;
- (void)invalidateTimer;
@end
