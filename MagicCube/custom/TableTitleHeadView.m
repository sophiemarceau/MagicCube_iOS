//
//  TableTitleHeadView.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "TableTitleHeadView.h"

@interface TableTitleHeadView ()
@property (strong,nonatomic) MagicLabel * titleLabel;
@property (strong,nonatomic) MagicLineView * lineView;
@end
@implementation TableTitleHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BHColorWhite;
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)setUpTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)setTitleFrame:(CGRect)frame{
    self.titleLabel.frame = frame;
}

- (void)setLineFrame:(CGRect)frame{
    self.lineView.frame = frame;
}

- (MagicLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 43.5)];
        _titleLabel.font = UIFontRegularOfSize(16);
        _titleLabel.textColor = BlackMagicColor;
        _titleLabel.text = @"会员特权";
    }
    return _titleLabel;
}

- (MagicLineView *)lineView{
    if (!_lineView) {
        _lineView = [[MagicLineView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, SCREEN_WIDTH, 0.5)];
    }
    return _lineView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
