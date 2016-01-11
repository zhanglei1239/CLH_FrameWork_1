//
//  CaptchaPopView.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptchaView.h"
#import "Toast+UIView.h"
@interface CaptchaPopView : UIView
@property (nonatomic,strong) UILabel * lblTitle;
@property (nonatomic,strong) UIView * utfBg;
@property (nonatomic,strong) UITextField * utfInput;
@property (nonatomic,strong) CaptchaView * captchaV;
@property (nonatomic,strong) UIView * hLine;
@property (nonatomic,strong) UIView * vLine;
@property (nonatomic,strong) UIButton * btnConfirm;
@property (nonatomic,strong) UIButton * btnCancel;
@property (nonatomic,assign) id delegate;
@end

@protocol CaptchaPopDelegate <NSObject>

-(void)CaptchaPopSuccess:(CaptchaPopView *)pop;
-(void)CaptchaPopCancel:(CaptchaPopView *)pop;

@end