//
//  BaseViewController.h
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UINavigationBar *navigationBar;
    UIScrollView * content; 
    UIView *notiView;
    NSString *corderCount;
    UITapGestureRecognizer * tap;
}
@property (strong, nonatomic) UILabel * lblTitle;
@property (strong, nonatomic) UIButton * btnBack;
@property (strong, nonatomic) UIView * topView;
@property (strong, nonatomic) UIView *contentView;
@property (nonatomic,assign) BOOL hidden;
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (void)showAlertWithTitle:(NSString *)title; 

-(void)hideCustomNavigationBar;
- (NSDictionary *)fetchedData:(NSString *)string;
- (NSArray *)getData:(NSString *)string; 

-(void)tapHide;
- (void)keyboardWillShow:(NSNotification *)notif;
- (void)keyboardShow:(NSNotification *)notif;
- (void)keyboardWillHide:(NSNotification *)notif;
- (void)keyboardHide:(NSNotification *)notif;
/**
 *  正则验证账号
 *
 *  @param account 输入的账号内容
 *
 *  @return YES 验证通过  NO 验证失败
 */
- (BOOL) validateAccount:(NSString *)account;
/**
 *  正则验证密码
 *
 *  @param passWord 输入的密码内容
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validatePassword:(NSString *)passWord;
/**
 *  正则验证手机号
 *
 *  @param phone 手机号
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validatePhone:(NSString *)phone;
/**
 *  正则验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateEmail:(NSString *)email;
/**
 *  正则验证中文
 *
 *  @param name 输入的中文内容
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateChinese2_4:(NSString *)name;
/**
 *  正则验证中文姓名
 *
 *  @param chinesesName 中文姓名
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validatePersonName:(NSString *)chinesesName;
/**
 *  验证数字
 *
 *  @param number 数字内容
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateNumber:(NSString *)number;
/**
 *  验证银行号
 *
 *  @param number 银行账号
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateBankNumber:(NSString *)number;
/**
 *  验证营业执照
 *
 *  @param number 营业执照号
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateBusinessLicenseCode:(NSString *)number;
/**
 *  验证法人姓名
 *
 *  @param name 法人姓名
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateLegalPerson:(NSString *)name;
/**
 *  验证身份证号
 *
 *  @param idCardNum 身份证号
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateIdCardNum:(NSString *)idCardNum;
/**
 *  验证社保号
 *
 *  @param socialSecurityNumber 社保号
 *
 *  @return YES 验证通过  NO 验证失败
 */
- (BOOL) validateSocialSecurityNumber:(NSString *)socialSecurityNumber;
/**
 *  验证驾驶证号
 *
 *  @param driverLicenseNumber 驾驶证号码
 *
 *  @return YES 验证通过  NO 验证失败
 */
- (BOOL) validateDriverLicenseNumber:(NSString *)driverLicenseNumber;
/**
 *  验证佣金率
 *
 *  @param commissionRatio 佣金率
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateCommissionRatio:(NSString *)commissionRatio;

/**
 *  验证短信验证码
 *
 *  @param messagePwd 短信验证码
 *
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL) validateMessagePwd:(NSString *)messagePwd;

/**
 *  验证数字
 *
 *  @param number 数字
 *  @param size 长度
 *  @return YES 验证通过 NO 验证失败
 */
- (BOOL)validateNumberWithSize:(NSString *)number size:(int)size;
/**
 *  根据字典和字段名称返回满足格式的字符串
 *
 *  @param dic 数据字典
 *  @param key 字段名
 *
 *  @return 结果字符串
 */
-(NSString *)returnStringFormatData:(NSMutableDictionary *)dic key:(NSString *)key;

-(BOOL)detactIfLogin;

-(void)showLogin;

@end
