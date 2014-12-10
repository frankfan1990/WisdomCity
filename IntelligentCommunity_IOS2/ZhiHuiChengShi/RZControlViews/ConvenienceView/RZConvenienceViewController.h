//
//  RZConvenienceViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

//这个代理用来传 家教家政 列表的数据
@protocol MyDataSendDelegate<NSObject>
@optional
-(void)sendData:(NSDictionary *)dict Type:(NSInteger)type Name:(NSString*)title;
@end


@interface RZConvenienceViewController : UIViewController
@property(nonatomic,weak)id<MyDataSendDelegate>delegate;

@end
