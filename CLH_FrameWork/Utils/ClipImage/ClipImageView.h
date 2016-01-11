//
//  ClipImageView.h
//  SliderGuideDemo
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClipImageView : UIImageView
{
    UIImageView * topImage;
    UIImageView * bottomImage;
    float SWidth;
    float SHeight;
}
@property (nonatomic,assign) id delegate;
/**
 *  添加ClipImage到superView上
 *
 *  @param view            targetView
 *  @param image           要添加的Image
 *  @param backgroundImage 背景Image
 */
- (void)clipImage:(UIImage *)image backgroundImage:(NSString *)backgroundImage;
-(void)clip;
@end

@protocol ClipFinishDelegate <NSObject>

-(void)ClipFinishCallBack:(ClipImageView*)clipImg;

@end
