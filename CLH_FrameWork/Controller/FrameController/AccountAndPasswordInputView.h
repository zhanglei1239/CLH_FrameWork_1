//
//  AccountAndPasswordInputView.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountAndPasswordInputView : UIView
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UITextField * utfUserAccount;
@property (nonatomic,strong) UITextField * utfPassword;
@property (nonatomic,strong) UIImageView * utfBg;
@property (nonatomic,strong) UIButton * btnLogin;
@property (nonatomic,strong) UIButton * btnForget;
@property (nonatomic,strong) UIButton * btnRegist;
@property (nonatomic,assign) id delegate;
@end
@protocol AccountLoginDelegate <NSObject>
/**
 *  登陆回调
 *
 *  @param view 当前登陆界面所需信息界面
 */
-(void)accountLoginDelegate:(AccountAndPasswordInputView*)view;
/**
 *  忘记密码回调
 *
 *  @param view 忘记密码的当前所需信息界面
 */
-(void)accountForgetDelegate:(AccountAndPasswordInputView*)view;
/**
 *  注册回调
 *
 *  @param view 注册账号当前所需信息界面
 */
-(void)accountRegistDelegate:(AccountAndPasswordInputView*)view;

@end