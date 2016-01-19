//
//  LoginViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#define iconCenterY 100
#import "LoginViewController.h"
#import "RetrivePasswordViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.topView setBackgroundColor:[UIColor clearColor]];
    
    content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    [content setBackgroundColor:[UIColor blackColor]];
    [content setContentSize:CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    content.bounces = NO;
    [self.view addSubview:content];
    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    [bg setImage:[UIImage imageNamed:@"bg@2x.jpg"]];
    [content addSubview:bg];
    
    [self.view bringSubviewToFront:self.btnBack];
    
    // Do any additional setup after loading the view.
    self.appIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.appIcon setImage:[UIImage imageNamed:@"120"]];
    self.appIcon.center = CGPointMake(UI_SCREEN_WIDTH/2, iconCenterY);
    [content addSubview:self.appIcon];
    
    self.apIv = [[AccountAndPasswordInputView alloc] initWithFrame:CGRectMake(20, UI_SCREEN_HEIGHT-140-10-200, UI_SCREEN_WIDTH-40, 200)];
    self.apIv.delegate = self;
    self.apIv.utfUserAccount.delegate = self;
    self.apIv.utfPassword.delegate = self;
    [content addSubview:self.apIv];
    
    self.lbTv = [[LoginByThirdView alloc] initWithFrame:CGRectMake(20, UI_SCREEN_HEIGHT-140, UI_SCREEN_WIDTH-40, 120)];
    self.lbTv.delegate = self;
    [content addSubview:self.lbTv];
    
    [content addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)tapHide{
    if (self.hidden == NO) {
        [self keyboardWillHide:nil];
        if ([self.apIv.utfUserAccount isFirstResponder]) {
            [self.apIv.utfUserAccount resignFirstResponder];
        }
        if ([self.apIv.utfPassword isFirstResponder]) {
            [self.apIv.utfPassword resignFirstResponder];
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notif {
    if (self.hidden == NO) {
        return;
    }
    self.hidden = NO;
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    [UIView animateWithDuration:.2 animations:^{
        CGFloat maxY = CGRectGetMaxY(self.view.frame);
        [content setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-maxY+y)];
    }];
}

- (void)keyboardShow:(NSNotification *)notif {
    
}

- (void)keyboardWillHide:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
    self.hidden = YES;
    [UIView animateWithDuration:.2 animations:^{
        [content setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }];
}

- (void)keyboardHide:(NSNotification *)notif {
    
}

- (void)keyboardChange:(NSNotification *)notif{
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    [UIView animateWithDuration:.2 animations:^{
        CGFloat maxY = CGRectGetMaxY(self.view.frame);
        [content setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-maxY+y)];
    }];
}


#pragma mark -- AccountAndPasswordLoginDelegate

-(void)accountLoginDelegate:(AccountAndPasswordInputView*)view{
    if ([view.utfUserAccount isFirstResponder]) {
        [view.utfUserAccount resignFirstResponder];
    }else if([view.utfPassword isFirstResponder]){
        [view.utfPassword resignFirstResponder];
    }
    NSLog(@"accountLoginDelegate");
}

-(void)accountForgetDelegate:(AccountAndPasswordInputView*)view{
    if ([view.utfUserAccount isFirstResponder]) {
        [view.utfUserAccount resignFirstResponder];
    }else if([view.utfPassword isFirstResponder]){
        [view.utfPassword resignFirstResponder];
    }
    NSLog(@"accountForgetDelegate");
    [self.navigationController pushViewController:[[RetrivePasswordViewController alloc] init] animated:YES];
}

-(void)accountRegistDelegate:(AccountAndPasswordInputView*)view{
    if ([view.utfUserAccount isFirstResponder]) {
        [view.utfUserAccount resignFirstResponder];
    }else if([view.utfPassword isFirstResponder]){
        [view.utfPassword resignFirstResponder];
    }
    NSLog(@"accountRegistDelegate");
}

#pragma mark -- loginByThirdDelegate
-(void)loginByQQ:(LoginByThirdView *)view{
    NSLog(@"loginByQQ");
}

-(void)loginByWeixin:(LoginByThirdView *)view{
    NSLog(@"loginByWeixin");
}

-(void)loginByWeibo:(LoginByThirdView *)view{
    NSLog(@"loginByWeibo");
}


#pragma mark -- UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"shouldChangeCharactersInRange");
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    NSLog(@"%f",UI_DeviceSystemVersion);
    if (UI_DeviceSystemVersion>=9.0) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}
@end
