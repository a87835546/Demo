//
//  CustomHitViewController.m
//  Demo
//
//  Created by 颜程 on 2018/6/20.
//  Copyright © 2018年 818. All rights reserved.
//

#import "CustomHitViewController.h"
#import "CustomButton.h"
@interface CustomHitViewController ()
@property (nonatomic,copy) NSMutableArray *array;

@end

@implementation CustomHitViewController

-(NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CustomButton *btn = [[CustomButton alloc] init];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor =[UIColor redColor];
    
    
    
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
- (IBAction)click:(CustomButton *)sender {
    YCLog(@"clcik");
    [self.array objectAtIndex:100];
}

@end
