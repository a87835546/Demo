//
//  YSLoopBanner.h
//  Demo
//
//  Created by 818 on 2018/7/2.
//  Copyright © 2018年 818. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YSLoopBanner : UIView

/** click action */
@property (nonatomic, copy) void (^clickAction) (NSInteger curIndex) ;

/** data source */
@property (nonatomic, copy) NSArray *imageURLStrings;


- (instancetype)initWithFrame:(CGRect)frame scrollDuration:(NSTimeInterval)duration;

- (void)invalidateTimer;

@end

