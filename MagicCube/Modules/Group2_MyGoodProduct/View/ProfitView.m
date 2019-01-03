//
//  ProfitView.m
//  MagicCube
//
//  Created by wanmeizty on 3/1/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "ProfitView.h"
#import "Profit.h"

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
    CGFloat levelheight = SCALE_W((185.5 - 40))/4.0;
    for (int i = 0; i < 4; i ++) {
        
        Profit * levelView = [[Profit alloc] initWithFrame:CGRectMake(0, SCALE_W(top + levelheight * i), SCREEN_WIDTH, levelheight)];
        [levelView configRedtexts:@[@"1～10",@"100"] text:@"售出1～10张   返利100元/张" line:LineDirectionShowDown];
        
        levelView.tag = 100 + i;
        [self addSubview:levelView];
    }
    
    UIView *linehead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    linehead.backgroundColor = BHHexColor(@"D9D9D9");
    [self addSubview:linehead];
    
    UIView *linehead2 = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_W(41.5), SCREEN_WIDTH, 0.5)];
    linehead2.backgroundColor = BHHexColor(@"D9D9D9");
    [self addSubview:linehead2];
}

-(void)setUpdata:(NSArray *)array{
    int index = 100;
    for (NSDictionary * dict in array) {
        CGFloat price = [[dict objectForKey:@"price"] floatValue];
        NSString * discount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"discount"]];
        NSString * name = [dict objectForKey:@"name"];
        Profit * levelView = [self viewWithTag:index];
        
        if (index == 100) {
            [levelView configRedtexts:@[@"1～10",@"100"] text:@"售出1～10张   返利100元/张" line:LineDirectionShowDown];
        }else if (index == 103){
            [levelView configRedtexts:@[@"1～10",@"100"] text:@"售出1～10张   返利100元/张" line:LineDirectionShowUp];
        }else{
            [levelView configRedtexts:@[@"1～10",@"100"] text:@"售出1～10张   返利100元/张" line:LineDirectionShowUpDown];
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
