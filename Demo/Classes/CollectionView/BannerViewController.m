//
//  BannerViewController.m
//  Demo
//
//  Created by 颜程 on 2018/6/24.
//  Copyright © 2018年 818. All rights reserved.
//

#import "BannerViewController.h"
#import "BannerView.h"
#import "YSLoopBanner.h"
#import "CustomHitViewController.h"
@interface BannerViewController ()
@property (weak, nonatomic) IBOutlet BannerView *bannerView;
@property (nonatomic,strong) YSLoopBanner *banner;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BannerView *view = [[BannerView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 250) images:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=431a4f6b1dfb121a9830f89bdd2d81eb&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F10dfa9ec8a136327701bf8109b8fa0ec08fac71a.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=b31e6db1bf1c9ee91dd2539357b4ba5b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F279759ee3d6d55fba3b9590267224f4a20a4dd92.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=9d5bf385a99a6050871e557f710c6b39&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F9d82d158ccbf6c8154bdd5ccb63eb13533fa4008.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=15d0234c165101f4ef1642533486cac5&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F0e2442a7d933c8954428e65edb1373f082020044.jpg"]];
    self.bannerView = view;
    [self.view addSubview:self.bannerView];
    
    self.banner = [[YSLoopBanner alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 200) scrollDuration:2];
    _banner.imageURLStrings =@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=431a4f6b1dfb121a9830f89bdd2d81eb&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F10dfa9ec8a136327701bf8109b8fa0ec08fac71a.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=b31e6db1bf1c9ee91dd2539357b4ba5b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F279759ee3d6d55fba3b9590267224f4a20a4dd92.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=9d5bf385a99a6050871e557f710c6b39&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F9d82d158ccbf6c8154bdd5ccb63eb13533fa4008.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530510619969&di=15d0234c165101f4ef1642533486cac5&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F0e2442a7d933c8954428e65edb1373f082020044.jpg"];
    _banner.clickAction = ^(NSInteger curIndex) {
        YCLog(@"%ld",curIndex);
    };
    [self.view addSubview:_banner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    CustomHitViewController *my = nil;
//    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
//    for (id vc in  self.navigationController.viewControllers) {
//        [temp addObject:vc];
//        if ([vc isKindOfClass:[CustomHitViewController class]]) {
//            my = vc;
//            [self.navigationController setViewControllers:[temp copy]];
//            return;
//        }
//    }
//
    [self.bannerView invalidateTimer];
    [self.banner invalidateTimer];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;
{
    return YES;
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item;
{
    CustomHitViewController *my = nil;
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
        for (id vc in  self.navigationController.viewControllers) {
            [temp addObject:vc];
            if ([vc isKindOfClass:[CustomHitViewController class]]) {
                my = vc;
                [self.navigationController setViewControllers:[temp copy]];
                return;
            }
        }
    
}
- (BOOL)navigationShouldPopOnBackButton {
    // 实现你所想做的
    [self.navigationController popToRootViewControllerAnimated:YES];
    return NO;
}

@end
