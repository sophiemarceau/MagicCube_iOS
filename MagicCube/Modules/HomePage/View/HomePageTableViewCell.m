//
//  HomePageTableViewCell.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "HomePageTableViewCell.h"
@interface HomePageTableViewCell ()

@property (strong,nonatomic) UIView * bgView;
@property (strong,nonatomic) UIImageView * picImageView;
@property (strong,nonatomic) UILabel* titleLabel;
@property (strong,nonatomic) UILabel * priceLabel;
@property (strong,nonatomic) UILabel * numLabel;
@property (strong,nonatomic) UILabel * redBgLabel;
@end
@implementation HomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = KBGColor;
        [self.contentView addSubview: self.bgView];
        [self.bgView addSubview:self.picImageView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.priceLabel];
        [self.bgView addSubview:self.numLabel];
        [self.bgView addSubview:self.redBgLabel];
    }
    return self;
}

- (void)configwidth:(NSDictionary *)dict{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"url"]]] placeholderImage:[UIImage imageNamed:@"首页_列表"]];
    self.titleLabel.text = @"【商品名称】Asnières 工坊是品牌的灵魂Asnières 工坊是品牌的灵魂";
    self.priceLabel.text = @"￥588零售指导价";
    self.numLabel.text = @"已经出售99323个";
    self.redBgLabel.text = @"代理价低至3折";
}

+ (CGFloat)cellHeight{
    return 10 +175 + 114 ;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 175 + 114)];
        _bgView.backgroundColor = KBGCell;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 16;
    }
    return _bgView;
}

-(UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, 175)];
    }
    return _picImageView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.picImageView.height +10, self.bgView.width -20, 50)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = BlackMagicColor;
        _titleLabel.font = UIFontRegularOfSize(16);
        _titleLabel.numberOfLines = 2;
       
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom + 5.5, (self.bgView.width -30)/2, 18)];
        _priceLabel.backgroundColor = [UIColor yellowColor];
        _priceLabel.textColor = GrayMagicColor;
        _priceLabel.font = UIFontRegularOfSize(18);
        
    }
    return _priceLabel;
}

-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.priceLabel.bottom + 7, (self.bgView.width -30)/2, 18)];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor = GrayMagicColor;
        _numLabel.font = UIFontRegularOfSize(14);
    }
    return _numLabel;
}

-(UILabel *)redBgLabel{
    if (_redBgLabel == nil) {
        _redBgLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgView.width - 130.5 -10, self.bgView.height - 35 -10 , 130.5, 35)];
        _redBgLabel.backgroundColor = RedMagicColor;
        _redBgLabel.textColor = [UIColor whiteColor];
        _redBgLabel.textAlignment = NSTextAlignmentCenter;
        _redBgLabel.font = UIFontRegularOfSize(14);
        _redBgLabel.layer.masksToBounds = YES;
        _redBgLabel.layer.cornerRadius = 4;
    }
    return _redBgLabel;
}
@end
