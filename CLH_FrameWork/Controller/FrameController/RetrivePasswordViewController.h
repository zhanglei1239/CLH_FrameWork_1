//
//  RetrivePasswordViewController.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BaseViewController.h"

@interface RetrivePasswordViewController : BaseViewController<UITextFieldDelegate>
@property (nonatomic,strong) UIView * phoneNumBg;
@property (nonatomic,strong) UIImageView * phoneIcon;
@property (nonatomic,strong) UITextField * utfPhoneNum;
@property (nonatomic,strong) UIView * captchaNumBg;
@property (nonatomic,strong) UIImageView * captchaIcon;
@property (nonatomic,strong) UITextField * utfCaptcha;
@property (nonatomic,strong) UIButton * btnCaptcha;
@property (nonatomic,strong) UIView * pwdBg;
@property (nonatomic,strong) UIImageView * pwdIcon;
@property (nonatomic,strong) UITextField * utfNewPwd;
@property (nonatomic,strong) UIView * pwdConfirmBg;
@property (nonatomic,strong) UIImageView * pwdConfirmIcon;
@property (nonatomic,strong) UITextField * utfConfirmPwd;
@property (nonatomic,strong) UIButton * btnCommit;
@end
