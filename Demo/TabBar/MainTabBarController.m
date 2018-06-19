//
//  MainTabBarController.m
//  模仿简书自定义Tabbar（纯代码）
//
//  Created by 余钦 on 16/5/30.
//  Copyright © 2016年 yuqin. All rights reserved.
//

#import "MainTabBarController.h"
#import "DemoViewController.h"
#import "MyViewController.h"
#import "BaseNavigationController.h"
#import "MainTabBar.h"


@interface MainTabBarController ()<MainTabBarDelegate>
@property(nonatomic, weak)MainTabBar *mainTabBar;
@property(nonatomic, strong)DemoViewController *homeVc;
@property(nonatomic, strong)MyViewController *meVc;
@end

@implementation MainTabBarController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self SetupMainTabBar];
    [self SetupAllControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetupMainTabBar{
    MainTabBar *mainTabBar = [[MainTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    _mainTabBar = mainTabBar;
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"发现", @"我的"];
    NSArray *images = @[@"icon_tabbar_home", @"icon_tabbar_me"];
    NSArray *selectedImages = @[@"icon_tabbar_home_active", @"icon_tabbar_me_active"];
    
    DemoViewController * homeVc = [[DemoViewController alloc] init];
    self.homeVc = homeVc;
    
    MyViewController * meVc = [[MyViewController alloc] init];
    self.meVc = meVc;
    
    NSArray *viewControllers = @[homeVc, meVc];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}



#pragma mark --------------------mainTabBar delegate
- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
    NSLog(@"11");
}

- (void)tabBarClickWriteButton:(MainTabBar *)tabBar{
    //    WriteViewController *writeVc = [[WriteViewController alloc] init];
    //    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:writeVc];
    //
    //    [self presentViewController:nav animated:YES completion:nil];
}
@end
