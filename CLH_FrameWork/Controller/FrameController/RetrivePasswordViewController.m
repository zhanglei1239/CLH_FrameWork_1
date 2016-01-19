//
//  RetrivePasswordViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "RetrivePasswordViewController.h"

@interface RetrivePasswordViewController ()
{
    UITextField * utfCurrent;
}
@end

@implementation RetrivePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblTitle setText:@"忘记密码"];
    [self.topView setBackgroundColor:[UIColor whiteColor]];
    
    content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-60)];
    [content setBackgroundColor:RGBACOLOR(239, 239, 239, 1)];
    [self.view addSubview:content];
    
    float offy = 0;
    float offx = 15;
    float dixy = 15;
    float height = 40;
    float iconHeight = 30;
    
    offy += dixy;
    
    self.phoneNumBg = [[UIView alloc] initWithFrame:CGRectMake(offx, offy, UI_SCREEN_WIDTH-offx*2, height)];
    [self.phoneNumBg setBackgroundColor:[UIColor whiteColor]];
    [content addSubview:self.phoneNumBg];
    
    self.phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(offx+(height-iconHeight)/2, offy+(height-iconHeight)/2, iconHeight, iconHeight)];
    [self.phoneIcon setImage:[UIImage imageNamed:@"phone"]];
    [content addSubview:self.phoneIcon];
    
    self.utfPhoneNum = [[UITextField alloc] initWithFrame:CGRectMake(offx+height, offy, UI_SCREEN_WIDTH-offx*2-height, height)];
    self.utfPhoneNum.delegate = self;
    self.utfPhoneNum.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
    [self.utfPhoneNum setValue:[UIFont fontWithName:TEXT_FONT_NAME size:14] forKeyPath:@"_placeholderLabel.font"];
    self.utfPhoneNum.placeholder = @"输入手机号...";
    self.utfPhoneNum.keyboardType = UIKeyboardTypePhonePad;
    [content addSubview:self.utfPhoneNum];
    
    offy += dixy+height;
    
    self.captchaNumBg = [[UIView alloc] initWithFrame:CGRectMake(offx, offy, UI_SCREEN_WIDTH-offx*2, height)];
    [self.captchaNumBg setBackgroundColor:[UIColor whiteColor]];
    [content addSubview:self.captchaNumBg];
    
    self.captchaIcon = [[UIImageView alloc] initWithFrame:CGRectMake(offx+(height-iconHeight)/2, offy+(height-iconHeight)/2, iconHeight, iconHeight)];
    [self.captchaIcon setImage:[UIImage imageNamed:@"captcha"]];
    [content addSubview:self.captchaIcon];
    
    self.utfCaptcha = [[UITextField alloc] initWithFrame:CGRectMake(offx+height, offy, UI_SCREEN_WIDTH-offx*2-height-height*2, height)];
    self.utfCaptcha.delegate = self;
    self.utfCaptcha.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
    [self.utfCaptcha setValue:[UIFont fontWithName:TEXT_FONT_NAME size:14] forKeyPath:@"_placeholderLabel.font"];
    self.utfCaptcha.placeholder = @"输入验证码...";
    self.utfCaptcha.keyboardType = UIKeyboardTypeNumberPad;
    [content addSubview:self.utfCaptcha];
    
    self.btnCaptcha = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-offx-height*2, offy, height*2, height)];
    [self.btnCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btnCaptcha.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self.btnCaptcha setBackgroundColor:RGBACOLOR(114, 195, 66, 1)];
    [self.btnCaptcha.titleLabel setNumberOfLines:0];
    [content addSubview:self.btnCaptcha];
    
    offy +=dixy + height;
    
    self.pwdBg = [[UIView alloc] initWithFrame:CGRectMake(offx, offy, UI_SCREEN_WIDTH-offx*2, height)];
    [self.pwdBg setBackgroundColor:[UIColor whiteColor]];
    [content addSubview:self.pwdBg];
    
    self.pwdIcon = [[UIImageView alloc] initWithFrame:CGRectMake(offx+(height-iconHeight)/2, offy+(height-iconHeight)/2, iconHeight, iconHeight)];
    [self.pwdIcon setImage:[UIImage imageNamed:@"pwd"]];
    [content addSubview:self.pwdIcon];
    
    self.utfNewPwd = [[UITextField alloc] initWithFrame:CGRectMake(offx+height, offy, UI_SCREEN_WIDTH-offx*2-height, height)];
    self.utfNewPwd.delegate = self;
    self.utfNewPwd.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
    [self.utfNewPwd setValue:[UIFont fontWithName:TEXT_FONT_NAME size:14] forKeyPath:@"_placeholderLabel.font"];
    self.utfNewPwd.placeholder = @"输入新密码...";
    self.utfNewPwd.keyboardType = UIKeyboardTypeDefault;
    [content addSubview:self.utfNewPwd];
    
    offy +=dixy + height;
    
    self.pwdConfirmBg = [[UIView alloc] initWithFrame:CGRectMake(offx, offy, UI_SCREEN_WIDTH-offx*2, height)];
    [self.pwdConfirmBg setBackgroundColor:[UIColor whiteColor]];
    [content addSubview:self.pwdConfirmBg];
    
    self.pwdConfirmIcon = [[UIImageView alloc] initWithFrame:CGRectMake(offx+(height-iconHeight)/2, offy+(height-iconHeight)/2, iconHeight, iconHeight)];
    [self.pwdConfirmIcon setImage:[UIImage imageNamed:@"pwd"]];
    [content addSubview:self.pwdConfirmIcon];
    
    self.utfConfirmPwd = [[UITextField alloc] initWithFrame:CGRectMake(offx+height, offy, UI_SCREEN_WIDTH-offx*2-height, height)];
    self.utfConfirmPwd.delegate = self;
    self.utfConfirmPwd.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
    [self.utfConfirmPwd setValue:[UIFont fontWithName:TEXT_FONT_NAME size:14] forKeyPath:@"_placeholderLabel.font"];
    self.utfConfirmPwd.placeholder = @"输入确认密码...";
    self.utfConfirmPwd.keyboardType = UIKeyboardTypeDefault;
    [content addSubview:self.utfConfirmPwd];
    
    offy += dixy*2 + height;
    
    self.btnCommit = [[UIButton alloc] initWithFrame:CGRectMake(offx, offy, UI_SCREEN_WIDTH-offx*2, height)];
    [self.btnCommit setTitle:@"确定" forState:UIControlStateNormal];
    [self.btnCommit.titleLabel  setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self.btnCommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCommit setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.btnCommit setBackgroundColor:RGBACOLOR(114, 195, 66, 1)];
    [self.btnCommit.layer setMasksToBounds:YES];
    [self.btnCommit.layer setCornerRadius:4];
    [content addSubview:self.btnCommit];
    
    [content addGestureRecognizer:tap];
}

-(void)tapHide{
    if (self.hidden == NO) {
        [utfCurrent resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    utfCurrent = textField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
