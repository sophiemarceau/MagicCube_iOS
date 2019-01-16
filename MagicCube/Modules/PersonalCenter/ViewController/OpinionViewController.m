//
//  OpinionViewController.m
//  MagicCube
//
//  Created by wanmeizty on 21/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "OpinionViewController.h"

#define placeholder @"请输入不少于5个字的描述"

@interface OpinionViewController ()<UITextViewDelegate>
@property (strong,nonatomic) UITextView * textview;
@property (strong,nonatomic) RedButton * submitBtn;
@property (strong,nonatomic) MagicLabel * limitLabel;
@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self addSubViews];
    // Do any additional setup after loading the view.
}
- (void)initdata{
    self.title = @"意见反馈";
}

- (void)requestSubmitOpinion{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    [params setObject:self.textview.text forKey:@"text"];
    WS(weakSelf)
    NSLog(@"-----requestRecords--->%@",params);
    NMShowLoadIng;
    [BTERequestTools requestWithURLString:kAppApiDistribution parameters:params type:HttpRequestTypeGet success:^(id responseObject) {
       
        NMRemovLoadIng;
        NSLog(@"---requestRecords--responseObject--->%@",responseObject);
        if (IsSucess(responseObject)) {
            NSDictionary * dataDict = [responseObject objectForKey:@"data"];
            
        }else{
            
            NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [BHToast showMessage:message];
        }
    } failure:^(NSError *error)  {
       
        NMRemovLoadIng;
        NSLog(@"error-------->%@",error);
    }];

}

-(void)addSubViews{
    self.view.backgroundColor = KBGColor;
    
    MagicLabel * titleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(16, 20, SCREEN_WIDTH - 32, 14)];
    titleLabel.text = @"反馈内容";
    titleLabel.textColor = Black626A75Color;
    [self.view addSubview:titleLabel];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 144)];
    bgView.backgroundColor = BHColorWhite;
    [self.view addSubview:bgView];
    
    UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(16,0,SCREEN_WIDTH-32,144)];
    textView.backgroundColor= [UIColor whiteColor];
    textView.text = placeholder;
    textView.font = UIFontRegularOfSize(14);
    textView.textColor = [UIColor colorWithHexString:@"626A75" alpha:0.4];
    textView.delegate = self;
    self.textview = textView;
    [bgView addSubview:textView];
    
    MagicLabel * limitLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 16 - 80, 156, 80, 14)];
    limitLabel.textColor = Black626A75Color;
    limitLabel.text = @"0/240";
    limitLabel.textAlignment = NSTextAlignmentRight;
    self.limitLabel = limitLabel;
    [self.view addSubview:limitLabel];
    
    
    self.submitBtn = [[RedButton alloc] initWithFrame:CGRectMake(16, 212, SCREEN_WIDTH - 32, 40)];
    self.submitBtn.titleLabel.font = UIFontSemiboldOfSize(16);
    [self.submitBtn setTitle:@"提交意见" forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = BtnBGGrayColor;
    [self.view addSubview:self.submitBtn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textview resignFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = placeholder;
        textView.textColor = [UIColor colorWithHexString:@"626A75" alpha:0.4];
        self.limitLabel.hidden = NO;
        self.submitBtn.backgroundColor = BtnBGGrayColor;
    }else{
        
    }
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:placeholder]){
        textView.text=@"";
        textView.textColor=Black626A75Color;
        self.limitLabel.hidden = YES;
        self.submitBtn.backgroundColor = RedMagicColor;
    }
    
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
