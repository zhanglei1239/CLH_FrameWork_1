//
//  MainViewController.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "HomePageViewController.h"
#import "SecondPageViewController.h"
#import "ThirdPageViewController.h"
#import "MineViewController.h"
@interface MainViewController : BaseTabBarViewController
{
    HomePageViewController * _home;
    SecondPageViewController * _second;
    ThirdPageViewController * _third;
    MineViewController * _mine;
}
@end
