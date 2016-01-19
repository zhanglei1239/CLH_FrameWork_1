//
//  CulihuiLuckyCell.h
//  促利汇_门户
//
//  Created by zhanglei on 15/7/10.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CulihuiLuckyCell : UITableViewCell
@property (nonatomic,strong) UIImageView * imgIcon;
@property (nonatomic,strong) UILabel * lblTitle;
@property (nonatomic,strong) UIButton * btnPay;
@property (nonatomic,strong) UIButton * btnReceive;
@property (nonatomic,strong) UIButton * btnRecment;
@property (nonatomic,strong) UIButton * btnAll;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UIView * bottom;
@property (nonatomic,strong) UIImageView * tipAllRecord;
@property (nonatomic,strong) UILabel * lblTipAllRecord;
@property (nonatomic,strong) UIImageView * tipLottery;
@property (nonatomic,strong) UILabel * lblTipLottery;
@property (nonatomic,strong) UIImageView * tipReward;
@property (nonatomic,strong) UILabel * lblTipReward;
@end
