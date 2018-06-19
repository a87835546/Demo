//
//  CustomTabBarController.m
//  Demo
//
//  Created by 818 on 2018/5/18.
//  Copyright © 2018年 818. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "DemoViewController.h"
#import "MyViewController.h"
#import "BaseNavigationController.h"
#import "ShoppingViewController.h"
@interface CustomTabBarController ()
@property (nonatomic, strong) CustomTabBar *mainTabBar;
@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    CustomTabBar *mainTabBar = [[CustomTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    self.mainTabBar.click = ^(NSInteger tag) {
        YCLog(@"%ld",tag);
    };
    _mainTabBar = mainTabBar;
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"发现", @"我的",@"商城"];
    NSArray *images = @[@"icon_tabbar_home", @"tabBar_my",@"business"];
    NSArray *selectedImages = @[@"icon_tabbar_home_active", @"tabBar_my_active",@"business_active"];
    
    DemoViewController * homeVc = [[DemoViewController alloc] init];
    
    
    MyViewController * meVc = [[MyViewController alloc] init];
    
    ShoppingViewController *shop = [[ShoppingViewController alloc] init];
    
    NSArray *viewControllers = @[homeVc, meVc,shop];
    
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
//    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}

@end
