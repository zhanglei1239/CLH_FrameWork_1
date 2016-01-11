//
//  SelfDefineButton.h
//  促利汇_渠道
//
//  Created by zhanglei on 15/6/28.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
enum {
    ButtonStateNormal = 1,
    ButtonStateSelect = 2,
    ButtonStateHilight = 3
};
@interface SelfDefineButton : UIView
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIImage * normalImg;
@property (nonatomic,strong) UIImage * selectImg;
@property (nonatomic,strong) UIImage * hilightImg;
@property (nonatomic,strong) NSString * normalTitle;
@property (nonatomic,strong) NSString * selectTitle;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIColor * normalColor;
@property (nonatomic,strong) UIColor * hilightColor;
@property (nonatomic,assign) id delegate; 
-(void)update;
@end
@protocol touchDelegate <NSObject>

-(void)touchSomething:(SelfDefineButton *)view;

@end