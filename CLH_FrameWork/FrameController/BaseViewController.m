//
//  BaseViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BaseViewController.h"
//#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Toast+UIView.h"
@interface BaseViewController ()
{
    
}
@end

@implementation BaseViewController
@synthesize contentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-60)];
    [self.view addSubview:content];
    [content setBackgroundColor:RGBACOLOR(238, 238, 238, 1)];
    
    float offy = 0;
    if (UI_DeviceSystemVersion<7.0) {
        self.topView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
        offy = 0;
    }else{
        self.topView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 60)];
        offy = 20;
    }
    [self.topView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.topView];
    
    self.btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10, offy, 40, 40)];
    [self.btnBack setImage:[UIImage imageNamed:@"top_back_02"] forState:UIControlStateNormal];
    [self.view addSubview:self.btnBack];
    [self.btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    float fontSize = 0;
    if (iPhone4s) {
        fontSize = 16;
    }else if(iPhone5){
        fontSize = 16;
    }else if(iPhone6){
        fontSize = 18;
    }else if(iPhone6p){
        fontSize = 18;
    }else{
        fontSize = 18;
    }
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, offy, UI_SCREEN_WIDTH-80, 40)];
    [self.lblTitle setTextColor:[UIColor blackColor]];
    [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.lblTitle setFont:[UIFont fontWithName:TEXT_FONT_NAME size:fontSize]];
    [self.view addSubview:self.lblTitle];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
//        [self preferredStatusBarStyle];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postNotificationWhenBecameActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHide)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    self.hidden = YES;
}

-(void)postNotificationWhenBecameActive:(id)sender{
    
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
        return NO;
    }
    return YES;
}

-(void)tapHide{
    if (self.hidden == NO) {
        [self keyboardWillHide:nil];
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
        [content setFrame:CGRectMake(0, 60, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-maxY+y-60)];
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
        [content setFrame:CGRectMake(0, 60, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-60)];
    }];
}

- (void)keyboardHide:(NSNotification *)notif {
    
}

- (void)keyboardChange:(NSNotification *)notif{
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    [UIView animateWithDuration:.2 animations:^{
        CGFloat maxY = CGRectGetMaxY(self.view.frame);
        [content setFrame:CGRectMake(0, 60, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-maxY+y-60)];
    }];
}

-(void)hideCustomNavigationBar{
    if (navigationBar) {
        [navigationBar setHidden:YES];
    }
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method

- (void)showAlertWithTitle:(NSString *)title{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (NSDictionary *)fetchedData:(NSString *)string
{
    NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return json;
}

- (NSArray *)getData:(NSString *)string{
    NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return json;
}

- (void)debugService{
    
}

//账号
- (BOOL) validateAccount:(NSString *)account
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{4,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:account];
}

//密码
- (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,10}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//手机号
- (BOOL) validatePhone:(NSString *)phone
{
    NSString *passWordRegex = @"^[1][3458][0-9]{9}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:phone];
}
//邮箱
- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//中文2-4字验证
- (BOOL)validateChinese2_4:(NSString *)name{
    NSString *emailRegex = @"^[\u4e00-\u9fa5]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:name];
}

//中文姓名判断
- (BOOL)validatePersonName:(NSString *)chinesesName{
    NSString *emailRegex = @"^[\u4e00-\u9fa5]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:chinesesName];
}

//全数字判断
- (BOOL)validateNumber:(NSString *)number{
    NSString *emailRegex = @"^[0-9]*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:number];
}

//银行账号判断
- (BOOL)validateBankNumber:(NSString *)number{
    return [self validateNumber:number];
}

//判断营业执照编号
- (BOOL)validateBusinessLicenseCode:(NSString *)number{
    NSString *emailRegex = @"^[0-9]{15}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:number];
}

//判断企业法人
- (BOOL)validateLegalPerson:(NSString *)name{
    return [self validatePersonName:name];
}

//判断身份证
- (BOOL)validateIdCardNum:(NSString *)idCardNum{
    NSString *passWordRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [identityCardPredicate evaluateWithObject:idCardNum];
}

//判断社保号
- (BOOL)validateSocialSecurityNumber:(NSString *)socialSecurityNumber{
    return [self validateNumber:socialSecurityNumber];
}

//判断驾驶证号
- (BOOL)validateDriverLicenseNumber:(NSString *)driverLicenseNumber{
    return [self validateIdCardNum:driverLicenseNumber];
}

//判断佣金率
- (BOOL)validateCommissionRatio:(NSString *)commissionRatio{
    return [self validateNumber:commissionRatio];
}

//短信验证码
- (BOOL)validateMessagePwd:(NSString *)messagePwd{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:messagePwd];
}

- (BOOL)validateNumberWithSize:(NSString *)number size:(int)size{
    NSString *passWordRegex = [NSString stringWithFormat:@"^[0-9]{1,%d}$",size] ;
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:number];
}

//获取数据字符串
-(NSString *)returnStringFormatData:(NSMutableDictionary *)dic key:(NSString *)key{
    id object = [dic objectForKey:key];
    if (object) {
        return  [NSString stringWithFormat:@"%@",object];
    }
    return @"";
}

-(BOOL)detactIfLogin{
    //TODO 进行是否登录的检测
    return YES;
//    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
//    NSString * userId = [ud objectForKey:UserAccountId];
//    if (![ud objectForKey:UserAccountId]||[userId isEqualToString:@""]) {
//        [self showLogin];
//        return NO;
//    }
//    return YES;
}

-(void)showLogin{
    //TODO 弹出登录框
}



@end
