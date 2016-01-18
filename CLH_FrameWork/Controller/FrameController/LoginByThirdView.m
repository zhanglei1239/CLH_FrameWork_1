//
//  LoginByThirdView.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LoginByThirdView.h"

@implementation LoginByThirdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        width = frame.size.width;
        height = frame.size.height;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    NSString *s1 = @"使用第三方账号登陆";
    UIFont *font1 = [UIFont fontWithName:TEXT_FONT_NAME size:12];
    CGSize size1 = CGSizeMake(self.frame.size.width, 30);
    CGSize labelsize1 = [s1 sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:UILineBreakModeWordWrap];
    self.lblThird = [[UILabel alloc] initWithFrame:CGRectMake((width-labelsize1.width)/2, 10, labelsize1.width, 30)];
    [self.lblThird setText:s1];
    [self.lblThird setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
    [self.lblThird setTextColor:[UIColor whiteColor]];
    [self addSubview:self.lblThird];
    
    self.line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+14.5, (width-labelsize1.width)/2-5, 1)];
    [self.line1 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.line1];
    
    self.line2 = [[UIView alloc] initWithFrame:CGRectMake((width-labelsize1.width)/2+labelsize1.width+5, 10+14.5, (width-labelsize1.width)/2-5, 1)];
    [self.line2 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.line2];
    
    self.btnLoginByWeiXin = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 60, 60)];
    [self.btnLoginByWeiXin setBackgroundColor:[UIColor whiteColor]];
    [self.btnLoginByWeiXin.layer setMasksToBounds:YES];
    [self.btnLoginByWeiXin.layer setCornerRadius:30];
    [self.btnLoginByWeiXin setImage:[UIImage imageNamed:@"UMS_wechat_session_icon"] forState:UIControlStateNormal];
    [self.btnLoginByWeiXin addTarget:self action:@selector(loginByWeixin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnLoginByWeiXin];
    
    self.btnLoginByWeibo = [[UIButton alloc] initWithFrame:CGRectMake(width/2-30, 50, 60, 60)];
    [self.btnLoginByWeibo setBackgroundColor:[UIColor whiteColor]];
    [self.btnLoginByWeibo.layer setMasksToBounds:YES];
    [self.btnLoginByWeibo.layer setCornerRadius:30];
    [self.btnLoginByWeibo setImage:[UIImage imageNamed:@"UMS_sina_icon"] forState:UIControlStateNormal];
    [self.btnLoginByWeibo addTarget:self action:@selector(loginByWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnLoginByWeibo];
    
    self.btnLoginByQQ = [[UIButton alloc] initWithFrame:CGRectMake(width-60, 50, 60, 60)];
    [self.btnLoginByQQ setBackgroundColor:[UIColor whiteColor]];
    [self.btnLoginByQQ.layer setMasksToBounds:YES];
    [self.btnLoginByQQ.layer setCornerRadius:30];
    [self.btnLoginByQQ setImage:[UIImage imageNamed:@"UMS_qq_icon"] forState:UIControlStateNormal];
    [self.btnLoginByQQ addTarget:self action:@selector(loginByQQ:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnLoginByQQ];
    
}

-(void)loginByWeixin:(LoginByThirdView *)view{
    if (_delegate && [_delegate respondsToSelector:@selector(loginByWeixin:)]) {
        [_delegate loginByWeixin:self];
    }
}

-(void)loginByWeibo:(LoginByThirdView *)view{
    if (_delegate && [_delegate respondsToSelector:@selector(loginByWeibo:)]) {
        [_delegate loginByWeibo:self];
    }
}

-(void)loginByQQ:(LoginByThirdView *)view{
    if (_delegate && [_delegate respondsToSelector:@selector(loginByQQ:)]) {
        [_delegate loginByQQ:self];
    }
}
@end
