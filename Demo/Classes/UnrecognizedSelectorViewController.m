//
//  UnrecogisedSelectorViewController.m
//  Demo
//
//  Created by 818 on 2018/5/15.
//  Copyright © 2018年 818. All rights reserved.
//

#import "UnrecognizedSelectorViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface UnrecognizedSelectorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSMutableArray *typeArray;
@end

@implementation UnrecognizedSelectorViewController
-(NSMutableArray *)typeArray {
    
    if (!_typeArray) {
        _typeArray = [NSMutableArray arrayWithObjects:@"调用没有实现的方法",@"数组越界array[0]方式调用",nil];
    }
    return _typeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle =  @"all type unrecognised selecotr";
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
    
    return self.typeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.typeArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self callNotFun];
    }else if (indexPath.row == 1){
        [self arrayBeyond];
    }
}


#pragma mark --- 调用没有实现的方法
-(void)callNotFun {
    UILabel *btn = [[UILabel alloc] init];
    [btn performSelector:@selector(xxx) withObject:self];
    [self.view addSubview:btn];
}

#pragma mark -- 数组越界
-(void)arrayBeyond {
    YCLog(@"%@",[self.typeArray objectAtIndex:100]);
//    YCLog(@"%@",[self.typeArray addObject:nil]);
//    [self.typeArray addObject:nil];

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
