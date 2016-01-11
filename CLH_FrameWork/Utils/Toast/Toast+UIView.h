//
//  Toast+UIView.h

#import<UIKit/UIKit.h>

@interface UIView (Toast)
// each makeToast method creates a view and displays it as toast
- (void)makeToast:(NSString *)message withValue:(NSString *)value withTextColor:(UIColor *) color;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position withTextColor:(UIColor *) color withValue:(NSString *)value;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title withTextColor:(UIColor *) color withValue:(NSString *)value;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title image:(UIImage *)image withTextColor:(UIColor *) color withValue:(NSString *)value;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image withTextColor:(UIColor *) color withValue:(NSString *)value;

// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(id)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point;

@end