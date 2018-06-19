//
//  XIBUserViewController.m
//  Demo
//
//  Created by 818 on 2018/5/30.
//  Copyright © 2018年 818. All rights reserved.
//

#import "XIBUserViewController.h"
#import <UIKit/UIKit.h>
@interface XIBUseViewController()

@end

@implementation XIBUseViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[[[NSBundle mainBundle] loadNibNamed:@"Test" owner:self options:0] lastObject]];
}
@end
