//
//  UploadPicButton.m
//  促利汇_门户
//
//  Created by zhanglei on 15/7/30.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "UploadPicButton.h"

@implementation UploadPicButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initText];
        [self initImg];
    }
    return self;
}

-(void)initImg{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    [self.imageView setImage:[UIImage imageNamed:@"upload_bg"]];
    [self addSubview:self.imageView];
    
    self.addView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-30)/2, 10, 30,30)];
    [self.addView setImage:[UIImage imageNamed:@"upload_add"]];
    [self addSubview:self.addView];
    
//    self.topImg = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-30)/2, 10, 30,30)];
////    [self.topImg setImage:[UIImage imageNamed:@""]];
//    [self addSubview:self.topImg];
}

-(void)initText{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width-34, self.frame.size.width, 14)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
    [self.titleLabel setTextColor:[UIColor grayColor]];
    [self addSubview:self.titleLabel];
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width-20, self.frame.size.width,14)];
    [self.subTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.subTitleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
    [self.subTitleLabel setTextColor:[UIColor grayColor]];
    [self addSubview:self.subTitleLabel];
}

-(void)update{
    [self.imageView setImage:self.normalImg];
    [self.titleLabel setText:self.normalTitle];
    [self.titleLabel setTextColor:self.normalColor];
    [self.subTitleLabel setTextColor:self.normalColor];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.imageView setImage:self.hilightImg];
    [self.titleLabel setTextColor:self.hilightColor];
    [self.subTitleLabel setTextColor:self.hilightColor];
    [self.imageView setAlpha:.5];
    [self.addView setAlpha:.5];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self.subTitleLabel setTextColor:self.normalColor];
    [self.titleLabel setTextColor:self.normalColor];
    [self.imageView setImage:self.normalImg];
    [self.imageView setAlpha:1];
    [self.addView setAlpha:1];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    
    if (x<0||x>self.frame.size.width||y<0||y>self.frame.size.height) {
        [self touchesCancelled:touches withEvent:event];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    
    if (x<0||x>self.frame.size.width||y<0||y>self.frame.size.height) {
        return;
    }
    [self performSelector:@selector(setStateChange) withObject:nil afterDelay:.05];
}

-(void)setStateChange{
    [self.titleLabel setTextColor:self.normalColor];
    [self.imageView setImage:self.normalImg];
    [self.subTitleLabel setTextColor:self.normalColor];
    [self.imageView setAlpha:1];
    [self.addView setAlpha:1];
    if (_delegate && [_delegate respondsToSelector:@selector(touchUpload:)]) {
        [_delegate touchUpload:self];
    }
}
@end
