//
//  HomePageViewController.m
//  MagicCube
//
//  Created by sophie on 2018/11/21.
//  Copyright © 2018 wanmeizty. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageTableViewCell.h"
#import "ProductDetailViewController.h"
#import "LineTabbarView.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"
#import "SecondaryLevelWebViewController.h"
#import "SPPageMenu.h"
#import "YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView.h"
#import "HomeListViewController.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,
TYCyclePagerViewDataSource,TYCyclePagerViewDelegate,LineTabbarSelectDelegate , SPPageMenuDelegate, UIScrollViewDelegate>{
    int current_page,total_count;
}
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) TYCyclePagerView *bannrView;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) LineTabbarView *headTabbarView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView *tableView;




@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *desLabel,*subLabel;
@property (nonatomic, strong) UIButton *memberBtn;
@property (nonatomic, strong) NSMutableArray *headImageViewArray;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"魔方好物";
    [self initDatas];
    [self initSubviews];
    [self requestData];
}

-(void)initDatas{
    self.listArray = [NSMutableArray array];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    [self.listArray addObject:@{@"url":@""}];
    self.bannerArray = [NSMutableArray array];
    [self.bannerArray addObject:@"1"];
    [self.bannerArray addObject:@"2"];
    [self.bannerArray addObject:@"3"];
    
    
    self.dataArr = @[@"爆款好物",@"品质好物",@"赚钱好物",@"特色好物",@"海外好物"];
}

-(void)initSubviews{
    
    _tableView = [[YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
//    [self.view addSubview:self.listView];
}

-(void)acceptMsg : (NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}


-(void)requestData{}

-(void)giveMeMoreData{}

//
//#pragma mark - tableViewDelegate
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    return 10;
//    return self.listArray.count;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
////    MessageItem *model = [self.listArray objectAtIndex:indexPath.row];
////    return  [model heightForRowWithisShow:model.isShow];
//    return [HomePageTableViewCell cellHeight];
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CellIdentifier = @"HomePageCell";
//    HomePageTableViewCell *cell;
//    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    [cell configwidth:[self.listArray objectAtIndex:indexPath.row]];
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    MessageItem *selectMessageItem = self.listArray[indexPath.row];
////
////    NSString *urlStr =  stringFormat(selectMessageItem.redirectUrl);
////    if([urlStr isEqualToString:@""]){
////        selectMessageItem.isShow = !selectMessageItem.isShow;
////        [self.listArray replaceObjectAtIndex:indexPath.row withObject:selectMessageItem];
////        [self.listView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
////    }else{
////        SecondaryLevelWebViewController *webVc= [[SecondaryLevelWebViewController alloc] init];
////        webVc.urlString = [NSString stringWithFormat:@"%@",selectMessageItem.redirectUrl];
////        webVc.isHiddenLeft = NO;
////        webVc.isHiddenBottom = NO;
////        [self.navigationController pushViewController:webVc animated:YES];
////    }
//
//
//    ProductDetailViewController *webVc= [[ProductDetailViewController alloc] init];
//    [self.navigationController pushViewController:webVc animated:YES];
//}
//
//#pragma mark - TYCyclePagerViewDataSource
//- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
//    return self.bannerArray.count;
//}
//
//- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
//    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
//     [cell.bannerImageView setImage:[UIImage imageNamed:@"home_banner"]];
////    if (index == 0) {
////        [cell.bannerImageView setImage:[UIImage imageNamed:@"首页_列表"]];
////    }
////    if (index == 1) {
////       [cell.bannerImageView setImage:[UIImage imageNamed:@"home_banner"]];
////    }
////    if (index == 2) {
////        [cell.bannerImageView setImage:[UIImage imageNamed:@"首页_列表"]];
////    }
////    if (index == 2) {
////        cell.contentView.backgroundColor = [UIColor redColor];
////    }
//    //    cell.backgroundColor = _datas[index];
//    //    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
////    HomeBannerModel *bannerModel = (HomeBannerModel *) bannerArray[index];
////
////    [cell.bannerImageView sd_setImageWithURL: [NSURL URLWithString:bannerModel.url]];
//
//
////        NSURL *URL =
////        [NSURL URLWithString:@"https://mobike.com/cn/"];
//////        [NSURL URLWithString:bannerModel.url];
////        NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
////        [cell.webView loadRequest:request];
//    return cell;
//}
//
//- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
//    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
//    layout.itemSize = CGSizeMake(SCREEN_WIDTH, 150);
//    layout.itemSpacing = SCALE_W(0);
//    //layout.minimumAlpha = 0.3;
//    //    layout.itemHorizontalCenter = YES;
//    layout.layoutType = TYCyclePagerTransformLayoutCoverflow;
//    return layout;
//}
//
//- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
//    _pageControl.currentPage = toIndex;
//    [_pageControl setCurrentPage:toIndex animate:YES];
//    //    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
//}
//
//- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
//    NSLog(@"didSelectedItemCell->  %ld",index);
//
//    SecondaryLevelWebViewController *vc = [[SecondaryLevelWebViewController alloc] init];
//    vc.urlString =
////    [NSString stringWithFormat:@"%@%@",kAppPartnerAddress,@"?partner=1"];
//        @"https://www.baidu.com";
////    kAppPartnerAddress;
//    vc.isHiddenLeft = YES;
//    NSLog(@"getDigInfo-->%@",vc.urlString);
//    vc.isHiddenBottom = YES;
//    [ self.navigationController pushViewController:vc animated:YES];
////    if (self.delegate && [self.delegate respondsToSelector:@selector(bannberJumpToWebView:)]) {
////        HomeBannerModel *bannerModel = (HomeBannerModel *) bannerArray[index];
////
////        [self.delegate bannberJumpToWebView:bannerModel.target];
////    }
//}
//
//#pragma mark - LineTabbarSelectDelegate
//-(void)tabbarDidSelect:(NSInteger)number{
//    NSLog(@"num-------->%ld",(long)number);
//}
//
//#pragma mark  initView
//-(UITableView *)listView{
//    if (_listView == nil) {
//        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - NAVIGATION_HEIGHT - TAB_BAR_HEIGHT)];
//        _listView.dataSource = self;
//        _listView.delegate = self;
//        _listView.backgroundColor = KBGColor;
//        //也可以让分割线消失
//        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self setTableHeadView];
//        UIView *footView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
//        footView.backgroundColor = KBGColor;
//        _listView.tableFooterView = footView;
//        WS(weakSelf)
//        _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf requestData];
//        }];
//        MJRefreshBackNormalFooter *allfooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf giveMeMoreData];
//        }];
//        _listView.mj_footer = allfooter;
//        _listView.mj_footer.ignoredScrollViewContentInsetBottom = HOME_INDICATOR_HEIGHT;
//    }
//    return _listView;
//}
//
//-(LineTabbarView *)headTabbarView{
//    if(_headTabbarView == nil){
//        _headTabbarView = [[LineTabbarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 97) WithNameArray:@[@{@"name":@"精选好物",@"pic":@"home_jingxuan"},@{@"name":@"美丽好物",@"pic":@"home_meilihaowu"},@{@"name":@"健康好物",@"pic":@"home_jiankanghaowu"},@{@"name":@"节庆好物",@"pic":@"home_jieqinghaowu"}]];
//        _headTabbarView.delegate = self;
//    }
//    return _headTabbarView;
//}
//
////设置头部视图
//- (void)setTableHeadView{
//    UIView *bgView;
//    bgView = [[UIView alloc] initWithFrame:CGRectZero];
//    [bgView addSubview:self.headTabbarView];
//    if(self.bannerArray && self.bannerArray.count > 0){
//        UIView *bannerBgView = [UIView new];
//        bannerBgView.backgroundColor =  KBGColor;
//        bannerBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
//
//        TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
//        pagerView.layout.layoutType = TYCyclePagerTransformLayoutCoverflow;
//        pagerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (150));
//        pagerView.layer.borderWidth = 0;
//        //    pagerView.isInfiniteLoop = YES;
//        pagerView.autoScrollInterval = 6.0;
//        pagerView.dataSource = self;
//        pagerView.delegate = self;
//        [pagerView setNeedUpdateLayout];
//        // registerClass or registerNibr
//        [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
//        _bannrView = pagerView;
//        [self addPageControl];
//        self.pageControl.frame = CGRectMake(0, CGRectGetHeight(_bannrView.frame) - 26, CGRectGetWidth(_bannrView.frame), 26);
//        [bannerBgView addSubview:_bannrView];
//        [bgView addSubview:bannerBgView];
//
//        self.headTabbarView.frame = CGRectMake(0, bannerBgView.height , SCREEN_WIDTH, self.headTabbarView.height);
//    }
//    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.headTabbarView.bottom );
//    [self.bannrView reloadData];
//    bgView.backgroundColor = KBGColor;
//    self.listView.tableHeaderView = bgView;
//}
//
//
//- (void)addPageControl {
//    TYPageControl *pageControl = [[TYPageControl alloc]init];
//    pageControl.numberOfPages = self.bannerArray.count;
//    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
//    pageControl.pageIndicatorSize = CGSizeMake(8, 8);
//    pageControl.currentPageIndicatorTintColor = RedMagicColor;
//    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
//    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
//    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
//    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
//    [_bannrView addSubview:pageControl];
//    _pageControl = pageControl;
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    NSInteger section = indexPath.section;
    if (section==0) {
        height = [self tableHeaderView].frame.size.height;
    }else if(section==1){
        height = scrollViewHeight + pageMenuH;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger section  = indexPath.section;
    if (section==0) {
        [cell.contentView addSubview:self.tableHeaderView];
        return cell;
    }else if(section==1){
        for (int i = 0; i < self.dataArr.count; i++) {
            HomeListViewController *baseVc = [[HomeListViewController alloc] init];
            [self addChildViewController:baseVc];
            [self.myChildViewControllers addObject:baseVc];
        }
        
        SPPageMenu *pageMenu  = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
        
        // 传递数组，默认选中第0个
        [pageMenu setItems:self.dataArr selectedItemIndex:0];
        // 等宽,不可滑动
//        pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        // 设置代理
        pageMenu.delegate = self;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, pageMenuH, SCREEN_WIDTH, scrollViewHeight)];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
        // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
        pageMenu.bridgeScrollView = scrollView;
        _pageMenu = pageMenu;
        // pageMenu.selectedItemIndex就是选中的item下标
        if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
            BaseViewController *baseVc = self.myChildViewControllers[_pageMenu.selectedItemIndex];
            [scrollView addSubview:baseVc.view];
            baseVc.view.frame = CGRectMake(SCREEN_WIDTH*_pageMenu.selectedItemIndex, 0, SCREEN_WIDTH, scrollViewHeight);
            scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*_pageMenu.selectedItemIndex, 0);
            scrollView.contentSize = CGSizeMake(self.myChildViewControllers.count*SCREEN_WIDTH, 0);
        }
        [cell.contentView addSubview:_pageMenu];
        [cell.contentView addSubview:self.scrollView];
        return cell;
    }
    return cell;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:[YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView class]]) {
        return;
    }
    CGFloat tabOffsetY = self.tableHeaderView.frame.size.height;
    
    CGFloat offsetY = self.tableView.contentOffset.y;

    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY+1 >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
}

#pragma mark - SPPageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    //    NSLog(@"%zd",index);
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    //    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(SCREEN_WIDTH * toIndex, 0, SCREEN_WIDTH, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
}

-(UIView *)tableHeaderView{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.backgroundColor = KBGColor;
        _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 222.5);
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 212.5)];
        bg.backgroundColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:bg];
        [bg addSubview:self.picImageView];
        [bg addSubview:self.desLabel];
        [bg addSubview:self.memberBtn];
        [bg addSubview:self.subLabel];
        UIImageView *headImageView;
        for (int i=0; i<self.headImageViewArray.count; i++) {
            headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+i*(23
                                                                                +10), 135.5, 23, 23)];
            [bg addSubview:headImageView];
            headImageView.backgroundColor = RedMagicColor;
            headImageView.layer.cornerRadius = 11.5;
            headImageView.layer.masksToBounds = YES;
        }
        UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                      10+(self.headImageViewArray.count - 1)*(23
                                                                                                             +10)+23 +15, 140 , 96, 12)];
        desLabel.text = @"正在使用魔方好物";
        desLabel.font = UIFontRegularOfSize(12);
        desLabel.textColor = Gray666Color;
        desLabel.textAlignment = NSTextAlignmentLeft;
        [bg addSubview:desLabel];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 172.5, SCREEN_WIDTH -20 +10, 26)];
        messageLabel.font = UIFontRegularOfSize(12);
        messageLabel.textAlignment = NSTextAlignmentRight;
        messageLabel.textColor  = Gray666Color;
        messageLabel.backgroundColor = BHHexColorAlpha(@"B5262F", 0.1);
        messageLabel.layer.cornerRadius = 13;
        messageLabel.layer.masksToBounds = YES;
        messageLabel.layer.borderColor = RedMagicColor.CGColor;
        messageLabel.layer.borderWidth = 1;
        messageLabel.text = @"CAT刚刚分销了元正正山小种红茶武夷山茶叶卡,分销收益2048元";
        [bg addSubview:messageLabel];
        
        _tableHeaderView.userInteractionEnabled = YES;
    }
    return _tableHeaderView;
}

-(UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16.5, 78, 78)];
//        _picImageView.image = [UIImage imageNamed:@""];
        _picImageView.backgroundColor = RedMagicColor;
        _picImageView.layer.masksToBounds = YES;
        _picImageView.layer.cornerRadius = 5;
    }
    return _picImageView;
}


-(NSMutableArray *)myChildViewControllers{
    if (_myChildViewControllers == nil) {
        _myChildViewControllers = [NSMutableArray arrayWithCapacity:0];
    }
    return _myChildViewControllers;
}

-(UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(96.5, 20.5, 268.5, 72)];
        _desLabel.font = UIFontRegularOfSize(12);
        _desLabel.textColor = Gray666Color;
        _desLabel.textAlignment = NSTextAlignmentLeft;
        _desLabel.numberOfLines = 4;
        _desLabel.text = @"创新商品卡分销网络\n领先区块链技术\n交易全程防伪保真\n分销无需进货，无需预缴货款";
    }
    return _desLabel;
}

-(UIButton *)memberBtn{
    if (_memberBtn== nil) {
        _memberBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90- 10, 42, 90, 28)];
        [_memberBtn setTitle:@"成为会员" forState:UIControlStateNormal];
        _memberBtn.layer.masksToBounds = YES;
        _memberBtn.layer.cornerRadius = 14;
        _memberBtn.titleLabel.font = UIFontRegularOfSize(12);
        [_memberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _memberBtn.backgroundColor = RedMagicColor;
    }
    return _memberBtn;
}


-(UILabel *)subLabel{
    if (_subLabel == nil) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 109.5, SCREEN_WIDTH -20, 12)];
        _subLabel.font = UIFontRegularOfSize(12);
        _subLabel.textColor = GrayMagicColor;;
        _subLabel.textAlignment = NSTextAlignmentLeft;
        _subLabel.text = @"全球已有 123998 人通过魔方好物交易了 2999008 件商品卡";
        
        
        NSDictionary * attubtrDict = @{NSFontAttributeName:UIFontMediumOfSize(12),NSForegroundColorAttributeName:Gray666Color};
        NSString *deliveryPrice =@"全球已有 123998 人通过魔方好物交易了 2999008 件商品卡";
        
        NSString *price1 = @"123998";
        NSString *price2 = @"2999008";
        NSArray *attrArray = @[price1,price2];
        NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];
     
        _subLabel.attributedText = attributestring;
    }
    return _subLabel;
}

-(NSMutableArray *)headImageViewArray{
    if (_headImageViewArray == nil) {
        _headImageViewArray = [NSMutableArray array];
        [_headImageViewArray addObject:@"1"];
        [_headImageViewArray addObject:@"1"];
        [_headImageViewArray addObject:@"1"];
        [_headImageViewArray addObject:@"1"];
        [_headImageViewArray addObject:@"1"];
    }
    return _headImageViewArray;
}
@end
