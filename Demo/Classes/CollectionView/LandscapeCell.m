//
//  LandscapeCell.m
//  Demo
//
//  Created by 818 on 2018/6/14.
//  Copyright © 2018年 818. All rights reserved.
//

#import "LandscapeCell.h"

@implementation LandscapeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
//        _topImage.backgroundColor = YCRandomColor;
//        [self.contentView addSubview:_topImage];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor blueColor];
        _botlabel.font = [UIFont systemFontOfSize:15];
        _botlabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}

@end
