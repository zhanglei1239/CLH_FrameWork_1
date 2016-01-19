//
//  MyPersonCenterViewController.m
//  促利汇_门户
//
//  Created by zhanglei on 15/7/8.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "MyPersonCenterViewController.h"
#import "CulihuiTopCell.h"
#import "CulihuiChangeCell.h"
#import "CulihuiLuckyCell.h"
#import "CulihuiLoveCell.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface MyPersonCenterViewController ()
{
    UIButton * btnSetting;
    UITableView * personTableView;
    NSMutableDictionary * orderDic;
    NSString * scoreNum;
    NSString * beanNum;
    BOOL ifShowNewGift;
    NSString * xinShouName;
    BOOL ifShareForPt;
    NSString * songJifenName;
    BOOL ifBeShop;
    NSString * chengShangjiaName;
    BOOL ifRequest;
    NSString * requestPangName;
    BOOL ifReceivePoint;
    NSMutableDictionary * idxDic;
    NSString * imgUrl;
}
@end

@implementation MyPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgUrl = @"";
    scoreNum = @"0";
    beanNum = @"0";
    
    ifShowNewGift =NO;
    ifShareForPt = NO;
    ifBeShop = NO;
    
    orderDic = [NSMutableDictionary dictionary];
    
    idxDic = [NSMutableDictionary dictionary];
    
    [self.topView setHidden:YES];
    
    [self.btnBack setHidden:YES];
    
    [content setBackgroundColor:[UIColor clearColor]];
    
    personTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-50)];
    personTableView.delegate = self;
    personTableView.dataSource = self;
    [personTableView setBackgroundColor:[UIColor clearColor]];
    personTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:personTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (![self ifNetWorkEnable]) {
        [self.view makeToast:@"当前没有可用网络" duration:1 position:@"center" image:nil withTextColor:[UIColor whiteColor] withValue:@""];
        return;
    }
    [personTableView reloadData];
}

-(void)showMsg:(id)sender{ 
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
        
    }
}

-(void)setting:(id)sender{
    BOOL isLogin =  [self detactIfLogin];
    if (isLogin) {
//        SettingViewController * setting = [[SettingViewController alloc] init];
//        [self.navigationController pushViewController:setting animated:YES];
    }
}

-(void)showQrCode:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
//        MyQrCodeViewController * qr = [[MyQrCodeViewController alloc] init];
//        [self.navigationController pushViewController:qr animated:YES];
    }
}

-(void)showReceiveScore:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)changeLuckBean:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showExChangePage:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showBepayExchangePage:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showBeReceiveExchangePage:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showBeRecommendExchangePage:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showLuckyRecorderPage:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showLuckyRecorderLotteryPage:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showLuckyRecorderReceivePage:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}

-(void)showLevelDesc:(id)sender{
    BOOL isLogin = [self detactIfLogin];
    if (isLogin) {
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table view data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (ifShowNewGift) {
        if (ifBeShop&&ifShareForPt&&ifRequest) {
            return 5+4;
        }else if(!ifBeShop&&!ifShareForPt&&!ifRequest){
            return 5+1;
        }else if((!ifBeShop&&ifShareForPt&&ifRequest)||(ifBeShop &&!ifShareForPt&&ifRequest)||(ifBeShop&&ifShareForPt&&!ifRequest)){
            return 5+3;
        }else if((!ifBeShop&&!ifShareForPt&&ifRequest)||(!ifBeShop&&ifShareForPt&&!ifRequest)||(ifBeShop&&!ifShareForPt&&!ifRequest)){
            return 5+2;
        }else{
            return 0;
        }
    }else{
        if (ifBeShop&&ifShareForPt&&ifRequest) {
            return 5+3;
        }else if(!ifBeShop&&!ifShareForPt&&!ifRequest){
            return 5;
        }else if((!ifBeShop&&ifShareForPt&&ifRequest)||(ifBeShop&&!ifShareForPt&&ifRequest)||(ifBeShop&&ifShareForPt&&!ifRequest)){
            return 5+2;
        }else if((!ifBeShop&&!ifShareForPt&&ifRequest)||(!ifBeShop&&ifShareForPt&&!ifRequest)||(ifBeShop&&!ifShareForPt&&!ifRequest)){
            return 5+1;
        }
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            CulihuiTopCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"tpCell%ld",(long)indexPath.row]];
            if (nil == cell) {
                cell = [[CulihuiTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"tpCell%ld",(long)indexPath.row]];
            }else{
                if (cell.bg) {
                    [cell.bg removeFromSuperview];
                }
                if (cell.btnMsg) {
                    [cell.btnMsg removeFromSuperview];
                }
                if (cell.btnSetting) {
                    [cell.btnSetting removeFromSuperview];
                }
                if (cell.btnQrCode) {
                    [cell.btnQrCode removeFromSuperview];
                }
                if (cell.imgPhoto) {
                    [cell.imgPhoto removeFromSuperview];
                }
                if (cell.btnName) {
                    [cell.btnName removeFromSuperview];
                }
                if (cell.btnLevel) {
                    [cell.btnLevel removeFromSuperview];
                }
                if (cell.receiveScore) {
                    [cell.receiveScore removeFromSuperview];
                }
                if (cell.line) {
                    [cell.line removeFromSuperview];
                }
                if (cell.changeLuckBean) {
                    [cell.changeLuckBean removeFromSuperview];
                }
                if (cell.bottom) {
                    [cell.bottom removeFromSuperview];
                }
                if (cell.btnLogin) {
                    [cell.btnLogin removeFromSuperview];
                }
                if (cell.lblHave) {
                    [cell.lblHave removeFromSuperview];
                }
                if (cell.lblScoreCount) {
                    [cell.lblScoreCount removeFromSuperview];
                }
                if (cell.lblScoreTitle) {
                    [cell.lblScoreTitle removeFromSuperview];
                }
                if (cell.lblHave1) {
                    [cell.lblHave1 removeFromSuperview];
                }
                if (cell.lblBeanCount) {
                    [cell.lblBeanCount removeFromSuperview];
                }
                if (cell.lblBeanTitle) {
                    [cell.lblBeanTitle removeFromSuperview];
                }
                if (cell.btnPhoto) {
                    [cell.btnPhoto removeFromSuperview];
                }
                if (cell.tipScore) {
                    [cell.tipScore removeFromSuperview];
                }
            }
            float offy = 20;
            cell.bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 120)];
            [cell.bg setImage:[UIImage imageNamed:@"center_top"]]; 
            [cell addSubview:cell.bg];
            
            cell.btnMsg = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-55, 5+offy, 60, 50)];
            [cell.btnMsg setImage:[UIImage imageNamed:@"btn_msg"] forState:UIControlStateNormal];
            [cell.btnMsg addTarget:self action:@selector(showMsg:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnMsg];
            
            cell.btnSetting = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-50-50, 5+offy, 65, 50)];
            [cell.btnSetting setImage:[UIImage imageNamed:@"btn_st"] forState:UIControlStateNormal];
            [cell.btnSetting addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnSetting];
            
            cell.btnQrCode = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-55, 100-45+offy, 60, 50)];
            [cell.btnQrCode setImage:[UIImage imageNamed:@"btn_qrCode"] forState:UIControlStateNormal];
            [cell.btnQrCode addTarget:self action:@selector(showQrCode:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnQrCode];
            
            cell.imgPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50+offy, 70, 70)];
            [cell.imgPhoto setImage:[UIImage imageNamed:@"mine_photo"]];
            
            [cell.imgPhoto.layer setMasksToBounds:YES];
            [cell.imgPhoto.layer setCornerRadius:35];
            [cell addSubview:cell.imgPhoto];
            
            cell.btnPhoto = [[UIButton alloc] initWithFrame:CGRectMake(20, 50+offy, 70, 70)];
            [cell.btnPhoto addTarget:self action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnPhoto setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:cell.btnPhoto];
            
            float width = 0;
            
            NSString * intro;
            
            intro = @"测试用户";
            
            UILabel * lblReview = [[UILabel alloc] init
                                   ];
            // 设置Label的字体 HelveticaNeue  Courier
            UIFont *fnt = [UIFont fontWithName:TEXT_FONT_NAME size:12];
            lblReview.font = fnt;
            // 根据字体得到NSString的尺寸
            lblReview.text = intro;
            CGSize size = [lblReview.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
            // 名字的H
            lblReview.lineBreakMode = NSLineBreakByCharWrapping;
            // 名字的W
            CGFloat nameW = size.width;
            
            if (nameW>=(UI_SCREEN_WIDTH-20-60-100-5)) {
                width = UI_SCREEN_WIDTH-20-60-100-5;
            }else{
                width = nameW;
            }
            
            cell.btnName = [[UIButton alloc] initWithFrame:CGRectMake(100, 70+offy, nameW, 20)];
            [cell.btnName.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnName addTarget:self action:@selector(modifyUserName:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnName setTitle:intro forState:UIControlStateNormal];
            [cell addSubview:cell.btnName];
            
            cell.btnLevel = [[UIButton alloc] initWithFrame:CGRectMake(nameW+100+5, 70+4+offy, 12, 12)];
            [cell.btnLevel setImage:[UIImage imageNamed:[NSString stringWithFormat:@"memberLevel_%@",@"1"]] forState:UIControlStateNormal];
            [cell.btnLevel addTarget:self action:@selector(showLevelDesc:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnLevel];
            
            cell.btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(100, 70+offy, 80, 20)];
            [cell.btnLogin setTitle:@"登录/注册" forState:UIControlStateNormal];
            [cell.btnLogin addTarget:self action:@selector(showLogin:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnLogin setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [cell.btnLogin.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
            [cell addSubview:cell.btnLogin];
            
//            NSString * userid = [ud objectForKey:UserAccountId];
//            //userid不存在 未登录状态 userid存在 已登录
//            if (![ud objectForKey:UserAccountId]||[userid isEqualToString:@""]) {
//                [cell.btnName setHidden:YES];
//                [cell.btnLevel setHidden:YES];
//                [cell.btnLogin setHidden:NO];
//            }else{
                [cell.btnName setHidden:NO];
                [cell.btnLevel setHidden:NO];
                [cell.btnLogin setHidden:YES];
//            }
            
            float w = 0;
            if (iPhone4s||iPhone5) {
                w = 64;
            }else if(iPhone6){
                w = 90;
            }else if(iPhone6p){
                w = 114;
            }else{
                w = 114;
            }
            
            cell.lblScoreCount = [[UILabel alloc] initWithFrame:CGRectMake(90-4, 99+offy, w+40+8, 24)];
            NSString * title = [NSString stringWithFormat:@"现有 %@ 积分",scoreNum];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:title];
            [cell.lblScoreCount setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell.lblScoreCount setTextAlignment:NSTextAlignmentCenter];
            [cell.lblScoreCount setTextColor:[UIColor grayColor]];
            NSRange range = [title rangeOfString:scoreNum];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:RGBACOLOR(255, 148, 0, 1)
                                  range:NSMakeRange(range.location, range.length)];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:TEXT_FONT_NAME size:14] range:NSMakeRange(range.location, range.length)];
            
            cell.lblScoreCount.attributedText = AttributedStr;
            
            [cell addSubview:cell.lblScoreCount];
            
            cell.receiveScore = [[UIButton alloc] initWithFrame:CGRectMake(90+((UI_SCREEN_WIDTH-90)/2-60)/2-1, 122+offy, 60, 20)];
            [cell.receiveScore setTitle:@"领取积分" forState:UIControlStateNormal];
            [cell.receiveScore.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.receiveScore.layer setMasksToBounds:YES];
            [cell.receiveScore.layer setCornerRadius:10];
            [cell.receiveScore.layer setBorderWidth:.5];
            [cell.receiveScore.layer setBorderColor:[UIColor grayColor].CGColor];
            [cell.receiveScore addTarget:self action:@selector(showReceiveScore:) forControlEvents:UIControlEventTouchUpInside];
            [cell.receiveScore setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.receiveScore setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [cell addSubview:cell.receiveScore];
            
            cell.tipScore = [[UIImageView alloc] initWithFrame:CGRectMake(90+((UI_SCREEN_WIDTH-90)/2-60)/2-1+56, 122+offy, 4, 4)];
            [cell.tipScore.layer setMasksToBounds:YES];
            [cell.tipScore.layer setCornerRadius:2];
            [cell.tipScore setBackgroundColor:[UIColor redColor]];
            [cell addSubview:cell.tipScore];
            
            if (ifReceivePoint) {
                [cell.tipScore setHidden:NO];
            }else{
                [cell.tipScore setHidden:YES];
            }
            
            cell.line = [[UIView alloc] initWithFrame:CGRectMake(90-1+(UI_SCREEN_WIDTH-90)/2-5, 100+5+offy, 1, 40)];
            [cell.line setBackgroundColor:[UIColor lightGrayColor]];
            [cell.line setAlpha:.5];
            [cell addSubview:cell.line];
            
            float w1 = 0;
            if (iPhone4s||iPhone5) {
                w1 = 64;
            }else if(iPhone6){
                w1 = 90;
            }else if(iPhone6p){
                w1 = 114;
            }else{
                w1 = 114;
            }
            
            cell.lblBeanCount = [[UILabel alloc] initWithFrame:CGRectMake(90+(UI_SCREEN_WIDTH-90)/2-4, 99+offy, 50+w1+4, 24)];
            NSString * titleB = [NSString stringWithFormat:@"现有 %@ 幸运豆",beanNum];
            NSMutableAttributedString *AttributedStrB = [[NSMutableAttributedString alloc]initWithString:titleB];
            [cell.lblBeanCount setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell.lblBeanCount setTextAlignment:NSTextAlignmentCenter];
            [cell.lblBeanCount setTextColor:[UIColor grayColor]];
            NSRange rangeB = [titleB rangeOfString:beanNum];
            
            [AttributedStrB addAttribute:NSForegroundColorAttributeName
                                  value:RGBACOLOR(255, 148, 0, 1)
                                  range:NSMakeRange(rangeB.location, rangeB.length)];
            [AttributedStrB addAttribute:NSFontAttributeName value:[UIFont fontWithName:TEXT_FONT_NAME size:14] range:NSMakeRange(rangeB.location, rangeB.length)];
            
            cell.lblBeanCount.attributedText = AttributedStrB;
            [cell addSubview:cell.lblBeanCount];
            
            cell.changeLuckBean = [[UIButton alloc] initWithFrame:CGRectMake(90+(UI_SCREEN_WIDTH-90)/2+((UI_SCREEN_WIDTH-90)/2-60)/2, 120+2+offy, 60, 20)];
            [cell.changeLuckBean setTitle:@"换幸运豆" forState:UIControlStateNormal];
            [cell.changeLuckBean.titleLabel setFont:fnt];
            [cell.changeLuckBean.layer setMasksToBounds:YES];
            [cell.changeLuckBean.layer setCornerRadius:10];
            [cell.changeLuckBean.layer setBorderWidth:.5];
            [cell.changeLuckBean.layer setBorderColor:[UIColor grayColor].CGColor];
            [cell.changeLuckBean addTarget:self action:@selector(changeLuckBean:) forControlEvents:UIControlEventTouchUpInside];
            [cell.changeLuckBean setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.changeLuckBean setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [cell addSubview:cell.changeLuckBean];
            
            cell.bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 150+offy, tableView.frame.size.width, 10)];
            [cell.bottom setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
            [cell addSubview:cell.bottom];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

        }
            break;
        case 1:
        {
            CulihuiChangeCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cgCell%ld",(long)indexPath.row]];
            if (nil == cell) {
                cell = [[CulihuiChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cgCell%ld",(long)indexPath.row]];
            }else{
                if (cell.imgIcon) {
                    [cell.imgIcon removeFromSuperview];
                }
                if (cell.lblTitle) {
                    [cell.lblTitle removeFromSuperview];
                }
                if (cell.btnAll) {
                    [cell.btnAll removeFromSuperview];
                }
                if (cell.line) {
                    [cell.line removeFromSuperview];
                }
                if (cell.btnPay) {
                    [cell.btnPay removeFromSuperview];
                }
                if (cell.btnReceive) {
                    [cell.btnReceive removeFromSuperview];
                }
                if (cell.btnRecment) {
                    [cell.btnRecment removeFromSuperview];
                }
                if (cell.tipNoPay) {
                    [cell.tipNoPay removeFromSuperview];
                }
                if (cell.lblTipNoPay) {
                    [cell.lblTipNoPay removeFromSuperview];
                }
                if (cell.tipNoReceive) {
                    [cell.tipNoReceive removeFromSuperview];
                }
                if (cell.lblTipNoReceive) {
                    [cell.lblTipNoReceive removeFromSuperview];
                }
                if (cell.tipNoRecommend) {
                    [cell.tipNoRecommend removeFromSuperview];
                }
                if (cell.lblTipNoRecommend) {
                    [cell.lblTipNoRecommend removeFromSuperview];
                } 
            }
            cell.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
            [cell.imgIcon setImage:[UIImage imageNamed:@"mine_change"]];
            [cell addSubview:cell.imgIcon];
            
            cell.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 100, 20)];
            [cell.lblTitle setText:@"我的兑换"];
            [cell.lblTitle setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
            [cell.lblTitle setTextColor:[UIColor blackColor]];
            [cell addSubview:cell.lblTitle];
            
            cell.btnAll = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-80, 10, 80, 20)];
            [cell.btnAll setTitle:@"全部兑换" forState:UIControlStateNormal];
            [cell.btnAll setImage:[UIImage imageNamed:@"btn_right"] forState:UIControlStateNormal];
            [cell.btnAll.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnAll setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.btnAll setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
            [cell.btnAll setImageEdgeInsets:UIEdgeInsetsMake(2, 58, 0, 0)];
            [cell.btnAll addTarget:self action:@selector(showExChangePage:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnAll setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            
            [cell addSubview:cell.btnAll];
            
            cell.line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 1)];
            [cell.line setBackgroundColor:[UIColor lightGrayColor]];
            [cell addSubview:cell.line];
            
            cell.btnPay = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, (UI_SCREEN_WIDTH-45)/3, 40)];
            [cell.btnPay setImage:[UIImage imageNamed:@"mine_pay"] forState:UIControlStateNormal];
            [cell.btnPay setTitle:@"待付款" forState:UIControlStateNormal];
            [cell.btnPay setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.btnPay setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [cell.btnPay.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnPay setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            [cell.btnPay setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            [cell.btnPay addTarget:self action:@selector(showBepayExchangePage:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnPay];
            
            NSString * noPay = [self returnStringFormatData:orderDic key:@"pendingPayment"];
            
            float tipOffx = 0;
            
            if(iPhone4s){
                tipOffx = 34;
            }else if(iPhone5){
                tipOffx = 34;
            }else if(iPhone6){
                tipOffx = 40;
            }else if(iPhone6p){
                tipOffx = 46;
            }else{
                tipOffx = 46;
            }
            
            cell.tipNoPay = [[UIImageView alloc] initWithFrame:CGRectMake(15+tipOffx, 50, 16, 16)];
            [cell.tipNoPay setImage:[UIImage imageNamed:@"no_read_tip"]];
            [cell addSubview:cell.tipNoPay];
            
            cell.lblTipNoPay = [[UILabel alloc] initWithFrame:CGRectMake(15+tipOffx+1, 50+1, 14, 14)];
            [cell.lblTipNoPay setText:noPay];
            [cell.lblTipNoPay.layer setMasksToBounds:YES];
            [cell.lblTipNoPay.layer setCornerRadius:7];
            [cell.lblTipNoPay setTextColor:[UIColor redColor]];
            [cell.lblTipNoPay setBackgroundColor:[UIColor whiteColor]];
            [cell.lblTipNoPay setTextAlignment:NSTextAlignmentCenter];
            [cell.lblTipNoPay setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell addSubview:cell.lblTipNoPay];
            
            if (!noPay||[noPay isEqualToString:@""]||[noPay isEqualToString:@"0"]) {
                [cell.tipNoPay setHidden:YES];
                [cell.lblTipNoPay setHidden:YES];
            }
            
            cell.btnReceive = [[UIButton alloc] initWithFrame:CGRectMake(20+(UI_SCREEN_WIDTH-45)/3, 45, (UI_SCREEN_WIDTH-45)/3, 40)];
            [cell.btnReceive setImage:[UIImage imageNamed:@"mine_receive"] forState:UIControlStateNormal];
            [cell.btnReceive setTitle:@"待收货" forState:UIControlStateNormal];
            [cell.btnReceive setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.btnReceive setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [cell.btnReceive.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnReceive setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            [cell.btnReceive setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            [cell.btnReceive addTarget:self action:@selector(showBeReceiveExchangePage:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnReceive];
            
            NSString * noReceive = [self returnStringFormatData:orderDic key:@"afterReceiving"];
            
            cell.tipNoReceive = [[UIImageView alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3+tipOffx, 50, 16, 16)];
            [cell.tipNoReceive setImage:[UIImage imageNamed:@"no_read_tip"]];
            [cell addSubview:cell.tipNoReceive];
            
            cell.lblTipNoReceive = [[UILabel alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3+tipOffx+1, 50+1, 14, 14)];
            [cell.lblTipNoReceive setText:noReceive];
            [cell.lblTipNoReceive.layer setMasksToBounds:YES];
            [cell.lblTipNoReceive.layer setCornerRadius:7];
            [cell.lblTipNoReceive setTextColor:[UIColor redColor]];
            [cell.lblTipNoReceive setBackgroundColor:[UIColor whiteColor]];
            [cell.lblTipNoReceive setTextAlignment:NSTextAlignmentCenter];
            [cell.lblTipNoReceive setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell addSubview:cell.lblTipNoReceive];
            
            if (!noReceive||[noReceive isEqualToString:@""]||[noReceive isEqualToString:@"0"]) {
                [cell.tipNoReceive setHidden:YES];
                [cell.lblTipNoReceive setHidden:YES];
            }
            
            cell.btnRecment = [[UIButton alloc] initWithFrame:CGRectMake(20+(UI_SCREEN_WIDTH-45)/3*2, 45, (UI_SCREEN_WIDTH-45)/3, 40)];
            [cell.btnRecment setImage:[UIImage imageNamed:@"mine_recomend"] forState:UIControlStateNormal];
            [cell.btnRecment setTitle:@"待评价" forState:UIControlStateNormal];
            [cell.btnRecment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.btnRecment setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [cell.btnRecment.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnRecment setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            [cell.btnRecment setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            [cell.btnRecment addTarget:self action:@selector(showBeRecommendExchangePage:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnRecment];
            
            NSString * noRecommend = [self returnStringFormatData:orderDic key:@"toEvaluate"];
            
            cell.tipNoRecommend = [[UIImageView alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3*2+tipOffx, 50, 16, 16)];
            [cell.tipNoRecommend setImage:[UIImage imageNamed:@"no_read_tip"]];
            [cell addSubview:cell.tipNoRecommend];
            
            cell.lblTipNoRecommend = [[UILabel alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3*2+tipOffx+1, 50+1, 14, 14)];
            [cell.lblTipNoRecommend setText:noRecommend];
            [cell.lblTipNoRecommend.layer setMasksToBounds:YES];
            [cell.lblTipNoRecommend.layer setCornerRadius:7];
            [cell.lblTipNoRecommend setTextColor:[UIColor redColor]];
            [cell.lblTipNoRecommend setBackgroundColor:[UIColor whiteColor]];
            [cell.lblTipNoRecommend setTextAlignment:NSTextAlignmentCenter];
            [cell.lblTipNoRecommend setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell addSubview:cell.lblTipNoRecommend];

            if (!noRecommend||[noRecommend isEqualToString:@""]||[noRecommend isEqualToString:@"0"]) {
                [cell.tipNoRecommend setHidden:YES];
                [cell.lblTipNoRecommend setHidden:YES];
            }
            
            cell.bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 90, tableView.frame.size.width, 10)];
            [cell.bottom setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
            [cell addSubview:cell.bottom];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
            break;
        case 2:
        {
            CulihuiLuckyCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"luckyCell%ld",(long)indexPath.row]];
            if (nil == cell) {
                cell = [[CulihuiLuckyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"luckyCell%ld",(long)indexPath.row]];
            }else{
                if (cell.imgIcon) {
                    [cell.imgIcon removeFromSuperview];
                }
                if (cell.lblTitle) {
                    [cell.lblTitle removeFromSuperview];
                }
                if (cell.btnAll) {
                    [cell.btnAll removeFromSuperview];
                }
                if (cell.line) {
                    [cell.line removeFromSuperview];
                }
                if (cell.btnPay) {
                    [cell.btnPay removeFromSuperview];
                }
                if (cell.btnReceive) {
                    [cell.btnReceive removeFromSuperview];
                }
                if (cell.btnRecment) {
                    [cell.btnRecment removeFromSuperview];
                }
                if (cell.bottom) {
                    [cell.bottom removeFromSuperview];
                }
                if (cell.tipAllRecord) {
                    [cell.tipAllRecord removeFromSuperview];
                }
                if (cell.lblTipAllRecord) {
                    [cell.lblTipAllRecord removeFromSuperview];
                }
                if (cell.tipLottery) {
                    [cell.tipLottery removeFromSuperview];
                }
                if (cell.lblTipLottery) {
                    [cell.lblTipLottery removeFromSuperview];
                }
                if (cell.tipReward) {
                    [cell.tipReward removeFromSuperview];
                }
                if (cell.lblTipReward) {
                    [cell.lblTipReward removeFromSuperview];
                }
            }
            cell.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
            [cell.imgIcon setImage:[UIImage imageNamed:@"mine_lucky"]];
            [cell addSubview:cell.imgIcon];
            
            cell.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 100, 20)];
            [cell.lblTitle setText:@"幸运记录"];
            [cell.lblTitle setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
            [cell.lblTitle setTextColor:[UIColor blackColor]];
            [cell addSubview:cell.lblTitle];
            
            cell.btnAll = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-80, 10, 80, 20)];
            [cell.btnAll setImage:[UIImage imageNamed:@"btn_right"] forState:UIControlStateNormal];
            [cell.btnAll setImageEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
            [cell addSubview:cell.btnAll];
            
            cell.line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 1)];
            [cell.line setBackgroundColor:[UIColor lightGrayColor]];
            [cell addSubview:cell.line];
            
            cell.btnPay = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, (UI_SCREEN_WIDTH-45)/3, 40)];
            [cell.btnPay setImage:[UIImage imageNamed:@"mine_recorder_all"] forState:UIControlStateNormal];
            [cell.btnPay setTitle:@"全部记录" forState:UIControlStateNormal];
            [cell.btnPay setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.btnPay setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [cell.btnPay.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnPay setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [cell.btnPay setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -14)];
            [cell.btnPay addTarget:self action:@selector(showLuckyRecorderPage:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnPay];
            
            NSString * allRecorder = [self returnStringFormatData:orderDic key:@"luckyAll"];
            
            float tipOffx = 0;
            
            if(iPhone4s){
                tipOffx = 34;
            }else if(iPhone5){
                tipOffx = 34;
            }else if(iPhone6){
                tipOffx = 40;
            }else if(iPhone6p){
                tipOffx = 46;
            }else{
                tipOffx = 46;
            }
            
            
            cell.tipAllRecord = [[UIImageView alloc] initWithFrame:CGRectMake(15+tipOffx, 50, 16, 16)];
            [cell.tipAllRecord setImage:[UIImage imageNamed:@"no_read_tip"]];
            [cell addSubview:cell.tipAllRecord];
            
            cell.lblTipAllRecord = [[UILabel alloc] initWithFrame:CGRectMake(15+tipOffx+1, 50+1, 14, 14)];
            [cell.lblTipAllRecord setText:allRecorder];
            [cell.lblTipAllRecord.layer setMasksToBounds:YES];
            [cell.lblTipAllRecord.layer setCornerRadius:7];
            [cell.lblTipAllRecord setTextColor:[UIColor redColor]];
            [cell.lblTipAllRecord setBackgroundColor:[UIColor whiteColor]];
            [cell.lblTipAllRecord setTextAlignment:NSTextAlignmentCenter];
            [cell.lblTipAllRecord setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell addSubview:cell.lblTipAllRecord];
            
            [cell.tipAllRecord setHidden:YES];
            [cell.lblTipAllRecord setHidden:YES];
            
            cell.btnReceive = [[UIButton alloc] initWithFrame:CGRectMake(20+(UI_SCREEN_WIDTH-45)/3, 45, (UI_SCREEN_WIDTH-45)/3, 40)];
            [cell.btnReceive setImage:[UIImage imageNamed:@"mine_recorder_lottery"] forState:UIControlStateNormal];
            [cell.btnReceive setTitle:@"中奖记录" forState:UIControlStateNormal];
            [cell.btnReceive setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.btnReceive setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [cell.btnReceive.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnReceive setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [cell.btnReceive setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -14)];
            [cell.btnReceive addTarget:self action:@selector(showLuckyRecorderLotteryPage:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnReceive];
            
            NSString * beLottery = [self returnStringFormatData:orderDic key:@"luckyzhong"];
            
            cell.tipLottery = [[UIImageView alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3+tipOffx, 50, 16, 16)];
            [cell.tipLottery setImage:[UIImage imageNamed:@"no_read_tip"]];
            [cell addSubview:cell.tipLottery];
            
            cell.lblTipLottery = [[UILabel alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3+tipOffx+1, 50+1, 14, 14)];
            [cell.lblTipLottery setText:beLottery];
            [cell.lblTipLottery.layer setMasksToBounds:YES];
            [cell.lblTipLottery.layer setCornerRadius:7];
            [cell.lblTipLottery setTextColor:[UIColor redColor]];
            [cell.lblTipLottery setBackgroundColor:[UIColor whiteColor]];
            [cell.lblTipLottery setTextAlignment:NSTextAlignmentCenter];
            [cell.lblTipLottery setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell addSubview:cell.lblTipLottery];
            
            if (!beLottery||[beLottery isEqualToString:@""]||[beLottery isEqualToString:@"0"]) {
                [cell.tipLottery setHidden:YES];
                [cell.lblTipLottery setHidden:YES];
            }
            
            cell.btnRecment = [[UIButton alloc] initWithFrame:CGRectMake(20+(UI_SCREEN_WIDTH-45)/3*2, 45, (UI_SCREEN_WIDTH-45)/3, 40)];
            [cell.btnRecment setImage:[UIImage imageNamed:@"mine_recorder_rc"] forState:UIControlStateNormal];
            [cell.btnRecment setTitle:@"领奖记录" forState:UIControlStateNormal];
            [cell.btnRecment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cell.btnRecment setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [cell.btnRecment.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
            [cell.btnRecment setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [cell.btnRecment setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -14)];
            [cell.btnRecment addTarget:self action:@selector(showLuckyRecorderReceivePage:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.btnRecment];
            
            NSString * beReward = [self returnStringFormatData:orderDic key:@"luckyling"];
            
            cell.tipReward = [[UIImageView alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3*2+tipOffx, 50, 16, 16)];
            [cell.tipReward setImage:[UIImage imageNamed:@"no_read_tip"]];
            [cell addSubview:cell.tipReward];
            
            cell.lblTipReward = [[UILabel alloc] initWithFrame:CGRectMake(15+(UI_SCREEN_WIDTH-45)/3*2+tipOffx+1, 50+1, 14, 14)];
            [cell.lblTipReward setText:beReward];
            [cell.lblTipReward.layer setMasksToBounds:YES];
            [cell.lblTipReward.layer setCornerRadius:7];
            [cell.lblTipReward setTextColor:[UIColor redColor]];
            [cell.lblTipReward setBackgroundColor:[UIColor whiteColor]];
            [cell.lblTipReward setTextAlignment:NSTextAlignmentCenter];
            [cell.lblTipReward setFont:[UIFont fontWithName:TEXT_FONT_NAME size:10]];
            [cell addSubview:cell.lblTipReward];
            
            if (!beReward||[beReward isEqualToString:@""]||[beReward isEqualToString:@"0"]) {
                [cell.tipReward setHidden:YES];
                [cell.lblTipReward setHidden:YES];
            }
            
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 90, tableView.frame.size.width, 10)];
            [view setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
            [cell addSubview:view];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
            break;
        case 3:
        {
            if (ifShowNewGift) {
                [idxDic setObject:@"gift" forKey:@"3"];
                return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"gift"];
            }else{
                if (ifShareForPt) {
                    [idxDic setObject:@"score" forKey:@"3"];
                    return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"score"];
                }else{
                    [idxDic setObject:@"record" forKey:@"3"];
                    return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"record"];
                }
            }
        }
            break;
        case 4:
        {
            if (ifShowNewGift) {
                if (ifShareForPt) {
                    [idxDic setObject:@"score" forKey:@"4"];
                    return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"score"];
                }else {
                    [idxDic setObject:@"record" forKey:@"4"];
                    return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"record"];
                }
            }else{
                if (ifShareForPt) {
                    [idxDic setObject:@"record" forKey:@"4"];
                    return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"record"];
                }else{
                    if (ifRequest) {
                        [idxDic setObject:@"promotion" forKey:@"4"];
                        return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"promotion"];
                    }else {
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"4"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else{
                            [idxDic setObject:@"help" forKey:@"4"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }
                }
            }
        }
            break;
        case 5:
        {
            if (ifShowNewGift) {
                if (ifShareForPt) {
                    [idxDic setObject:@"record" forKey:@"5"];
                    return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"record"];
                }else{
                    if (ifRequest) {
                        [idxDic setObject:@"promotion" forKey:@"5"];
                        return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"promotion"];
                    }else {
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"5"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else {
                            [idxDic setObject:@"help" forKey:@"5"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }
                }
            }else{
                if (ifShareForPt) {
                    if (ifRequest) {
                        [idxDic setObject:@"promotion" forKey:@"5"];
                        return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"promotion"];
                    }else{
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"5"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else{
                            [idxDic setObject:@"help" forKey:@"5"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }
                }else{
                    if (ifRequest) {
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"5"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else{
                            [idxDic setObject:@"help" forKey:@"5"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }else{
                        if (ifBeShop) {
                            [idxDic setObject:@"help" forKey:@"5"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }else{
                            // 新手 分享赠积分 推广赠豪礼 成为商家都不存在 那一共就5个 分别是前三项和积分记录和帮助  这项就不会存在并调用了
                        }
                    }
                }
            }
        }
            break;
        case 6:
        {
            if (ifShowNewGift) {
                if (ifShareForPt) {
                    if (ifRequest) {
                        [idxDic setObject:@"promotion" forKey:@"6"];
                        return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"promotion"];
                    }else{
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else{
                            [idxDic setObject:@"help" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }
                }else{
                    if (ifRequest) {
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else{
                            [idxDic setObject:@"help" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }else{
                        if (ifBeShop) {
                            [idxDic setObject:@"help" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }
                }
            }else{
                if (ifShareForPt) {
                    if (ifRequest) {
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else{
                            [idxDic setObject:@"help" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }else{
                        if (ifBeShop) {
                            [idxDic setObject:@"help" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }else{
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }
                    }
                }else{
                    if (ifRequest) {
                        if (ifBeShop) {
                            [idxDic setObject:@"help" forKey:@"6"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }else{
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }
                    }else{
                        if (ifBeShop) {
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }else{
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }
                    }
                }
            }
        }
            break;
        case 7:
        {
            if (ifShowNewGift) {
                if (ifShareForPt) {
                    if (ifRequest) {
                        if (ifBeShop) {
                            [idxDic setObject:@"beShop" forKey:@"7"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"beShop"];
                        }else{
                            [idxDic setObject:@"help" forKey:@"7"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }else {
                        if (ifBeShop) {
                            [idxDic setObject:@"help" forKey:@"7"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }
                    }
                }else{
                    if (ifRequest) {
                        if (ifBeShop) {
                            [idxDic setObject:@"help" forKey:@"7"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }else{
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }
                    }else{
//                        NSLog(@"当前Cell:%ld",indexPath.row);
                    }
                }
            }else{
                if (ifShareForPt) {
                    if (ifRequest) {
                        if (ifBeShop) {
                            [idxDic setObject:@"help" forKey:@"7"];
                            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
                        }else{
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }
                    }else{
//                        NSLog(@"当前Cell:%ld",indexPath.row);
                    }
                }else{
                    if (ifRequest) {
                        if (ifBeShop) {
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }else{
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                        }
                    }else{
//                            NSLog(@"当前Cell:%ld",indexPath.row);
                    }
                }
            }
        }
            break;
        case 8:
        {
            [idxDic setObject:@"help" forKey:@"7"];
            return [self creteaCulihuiLoveCell:tableView row:indexPath.row section:indexPath.section cellName:@"help"];
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            return 180;
        }
            break;
        case 1:
        {
            return 100;
        }
            break;
        case 2:
        {
            return 100;
        }
            break;
        case 3:
        {
            return 42;
        }
            break;
        case 4:
        {
            return 42;
        }
            break;
        case 5:
        {
            return 42;
        }
            break;
        case 6:
        {
            return 42;
        }
            break;
        case 7:
        {
            return 42;
        }
            break;
        case 8:
        {
            return 42;
        }
            break;
        case 9:
        {
            return 42;
        }
            break;
        case 10:
        {
            return 42;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = [idxDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    if (cellName && ![cellName isEqualToString:@""]) {
        if ([cellName isEqualToString:@"gift"]) {
            
        }else if([cellName isEqualToString:@"score"]){
            
        }else if([cellName isEqualToString:@"promotion"]){
            
        }else if([cellName isEqualToString:@"beShop"]){
            
        }else if([cellName isEqualToString:@"help"]){
            
        }else if([cellName isEqualToString:@"record"]){
            
        }
    }
}

-(void)showLogin:(id)sender{
    [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:^{
        
    }];
}

-(CulihuiLoveCell *)creteaCulihuiLoveCell:(UITableView *)tableView row:(long)row section:(long)section cellName:(NSString *)name{
    CulihuiLoveCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"loveCell%ld",section]];
    if (nil != cell) {
        if (cell.lblTitle) {
            [cell.lblTitle removeFromSuperview];
        }
        if (cell.imgIcon) {
            [cell.imgIcon removeFromSuperview];
        }
    }
    
    cell = [[CulihuiLoveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"loveCell%ld",section]];
    cell.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 100, 20)];
    [cell.lblTitle setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [cell.lblTitle setTextColor:[UIColor blackColor]];
    [cell addSubview:cell.lblTitle];
    
    cell.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    [cell addSubview:cell.imgIcon];
    cell.key = name;
    if ([name isEqualToString:@"love"]) {
        [cell.imgIcon setImage:[UIImage imageNamed:@"mine_love"]];
        [cell.lblTitle setText:@"爱心轨迹"];
    }else if ([name isEqualToString:@"gift"]){
        [cell.imgIcon setImage:[UIImage imageNamed:@"mine_new_gift"]];
        [cell.lblTitle setText:xinShouName];
    }else if([name isEqualToString:@"score"]){
        [cell.imgIcon setImage:[UIImage imageNamed:@"mine_share_score"]];
        [cell.lblTitle setText:songJifenName];
    }else if([name isEqualToString:@"promotion"]){
        [cell.imgIcon setImage:[UIImage imageNamed:@"mine_new_gift"]];
        [cell.lblTitle setText:requestPangName];
    }else if([name isEqualToString:@"beShop"]){
        [cell.imgIcon setImage:[UIImage imageNamed:@"mine_beShop"]];
        [cell.lblTitle setText:chengShangjiaName];
    }else if([name isEqualToString:@"help"]){
        [cell.imgIcon setImage:[UIImage imageNamed:@"mine_help"]];
        [cell.lblTitle setText:@"意见反馈"];
    }else if([name isEqualToString:@"record"]){
        [cell.imgIcon setImage:[UIImage imageNamed:@"mine_score"]];
        [cell.lblTitle setText:@"积分记录"];
    }
    
    cell.imgGOArrow = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-30, 12, 20,20)];
    [cell.imgGOArrow setImage:[UIImage imageNamed:@"btn_right"] forState:UIControlStateNormal];
    [cell addSubview:cell.imgGOArrow];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 40, tableView.frame.size.width, 2)];
    [view setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
    [cell addSubview:view];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)changePhoto:(id)sender{
    BOOL isLogin =  [self detactIfLogin];
    if (isLogin) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请选择一寸照片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        alertView.tag = 1;
        alertView.delegate = self;
        [alertView show];
    }
}

#pragma mark alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 2:
        {
            UIImagePickerController *pick = [[UIImagePickerController alloc]init];
            
            pick.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            pick.delegate = self;
            pick.allowsEditing = NO;
            
            pick.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, (NSString*)kUTTypeMovie, nil];
            
            [self presentViewController:pick animated:YES completion:nil];
        }
            break;
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *pick = [[UIImagePickerController alloc]init];
                
                pick.sourceType =  UIImagePickerControllerSourceTypeCamera;
                pick.delegate = self;
                pick.allowsEditing = NO;
                
                pick.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, (NSString*)kUTTypeMovie, nil];
                
                [self presentViewController:pick animated:YES completion:nil];
            }else{
                [self showAlertWithTitle:@"无摄像头"];
            }
            
        }
            break;
        default:
            break;
    }
    
}

#pragma mark ImagePick delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage;
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        [self dismissViewControllerAnimated: YES completion:nil];
        
        NSData *mData = nil;
        mData =UIImageJPEGRepresentation(originalImage, 0.05);
        UIImage *needImage = nil;
        
        needImage = [UIImage imageWithData:mData];
        
//        CGSize size = needImage.size;
//        TODO 注释掉直接截取上传图中部的代码
//        if (size.height>size.width) {
//            needImage = [self clipImageInRect:CGRectMake(0, (size.height-size.width)/2, size.width, size.width) image:needImage];
//        }else{
//            needImage = [self clipImageInRect:CGRectMake(0, (size.width-size.height)/2, size.height, size.height) image:needImage];
//        }
        
        needImage = [self imageWithImageSimple:needImage scaledToSize:CGSizeMake(150, 150)];
        
//        //上传身份证图片
//        CDUploadProductImage *uploadimage = [[CDUploadProductImage alloc] initWithImage:needImage uploadfinish:^(NSString *url){
//            if ([url isEqualToString:@""]||!url) {
//                [self.view makeToast:@"文件上传失败！请重试..." duration:1 position:@"center"
//                               image:nil withTextColor:[UIColor whiteColor] withValue:@""];
//                return ;
//            }
////            上传成功之后的处理
//            NSString * urlString = url;
//            NSString * fullUrl= [NSString stringWithFormat:@"%@",urlString];
//            imgUrl = fullUrl;
//            [self performSelectorOnMainThread:@selector(showUPloadSuccess) withObject:nil waitUntilDone:NO];
//        } uploadcancel:^{
//            
//        }];
    }
}

-(void)showUPloadSuccess{
    [self.view makeToast:@"上传成功" duration:1 position:@"center"
                   image:nil withTextColor:[UIColor whiteColor] withValue:@""];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (UIImage *)clipImageInRect:(CGRect)rect image:(UIImage *)img
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modifyUserName:(id)sender{
    
}

-(BOOL)ifNetWorkEnable{
    return YES;
}
@end
