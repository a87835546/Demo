//
//  ShoppingViewController.m
//  Demo
//
//  Created by 818 on 2018/6/7.
//  Copyright © 2018年 818. All rights reserved.
//

#import "ShoppingViewController.h"

@interface ShoppingViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIImageView *searchImgView;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNaviTitleView];
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
    
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    YCLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView.contentOffset.y > -64) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}
- (void)setNaviTitleView {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(mainNavi) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT - 40 *2 , 40)];
    self.navigationItem.titleView = view;
    view.layer.borderWidth = 0.8f;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    self.searchImgView.image = [UIImage imageNamed:@"fail"];
    self.searchImgView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:self.searchImgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 40)];
    textField.delegate = self;
    [view addSubview:textField];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.searchImgView.hidden  = YES;
}

- (void)mainNavi {
    YCLog(@"mainNavi");
}

- (void)rightClick {
    YCLog(@"rightClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
