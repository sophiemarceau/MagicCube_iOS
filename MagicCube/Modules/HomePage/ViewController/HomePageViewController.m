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
#import "ZTGCDTimerManager.h"
#import "AppDelegate.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,
TYCyclePagerViewDataSource,TYCyclePagerViewDelegate,LineTabbarSelectDelegate , SPPageMenuDelegate, UIScrollViewDelegate>{
    int current_page,total_count;
    UIView *bg;
}
//@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) TYCyclePagerView *bannrView;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) LineTabbarView *headTabbarView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *navigationListArray;
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) YXIgnoreHeaderTouchAndRecognizeSimultaneousTableView *tableView;
@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *desLabel,*subLabel,*describeLabel,*messageLabel;
@property (nonatomic, strong) UIButton *memberBtn;
@property (nonatomic, strong) NSMutableArray *headImageViewArray;
@property (nonatomic, strong) NSDictionary *moduleResultDic,*goodListResultDic;
@property (nonatomic, strong)NSString * navID;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initSubviews];
    [self requestData];
    [self requestHomePageRecent];
    [self requestHomePagePlatform];
    [self requestHomePageRecentUserList];
}

-(void)initDatas{
//    self.listArray = [NSMutableArray array];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    [self.listArray addObject:@{@"url":@""}];
//    self.bannerArray = [NSMutableArray array];
//    [self.bannerArray addObject:@"1"];
//    [self.bannerArray addObject:@"2"];
//    [self.bannerArray addObject:@"3"];
    
    
//    [self.navigationListArray addObjectsFromArray:@[@"爆款好物",@"品质好物",@"赚钱好物",@"特色好物",@"海外好物"]];
}

-(void)initSubviews{
   UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, STATUS_BAR_HEIGHT, SCREEN_WIDTH/2, TAB_BAR_HEIGHT-STATUS_BAR_HEIGHT)];
    tempView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-72)/2 +18, 0, 72, TAB_BAR_HEIGHT - STATUS_BAR_HEIGHT)];
    titleLabel.text = @"魔方分销";
    titleLabel.textColor = BHHexColor(@"3F3F3F");
    titleLabel.font = UIFontRegularOfSize(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [tempView addSubview:titleLabel];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabel.left -8 -18 , (TAB_BAR_HEIGHT -STATUS_BAR_HEIGHT -18)/2, 18, 18)];
    titleImageView.image = [UIImage imageNamed:@"navTitle"];
    [tempView addSubview:titleImageView];
    self.navigationItem.titleView = tempView;
    
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

-(void)requestHomePageRecent{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [pramaDic setObject:[self getNowTimeTimestamp] forKey:@"time"];
    [BTERequestTools requestWithURLString:kAppApiHomePageDistriRecent parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        NMRemovLoadIng;
//        NSLog(@"---kAppApiHomePageDistriRecent--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSArray *array = [responseObject objectForKey:@"data"];
            if (array && array.count > 0) {
                NSDictionary *dic = array[0];
                NSString *nickNameStr,*commissionStr,*goodsNameStr;
                nickNameStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickname"]];
                commissionStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"commission"]];
                goodsNameStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"goodsName"]];
                self.messageLabel.text = [NSString stringWithFormat:@"%@刚刚发放了%@,分销收益%@元",nickNameStr,goodsNameStr,commissionStr];
            }
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

-(void)requestHomePagePlatform{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [BTERequestTools requestWithURLString:kAppApiHomePagePlatform parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        NMRemovLoadIng;
//        NSLog(@"---kAppApiHomePagePlatform--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            NSString *price1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"user"]];
            NSString *price2 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"card"]];

            NSDictionary * attubtrDict = @{NSFontAttributeName:UIFontMediumOfSize(12),NSForegroundColorAttributeName:Gray666Color};
            NSString *deliveryPrice = [NSString stringWithFormat:@"全球已有 %@ 人通过魔方分销发放了 %@ 件福利卡",price1,price2];
            NSArray *attrArray = @[price1,price2];
            NSAttributedString * attributestring = [MagicRichTool initWithString:deliveryPrice dict:attubtrDict subStringArray:attrArray];
            self.subLabel.attributedText = attributestring;
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

-(void)requestHomePageRecentUserList{
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [BTERequestTools requestWithURLString:kAppApiiHomePageUserRecentList parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        NMRemovLoadIng;
//        NSLog(@"---kAppApiiHomePageUserRecentList--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSArray *array = [responseObject objectForKey:@"data"];
            for (int i=0; i < self.headImageViewArray.count; i++) {
               UIImageView *temp  =[self.view viewWithTag:2000+i];
                [temp removeFromSuperview];
                temp = nil;
            }
            
            [self.headImageViewArray removeAllObjects];
            [self.headImageViewArray addObjectsFromArray:array];
            
            UIImageView *headImageView;
            for (int i = 0; i < self.headImageViewArray.count; i++) {
                headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+i*(23
                                                                                    +10), self.subLabel.bottom +14, 23, 23)];
                NSString *headStr = [NSString stringWithFormat:@"%@",[self.headImageViewArray[i] objectForKey:@"avatar"]];

                [headImageView sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage: [UIImage imageNamed:[NSString stringWithFormat:@"head-%d",i]]];
                [self->bg addSubview:headImageView];
                //            headImageView.backgroundColor = RedMagicColor;
                headImageView.layer.cornerRadius = 11.5;
                headImageView.layer.masksToBounds = YES;
                headImageView.tag = 2000 + i;
            }
            self.describeLabel.frame = CGRectMake(
                                                  10+(self.headImageViewArray.count - 1)*(23
                                                                                          +10)+23 +15, self.subLabel.bottom +18.5 , 96, 12);
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
}

-(void)requestData{
     NSLog(@"requestData-------->");
    [self.myChildViewControllers removeAllObjects];
    for (BaseViewController *vc in self.navigationListArray) {
        [vc removeFromParentViewController];
    }
    [self.navigationListArray removeAllObjects];
    
    NSMutableDictionary * pramaDic = @{}.mutableCopy;
    [BTERequestTools requestWithURLString:kAppApiHomePageModuleMenu parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
        NMRemovLoadIng;
        NSLog(@"---kAppApiHomePageModuleMenu--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSArray *array = [responseObject objectForKey:@"data"];
            self.moduleResultDic = (NSDictionary *)responseObject;
            [self.navigationListArray removeAllObjects];
            [self.navigationListArray addObjectsFromArray:array];
            NSMutableArray *tagNameList = [NSMutableArray arrayWithCapacity:0];
            for (int i = 0; i < self.navigationListArray.count; i++) {
                [tagNameList addObject:self.navigationListArray[i][@"name"]];
                self.navID = [NSString stringWithFormat:@"%d",[[[self.navigationListArray objectAtIndex:i] objectForKey:@"value"] intValue]];
                BaseViewController *vc;
                vc = [[HomeListViewController alloc] init];
                ((HomeListViewController *)vc).tagid = self.navID;
                [self addChildViewController:vc];// 如果不加这句 会导致push不管用
                // 控制器本来自带childViewControllers,但是遗憾的是该数组的元素顺序永远无法改变，只要是addChildViewController,都是添加到最后一个，而控制器不像数组那样，可以插入或删除任意位置，所以这里自己定义可变数组，以便插入(删除)(如果没有插入(删除)功能，直接用自带的childViewControllers即可)
                [self.myChildViewControllers addObject:vc];
            }
            [self.pageMenu setItems:tagNameList selectedItemIndex:0];
            // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
            self.pageMenu.bridgeScrollView = self.scrollView;
            // pageMenu.selectedItemIndex就是选中的item下标
            if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
                BaseViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
                [self.scrollView addSubview:baseVc.view];
                baseVc.view.frame = CGRectMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0, SCREEN_WIDTH, scrollViewHeight);
                self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0);
                self.scrollView.contentSize = CGSizeMake(self.myChildViewControllers.count*SCREEN_WIDTH, 0);
            }
            [self.tableView reloadData];
        }else{
            if ([[responseObject objectForKey:@"code"] isEqualToString:@"401"]) {
                [User removeLoginData];
                [self.navigationController popToRootViewControllerAnimated:NO];
                AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                [appDelegate setupKeyWindow];
                return;
            }
        }
    } failure:^(NSError *error)  {
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];
    
//    // 创建组
//    dispatch_group_t group = dispatch_group_create();
//    // 将第1个网络请求任务添加到组中
//    //菜单有什么选项的获取 接口
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 创建信号量
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//
//        NSMutableDictionary * pramaDic = @{}.mutableCopy;
//        [BTERequestTools requestWithURLString:kAppApiHomePageModuleMenu parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
//            NMRemovLoadIng;
//            NSLog(@"---kAppApiHomePageModuleMenu--responseObject--->%@",responseObject);
//            if (IsSucess(responseObject)) {
//                self.moduleResultDic = (NSDictionary *)responseObject;
//            }
//            // 如果请求成功，发送信号量
//            dispatch_semaphore_signal(semaphore);
//        } failure:^(NSError *error)  {
//            NMRemovLoadIng;
//            // 如果请求失败，也发送信号量
//            dispatch_semaphore_signal(semaphore);
//            NSLog(@"error-------->%@",error);
//        }];
//
//        // 在网络请求任务成功之前，信号量等待中
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    });
//    // 将第2个网络请求任务添加到组中
//    //获取 商品列表
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 创建信号量
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        // 开始网络请求任务
//        NSMutableDictionary * pramaDic = @{}.mutableCopy;
//        [BTERequestTools requestWithURLString:kAppApiHomePageList parameters:pramaDic type:HttpRequestTypeGet success:^(id responseObject) {
//            NMRemovLoadIng;
//            NSLog(@"---kAppApiHomePageList--responseObject--->%@",responseObject);
//            if (IsSucess(responseObject)) {
//               self.goodListResultDic = (NSDictionary *)responseObject;
//            }
//            // 如果请求成功，发送信号量
//            dispatch_semaphore_signal(semaphore);
//        } failure:^(NSError *error)  {
//            NMRemovLoadIng;
//            // 如果请求失败，也发送信号量
//            dispatch_semaphore_signal(semaphore);
//            NSLog(@"error-------->%@",error);
//        }];
//        // 在网络请求任务成功之前，信号量等待中
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    });
//
//    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        if (self.goodListResultDic==nil || self.moduleResultDic==nil) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//
////                self.failView.hidden = NO;
//                [BHToast showMessage:@"网络加载失败,请重试"];
//            });
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
////                self.failView.hidden = YES;
//                [self initUIView];
//            });
//        }
//    });
}

-(void)giveMeMoreData{}


-(void)initUIView{}
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
        [cell.contentView addSubview:self.pageMenu];
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

-(NSString *)getNowTimeTimestamp{
    NSDate *startDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: startDate];
    NSDate *localeNowDate = [startDate  dateByAddingTimeInterval: interval];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeNowDate timeIntervalSince1970]];
    return timeSp;
}

-(void)gotoMember:(UIGestureRecognizer *)sender{
    SecondaryLevelWebViewController *webVc= [[SecondaryLevelWebViewController alloc] init];
    webVc.isHiddenLeft = YES;
    webVc.isHiddenBottom = YES;
    webVc.isHideTabarView = YES;
    webVc.urlString = [NSString stringWithFormat:@"%@",@"https://l.bte.top/ad/partner"];
  
    [self.navigationController pushViewController:webVc animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ZTGCDTimerManager sharedInstance] cancelTimerWithName:@"beck.wang.singleTimer"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[ZTGCDTimerManager sharedInstance] scheduleGCDTimerWithName:@"beck.wang.singleTimer" interval:3 queue:dispatch_get_main_queue() repeats:YES option:CancelPreviousTimerAction action:^{
        [self requestHomePageRecent];
        [self requestHomePagePlatform];
        [self requestHomePageRecentUserList];
    }];

}

-(UILabel *) describeLabel{
    if (_describeLabel == nil) {
        _describeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _describeLabel.text = @"正在使用魔方分销";
        _describeLabel.font = UIFontRegularOfSize(12);
        _describeLabel.textColor = Gray666Color;
        _describeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _describeLabel;
}

-(UIView *)tableHeaderView{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.backgroundColor = KBGColor;
        _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 117+ 150 +10);
        bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 117+ 150)];
        bg.backgroundColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:bg];
        UIImageView *picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"421543305740_.pic_hd"]];
        picImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        [bg addSubview:picImageView];
        //        [bg addSubview:self.picImageView];
        //        [bg addSubview:self.desLabel];
        //        [bg addSubview:self.memberBtn];
        [bg addSubview:self.subLabel];
        [bg addSubview:self.describeLabel];
        [bg addSubview:self.messageLabel];
        
        _tableHeaderView.userInteractionEnabled = YES;
        picImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapShareView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMember:)];
        [picImageView addGestureRecognizer:tapShareView];
        
    }
    return _tableHeaderView;
}

-(UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  self.subLabel.bottom +51, SCREEN_WIDTH -20 +10, 26)];
        _messageLabel.font = UIFontRegularOfSize(12);
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor  = Gray666Color;
        _messageLabel.backgroundColor = BHHexColorAlpha(@"B5262F", 0.1);
        _messageLabel.layer.cornerRadius = 13;
        _messageLabel.layer.masksToBounds = YES;
        _messageLabel.layer.borderColor = RedMagicColor.CGColor;
        _messageLabel.layer.borderWidth = 1;
        
    }
    return _messageLabel;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, pageMenuH, SCREEN_WIDTH, scrollViewHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(SPPageMenu *)pageMenu{
    if (_pageMenu == nil) {
        _pageMenu  = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
        // 自适应内容,可以左右滑动
        _pageMenu.permutationWay = SPPageMenuPermutationWayScrollAdaptContent;
        // 设置代理
        _pageMenu.delegate = self;
    }
    return _pageMenu;
}

-(NSMutableArray *)navigationListArray{
    if (_navigationListArray == nil) {
        _navigationListArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _navigationListArray;
}

-(NSMutableArray *)headImageViewArray{
    if (_headImageViewArray == nil) {
        _headImageViewArray = [NSMutableArray array];
        
    }
    return _headImageViewArray;
}

-(UILabel *)subLabel{
    if (_subLabel == nil) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150+14, SCREEN_WIDTH -20, 12)];
        _subLabel.font = UIFontRegularOfSize(12);
        _subLabel.textColor = GrayMagicColor;;
        _subLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _subLabel;
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
@end
