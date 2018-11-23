//
//  MemberView.m
//  MagicCube
//
//  Created by sophie on 2018/11/22.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "MemberView.h"
@interface MemberView()



@end
@implementation MemberView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = KBGCell;
        [self addSubview:self.titleLabel];
        [self addSubview:self.updateMemBtn];
        [self addSubview:self.normalLabel];
        [self addSubview:self.goldLabel];
        [self addSubview:self.siverLabel];
        [self addSubview:self.diamondLabel];
        [self addSubview:self.normalImageView];
        [self addSubview:self.goldImageView];
        [self addSubview:self.siverImageView];
        [self addSubview:self.diamondImageView];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, 84, 14)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = GrayMagicColor;
        _titleLabel.font = UIFontRegularOfSize(14);
        _titleLabel.text = @"零售指导价：";
    }
    return _titleLabel;
}

-(UIButton *)updateMemBtn{
    if (_updateMemBtn == nil) {
        _updateMemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _updateMemBtn.backgroundColor = [UIColor clearColor];
        _updateMemBtn.frame = CGRectMake(SCREEN_WIDTH -108, 16, 108, 14);
        _updateMemBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_updateMemBtn setTitle: @"升级钻石会员？" forState:UIControlStateNormal];
        [_updateMemBtn setTitleColor:RedMagicColor forState:UIControlStateNormal];
        _updateMemBtn.titleLabel.font = UIFontRegularOfSize(14);
    }
    return _updateMemBtn;
}

-(UILabel *)normalLabel{
    if (_normalLabel == nil) {
         _normalLabel = [self createlabelframe:CGRectMake(30, 50, 157, 15)];
        _normalLabel.attributedText = [self setValueWith:@"普通会员:488" WithNumStr:@"488"];
    }
    return _normalLabel;
}

-(UILabel *)goldLabel{
    if (_goldLabel == nil) {
         _goldLabel = [self createlabelframe:CGRectMake(208, 50, 157, 15)];
         _goldLabel.attributedText = [self setValueWith:@"黄金会员:388(6折)" WithNumStr:@"388(6折)"];
    }
    return _goldLabel;
}

-(UILabel *)siverLabel{
    if (_siverLabel == nil) {
         _siverLabel = [self createlabelframe:CGRectMake(30, 79, 157, 15)];
        _siverLabel.attributedText = [self setValueWith:@"白金会员:288(5.5折)" WithNumStr:@"288(5.5折)"];
    }
    return _siverLabel;
}

-(UILabel *)diamondLabel{
    if (_diamondLabel == nil) {
        _diamondLabel = [self createlabelframe:CGRectMake(208, 79, 157, 15)];
        _diamondLabel.attributedText = [self setValueWith:@"钻石会员:188(4.5折)" WithNumStr:@"188(4.5折)"];
    }
    return _diamondLabel;
}

-(UIImageView *)normalImageView{
    if (_normalImageView == nil) {
        _normalImageView = [self createImageViewframe:CGRectMake(10, 50, 15, 15) WithImageName:@"putonghuiyuan"];
    }
    return _normalImageView;
}

-(UIImageView *)goldImageView{
    if (_goldImageView == nil) {
        _goldImageView = [self createImageViewframe:CGRectMake(188, 50, 15, 15) WithImageName:@"huangjinhuiyuan"];
    }
    return _goldImageView;
}

-(UIImageView *)siverImageView{
    if (_siverImageView == nil) {
        _siverImageView = [self createImageViewframe:CGRectMake(10, 81.1, 15, 15) WithImageName:@"baijinhuiyuan"];
    }
    return _siverImageView;
}

-(UIImageView *)diamondImageView{
    if (_diamondImageView == nil) {
        _diamondImageView = [self createImageViewframe:CGRectMake(188, 81.1, 15, 15) WithImageName:@"zuanshihuiyuan"];
    }
    return _diamondImageView;
}

- (UILabel *)createlabelframe:(CGRect)frame{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = GrayMagicColor;
    label.font = UIFontRegularOfSize(15);
    return label;
}

- (UIImageView *)createImageViewframe:(CGRect)frame WithImageName:(NSString *)imageNameStr{
    UIImageView * tempImageView = [[UIImageView alloc] initWithFrame:frame];
    tempImageView.image = [UIImage imageNamed:imageNameStr];
    return tempImageView;
}

-(NSAttributedString *)setValueWith:deliveryStr WithNumStr:(NSString *)numStr{
    NSDictionary * attubtrDict = @{NSFontAttributeName:UIFontMediumOfSize(15),NSForegroundColorAttributeName:BlackMagicColor};
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryStr dict:attubtrDict subString:numStr];
    return attributestring;
}
@end
