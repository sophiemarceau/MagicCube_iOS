//
//  DistributeLevelView.m
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "DistributeLevelView.h"
#import "MagicRichTool.h"

@interface DistributeLevelView ()
@property (strong,nonatomic) UIView * outCircle;
@property (strong,nonatomic) UIView * inCircle;
@property (strong,nonatomic) MagicLineView * upLine;
@property (strong,nonatomic) MagicLineView * downLine;
@property (strong,nonatomic) MagicLabel * levelLabel;
@property (strong,nonatomic) MagicLabel * priceLabel;
@property (strong,nonatomic) UIButton * gradeBtn;
@end

@implementation DistributeLevelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.outCircle];
        [self addSubview:self.inCircle];
        [self addSubview:self.upLine];
        [self addSubview:self.downLine];
        [self addSubview:self.levelLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.gradeBtn];
        
    }
    return self;
}


- (void)configTextRed:(BOOL)isred
                level:(NSString *)level
                price:(CGFloat)price
             discount:(NSString *)discount
                grade:(BOOL)isgreaded
            gradeText:(NSString *)gradetext
                 line:(LinePosition)posision{
    
    self.levelLabel.text = level;
    
    
    if (isred) {
        self.outCircle.layer.borderColor = RedMagicColor.CGColor;
        self.inCircle.layer.borderColor = RedMagicColor.CGColor;
        self.inCircle.backgroundColor = RedMagicColor;
        self.inCircle.hidden = NO;
        self.levelLabel.textColor = Gray666Color;
        self.priceLabel.textColor = RedMagicColor;
        
        if (price >= 0 && discount >= 0) {
            NSString * priceDiscountStr = [NSString stringWithFormat:@"%.2f元（%@折）",price,discount];
            NSDictionary * descattubtrDict = @{NSFontAttributeName: UIFontLightOfSize(20)};
            NSArray * array = @[@{subDictKey:descattubtrDict,substrKey:[NSString stringWithFormat:@"%.2f元",price]}];
            self.priceLabel.attributedText = [MagicRichTool initWithString:priceDiscountStr attrbutes:array];
        }
        
    }else{
        if (price >= 0 && discount >= 0) {
            NSString * priceDiscountStr = [NSString stringWithFormat:@"%.2f元（%@折）",price,discount];
            NSDictionary * descattubtrDict = @{NSFontAttributeName: UIFontLightOfSize(14)};
            NSArray * array = @[@{subDictKey:descattubtrDict,substrKey:[NSString stringWithFormat:@"%.2f元",price]}];
            self.priceLabel.attributedText = [MagicRichTool initWithString:priceDiscountStr attrbutes:array];
        }
        
        self.outCircle.layer.borderColor = [UIColor colorWithHexString:@"CDCDCD" alpha:1].CGColor;
        self.inCircle.hidden = YES;
        self.levelLabel.textColor = GrayMagicColor;
        self.priceLabel.textColor = GrayMagicColor;
    }
    
    [self.gradeBtn setTitle:gradetext forState:UIControlStateNormal];
    if (isgreaded) {
        [self.gradeBtn setTitleColor:[UIColor colorWithHexString:@"999999" alpha:0.3] forState:UIControlStateNormal];
        self.gradeBtn.layer.borderColor = [UIColor colorWithHexString:@"999999" alpha:0.3].CGColor;
    }else{
        [self.gradeBtn setTitleColor:RedMagicColor forState:UIControlStateNormal];
        self.gradeBtn.layer.borderColor = RedMagicColor.CGColor;
    }
    
    if (posision == LinePositionShowUp) {
     // 只有上
        self.upLine.hidden = NO;
        self.downLine.hidden = YES;
    }else if (posision == LinePositionShowDown){
    // 只有下
        self.upLine.hidden = YES;
        self.downLine.hidden = NO;
    }else if (posision == LinePositionShowUpDown){
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
        _outCircle.layer.cornerRadius = _outCircle.width * 0.5;
    }
    return _outCircle;
}

- (UIView *)inCircle{
    if (!_inCircle) {
        _inCircle = [[UIView alloc] initWithFrame:CGRectMake(SCALE_W(28.5), (self.frame.size.height - SCALE_W(8)) * 0.5, SCALE_W(8), SCALE_W(8))];
        _inCircle.layer.borderWidth = 0.5;
        _inCircle.layer.masksToBounds = YES;
        _inCircle.layer.cornerRadius = _inCircle.width * 0.5;
        _inCircle.backgroundColor = RedMagicColor;
    }
    return _inCircle;
}

- (MagicLineView *)upLine{
    if (!_upLine) {
        _upLine = [[MagicLineView alloc] initWithFrame:CGRectMake(SCALE_W(32.5), 0, 0.5, (self.frame.size.height - SCALE_W(14)) * 0.5)];
        _upLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    return _upLine;
}

-(MagicLineView *)downLine{
    if (!_downLine) {
        _downLine = [[MagicLineView alloc] initWithFrame:CGRectMake(SCALE_W(32.5), SCALE_W(7) + self.frame.size.height * 0.5, 0.5, (self.frame.size.height - SCALE_W(14)) * 0.5)];
        _downLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    }
    return _downLine;
}

- (MagicLabel *)levelLabel{
    if (!_levelLabel) {
        _levelLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(48.5), (self.frame.size.height - SCALE_W(14)) * 0.5, SCALE_W(114), SCALE_W(14))];
        _levelLabel.font = UIFontRegularOfSize(SCALE_W(14));
    }
    return _levelLabel;
}

-(MagicLabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(118.5), 0, SCREEN_WIDTH - SCALE_W(209), self.frame.size.height)];
        _priceLabel.font = UIFontLightOfSize(12);
    }
    return _priceLabel;
}

- (UIButton *)gradeBtn{
    if (!_gradeBtn) {
        _gradeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCALE_W(90.5), (self.frame.size.height - SCALE_W(22.5)) * 0.5, SCALE_W(85.5), SCALE_W(22.5))];
        _gradeBtn.layer.cornerRadius = 2;
        _gradeBtn.titleLabel.font = UIFontRegularOfSize(SCALE_W(12));
        _gradeBtn.layer.borderColor = [UIColor colorWithHexString:@"999999" alpha:0.3].CGColor;
        _gradeBtn.layer.borderWidth = 0.5;
        _gradeBtn.layer.masksToBounds = YES;
    }
    return _gradeBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
