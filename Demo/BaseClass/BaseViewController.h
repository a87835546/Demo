//
//  BaseViewController.h
//  Demo
//
//  Created by 818 on 2018/5/14.
//  Copyright © 2018年 818. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSString *naviTitle;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end
