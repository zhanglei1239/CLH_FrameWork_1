//
//  BaseTabBarViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface BaseTabBarViewController ()
{
    UILabel * lblTitle;
}
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)customNavigationBar:(NSString *)title leftBtn:(UIView *)left rightBtn:(UIView *)right{
    if (!navigationBar) {
        if (UI_DeviceSystemVersion < 7.0) {
            navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
        }else{
            navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 60)];
        }
        [self.view addSubview:navigationBar];
        [self.view bringSubviewToFront:navigationBar];
    }
    navigationBar.tintColor = [UIColor whiteColor];
    [navigationBar setBackgroundColor:[UIColor whiteColor]];
    
    UINavigationItem *barItem = [[UINavigationItem alloc] initWithTitle:self.title];
    if (left) {
        barItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    }
    if(right){
        barItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    }
    
    [navigationBar pushNavigationItem:barItem animated:NO];
    
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, UI_SCREEN_WIDTH, 40)];
    [lblTitle setFont:[UIFont fontWithName:TEXT_FONT_NAME size:18]];
    [lblTitle setTextColor:[UIColor blackColor]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [navigationBar addSubview:lblTitle];
    
    [lblTitle setText:title];
    
}

-(void)hideCustomNavigationBar{
    if (navigationBar) {
        [navigationBar setHidden:YES];
    }
}

-(void)showCustomNavigationBar{
    if (navigationBar) {
        [navigationBar setHidden:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
