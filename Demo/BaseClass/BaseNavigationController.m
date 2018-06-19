//
//  BaseNvaigationController.m
//  Demo
//
//  Created by 818 on 2018/5/14.
//  Copyright © 2018年 818. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        
        [backBtn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = backItem;
        self.navigationBar.backItem.title = @"";
    }
    [super pushViewController:viewController animated:animated];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
