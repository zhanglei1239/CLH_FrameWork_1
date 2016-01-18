//
//  AccountAndPasswordInputView.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AccountAndPasswordInputView.h"

@implementation AccountAndPasswordInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.utfBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    [self.utfBg setBackgroundColor:[UIColor redColor]];
    [self.utfBg.layer setMasksToBounds:YES];
    [self.utfBg.layer setCornerRadius:6];
    [self.utfBg setAlpha:.5];
    [self addSubview:self.utfBg];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, self.frame.size.width, 1)];
    [self.line setBackgroundColor:[UIColor grayColor]];
    [self addSubview:self.line];
    
    self.utfUserAccount = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, 30)];
    [self.utfUserAccount setPlaceholder:@"用户名"];
    [self.utfUserAccount setTextColor:[UIColor whiteColor]];
    [self.utfUserAccount setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self addSubview:self.utfUserAccount];
    
    self.utfPassword = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, self.frame.size.width-20, 30)];
    [self.utfPassword setPlaceholder:@"密码"];
    [self.utfPassword setTextColor:[UIColor whiteColor]];
    [self.utfPassword setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self addSubview:self.utfPassword];
    
    self.btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, self.frame.size.width, 40)];
    [self.btnLogin.layer setMasksToBounds:YES];
    [self.btnLogin.layer setCornerRadius:6];
    [self.btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnLogin setBackgroundColor:[UIColor greenColor]];
    [self.btnLogin setTitle:@"登陆" forState:UIControlStateNormal];
    [self.btnLogin.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self.btnLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnLogin];
    
    self.btnForget = [[UIButton alloc] initWithFrame:CGRectMake(0, 160, 100, 40)];
    [self.btnForget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.btnForget setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnForget.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self.btnForget setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.btnForget addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnForget];
     
    self.btnRegist = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 160, 100, 40)];
    [self.btnRegist setTitle:@"注册账号" forState:UIControlStateNormal];
    [self.btnRegist setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnRegist setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.btnRegist.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self.btnRegist addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnRegist];
}

-(void)login:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(accountLoginDelegate:)]) {
        [_delegate accountLoginDelegate:self];
    }
}

-(void)forget:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(accountForgetDelegate:)]) {
        [_delegate accountForgetDelegate:self];
    }
}

-(void)regist:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(accountRegistDelegate:)]) {
        [_delegate accountRegistDelegate:self];
    }
}
@end
