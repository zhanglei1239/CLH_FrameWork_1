//
//  CulihuiChangeCell.h
//  促利汇_门户
//
//  Created by zhanglei on 15/7/10.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CulihuiChangeCell : UITableViewCell
@property (nonatomic,strong) UIImageView * imgIcon;
@property (nonatomic,strong) UILabel * lblTitle;  
@property (nonatomic,strong) UIButton * btnPay;
@property (nonatomic,strong) UIButton * btnReceive;
@property (nonatomic,strong) UIButton * btnRecment;
@property (nonatomic,strong) UIButton * btnAll;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UIView * bottom;
@property (nonatomic,strong) UIImageView * tipNoPay;
@property (nonatomic,strong) UILabel * lblTipNoPay;
@property (nonatomic,strong) UIImageView * tipNoReceive;
@property (nonatomic,strong) UILabel * lblTipNoReceive;
@property (nonatomic,strong) UIImageView * tipNoRecommend;
@property (nonatomic,strong) UILabel * lblTipNoRecommend; 
@end
