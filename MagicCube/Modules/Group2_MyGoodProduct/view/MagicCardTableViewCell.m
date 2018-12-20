//
//  MagicCardTableViewCell.m
//  MagicCube
//
//  Created by wanmeizty on 20/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "MagicCardView.h"
#import "MagicCardTableViewCell.h"

@interface MagicCardTableViewCell ()
@property (strong,nonatomic) MagicCardView * cardView;
@end

@implementation MagicCardTableViewCell

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
        CGFloat heigth = [MagicCardTableViewCell cellHeight];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        //        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heigth)];
        //        [self.contentView addSubview:self.imgView];
        self.cardView = [[MagicCardView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , heigth)];
        [self.contentView addSubview:self.cardView];
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
    //    self.imgView.image = [UIImage imageNamed:imageName];
    //    self.cardView
    
}

- (void)configDataDict:(NSDictionary *)dict{
    [self.cardView setUpDistributeDict:dict];
}
@end
