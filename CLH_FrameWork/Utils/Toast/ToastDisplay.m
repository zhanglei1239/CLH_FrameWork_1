//
//  ToastDisplay.m

#import "ToastDisplay.h"
#import <CoreGraphics/CoreGraphics.h>
#import "SynthesizeSingleton.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat CSToastHeight              =20.0;
static const CGFloat CSToastFontSize            =13.0;
static const CGFloat CSToastMaxMessageLines     =0;
static const CGFloat CSToastFadeDuration        =0.2;
static const CGFloat CSToastPosition            =15.0; 

// display duration and position
static const CGFloat CSToastDefaultDuration     =10.0;

@implementation ToastDisplay

SYNTHESIZE_SINGLETON_FOR_CLASS(ToastDisplay)

- (id) init
{
    self = [super init];
    
    if (self) {
        _displays = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) dealloc
{
    
}

#pragma mark -
#pragma mark Public method
#pragma mark -
+ (void)showToast:(NSString *)message withColorType:(int)colorType;
{
    if (message ==nil) {
        return;
    }
    
    [[ToastDisplay sharedToastDisplay] show:[[ToastDisplay sharedToastDisplay] makeViewOfMessage:message withColorType:colorType]];
}

#pragma mark -
#pragma mark Private method
#pragma mark -
- (UILabel *)makeViewOfMessage:(NSString *)msg withColorType:(int)colorType
{
    // 如果还有其他的view正在
    [self reposition];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH,CSToastHeight)];
    
    messageLabel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    
    [_displays addObject:messageLabel];
    
    messageLabel.center =CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/2);
    
    messageLabel.numberOfLines =CSToastMaxMessageLines;
    messageLabel.font = [UIFont systemFontOfSize:CSToastFontSize];
    messageLabel.lineBreakMode =NSLineBreakByWordWrapping;
    if (colorType ==1)
    {
        messageLabel.textColor = [UIColor whiteColor];
    }
    else if (colorType == 2)
    {
        messageLabel.textColor = [UIColor redColor];
    }
    messageLabel.textAlignment =NSTextAlignmentCenter;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.alpha =1.0;
    messageLabel.text = msg;
    
    return messageLabel;
}


- (void)reposition
{
    for (UILabel * t in _displays) {
        [t setFrame:CGRectMake (t.frame.origin.x, (t.frame.origin.y - (CSToastPosition)), t.frame.size.width, t.frame.size.height)];
    }
}

- (void)show:(UILabel *)toast{
    toast.alpha =0.0;
    
    [UIView animateWithDuration:CSToastFadeDuration
                         delay:0.0
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        toast.alpha =1.0;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:CSToastFadeDuration+0.3f
                                             delay:CSToastDefaultDuration
                                           options:UIViewAnimationOptionCurveEaseIn
                                        animations:^{
                                            toast.alpha =0.0;
                                        }completion:^(BOOL finished) {
                                            [_displays removeObject:toast]; //把当前的view在array里面移除
                                            [toast removeFromSuperview];
                                        }];
                    }];
}

@end