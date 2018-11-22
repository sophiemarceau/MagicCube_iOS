
//
//  ProductDetailViewController.m
//  MagicCube
//
//  Created by sophiemarceau_qu on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "MemberView.h"
#import "ProducDetailtHeaderView.h"
#import "ProductInfoView.h"
@interface ProductDetailViewController ()
@property (nonatomic, strong) MemberView *memberView;
@property (nonatomic, strong) ProducDetailtHeaderView *headerView;
@property (nonatomic, strong) ProductInfoView *productInfoView;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initSubviews];
    [self requestData];
}

-(void)requestData{}

-(void)initDatas{
    self.title = @"产品详情";
}

-(void)initSubviews{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.memberView];
    [self.view addSubview:self.productInfoView];
}


-(ProducDetailtHeaderView *) headerView{
    if (_headerView == nil ) {
        _headerView = [[ProducDetailtHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT ,175+114)];
    }
    return _headerView;
}
-(MemberView *)memberView{
    if (_memberView == nil) {
        _memberView = [[MemberView alloc] initWithFrame:CGRectMake(0, 299, SCREEN_WIDTH, 110)];
        _memberView.backgroundColor = [UIColor whiteColor];
        [_memberView.updateMemBtn addTarget:self action:@selector(gotoUpdateOnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _memberView;
}

-(ProductInfoView *)productInfoView{
    if (_productInfoView == nil) {
        _productInfoView = [[ProductInfoView alloc] initWithFrame:CGRectMake(0, 419, SCREEN_WIDTH, 257.5)];
    }
    return _productInfoView;
}

-(void)gotoUpdateOnclick:(UIButton *)sender{
    NSLog(@"gotoUpdateOnclick");
}
@end
