//
//  LocateButton.h
//  促利汇_门户
//
//  Created by zhanglei on 15/7/9.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocateButton : UIView
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
-(void)updateFrame;
@end
@protocol touchDelegate <NSObject>

-(void)touchLocate:(LocateButton *)view;

@end
