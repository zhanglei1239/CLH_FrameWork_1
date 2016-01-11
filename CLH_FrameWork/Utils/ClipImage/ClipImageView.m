//
//  ClipImageView.m
//  SliderGuideDemo
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 zhanglei. All rights reserved.
//
#define ClipDelay .1f
#define ClipDuration .8
#import "ClipImageView.h"

@implementation ClipImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        SWidth = [[UIScreen mainScreen] bounds].size.width;
        SHeight = [[UIScreen mainScreen] bounds].size.height;
    }
    return self;
}

-(void)clipImage:(UIImage *)image backgroundImage:(NSString *)backgroundImage{
    // 上半部
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SWidth, SHeight * 0.5)];
    UIImage * clipImgT = [self clipImage:image withRectPosition:@"top"];
    [topImage setImage:clipImgT];
    [self addSubview:topImage];
    
    // 下半部
    bottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, SHeight*0.5, SWidth, SHeight * 0.5)];
    UIImage * clipImgB = [self clipImage:image withRectPosition:@"bottom"];
    [bottomImage setImage:clipImgB];
    [self addSubview:bottomImage];
}
/**
 *  裁剪之后的动画
 */
-(void)clip{
    // 延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ClipDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 执行动画
        [UIView animateWithDuration:ClipDuration animations:^{
            CGRect topRect = topImage.frame;
            topRect.origin.y -= SHeight*.5;
            topImage.frame = topRect;
            
            CGRect bottomRect = bottomImage.frame;
            bottomRect.origin.y += SHeight*.5;
            bottomImage.frame = bottomRect;
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(ClipFinishCallBack:)]) {
                [_delegate ClipFinishCallBack:self];
            }
        }];
    });
}

/**
 *  Image裁剪方法
 *
 *  @param image 需要进行裁剪的Image
 *  @param pos   当前要裁剪的位置，top 上  bottom 下 left 左 right 右 默认为不进行裁剪全部输出
 *
 *  @return 返回裁剪之后的Image
 */
- (UIImage *)clipImage:(UIImage *)image withRectPosition:(NSString *)pos {
    CGRect clipFrame;
    if ([pos isEqualToString:@"top"]) {
        clipFrame = CGRectMake(0, 0, image.size.width, image.size.height/2);
    }else if([pos isEqualToString:@"bottom"]){
        clipFrame = CGRectMake(0, image.size.height/2, image.size.width, image.size.height/2);
    }else if([pos isEqualToString:@"left"]){
        clipFrame = CGRectMake(0, 0, image.size.width/2, image.size.height);
    }else if([pos isEqualToString:@"right"]){
        clipFrame = CGRectMake(image.size.width/2, 0, image.size.width/2, image.size.height);
    }else{
        clipFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    
    CGImageRef refImage = CGImageCreateWithImageInRect(image.CGImage, clipFrame);
    UIImage *newImage = [UIImage imageWithCGImage:refImage];
    CGImageRelease(refImage);
    return newImage;
}

@end
