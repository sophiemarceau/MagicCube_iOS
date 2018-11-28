//
//  TempImageTableViewCell.m
//  MagicCube
//
//  Created by wanmeizty on 28/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "TempImageTableViewCell.h"

@interface TempImageTableViewCell ()
@property (strong,nonatomic) UIImageView * imgView;
@end

@implementation TempImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat heigth = [TempImageTableViewCell cellHeight];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heigth)];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}
+ (CGFloat)cellHeight{
    return SCALE_W(145);
}

+ (CGFloat)cellDetailHeight{
    return SCALE_W(173.5);
}
- (void)configDict:(NSString *)imageName{
    self.imgView.image = [UIImage imageNamed:imageName];
}
@end
