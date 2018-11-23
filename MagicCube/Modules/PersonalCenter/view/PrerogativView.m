//
//  PrerogativView.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "PrerogativView.h"
#import "SpecilView.h"

@interface PrerogativView ()
@property (strong,nonatomic) UIButton * joinMagicBtn;
@end

@implementation PrerogativView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = SCREEN_WIDTH / 4.0;
        for (int i = 0; i < 4; i ++) {
            SpecilView * view = [[SpecilView alloc] initWithFrame:CGRectMake(width * i, 0, width, 100)];
            view.tag = 100 + i;
            [self addSubview:view];
        }
        
        [self addSubview:self.joinMagicBtn];
        
    }
    return self;
}

-(void)configwithDict:(NSDictionary *)dict{
    NSArray * newArray = @[
        @{@"title":@"18/月起",@"desc":@"超低价格"},
        @{@"title":@"最低3折",@"desc":@"分销优惠"},
        @{@"title":@"50%起",@"desc":@"超低返佣"},
        @{@"title":@"50%起",@"desc":@"平台分红"}];
    NSInteger tag = 100;
    for (NSDictionary * subdict in newArray) {
        
        SpecilView * view = [self viewWithTag:tag];
        [view configWithDict:subdict];
        tag ++;
    }
    [self.joinMagicBtn setTitle:@"18元起成为魔方合伙人" forState:UIControlStateNormal];
}

- (UIButton *)joinMagicBtn{
    if (!_joinMagicBtn) {
        _joinMagicBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 196) * 0.5, 139, 196, 38)];
        _joinMagicBtn.backgroundColor = RedMagicColor;
        [_joinMagicBtn setTitleColor:BHColorWhite forState:UIControlStateNormal];
        _joinMagicBtn.titleLabel.font = UIFontRegularOfSize(16);
    }
    return _joinMagicBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
