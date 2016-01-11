//
//  SelfDefineButton.m
//  促利汇_渠道
//
//  Created by zhanglei on 15/6/28.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "SelfDefineButton.h"

@implementation SelfDefineButton
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
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/10*2.5, self.frame.size.height/10*2, self.frame.size.width/10*5, self.frame.size.width/10*5)];
    [self addSubview:self.imageView];
}

-(void)initText{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/10*7, self.frame.size.width, self.frame.size.height/10*3)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
    [self addSubview:self.titleLabel];
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
    if (_delegate && [_delegate respondsToSelector:@selector(touchSomething:)]) {
        [_delegate touchSomething:self];
    }
} 
@end
