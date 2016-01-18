//
//  BaseTabBarViewController.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController<UITabBarControllerDelegate>
{
    UINavigationBar *navigationBar;
}

-(void)customNavigationBar:(NSString *)title leftBtn:(UIView *)left rightBtn:(UIView *)right;
-(void)hideCustomNavigationBar;
-(void)showCustomNavigationBar;
@end
