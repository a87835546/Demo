//
//  CunstomTabBar.m
//  Demo
//
//  Created by 818 on 2018/5/18.
//  Copyright © 2018年 818. All rights reserved.
//

#import "CustomTabBar.h"
@interface CustomTabBar()
@property(nonatomic, copy) NSArray *tabBarArray;
@end
@implementation CustomTabBar

-(NSArray *)tabBarArray {
    if (!_tabBarArray) {
        _tabBarArray = [NSArray arrayWithObjects: nil];
    }
    return _tabBarArray;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i =0; self.subviews.count; i ++) {
        [[self.subviews objectAtIndex:i] removeFromSuperview];
    }
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.tabBarArray.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int i = 0 ; i < self.tabBarArray.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 1111 + i;
        [btn addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.tabBarArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(btnW * i, btnY, btnW, btnH);
        [self addSubview:btn];
    }
    YCLog(@"11");
}

- (void)tabBarClick:(UIButton *)sender {
    YCLog(@"%ld",sender.tag);
    if (self.click) {
        self.click(sender.tag);
    }
}
@end
