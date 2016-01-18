//
//  LoginViewController.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountAndPasswordInputView.h"
#import "LoginByThirdView.h"
@interface LoginViewController : BaseViewController<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView * appIcon;
@property (nonatomic,strong) AccountAndPasswordInputView * apIv;
@property (nonatomic,strong) LoginByThirdView * lbTv;
@end
