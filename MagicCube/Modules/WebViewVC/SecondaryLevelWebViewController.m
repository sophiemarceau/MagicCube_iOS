//
//  SecondaryLevelWebViewController.m
//  BTE
//
//  Created by sophiemarceau_qu on 2018/8/12.
//  Copyright © 2018年 wangli. All rights reserved.
//

#import "SecondaryLevelWebViewController.h"

#import "TestJSObject.h"


@interface SecondaryLevelWebViewController ()<RetrunFormJsFunctionDelegate>{
    NSUInteger selectedIndex;
}

@property (nonatomic,strong) NSTimer * timer;
@end

@implementation SecondaryLevelWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotification];
}

- (void)addNotification {}

- (void)update {
    [self.webView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //     NSLog(@"--------webview-------viewWillAppear------------------%@",self.urlString);
}

#pragma mark - viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)go2PageVc:(NSDictionary *)obj{
    if (obj != nil) {
        NSString *action = [obj objectForKey:@"action"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([action isEqualToString:@"bindWechat"]) {
                
            }
        });
    }
}

#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSLog(@"---------------shouldStartLoadWithRequest------------------");
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
//    NSLog(@"---------------START------------------");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSLog(@"---------------webViewDidFinishLoad------------------>%@",self.urlString);
    [super webViewDidFinishLoad:webView];
    NSString *webNavtitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (webNavtitle.length != 0) {
        self.navigationItem.title = webNavtitle;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"---------------error---------------%@---",error);
}

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx{
    TestJSObject *testJO=[TestJSObject new];
    testJO.delegate = self;
    ctx[@"bteApp"]=testJO;
    ctx[@"viewController"] = self;
    ctx.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"JSContext------>异常信息：%@", exceptionValue);
    };
}

#pragma mark - goback返回
- (void)goback {
    [super goback];
    UINavigationController *nav = self.tabBarController.selectedViewController;
    NSLog(@"nav.visibleViewController.navigationItem.title-------->%@",nav.visibleViewController.navigationItem.title);
    NSLog(@"goback-------urlstring----->%@",self.urlString);

}

#pragma mark - get Data From Server

#pragma mark - Navigation
//- (UIBarButtonItem *)creatRightBarItem {
//    UIImage *buttonNormal = [[UIImage imageNamed:@"Group 24"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:buttonNormal style:UIBarButtonItemStylePlain target:self action:@selector(shareAlert)];
//    return leftItem;
//}
//
//- (UIBarButtonItem *)leftBart{
//    UIImage *buttonNormal = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:buttonNormal style:UIBarButtonItemStylePlain target:self action:@selector(disback)];
//    return backItem;
//}
//
//-(NSDictionary *)convertjsonStringToDict:(NSString *)jsonString{
//    NSDictionary *retDict = nil;
//    if ([jsonString isKindOfClass:[NSString class]]) {
//        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
//        return  retDict;
//    }else{
//        return retDict;
//    }
//}
@end
