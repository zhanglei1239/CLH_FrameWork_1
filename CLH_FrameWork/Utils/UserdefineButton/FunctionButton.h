//
//  FunctionButton.h
//  促利汇_渠道
//
//  Created by zhanglei on 15/7/4.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionButton : UIView
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UIImageView * whiteBg;
@property (nonatomic,strong) UIImageView * arrow;
@property (nonatomic,strong) UILabel * lblTitle;
@property (nonatomic,strong) UILabel * lblEngTitle;

@property (nonatomic,strong) UIImage * iconImg;
@property (nonatomic,strong) NSString * funTitle;
@property (nonatomic,strong) NSString * funEngTitle;
@property (nonatomic,assign) id delegate;
@property (nonatomic,strong) NSString * functionKey;
-(void)update;
@end
@protocol touchDelegate <NSObject>

-(void)touchFunction:(FunctionButton *)view;

@end