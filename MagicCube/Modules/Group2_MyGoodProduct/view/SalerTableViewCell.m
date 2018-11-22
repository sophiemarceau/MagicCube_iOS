//
//  SalerTableViewCell.m
//  MagicCube
//
//  Created by wanmeizty on 22/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "SalerTableViewCell.h"

@interface SalerTableViewCell ()
@property (strong,nonatomic) UIImageView * iconView;
@property (strong,nonatomic) MagicLabel * nameLabel;
@property (strong,nonatomic) MagicLabel * priceLabel;
@property (strong,nonatomic) MagicLabel * dateLabel;
@end

@implementation SalerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat width = (SCREEN_WIDTH - 20)/3.0;
        CGFloat cellHeight = [SalerTableViewCell cellHeight];
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10.5, 28, 28)];
        [self.contentView addSubview:self.iconView];
        
        self.nameLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(50, 0, width - 40, cellHeight)];
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10 + width, 0, width, cellHeight)];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.priceLabel];
        
        self.dateLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10 + 2 * width, 0, width, cellHeight)];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        self.dateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        self.dateLabel.textColor = BlackMagicColor;
        [self.contentView addSubview:self.dateLabel];
        
        MagicLineView * lineView = [MagicLineView initFame:CGRectMake(0, cellHeight - 0.5, SCREEN_WIDTH, 0.5)];
        [self.contentView addSubview:lineView];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)configDict:(NSDictionary *)dict{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:@"home_jingxuan"]];
    self.nameLabel.text = @"张某某";
    self.priceLabel.text = @"￥888";
    self.dateLabel.text = @"12/12";
}

+ (CGFloat)cellHeight{
    return 48;
}
@end
