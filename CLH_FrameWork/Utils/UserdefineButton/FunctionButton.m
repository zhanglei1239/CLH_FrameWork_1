//
//  SelfDefineButton.m
//  促利汇_渠道
//
//  Created by zhanglei on 15/6/28.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "FunctionButton.h"

@implementation FunctionButton

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
    self.whiteBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.whiteBg setImage:[UIImage imageNamed:@"whiteBg"]];
    [self addSubview:self.whiteBg];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, (self.frame.size.height*255)/277-5, self.frame.size.height-10)];
    [self addSubview:self.image];
    
    self.arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-40, self.frame.size.height-40, 30,30)];
    [self.arrow setImage:[UIImage imageNamed:@"functionarrow"]];
    [self addSubview:self.arrow];
}

-(void)initText{
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.height*255)/277+10, 20, self.frame.size.width-(self.frame.size.height*255)/277+20, 20)];
    [self.lblTitle setTextAlignment:NSTextAlignmentLeft]; 
    [self.lblTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self addSubview:self.lblTitle];
    
    self.lblEngTitle = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.height*255)/277+10, 20+20, self.frame.size.width-(self.frame.size.height*255)/277+20, 20)];
    [self.lblEngTitle setTextAlignment:NSTextAlignmentLeft];
    [self.lblEngTitle setTextColor:[UIColor darkGrayColor]];
    [self.lblEngTitle setFont:[UIFont fontWithName:TEXT_FONT_NAME size:16]];
    [self addSubview:self.lblEngTitle];
}

-(void)update{
    [self.image setImage:self.iconImg];
    [self.lblTitle setText:self.funTitle];
    [self.lblEngTitle setText:self.funEngTitle];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
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
    if (_delegate && [_delegate respondsToSelector:@selector(touchFunction:)]) {
        [_delegate touchFunction:self];
    }
}
@end
