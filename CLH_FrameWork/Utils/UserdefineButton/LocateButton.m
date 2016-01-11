//
//  LocateButton.m
//  促利汇_门户
//
//  Created by zhanglei on 15/7/9.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "LocateButton.h"

@implementation LocateButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initImg];
        [self initText];
    }
    return self;
}

-(void)initImg{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-18, (self.frame.size.height-30)/2, 30, 30)];
    [self.imageView setImage:[UIImage imageNamed:@"down"]];
    [self addSubview:self.imageView];
}

-(void)initText{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-10, self.frame.size.height)];
    [self.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:12]];
    [self addSubview:self.titleLabel];
}

-(void)updateFrame{
    if (self.titleLabel.text.length == 2) {
        [self.imageView setFrame:CGRectMake(self.frame.size.width-28, (self.frame.size.height-30)/2-2, 30, 30)];
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width-22, self.frame.size.height)];
    }else if(self.titleLabel.text.length == 3){
        [self.imageView setFrame:CGRectMake(self.frame.size.width-18, (self.frame.size.height-30)/2-2, 30, 30)];
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width-12, self.frame.size.height)];
    }else if(self.titleLabel.text.length >= 4){
        [self.imageView setFrame:CGRectMake(self.frame.size.width-18, (self.frame.size.height-30)/2-2, 30, 30)];
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width-10, self.frame.size.height)];
    }else{
        [self.imageView setFrame:CGRectMake(self.frame.size.width-18, (self.frame.size.height-30)/2-2, 30, 30)];
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width-10, self.frame.size.height)];
    }
}

-(void)update{
    [self.imageView setImage:self.normalImg];
    [self.titleLabel setText:self.normalTitle];
    [self.titleLabel setTextColor:self.normalColor];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.imageView setImage:self.hilightImg];
    [self.titleLabel setTextColor:self.hilightColor];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self.titleLabel setTextColor:self.normalColor];
    [self.imageView setImage:self.normalImg];
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
    if (_delegate && [_delegate respondsToSelector:@selector(touchLocate:)]) {
        [_delegate touchLocate:self];
    }
}
@end
