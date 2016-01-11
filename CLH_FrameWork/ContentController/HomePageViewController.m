//
//  HomePageViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "HomePageViewController.h"
#import "LocateButton.h"
#import "LocationViewController.h"
#import "QRCodeScanViewController.h"
#import "Toast+UIView.h"
#import "CustomURLCache.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "CaptchaPopView.h"
#import "NetServiceManager.h"
@interface HomePageViewController ()
{
    LocateButton * btnLocate;
    UIImageView * imgSearch;
    UILabel * lblSearch;
    UIImageView * imgScan;
    UIImageView * imgMsg;
    UIButton * btnSearch;
    UIButton * btnScan;
    UIButton * btnMsg;
    
    UIWebView * wView;
    
    CaptchaPopView * captchaPop;
    UIButton * btnCover;
    NSString * token;
}
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lblTitle setHidden:YES];
    [self.btnBack setHidden:YES];
    // Do any additional setup after loading the view.
 
    btnLocate = [[LocateButton alloc] initWithFrame:CGRectMake(5, 20, 60, 40)];
    btnLocate.normalTitle = @"选择城市";
    btnLocate.normalColor = [UIColor whiteColor];
    btnLocate.hilightColor = [UIColor lightGrayColor];
    UIImage * img = [UIImage imageNamed:@"down"];
    btnLocate.selectImg = img;
    btnLocate.normalImg = img;
    [btnLocate update];
    btnLocate.delegate = self;
    [self.topView addSubview:btnLocate];
    
    [self.view removeGestureRecognizer:tap];
    UIImageView * imgBottom;
    if (iPhone4s||iPhone5) {
        imgBottom = [[UIImageView alloc] initWithFrame:CGRectMake(74, 42, 200, 6)];
        [imgBottom setImage:[UIImage imageNamed:@"search_bottom"]];
        [self.view addSubview:imgBottom];
    }else if(iPhone6){
        imgBottom = [[UIImageView alloc] initWithFrame:CGRectMake(74, 42, 255, 8)];
        [imgBottom setImage:[UIImage imageNamed:@"search_bottom"]];
        [self.view addSubview:imgBottom];
    }else {
        imgBottom = [[UIImageView alloc] initWithFrame:CGRectMake(74, 42, 275, 10)];
        [imgBottom setImage:[UIImage imageNamed:@"search_bottom"]];
        [self.view addSubview:imgBottom];
    }
    
    imgSearch = [[UIImageView alloc] initWithFrame:CGRectMake(80, 26, 16, 16)];
    [imgSearch setImage:[UIImage imageNamed:@"img_search"]];
    [self.view addSubview:imgSearch];
    
    lblSearch = [[UILabel alloc]initWithFrame:CGRectMake(100, 26, 100, 16)];
    [lblSearch setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [lblSearch setTextColor:[UIColor lightTextColor]];
    [lblSearch setText:@"搜索宝贝"];
    [self.view addSubview:lblSearch];
    
    imgScan = [[UIImageView alloc] initWithFrame:CGRectMake(imgBottom.frame.origin.x+imgBottom.frame.size.width-16-4, 26, 16, 16)];
    [imgScan setImage:[UIImage imageNamed:@"img_scan"]];
    [self.view addSubview:imgScan];
    
    imgMsg = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-30, 26, 16, 16)];
    [imgMsg setImage:[UIImage imageNamed:@"img_msg"]];
    [self.view addSubview:imgMsg];
    
    btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(imgSearch.frame.origin.x, imgSearch.frame.origin.y, imgBottom.frame.size.width-16-2-12, 16)];
    [btnSearch addTarget:self action:@selector(searchInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
    
    btnScan = [[UIButton alloc] initWithFrame:imgScan.frame];
    [btnScan addTarget:self action:@selector(scanInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnScan];
    
    btnMsg = [[UIButton alloc] initWithFrame:imgMsg.frame];
    [btnMsg addTarget:self action:@selector(showMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMsg];
    
    wView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-60)];
    wView.delegate = self;
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://github.com/"]];
    [wView loadRequest:request];
    [self.view addSubview:wView];
    
    btnCover = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    [self.view addSubview:btnCover];
    btnCover.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * cityName = [ud objectForKey:CurrentSelectCity];
    if (!cityName) {
        [btnLocate setNormalTitle:@"选择城市"];
    }else{
        [btnLocate setNormalTitle:cityName];
    }

    [btnLocate update];
    [btnLocate updateFrame];
}

-(void)searchInfo:(id)sender{
//    NSDictionary * params = @{@"email": @"calvin.xiao@springside.io",@"password" : @"springside"};
//    [[NetServiceManager sharedNetServiceManager] getPath:@"http://123.56.8.122:8080/api/accounts/login?" parameters:params success:^(id responseObject) {
//        NSLog(@"success");
//        NSError * error;
//        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"aaa:%@",data);
//        token = [data objectForKey:@"token"];
//        NSLog(@"token:%@",token);
//    } failure:^(NSError *error) {
//        NSLog(@"failure");
//    }];
}

-(void)scanInfo:(id)sender{
    if (SIMULATOR==1) {
        [self.view makeToast:@"模拟器不支持二维码扫描功能!" duration:1 position:@"center" image:nil withTextColor:[UIColor redColor] withValue:@""];
    }else{
        QRCodeScanViewController * qrcode = [[QRCodeScanViewController alloc] init];
        [self.navigationController pushViewController:qrcode animated:YES];
    }
}

-(void)showMsg:(id)sender{
//    NSDictionary * params = @{@"token": token};
//    [[NetServiceManager sharedNetServiceManager] getPath:@"http://123.56.8.122:8080/api/books/3/request?" parameters:params success:^(id responseObject) {
//        NSLog(@"success");
//        NSError * error;
//        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"aaa:%@",data); 
//    } failure:^(NSError *error) {
//        
//    }];
    [btnCover setHidden:NO];
    captchaPop = [[CaptchaPopView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-8, 100)];
    captchaPop.delegate = self;
    captchaPop.center = CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/2);
    [self.view addSubview:captchaPop];
    [self.view bringSubviewToFront:captchaPop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
}

-(void)touchLocate:(LocateButton *)view{
    LocationViewController * location = [[LocationViewController alloc] init];
    [self presentViewController:location animated:NO completion:^{
        
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
}

-(void)CaptchaPopSuccess:(CaptchaPopView *)cPop{
    [btnCover setHidden:YES];
    [cPop removeFromSuperview];
}

-(void)CaptchaPopCancel:(CaptchaPopView *)cPop{
    [btnCover setHidden:YES];
    [cPop removeFromSuperview];
}
@end
