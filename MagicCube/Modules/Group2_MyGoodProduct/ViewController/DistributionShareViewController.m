//
//  DistributionShareViewController.m
//  MagicCube
//
//  Created by wanmeizty on 29/11/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "DistributionShareViewController.h"
#import "UIButton+ImgTitlePos.h"
#import "SendPreviewViewController.h"
@interface DistributionShareViewController ()
@property (strong,nonatomic) UIButton * distributeShareBtn;
@property (strong,nonatomic) UIButton * distributeRecordBtn;
@end

@implementation DistributionShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分销中心";
    [self addSubViews];
    // Do any additional setup after loading the view.
}

- (void)addSubViews{
    
    UIScrollView * rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT)];
    rootView.backgroundColor = BHColorWhite;
    [self.view addSubview:rootView];
    
    CGFloat top = 0;
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCALE_W(163.5))];
    imgView.image = [UIImage imageNamed:@"分销中心_详情"];
    [rootView addSubview:imgView];
    top += SCALE_W(163.5);
    
    UIView * selectBgView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_W(266)) * 0.5, SCALE_W(15) + top, SCALE_W(266), SCALE_W(30))];
    selectBgView.layer.cornerRadius = 4;
    selectBgView.layer.masksToBounds = YES;
    selectBgView.layer.borderColor = RedMagicColor.CGColor;
    selectBgView.layer.borderWidth = 0.5;
    [rootView addSubview:selectBgView];
    top += SCALE_W(30 + 15);
    
    NSArray * selectTitles = @[@"分销到",@"分销记录"];
    int index = 0;
    for (NSString * selectTitle in selectTitles) {
        UIButton * selectBtn = [self createSelectBtn:CGRectMake(index *SCALE_W(133), 0, SCALE_W(133), SCALE_W(30))];
        [selectBtn setTitle:selectTitle forState:UIControlStateNormal];
        [selectBtn setTitle:selectTitle forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectBgView addSubview:selectBtn];
        if (index == 0) {
            selectBtn.selected = YES;
            self.distributeShareBtn = selectBtn;
        }else{
            selectBtn.selected = NO;
            self.distributeRecordBtn = selectBtn;
        }
        index ++;
        
    }
    
    UIScrollView * selectBottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCREEN_HEIGHT - top - NAVIGATION_HEIGHT - HOME_INDICATOR_HEIGHT)];
    selectBottomView.backgroundColor = KBGColor;
    [rootView addSubview:selectBottomView];
    
    UIView * shareBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_W(105))];
    shareBgView.backgroundColor = [UIColor whiteColor];
    [selectBottomView addSubview:shareBgView];
    
    NSArray * array = @[@"朋友圈",@"微信",@"微博",@"抖音",@"QQ",@"支付宝",@"今日头条"];
    NSArray * imgarray = @[@"pengyouquan",@"weixin",@"weibo",@"douyin",@"qq",@"zhifubao",@"jinritoutiao"];
    CGFloat intevalw = SCALE_W(10);
    CGFloat btnw = (SCREEN_WIDTH - 5 * intevalw) / 4.0;
    CGFloat btnh = SCALE_W(30);
    int i = 0;
    for (NSString * sharetitle in array) {
         UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(intevalw + (intevalw + btnw) * (i % 4), SCALE_W(15) + (SCALE_W(15) + btnh) * (i / 4), btnw, btnh)];
        [btn setTitleColor:Gray666Color forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@" %@",sharetitle] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgarray[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = UIFontRegularOfSize(12);
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = GrayMagicColor.CGColor;
        btn.layer.borderWidth = 0.5;
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -btn.titleLabel.width, 0, btn.titleLabel.width )];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -btn.titleLabel.width - 2.5, 0, btn.titleLabel.width + 2.5 )];
//
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, btn.imageView.width - 10, 0,-btn.imageView.width + 10)];
        [shareBgView addSubview:btn];

        i ++;
    }
}

#pragma --mark 按钮
-(void)selectClick:(UIButton *)btn{
    
    if (btn == self.distributeShareBtn) {
        self.distributeShareBtn.selected = YES;
        self.distributeRecordBtn.selected = NO;
    }else{
        self.distributeShareBtn.selected = NO;
        self.distributeRecordBtn.selected = YES;
    }
}

- (void)shareClick:(UIButton *)btn{
    SendPreviewViewController * sendVC = [[SendPreviewViewController alloc] init];
    [self.navigationController pushViewController:sendVC animated:YES];
}

-(UIButton *)createSelectBtn:(CGRect)frame{
    UIButton * btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitleColor:GrayMagicColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:BHColorWhite] forState:UIControlStateNormal];
    [btn setTitleColor:BHColorWhite forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageWithColor:RedMagicColor] forState:UIControlStateSelected];
    btn.titleLabel.font = UIFontRegularOfSize(14);
    return btn;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
