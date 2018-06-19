//
//  MyViewController.m
//  Demo
//
//  Created by 818 on 2018/5/17.
//  Copyright © 2018年 818. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSDictionary *dic;
@end

@implementation MyViewController
-(NSDictionary *)dic {
    if (!_dic) {
        _dic = [NSDictionary dictionaryWithObjects:@[@"ScrollViewController",@"CollectionViewController"] forKeys:@[@"简单九宫格",@"横向滑动collection"]];
        
    }
    return _dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YCRandomColor;
    self.naviTitle = @"collection view 的各种使用";

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
    
    return [self.dic.allKeys count];
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
    BaseViewController* vc  = [[cls alloc] init];
    vc.naviTitle = self.dic.allKeys[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
