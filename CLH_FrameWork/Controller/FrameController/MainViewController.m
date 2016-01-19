//
//  MainViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MainViewController.h"
#import "LoadingPageViewController.h"
#import "LocateButton.h"
enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5
}; typedef NSUInteger UIDeviceResolution;

@interface MainViewController ()
{
    UINavigationBar *navigationBar;
    UIView * topView;
    UILabel * lblTitle; 
    UIBarButtonItem * _menu; 
    
    UIImageView * redDot;
    
    NSTimer * delegateTimer;
}
@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    }
    
    [self setupSubviews];
    self.selectedIndex = 0;
    
    float x = 0;
    float y = 0;
    float w = 0;
    if (iPhone4s) {
        x  = 210;
        y = UI_SCREEN_HEIGHT-46;
        w = 6;
    }else if(iPhone5){
        x  = 210;
        y = UI_SCREEN_HEIGHT-46;
        w = 6;
    }else if(iPhone6){
        x  = 244;
        y = UI_SCREEN_HEIGHT-46;
        w = 6;
    }else if(iPhone6p){
        x  = 270;
        y = UI_SCREEN_HEIGHT-46;
        w = 6;
    }else {
        x  = 210;
        y = UI_SCREEN_HEIGHT-46;
        w = 6;
    }
    
    redDot = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, w)];
    [redDot setBackgroundColor:[UIColor redColor]];
    [redDot.layer setMasksToBounds:YES];
    [redDot.layer setCornerRadius:4];
    [self.view addSubview:redDot];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideRedDot:) name:HideRedDot object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRedDot:) name:ShowRedDot object:nil];
    
//    //定义locationService;
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registNotifyRefresh:) name:kNotifyLocationRefresh object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(degistNotifyRefresh:) name:kNotifyLocationRefreshShut object:nil];
    
}
//
//-(void)hideRedDot:(id)sender{
//    //隐藏红点
//    redDot.hidden = YES;
//}
//
//-(void)showRedDot:(NSNotification *)noti{
//    //接受推送显示红点
//    redDot.hidden = NO;
//}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:@"firstLoad"]) {
        LoadingPageViewController * controller= [[LoadingPageViewController alloc] init];
        [self presentViewController:controller animated:NO completion:^{
            
        }];
    }
}


- (void)setupSubviews
{
    self.tabBar.backgroundColor = [UIColor whiteColor];
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, .5)];
    [line setAlpha:.6];
    [self.tabBar addSubview:line];
    
    _home = [[HomePageViewController alloc] init];
    UIImage *selectedImg = [UIImage imageNamed:@"bottom_homepage_r"];
    UIImage *unSelectImg = [UIImage imageNamed:@"bottom_homepage_b"];
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        unSelectImg = [unSelectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    _home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:unSelectImg selectedImage:selectedImg];
    [_home.tabBarItem setTag:0];
    
    [self unSelectedTapTabBarItems:_home.tabBarItem];
    [self selectedTapTabBarItems:_home.tabBarItem];
    
    _second = [[SecondPageViewController alloc] init];
    
    selectedImg = [UIImage imageNamed:@"bottom_category_r"];
    unSelectImg = [UIImage imageNamed:@"bottom_category_b"];
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        unSelectImg = [unSelectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    _second.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"第二页" image:unSelectImg selectedImage:selectedImg];
    [_second.tabBarItem setTag:1];
    
    [self unSelectedTapTabBarItems:_second.tabBarItem];
    [self selectedTapTabBarItems:_second.tabBarItem];
    
    _third = [[ThirdPageViewController alloc] init];
    
    selectedImg = [UIImage imageNamed:@"bottom_findnew_r"];
    unSelectImg = [UIImage imageNamed:@"bottom_findnew_b"];
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        unSelectImg = [unSelectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    _third.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"第三页" image:unSelectImg selectedImage:selectedImg];
    [_third.tabBarItem setTag:2];
    
    _third.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self unSelectedTapTabBarItems:_third.tabBarItem];
    [self selectedTapTabBarItems:_third.tabBarItem];
    
    _mine = [[MyPersonCenterViewController alloc] init];
    
    selectedImg = [UIImage imageNamed:@"bottom_myculihui_r"];
    unSelectImg = [UIImage imageNamed:@"bottom_myculihui_b"];
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        unSelectImg = [unSelectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    _mine.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:unSelectImg selectedImage:selectedImg];
    
    [_mine.tabBarItem setTag:3];
    
    _mine.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self unSelectedTapTabBarItems:_mine.tabBarItem];
    [self selectedTapTabBarItems:_mine.tabBarItem];
    
    self.viewControllers = @[_home,_second,_third,_mine];
    [self selectedTapTabBarItems:_home.tabBarItem];
}

-(void)unSelectedBarButtonItems:(UIBarButtonItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:TEXT_FONT_NAME size:12], NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedBarButtonItems:(UIBarButtonItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:TEXT_FONT_NAME size:12],
                                        NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:TEXT_FONT_NAME size:12], NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:TEXT_FONT_NAME size:12],
                                        NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        [self hideCustomNavigationBar];
    }else if (item.tag == 1){
        [self hideCustomNavigationBar];
    }else if (item.tag == 2){
        [self hideCustomNavigationBar];
    }else if (item.tag == 3){
        [self hideCustomNavigationBar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
