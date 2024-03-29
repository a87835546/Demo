//
//  MainTabBar.m
//  模仿简书自定义Tabbar（纯代码）
//
//  Created by 余钦 on 16/5/30.
//  Copyright © 2016年 yuqin. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"

@interface MainTabBar ()
@property(nonatomic, strong)NSMutableArray *tabbarBtnArray;
@property(nonatomic, weak)UIButton *writeButton;
@property(nonatomic, weak)MainTabBarButton *selectedButton;
@end

@implementation MainTabBar
- (NSMutableArray *)tabbarBtnArray{
    if (!_tabbarBtnArray) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return  _tabbarBtnArray;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self SetupWriteButton];
    }
    
    return self;
}

- (void)SetupWriteButton{
    UIButton *writeButton = [UIButton new];
    writeButton.adjustsImageWhenHighlighted = NO;
    [writeButton setBackgroundImage:[UIImage imageNamed:@"button_write~iphone"] forState:UIControlStateNormal];
    [writeButton addTarget:self action:@selector(ClickWriteButton) forControlEvents:UIControlEventTouchUpInside];
    writeButton.bounds = CGRectMake(0, 0, writeButton.currentBackgroundImage.size.width, writeButton.currentBackgroundImage.size.height);
//    [self addSubview:writeButton];
    _writeButton = writeButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.writeButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int nIndex = 0; nIndex < self.tabbarBtnArray.count; nIndex++) {
        CGFloat btnX = btnW * nIndex;
        MainTabBarButton *tabBarBtn = self.tabbarBtnArray[nIndex];
        if (nIndex > 1) {
            btnX += btnW;
        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = nIndex;
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}
- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem addTabButtonWithName:(NSString *)name selName:(NSString *)selName titleString:(NSString*)titleString {
    
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    
    // 设置图片
    [tabBarBtn setImage :[UIImage imageNamed:name] forState:UIControlStateNormal];
    [tabBarBtn setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    [tabBarBtn setTitle:titleString forState:UIControlStateNormal];
    [tabBarBtn setTitle:titleString forState:UIControlStateSelected];
    tabBarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
    
}
- (void)ClickTabBarButton:(MainTabBarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}

- (void)ClickWriteButton{
    if ([self.delegate respondsToSelector:@selector(tabBarClickWriteButton:)]) {
        [self.delegate tabBarClickWriteButton:self];
    }
}
@end
