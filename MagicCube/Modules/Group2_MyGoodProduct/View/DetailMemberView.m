//
//  DetailMemberView.m
//  MagicCube
//
//  Created by wanmeizty on 19/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "DetailMemberView.h"


@interface DetailMemberView ()<gradeUpDelegate>
@property (assign,nonatomic) NSInteger currentUserMemberLevel;
@end

@implementation DetailMemberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _currentUserMemberLevel = 1;
    MagicLabel * distributeTitlelabel = [[MagicLabel alloc] initWithFrame:CGRectMake(10, SCALE_W(0), SCREEN_WIDTH - 20, SCALE_W(41.5))];
    distributeTitlelabel.text = @"厂商返利";
    distributeTitlelabel.textColor = Gray666Color;
    [self addSubview:distributeTitlelabel];
    
    CGFloat top = SCALE_W(42);
    CGFloat levelheight = SCALE_W((185.5 - 40))/4.0;
    for (int i = 0; i < 4; i ++) {
        
        DistributeLevelView * levelView = [[DistributeLevelView alloc] initWithFrame:CGRectMake(0, SCALE_W(top + levelheight * i), SCREEN_WIDTH, levelheight)];
        levelView.delegate = self;
        [levelView configTextRed:YES level:@"黄金会员" price:888 discount:@"8.5" grade:YES gradeText:@"升级黄金会员" line:LinePositionShowUpDown];
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
        DistributeLevelView * levelView = [self viewWithTag:index];
        [levelView configTextRed:YES level:name price:price discount:discount grade:YES gradeText:[NSString stringWithFormat:@"升级%@",name] line:LinePositionShowUpDown];
        index ++;
    }
}

-(void)setUpdata:(NSArray *)array currentUserMemberLevel:(NSInteger)currentUserMemberLevel{
    self.currentUserMemberLevel = currentUserMemberLevel;
    int index = 100;
    BOOL textRed = NO;
    BOOL grade = NO;
    for (NSDictionary * dict in array) {
        CGFloat price = [[dict objectForKey:@"price"] floatValue];
        NSString * discount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"discount"]];
        NSString * name = [dict objectForKey:@"name"];
        NSInteger level = [[dict objectForKey:@"level"] integerValue];
        
        
        if (level <= currentUserMemberLevel) {
            textRed = YES;
            grade = NO;
        }else{
            textRed = NO;
            grade = YES;
        }
        DistributeLevelView * levelView = [self viewWithTag:index];
        
        [levelView configTextRed:textRed level:name price:price discount:discount grade:grade gradeText:[NSString stringWithFormat:@"升级%@",name] line:LinePositionShowUpDown];
        index ++;
    }
}

-(void)gradeUp{
    if ([self.gradeDelegate respondsToSelector:@selector(gradeUpLevel:)]) {
        [self.gradeDelegate gradeUpLevel:self.currentUserMemberLevel];
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
