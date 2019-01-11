//
//  SmallCardView.m
//  MagicCube
//
//  Created by wanmeizty on 24/12/18.
//  Copyright © 2018年 wanmeizty. All rights reserved.
//

#import "SmallCardView.h"

@interface SmallCardView ()<UITextFieldDelegate>
@property (strong,nonatomic) UIImageView * imgView;
@property (strong,nonatomic) MagicLabel * nameLabel;
@property (strong,nonatomic) MagicLabel * detailLabel;
@property (strong,nonatomic) MagicLabel * saleLabel;
//@property (strong,nonatomic) RedButton * priceBtn;
@property (strong,nonatomic) UITextField * priceTextField;
//@property (strong,nonatomic) UIImageView * bgView;
@end

@implementation SmallCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.imgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.saleLabel];
//    [self addSubview:self.priceBtn];
    [self addSubview:self.priceTextField];
}

- (void)setUpData:(NSDictionary *)dict{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]]];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"homeCellBgIcon"]];
    
//    self.image = [UIImage imageNamed:@"homeCellBgIcon"];
    self.nameLabel.text = [dict objectForKey:@"name"];//@"燕之屋 尼罗河蓝\n孕妇正品燕盏卡";
    self.detailLabel.text = [dict objectForKey:@"subTitle"];//@"干燕窝原料印尼进口 CAIQ溯源";
    self.saleLabel.text = @"售价";
    
    NSString * price = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"price"] doubleValue]];
    self.priceTextField.text = price;
//    [self.priceBtn setTitle:price forState:UIControlStateNormal];
//    if ([dict objectForKey:@"image"]) {
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"home_jieqinghaowu"]];//[UIImage imageNamed:@"home_jieqinghaowu"];
//    }
    
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCALE_W(20), 10, SCALE_W(90), 90)];
    }
    return _imgView;
}

-(MagicLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(134), 13, SCALE_W(156), 40)];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = UIFontMediumOfSize(14);
        _nameLabel.textColor = Black1Color;

    }
    return _nameLabel;
}

-(MagicLabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(134), 55, SCALE_W(156), 14)];
        _detailLabel.textColor = Gray858Color;
        _detailLabel.font = UIFontRegularOfSize(10);
    }
    return _detailLabel;
}

-(MagicLabel *)saleLabel{
    if (!_saleLabel) {
        _saleLabel = [[MagicLabel alloc] initWithFrame:CGRectMake(SCALE_W(134), 78, SCALE_W(28), 12)];
        _saleLabel.textColor = Gray666Color;
        _saleLabel.font = UIFontLightOfSize(12);
        
    }
    return _saleLabel;
}



//-(RedButton *)priceBtn{
//    if (!_priceBtn) {
//        _priceBtn = [[RedButton alloc] initWithFrame:CGRectMake(SCALE_W(168), 72.5, SCALE_W(102), 23)];
//        _priceBtn.userInteractionEnabled = NO;
//        _priceBtn.titleLabel.font = UIFontLightOfSize(14);
//        [_priceBtn setLayerCornerRadius:23 * 0.5];
//    }
//    return _priceBtn;
//}

-(UITextField *)priceTextField{
    if (!_priceTextField) {
        _priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCALE_W(178), 72.5, SCALE_W(102), 23)];
        _priceTextField.backgroundColor = RedMagicColor;
        _priceTextField.layer.masksToBounds = YES;
        _priceTextField.layer.cornerRadius = 23 * 0.5;
        _priceTextField.font = UIFontRegularOfSize(14);
        _priceTextField.textColor = BHColorWhite;
        _priceTextField.textAlignment = NSTextAlignmentCenter;
        _priceTextField.placeholder = @"请输入售价";
        _priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [_priceTextField setValue:BHColorWhite forKeyPath:@"_placeholderLabel.textColor"];
        _priceTextField.delegate = self;
        _priceTextField.enabled = NO;
        
//        UIImageView * rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit"]];
//        rightView.frame = CGRectMake(SCALE_W(102) - 15 - 5, 4, 15, 15);
//        [_priceTextField addSubview:rightView];
    }
    return _priceTextField;
}

- (NSString *)getPrice{
    return _priceTextField.text;
}

-(void)hidekeyboard{
    [_priceTextField resignFirstResponder];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//
//    // 小数点在字符串中的位置 第一个数字从0位置开始
//    NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
//    if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
//
//        NSLog(@"小数点后最多两位");
//
//        return NO;
//
//    }
//
//    if (dotLocation == NSNotFound) {
//        if ([string isEqualToString:@"."]) {
//            textField.text = @"0";
//        }else if ([string isEqualToString:@"0"]){
//            textField.text = @" ";
//        }else if([self deptNumInputShouldNumber:string]){
//            if ([textField.text length] == 1) {
//                textField.text = @"";
//            }else{
//
//            }
//        }
//    }
//    NSLog(@"text==>%@",textField.text);
//    NSLog(@"%ld",dotLocation);
//
//
//    return YES;
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isHaveDian;
    
    //判断是否有小数点
    if ([textField.text containsString:@"."]) {
        isHaveDian = YES;
    }else{
        isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        NSLog(@"single = %c",single);
        
        //不能输入.0~9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.')){
            NSLog(@"您输入的格式不正确");
            return NO;
        }
        
        //只能有一个小数点
        if (isHaveDian && single == '.') {
            NSLog(@"只能输入一个小数点");
            return NO;
        }
        
        //如果第一位是.则前面加上0
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        //如果第一位是0则后面必须输入.
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    NSLog(@"1第二个字符必须是小数点");
                    return NO;
                }
            }else if(textField.text.length == 1){
                if (![string isEqualToString:@"."]) {
                    NSLog(@"2第二个字符必须是小数点");
                    textField.text = @"";
                    return YES;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    NSLog(@"3第二个字符必须是小数点");
                    return YES;
                }
            }
        }
        
        //小数点后最多能输入两位
        if (isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            //由于range.location是NSUInteger类型的，所以不能通过(range.location - ran.location) > 2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    NSLog(@"小数点后最多有两位小数");
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[1-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
