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

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,TYCyclePagerViewDataSource,TYCyclePagerViewDelegate,LineTabbarSelectDelegate>{
    int current_page,total_count;
}
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) TYCyclePagerView *bannrView;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) LineTabbarView *headTabbarView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

-(void)initSubviews{
    [self.view addSubview:self.listView];
}

-(void)requestData{}

-(void)giveMeMoreData{}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
    return self.listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MessageItem *model = [self.listArray objectAtIndex:indexPath.row];
//    return  [model heightForRowWithisShow:model.isShow];
    return [HomePageTableViewCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"HomePageCell";
    HomePageTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell configwidth:[self.listArray objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MessageItem *selectMessageItem = self.listArray[indexPath.row];
//
//    NSString *urlStr =  stringFormat(selectMessageItem.redirectUrl);
//    if([urlStr isEqualToString:@""]){
//        selectMessageItem.isShow = !selectMessageItem.isShow;
//        [self.listArray replaceObjectAtIndex:indexPath.row withObject:selectMessageItem];
//        [self.listView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//    }else{
//        SecondaryLevelWebViewController *webVc= [[SecondaryLevelWebViewController alloc] init];
//        webVc.urlString = [NSString stringWithFormat:@"%@",selectMessageItem.redirectUrl];
//        webVc.isHiddenLeft = NO;
//        webVc.isHiddenBottom = NO;
//        [self.navigationController pushViewController:webVc animated:YES];
//    }
    
    
    ProductDetailViewController *webVc= [[ProductDetailViewController alloc] init];
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.bannerArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
     [cell.bannerImageView setImage:[UIImage imageNamed:@"home_banner"]];
//    if (index == 0) {
//        [cell.bannerImageView setImage:[UIImage imageNamed:@"首页_列表"]];
//    }
//    if (index == 1) {
//       [cell.bannerImageView setImage:[UIImage imageNamed:@"home_banner"]];
//    }
//    if (index == 2) {
//        [cell.bannerImageView setImage:[UIImage imageNamed:@"首页_列表"]];
//    }
//    if (index == 2) {
//        cell.contentView.backgroundColor = [UIColor redColor];
//    }
    //    cell.backgroundColor = _datas[index];
    //    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
//    HomeBannerModel *bannerModel = (HomeBannerModel *) bannerArray[index];
//
//    [cell.bannerImageView sd_setImageWithURL: [NSURL URLWithString:bannerModel.url]];
   
    
//        NSURL *URL =
//        [NSURL URLWithString:@"https://mobike.com/cn/"];
////        [NSURL URLWithString:bannerModel.url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
//        [cell.webView loadRequest:request];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, 150);
    layout.itemSpacing = SCALE_W(0);
    //layout.minimumAlpha = 0.3;
    //    layout.itemHorizontalCenter = YES;
    layout.layoutType = TYCyclePagerTransformLayoutCoverflow;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    //    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    //    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    NSLog(@"didSelectedItemCell->  %ld",index);
//    if (self.delegate && [self.delegate respondsToSelector:@selector(bannberJumpToWebView:)]) {
//        HomeBannerModel *bannerModel = (HomeBannerModel *) bannerArray[index];
//
//        [self.delegate bannberJumpToWebView:bannerModel.target];
//    }
}

#pragma mark - LineTabbarSelectDelegate
-(void)tabbarDidSelect:(NSInteger)number{
    NSLog(@"num-------->%ld",(long)number);
}

#pragma mark  initView
-(UITableView *)listView{
    if (_listView == nil) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - NAVIGATION_HEIGHT - TAB_BAR_HEIGHT)];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = KBGColor;
        //也可以让分割线消失
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self setTableHeadView];
        UIView *footView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
        footView.backgroundColor = KBGColor;
        _listView.tableFooterView = footView;
        WS(weakSelf)
        _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestData];
        }];
        MJRefreshBackNormalFooter *allfooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf giveMeMoreData];
        }];
        _listView.mj_footer = allfooter;
        _listView.mj_footer.ignoredScrollViewContentInsetBottom = HOME_INDICATOR_HEIGHT;
    }
    return _listView;
}

-(LineTabbarView *)headTabbarView{
    if(_headTabbarView == nil){
        _headTabbarView = [[LineTabbarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 97) WithNameArray:@[@{@"name":@"精选好物",@"pic":@"home_jingxuan"},@{@"name":@"美丽好物",@"pic":@"home_meilihaowu"},@{@"name":@"健康好物",@"pic":@"home_jiankanghaowu"},@{@"name":@"节庆好物",@"pic":@"home_jieqinghaowu"}]];
        _headTabbarView.delegate = self;
    }
    return _headTabbarView;
}

//设置头部视图
- (void)setTableHeadView{
    UIView *bgView;
    bgView = [[UIView alloc] initWithFrame:CGRectZero];
    [bgView addSubview:self.headTabbarView];
    if(self.bannerArray && self.bannerArray.count > 0){
        UIView *bannerBgView = [UIView new];
        bannerBgView.backgroundColor =  KBGColor;
        bannerBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        
        TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
        pagerView.layout.layoutType = TYCyclePagerTransformLayoutCoverflow;
        pagerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (150));
        pagerView.layer.borderWidth = 0;
        //    pagerView.isInfiniteLoop = YES;
        pagerView.autoScrollInterval = 6.0;
        pagerView.dataSource = self;
        pagerView.delegate = self;
        [pagerView setNeedUpdateLayout];
        // registerClass or registerNibr
        [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
        _bannrView = pagerView;
        [bannerBgView addSubview:_bannrView];
        [bgView addSubview:bannerBgView];
        
        self.headTabbarView.frame = CGRectMake(0, bannerBgView.height , SCREEN_WIDTH, self.headTabbarView.height);
    }
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.headTabbarView.bottom );
    [self.bannrView reloadData];
    bgView.backgroundColor = KBGColor;
    self.listView.tableHeaderView = bgView;
}
@end
