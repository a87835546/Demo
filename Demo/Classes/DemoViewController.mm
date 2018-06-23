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
        _dic = [NSDictionary dictionaryWithObjects:@[@"UnrecognizedSelectorViewController",@"DESViewController",@"RSAViewController",@"MD5ViewController",@"AESViewController",@"FMDBViewController",@"RNViewController",@"XIBUseViewController",@"UploadFileViewController",@"SelectPicViewController",@"HTMLCallAppViewController",@"CustomHitViewController"] forKeys:@[@"unrecognized selector(抛出没有找到方法的解决方式)",@"DES加密",@"RSA加密方法",@"MD5校验",@"AES加密",@"fmdb数据库的简单使用",@"RN通讯",@"xib使用",@"AFN上传文件",@"相册图片选择，拍照获取",@"HTML CALL APP",@"自定义响应区域"]];
        
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"demo集合";
    [self creatTableView];
    float i = 0.132123113231321321;
    double_t   f = 0.45456464654654654;
    NSNumber *z = [NSNumber numberWithDouble:42135434546540.15465546465465456464654564654];
    NSInteger y = 1231.14546546465;
    YCLog(@"%f \n %ld \n %l",f,(long)y,z);
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

@end
