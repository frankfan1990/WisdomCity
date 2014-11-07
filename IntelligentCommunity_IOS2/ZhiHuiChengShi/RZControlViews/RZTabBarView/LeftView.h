//
//  LeftView.h
//  SideslipTabBar
//
//  Created by zhangqingfeng on 13-7-9.
//  Copyright (c) 2013年 zhangqingfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LeftView;
@protocol LeftViewDelegate <NSObject>

- (void)LeftView:(LeftView *)view selectedIndex:(NSInteger)integer;

@end

@interface LeftView : UIView
<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>


@property (nonatomic, weak)   id<LeftViewDelegate>delegate;
@property (nonatomic, strong) NSArray *viewConttrollers;
@property (nonatomic, strong) NSArray *viewConttrollersTitle;
@property (nonatomic, strong) NSArray *viewConttrollersIcon;
- (id)initWithArray:(NSArray *)array Title:(NSArray*)arrayTitle Icon:(NSArray *)arrayIcon;

@end
