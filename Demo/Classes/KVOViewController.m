//
//  KVOViewController.m
//  Demo
//
//  Created by 818 on 2018/6/28.
//  Copyright © 2018年 818. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()
{
    NSMutableDictionary *_mDic;
}
@property (nonatomic,strong) NSMutableDictionary *mDic;
@property (nonatomic,strong) NSMutableArray *mArr;

@end

@implementation KVOViewController
-(void)setMDic:(NSMutableDictionary *)mDic
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dictionay_update" object:_mDic];
    _mDic = mDic;
}
-(NSMutableDictionary *)mDic {
    if (!_mDic) {
        _mDic = [NSMutableDictionary dictionary];
        [_mDic addObserver:self forKeyPath:@"allValues" options:0 context:nil];
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDic:) name:@"dictionay_update" object:_mDic];

    return _mDic;
}
-(NSMutableArray *)mArr {
    if (!_mArr) {
        _mArr = [NSMutableArray array];
    }
    return _mArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.mDic setObject:@"123" forKey:@"1"];
    
}
- (void)updateDic:(NSNotification *)notification
{
    YCLog(@"%@",notification.userInfo);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    YCLog(@"%@",keyPath);
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
