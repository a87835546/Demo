//
//  BannerView.m
//  Demo
//
//  Created by 颜程 on 2018/6/24.
//  Copyright © 2018年 818. All rights reserved.
//

#import "BannerView.h"
#import <UIImageView+WebCache.h>

@interface BannerView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSArray *_images;
    NSInteger _index;
    NSTimer *_timer;
}
@end
@implementation BannerView

-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;
{
    self= [super initWithFrame:frame];
    if (self) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:images];
        [temp insertObject:images.lastObject atIndex:0];
        [temp insertObject:images.firstObject atIndex:temp.count];
        YCLog(@"%lu",(unsigned long)temp.count);
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _images = images;
        _scrollView.contentSize = CGSizeMake( self.frame.size.width * temp.count,self.frame.size.height);
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < temp.count; i ++) {
            UIImageView* contentView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
//            [contentView sd_setImageWithURL:[NSURL URLWithString:temp[i]]];
            [contentView sd_setImageWithURL:[NSURL URLWithString:temp[i]] placeholderImage:[UIImage imageNamed:@""]];
            [_scrollView addSubview:contentView];
        }
        [self initTimer];
        [self addSubview:_scrollView];
    }
    return self;
}
-(void)initTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }else{
    if (@available(iOS 10.0, *)) {
        
        _timer =[NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];

        [_timer fire];
     
    } else {
        // Fallback on earlier versions
    }
    }
}
-(void)invalidateTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)timerAction
{
    YCLog(@"timerAction");
    [UIView animateWithDuration:1 animations:^{
        if (_index+1<_images.count) {
            _index++;
        }
        else
        {
            _index=0;
        }
        [self->_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*self->_index, 0)];
    } completion:^(BOOL finished) {

    }];
}
-(void)dealloc {
    [_timer invalidate];
    _timer = nil;
}


@end
