//
//  ToastDisplay.h

// 这个class就是直接在屏幕中央打印游戏信息 (内容提示，错误提示）
#import <Foundation/Foundation.h>
@interface ToastDisplay :NSObject
{
    NSMutableArray *_displays;
}

+(ToastDisplay *) sharedToastDisplay;
// 0 = 白色； 1 = 红色
+ (void)showToast:(NSString *)message withColorType:(int)colorType;

@end