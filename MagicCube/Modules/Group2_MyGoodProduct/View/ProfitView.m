//
//  ProfitView.m
//  MagicCube
//
//  Created by wanmeizty on 3/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "ProfitView.h"
#import "Profit.h"
@interface ProfitView ()
@property (strong,nonatomic) UIView * contentView;
@end
@implementation ProfitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    MagicLabel * distributeTitlelabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(0), SCREEN_WIDTH - 20, SCALE_W(41.5))];
    distributeTitlelabel.text = @"厂商返利";
    distributeTitlelabel.textColor = Gray666Color;
    [self addSubview:distributeTitlelabel];
    
    CGFloat top = SCALE_W(42);
//    CGFloat levelheight = SCALE_W((185.5 - 40))/4.0;
//    for (int i = 0; i < 4; i ++) {
//
//        Profit * levelView = [[Profit alloc] initWithFrame:CGRectMake(0, SCALE_W(top + levelheight * i), SCREEN_WIDTH, levelheight)];
//        [levelView configRedtexts:@[@"1～10",@"100"] text:@"售出1～10张   返利100元/张" line:LineDirectionShowDown];
//
//        levelView.tag = 100 + i;
//        [self addSubview:levelView];
//    }
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, self.frame.size.height - top)];
    [self addSubview:self.contentView];
    
    UIView *linehead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    linehead.backgroundColor = BHHexColor(@"D9D9D9");
    [self addSubview:linehead];
    
    UIView *linehead2 = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(41.5), SCREEN_WIDTH, 0.5)];
    linehead2.backgroundColor = BHHexColor(@"D9D9D9");
    [self addSubview:linehead2];
}

-(void)setUpdata:(NSArray *)array{
    int index = 0;
    CGFloat top = SCALE_W(42);
    [self.contentView removeAllSubviews];
    self.contentView.frame = CGRectMake(0, top, SCREEN_WIDTH, self.frame.size.height - top);
    
    CGFloat levelheight = SCALE_W((self.height - 40))/ (array.count *1.0);
    for (NSDictionary * dict in array) {
//        CGFloat price = [[dict objectForKey:@"price"] floatValue];
//        NSString * discount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"discount"]];
//        NSString * name = [dict objectForKey:@"name"];
//        Profit * levelView = [self viewWithTag:index];
        
        Profit * levelView = [[Profit alloc] initWithFrame:CGRectMake(0, SCALE_W(0 + levelheight * index), SCREEN_WIDTH, levelheight)];
        [self.contentView addSubview:levelView];
        NSString * min = [NSString stringWithFormat:@"%@",[dict objectForKey:@"min"]];
        NSString * max = [NSString stringWithFormat:@"%@",[dict objectForKey:@"max"]];
        NSString * amount = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"amount"] doubleValue]];
        NSString * range = [NSString stringWithFormat:@"%@~%@",min,max];
        NSArray * texts = @[range,[NSString stringWithFormat:@"%@",amount]];
        NSString *text = [NSString stringWithFormat:@"售出%@张   返利%@元/张",range,amount];
        if (index == 0) {
            [levelView configRedtexts:texts text:text line:LineDirectionShowDown];
        }else if (index == array.count - 1){
            [levelView configRedtexts:texts text:text line:LineDirectionShowUp];
        }else{
            [levelView configRedtexts:texts text:text line:LineDirectionShowUpDown];
        }
        
        if (array.count == 1) {
            [levelView configRedtexts:texts text:text line:LineDirectionShowNone];
        }
        index ++;
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
