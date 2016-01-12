//
//  CaptchaPopView.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CaptchaPopView.h"

@implementation CaptchaPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self setBackgroundColor:RGBACOLOR(210, 210, 210, 1)];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:4];
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width-40, 14)]; 
    [self.lblTitle setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
    [self.lblTitle setTextColor:[UIColor redColor]];
    [self.lblTitle setText:@"请输入图片验证码"];
    [self addSubview:self.lblTitle];
    
    self.utfBg = [[UIView alloc] initWithFrame:CGRectMake(20, 27, 130, 30)];
    [self.utfBg setBackgroundColor:[UIColor whiteColor]];
    [self.utfBg.layer setMasksToBounds:YES];
    [self.utfBg.layer setCornerRadius:2];
    [self.utfBg.layer setBorderWidth:1];
    [self.utfBg.layer setBorderColor:[UIColor greenColor].CGColor];
    [self addSubview:self.utfBg];
    
    self.utfInput = [[UITextField alloc] initWithFrame:CGRectMake(24, 30, 130-8, 24)];
    [self.utfInput setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
    [self.utfInput setPlaceholder:@"输入图片验证码"];
    [self addSubview:self.utfInput];
    
    self.captchaV = [[CaptchaView alloc] initWithFrame:CGRectMake(20+140+4, 27, 120, 30)];
    [self addSubview:self.captchaV];
    
    self.hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 69, self.frame.size.width, 1)];
    [self.hLine setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:self.hLine];
    
    self.btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width/2-.5, 30)];
    [self.btnConfirm setTitleColor:RGBACOLOR(22, 248, 152, 1) forState:UIControlStateNormal];
    [self.btnConfirm.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    [self.btnConfirm addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnConfirm];
   
    self.btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2+.5, 70, self.frame.size.width/2-.5, 30)];
    [self.btnCancel setTitleColor:RGBACOLOR(22, 248, 152, 1) forState:UIControlStateNormal];
    [self.btnCancel.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnCancel];
    
    self.vLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-.5, 70, 1, 30)];
    [self.vLine setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:self.vLine];
}

-(void)cancel:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(CaptchaPopCancel:)]) {
        [_delegate CaptchaPopCancel:self];
    }
}

-(void)confirm:(id)sender{
    NSString * lowCaseInput = [self.utfInput.text lowercaseString];
    NSString * lowCaseCaptcha = [self.captchaV.changeString lowercaseString];
    if ([lowCaseInput isEqualToString:@""]) {
        [self makeToast:@"请输入图片验证码!" duration:1 position:@"center" image:nil withTextColor:[UIColor redColor] withValue:@""];
        return;
    }
    else if(![lowCaseCaptcha isEqualToString:lowCaseInput]){
        [self makeToast:@"验证码输入错误!" duration:1 position:@"center" image:nil withTextColor:[UIColor redColor] withValue:@""];
        return;
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(CaptchaPopSuccess:)]) {
            [_delegate CaptchaPopSuccess:self];
        }
    }
}


@end
