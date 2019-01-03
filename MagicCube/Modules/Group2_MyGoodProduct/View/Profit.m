//
//  Profit.m
//  MagicCube
//
//  Created by wanmeizty on 3/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "Profit.h"

@interface Profit ()
@property (strong,nonatomic) UIView * outCircle;
@property (strong,nonatomic) UIView * inCircle;
@property (strong,nonatomic) MagicLineView * upLine;
@property (strong,nonatomic) MagicLineView * downLine;
@property (strong,nonatomic) MagicLabel * profitLabel;
@end

@implementation Profit

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.outCircle];
        [self addSubview:self.inCircle];
        [self addSubview:self.upLine];
        [self addSubview:self.downLine];
        [self addSubview:self.levelLabel];
    }
    return self;
}

- (void)configRedtexts:(NSArray *)redtexts
                  text:(NSString *)text
                  line:(LineDirection)posision{
    
    
    
    
    
    NSDictionary * attubtrDict = @{NSForegroundColorAttributeName:RedMagicColor};
    
    NSAttributedString * attributestring = [MagicRichTool initWithString:text dict:attubtrDict subStringArray:redtexts];
    self.profitLabel.attributedText = attributestring;
    
    if (posision == LineDirectionShowUp) {
        // 只有上
        self.upLine.hidden = NO;
        self.downLine.hidden = YES;
    }else if (posision == LineDirectionShowDown){
        // 只有下
        self.upLine.hidden = YES;
        self.downLine.hidden = NO;
    }else if (posision == LineDirectionShowUpDown){
        // 都有
        self.upLine.hidden = NO;
        self.downLine.hidden = NO;
    }else{
        self.upLine.hidden = YES;
        self.downLine.hidden = YES;
    }
}

-(UIView *)outCircle{
    if (!_outCircle) {
        _outCircle = [[UIView alloc] initWithFrame:CGRectMake(SCALE_W(25.5), (self.frame.size.height - SCALE_W(14)) * 0.5, SCALE_W(14), SCALE_W(14))];
        _outCircle.layer.borderWidth = 0.5;
        _outCircle.layer.masksToBounds = YES;
        _outCircle.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        _outCircle.layer.cornerRadius = _outCircle.width * 0.5;
        _outCircle.layer.borderColor = RedMagicColor.CGColor;
    }
    return _outCircle;
}

- (UIView *)inCircle{
    if (!_inCircle) {
        _inCircle = [[UIView alloc] initWithFrame:CGRectMake(SCALE_W(28.5), (self.frame.size.height - SCALE_W(8)) * 0.5, SCALE_W(8), SCALE_W(8))];
        _inCircle.layer.borderWidth = 0.5;
        _inCircle.layer.borderColor = RedMagicColor.CGColor;
        _inCircle.backgroundColor = RedMagicColor;
        _inCircle.layer.cornerRadius = _inCircle.width * 0.5;
    }
    return _inCircle;
}

- (MagicLineView *)upLine{
    if (!_upLine) {
        _upLine = [[MagicLineView alloc] initWithFrame:CGRectMake(SCALE_W(32.5), 0, 0.5, (self.frame.size.height - SCALE_W(14)) * 0.5)];
        _upLine.backgroundColor = LineD1GrayColor;
    }
    return _upLine;
}

-(MagicLineView *)downLine{
    if (!_downLine) {
        _downLine = [[MagicLineView alloc] initWithFrame:CGRectMake(SCALE_W(32.5), SCALE_W(7) + self.frame.size.height * 0.5, 0.5, (self.frame.size.height - SCALE_W(14)) * 0.5)];
        _downLine.backgroundColor = LineD1GrayColor;
    }
    return _downLine;
}

- (MagicLabel *)levelLabel{
    if (!_profitLabel) {
        _profitLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(48.5), 0, self.frame.size.width - SCALE_W(48.5) - SCALE_W(10), self.frame.size.height)];
        _profitLabel.font = UIFontLightOfSize(14);
    }
    return _profitLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
