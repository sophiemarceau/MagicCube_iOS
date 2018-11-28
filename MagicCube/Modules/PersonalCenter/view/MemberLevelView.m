//
//  MemberLevelView.m
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MemberLevelView.h"

@interface MemberLevelView ()
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * levelLabel;
@property (assign,nonatomic) CGFloat imgW;
@end

@implementation MemberLevelView

- (instancetype)initWithFrame:(CGRect)frame imgW:(CGFloat)width
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImgW:width];
    }
    return self;
}

- (void)createImgW:(CGFloat)width{
    if (width <= 0) width = 15;
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - width) * 0.5, (SCALE_W(42) - width) * 0.5, width, width)];
    [self addSubview:self.imgView];
    
    self.levelLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(0, SCALE_W(42), self.frame.size.width, 14)];
    self.levelLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.levelLabel];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImgW:15];
    }
    return self;
}

- (void)configView:(NSString *)imgName levelText:(NSString *)levelStr{
    self.imgView.image = [UIImage imageNamed:imgName];
    self.levelLabel.text = levelStr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
