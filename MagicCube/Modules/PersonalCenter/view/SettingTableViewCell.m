//
//  SettingTableViewCell.m
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell ()
@property (strong,nonatomic) UIImageView * rightImgView;
@property (strong,nonatomic) MagicLabel * leftLabel;
@property (strong,nonatomic) MagicLabel * rightLabel;
@end

@implementation SettingTableViewCell

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
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat cellHeight = [SettingTableViewCell cellHeight];
    self.rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 10, (cellHeight - 16) * 0.5, 15, 16)];
    self.rightImgView.image = [UIImage imageNamed:@"rightArrow"];
    [self.contentView addSubview:self.rightImgView];
    
    self.rightLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5 - 31, cellHeight)];
    self.rightLabel.textColor = [UIColor colorWithHexString:@"626A75" alpha:0.5];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.rightLabel];
    
    self.leftLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH * 0.5 - 10, cellHeight)];
    self.leftLabel.textColor = Black626A75Color;
    [self.contentView addSubview:self.leftLabel];
    
    MagicLineView * line = [[MagicLineView alloc] initWithFrame:CGRectMake(0, cellHeight - 0.5, SCREEN_WIDTH, 0.5)];
    [self.contentView addSubview:line];
}

+ (CGFloat)cellHeight{
    return 44;
}
- (void)configDict:(NSDictionary *)dict{
    
    BOOL hasRightArrow = [[dict objectForKey:@"showRight"] boolValue];
    self.rightImgView.hidden = !hasRightArrow;
    CGFloat cellHeight = [SettingTableViewCell cellHeight];
    if (hasRightArrow) {
        self.rightLabel.frame = CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5 - 31, cellHeight);
    }else{
        self.rightLabel.frame = CGRectMake(SCREEN_WIDTH* 0.5, 0, SCREEN_WIDTH * 0.5 - 10, cellHeight);
    }
    self.leftLabel.text = [dict objectForKey:@"left"];
    self.rightLabel.text = [dict objectForKey:@"right"];
}

- (void)configDict:(NSDictionary *)dict showRightArrow:(BOOL)hasRightArrow{
    self.rightImgView.hidden = hasRightArrow;
    CGFloat cellHeight = [SettingTableViewCell cellHeight];
    if (hasRightArrow) {
        self.rightLabel.frame = CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5 - 31, cellHeight);
    }else{
        self.rightLabel.frame = CGRectMake(SCREEN_WIDTH* 0.5, 0, SCREEN_WIDTH * 0.5 - 10, cellHeight);
    }
    
    [self configDict:dict];
}
@end
