//
//  LoginByThirdView.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginByThirdView : UIView
{
    float width;
    float height;
}
@property (nonatomic,strong) UIView * line1;
@property (nonatomic,strong) UILabel * lblThird;
@property (nonatomic,strong) UIView * line2;
@property (nonatomic,strong) UIButton * btnLoginByQQ;
@property (nonatomic,strong) UIButton * btnLoginByWeiXin;
@property (nonatomic,strong) UIButton * btnLoginByWeibo;
@property (nonatomic,assign) id delegate;
@end
@protocol LoginByThirdDelegate <NSObject>

-(void)loginByQQ:(LoginByThirdView *)view;
-(void)loginByWeixin:(LoginByThirdView *)view;
-(void)loginByWeibo:(LoginByThirdView *)view;

@end