//
//  DemoViewController.m
//  Demo
//
//  Created by 818 on 2018/5/14.
//  Copyright © 2018年 818. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSDictionary *dic;
@end

@implementation DemoViewController

-(NSDictionary *)dic {
    if (!_dic) {
        _dic = [NSDictionary dictionaryWithObjects:@[@"UnrecognizedSelectorViewController"] forKeys:@[@"unrecognized selector(抛出没有找到方法的解决方式)"]];
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"demo集合";
    [self creatTableView];

}

- (void)creatTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame  = self.view.frame;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dic.allKeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dic.allKeys[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cls = NSClassFromString(self.dic.allValues[indexPath.row]);
    id vc  = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
