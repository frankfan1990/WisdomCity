//
//  RightView.m
//  SideslipTabBar
//
//  Created by zhangqingfeng on 14-1-21.
//  Copyright (c) 2014年 zhangqingfeng. All rights reserved.
//

#import "RightView.h"

@implementation RightView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 50, self.bounds.size.width - 80, self.bounds.size.height-50)];
        imageView.image = [UIImage imageNamed:@"2.jpg"];
        [self addSubview:imageView];
        imageView = nil;
    }
    return self;
}


@end
