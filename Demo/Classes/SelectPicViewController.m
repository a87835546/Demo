//
//  SelectPicViewController.m
//  Demo
//
//  Created by 818 on 2018/6/6.
//  Copyright © 2018年 818. All rights reserved.
//

#import "SelectPicViewController.h"

@interface SelectPicViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,copy) NSArray *array;
@property (nonatomic,strong) UIImagePickerController *pickView;

@end

@implementation SelectPicViewController

-(UIImagePickerController *)pickView {
    if (!_pickView) {
        _pickView = [[UIImagePickerController alloc] init];
        _pickView.delegate = self;
    }
    return _pickView;
}

-(NSArray *)array {
    if (!_array) {
        _array = [NSArray arrayWithObjects:@"相册选取",@"拍照", nil];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    // Do any additional setup after loading the view.
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
    
    return [self.array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self pic];
    }else{
        [self camera];
    }
}

#pragma mark -- 相册选择
- (void)pic {
    self.pickView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.pickView animated:YES completion:nil];
}

#pragma mark -- 拍照选取
- (void)camera {
    self.pickView.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.pickView animated:YES completion:nil];


}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    UIImageView *img = [[UIImageView alloc] initWithImage:image];
    img.frame = CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 200);
    [self.view addSubview:img];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    UIImageView *img = [[UIImageView alloc] initWithImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    img.frame = CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 200);
    [self.view addSubview:img];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self.pickView dismissViewControllerAnimated:YES completion:^{}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
