//
//  ScrollViewController.m
//  Demo
//
//  Created by 818 on 2018/6/13.
//  Copyright © 2018年 818. All rights reserved.
//

#import "ScrollViewController.h"
#import "CollectionViewCell.h"
@interface ScrollViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,copy) NSMutableArray *titles;
@property (nonatomic,strong) UICollectionView *topView;

@end

@implementation ScrollViewController
-(NSMutableArray *)titles {
    if (!_titles ) {
        _titles = [NSMutableArray arrayWithObjects:@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8",@"标题8",@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8",@"标题8",@"标题8",@"标题8", nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

- (void)creatUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100, 100);
    self.topView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    self.topView.delegate = self;
    self.topView.dataSource = self;
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.topView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell___111"];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    YCLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    YCLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

#pragma mark -- UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell___111" forIndexPath:indexPath];
    cell.botlabel.text = self.titles[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100,100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YCLog(@"%ld",indexPath.row);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [[UICollectionReusableView alloc] init];
    view.backgroundColor = [UIColor redColor];
    return view;
}

@end
