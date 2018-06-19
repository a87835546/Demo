//
//  CollectionViewController.m
//  Demo
//
//  Created by 818 on 2018/6/14.
//  Copyright © 2018年 818. All rights reserved.
//

#import "CollectionViewController.h"
#import "LandscapeCell.h"
@interface CollectionViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,copy) NSMutableArray *titles;
@property (nonatomic,strong) UICollectionView *topView;

@end

@implementation CollectionViewController
-(NSMutableArray *)titles {
    if (!_titles ) {
        _titles = [NSMutableArray arrayWithObjects:@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8",@"标题8",@"标题8",@"标题8", nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
}

- (void)creatUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(80, 40);
    self.topView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 40) collectionViewLayout:layout];
    self.topView.delegate = self;
    self.topView.dataSource = self;
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.topView registerClass:[LandscapeCell class] forCellWithReuseIdentifier:@"cell___123"];
    
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
    LandscapeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell___123" forIndexPath:indexPath];
    cell.botlabel.text = self.titles[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80,40);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
