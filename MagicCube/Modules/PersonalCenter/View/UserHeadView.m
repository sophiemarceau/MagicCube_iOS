//
//  UserHeadView.m
//  MagicCube
//
//  Created by wanmeizty on 23/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "UserHeadView.h"
#import "MemberLevelView.h"
#import "UIButton+ImageTitleAlign.h"

@interface UserHeadView ()
@property (strong,nonatomic) UIImageView * iconView;
@property (strong,nonatomic) UIButton * memberTypeBtn;
@property (strong,nonatomic) MagicLabel * balenceLabel;
@property (strong,nonatomic) MagicLabel * magicPointLabel;
@property (strong,nonatomic) UIButton * menberBtn;
@property (strong,nonatomic) UIImageView * redBGView;
@property (strong,nonatomic) MagicLabel * nameLabel;
@property (strong,nonatomic) UIButton * detailBtn;
@property (strong,nonatomic) UIButton * settingBtn;

@property (strong,nonatomic) UIView * shadowView;

@end

@implementation UserHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.redBGView];
        [self.redBGView addSubview:self.iconView];
        [self.redBGView addSubview:self.nameLabel];
        [self.redBGView addSubview:self.memberTypeBtn];
        
//        [self.redBGView addSubview:self.balenceLabel];
        
        
        [self addSubview:self.magicPointLabel];
        [self addSubview:self.detailBtn];
        [self addSubview:self.shadowView];
       
        [self.shadowView addSubview:self.menberBtn];
        
        NSArray * array = @[@"普通会员",@"黄金会员",@"白金会员",@"钻石会员"];
        NSArray * imgArray = @[@"putong",@"huanjin",@"putong",@"zuanshi"];
        CGFloat width = (SCREEN_WIDTH - 20) / 4.0;
        for (int index = 0; index < array.count; index ++) {
            MemberLevelView * memberView = [[MemberLevelView alloc] initWithFrame:CGRectMake(index * width, 0, width, SCALE_W(70))];
            memberView.tag = 500 + index;
            LineLRPosition pos = LinePositionShowLeftRight;
            if (index == 0) {
                
                pos = LinePositionShowRight;
            }else if (index == array.count - 1){
                pos = LinePositionShowLeft;
                [memberView removeFromSuperview];
                memberView = [[MemberLevelView alloc] initWithFrame:CGRectMake(index * width, 0, width, SCALE_W(70)) imgW:SCALE_W(30)];
            }else{
                pos = LinePositionShowLeftRight;
            }
            [memberView configView:imgArray[index] lightImage:imgArray[index] levelText:array[index] LineLRPosition:pos];
//            memberView.backgroundColor = [UIColor whiteColor];
            [self.shadowView addSubview:memberView];
        }
         [self addSubview:self.settingBtn];
        MagicLineView * lineview = [[MagicLineView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, SCREEN_WIDTH, 0.5)];
        [self addSubview:lineview];
    }
    return self;
}

- (void)createBGColor{
    
}

- (void)configWithDict:(NSDictionary *)dict{
    NSArray * levels = [dict objectForKey:@"memberRule"];
    
    NSDictionary * userInfo = [dict objectForKey:@"userInfo"];
    
    NSInteger memberLevel = [[userInfo objectForKey:@"memberLevel"] integerValue];
    
    int index = 0;
    for (NSDictionary * subdict in levels) {
        MemberLevelView * memberView = [self.shadowView viewWithTag:500+index];
        NSString * name = [subdict objectForKey:@"name"];
        NSInteger level = [[userInfo objectForKey:@"level"] integerValue];
        if (level <= memberLevel) {
            [memberView setUpName:name imgLight:YES];
        }else{
            [memberView setUpName:name imgLight:NO];
        }
        
        index ++;
    }
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Bitmap"]]] placeholderImage:[UIImage imageNamed:@"Bitmap"]];
    [self.memberTypeBtn setImage:[UIImage imageNamed:@"zuanshihuiyuan"] forState:UIControlStateNormal];
    [self.memberTypeBtn setTitle:@"钻石会员" forState:UIControlStateNormal];
    [self.memberTypeBtn leftAlignmentImgLeftTitleRight:YES middleSpace:5 leftSpace:0];
//    _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [_nameBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _nameBtn.imageView.width , 0, _nameBtn.imageView.width)];
//    [_nameBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _nameBtn.titleLabel.width + 5, 0, -_nameBtn.titleLabel.width - 5)];
    
//    self.balenceLabel.text = @" 会员卡余额：￥28";
    
    UIFont *font =  UIFontMediumOfSize(16);
    NSDictionary * attubtrDict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:RedMagicColor};
    NSString *deliveryPrice =@"魔方工分  18";
    NSString *price = @"  18";
    NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subString:price];
    self.magicPointLabel.attributedText = attributestring;
    [self.detailBtn setTitle:@"奖励细则？" forState:UIControlStateNormal];
    self.nameLabel.text = [userInfo objectForKey:@"nickname"];//@"用户名";
    [self.menberBtn setTitle:@"升级会员" forState:UIControlStateNormal];
}

-(UIImageView *)redBGView{
    if (!_redBGView) {
        _redBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(162))];
        [_redBGView setImage:[UIImage imageNamed:@"redBgIcon"]];
    }
    return _redBGView;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(50), SCALE_W(60), SCALE_W(60))];
        _iconView.layer.cornerRadius = _iconView.height * 0.5;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UIButton *)memberTypeBtn{
    if (!_memberTypeBtn) {
        
        _memberTypeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCALE_W(94), SCALE_W(89.5), SCALE_W(160), SCALE_W(15))];
        [_memberTypeBtn setTitleColor:BHColorWhite forState:UIControlStateNormal];
        _memberTypeBtn.titleLabel.font = UIFontRegularOfSize(10);
        
        
    }
    return _memberTypeBtn;
}

-(MagicLabel *)nameLabel{
    if (!_nameLabel) {
        // CGRectMake(SCALE_W(167), SCALE_W(64), SCALE_W(80), SCALE_W(10))
        _nameLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(94), SCALE_W(61), SCALE_W(160), SCALE_W(16))];
        _nameLabel.font = UIFontMediumOfSize(16);
        _nameLabel.textColor = BHColorWhite;
    }
    return _nameLabel;
}

- (MagicLabel *)balenceLabel{
    if (!_balenceLabel) {
        _balenceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(92), SCALE_W(85), SCALE_W(123.5), SCALE_W(23.5))];
        _balenceLabel.font = UIFontRegularOfSize(12);
        _balenceLabel.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.2];
        _balenceLabel.layer.cornerRadius = 3;
        _balenceLabel.layer.masksToBounds = YES;
        _balenceLabel.textColor = BHColorWhite;
    }
    return _balenceLabel;
}

-(MagicLabel *)magicPointLabel{
    if (!_magicPointLabel) {
        _magicPointLabel = [MagicLabel initWithFrame:CGRectMake(10, SCALE_W(259), SCALE_W(160), 14)];
        _magicPointLabel.font = UIFontRegularOfSize(14);
        _magicPointLabel.textColor = Gray666Color;
    }
    return _magicPointLabel;
}

- (UIButton *)menberBtn{
    if (!_menberBtn) {
        _menberBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCALE_W(235), SCALE_W(71), SCALE_W(110), 28)];
        _menberBtn.titleLabel.font = UIFontMediumOfSize(14);
        _menberBtn.layer.cornerRadius = 4;
        _menberBtn.layer.masksToBounds = YES;
        _menberBtn.backgroundColor = RedMagicColor;
        [_menberBtn setTitleColor:BHColorWhite forState:UIControlStateNormal];
        [_menberBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menberBtn;
}

- (UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50 - 10, SCALE_W(263), 50, 10)];
        _detailBtn.titleLabel.font = UIFontRegularOfSize(10);
        _detailBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_detailBtn setTitleColor:RedMagicColor forState:UIControlStateNormal];
        [_detailBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _detailBtn.tag = 3000;
    }
    return _detailBtn;
}

-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCALE_W(68), SCALE_W(68), SCALE_W(68), SCALE_W(24))];
        [_settingBtn setTitleColor:BHColorWhite forState:UIControlStateNormal];
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _settingBtn.titleLabel.font = UIFontRegularOfSize(14);
        _settingBtn.tag = 3001;
    }
    return _settingBtn;
}

-(UIView *)shadowView{
    if (!_shadowView) {
//        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH - 20, 112)];
//        _shadowView.backgroundColor = [UIColor whiteColor];
//        _shadowView.layer.shadowOffset = CGSizeMake(1, 1);
//        _shadowView.layer.shadowOpacity = 0.8;
//        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _shadowView.layer.shadowRadius = 2;
        
        _shadowView            = [UIView new];
        _shadowView.frame               = CGRectMake(10, SCALE_W(130), SCREEN_WIDTH - 20, SCALE_W(112));
        _shadowView.backgroundColor     = [UIColor whiteColor];
        _shadowView.layer.cornerRadius  = 5;
        _shadowView.layer.masksToBounds = NO;

        _shadowView.layer.shadowColor   = [UIColor colorWithHexString:@"000000" alpha:0.16].CGColor;
        _shadowView.layer.shadowOffset  = CGSizeMake(0, 0);
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowRadius  = 5;

    }
    return _shadowView;
}

- (void)btnClick:(UIButton *)btn{
    if (self.btnClickBlock) {
        self.btnClickBlock(btn.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
