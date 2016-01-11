//
//  SynthesizeSingleton.h
//  TexasPoker-iOS
//
//  Created by 束 永兴 on 13-3-27.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#define SINGLETON_CLASS(classname) \
\
+ (classname *)shared##classname \
{\
    static dispatch_once_t pred = 0; \
    __strong static id _shared##classname = nil; \
    dispatch_once(&pred,^{ \
        _shared##classname = [[self alloc] init]; \
    });  \
    return _shared##classname; \
}