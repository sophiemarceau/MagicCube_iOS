//
//  SpecilView.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "SpecilView.h"

@interface SpecilView ()
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * titlLabel;
@property (strong,nonatomic) MagicLabel * desclabel;
@end

@implementation SpecilView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imgView];
        [self addSubview:self.titlLabel];
        [self addSubview:self.desclabel];
    }
    return self;
}

- (void)configWithDict:(NSDictionary *)dict{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"idocn"]]] placeholderImage:[UIImage imageNamed:@"caiwuzhongxin_selected"]];
    
    self.titlLabel.text = [dict objectForKey:@"title"];
    self.desclabel.text = [dict objectForKey:@"desc"];
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 30) * 0.5, 21, 30, 30)];
    }
    return _imgView;
}

-(MagicLabel *)titlLabel{
    if (!_titlLabel) {
        _titlLabel = [MagicLabel initWithFrame:CGRectMake(0, 65, self.frame.size.width, 14)];
        _titlLabel.textAlignment = NSTextAlignmentCenter;
        _titlLabel.textColor = BlackMagicColor;
    }
    return _titlLabel;
}

-(MagicLabel *)desclabel{
    if (!_desclabel) {
        _desclabel = [MagicLabel initWithFrame:CGRectMake(0, 87, self.frame.size.width, 12)];
        _desclabel.font = UIFontRegularOfSize(12);
        _desclabel.textAlignment = NSTextAlignmentCenter;
    }
    return _desclabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
