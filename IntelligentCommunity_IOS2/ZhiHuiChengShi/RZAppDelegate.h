//
//  RZAppDelegate.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-6-17.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import "RZTabBarController.h"
#import "RESideMenu.h"



#pragma mark AMap 高德地图
#import "AMapKey.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface RZAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,RESideMenuDelegate,MAMapViewDelegate,AMapSearchDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void)clearUserInfos;
-(void)goInfo:(BOOL)Visitor;

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;
@end
