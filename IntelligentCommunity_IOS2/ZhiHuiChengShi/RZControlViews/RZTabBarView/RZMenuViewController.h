//
//  RZMenuViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-19.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
@interface RZMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableArray *viewConttrollersTitle;
@property (nonatomic, strong) NSMutableArray *viewConttrollersIcon;

 
@end
