//
//  RZCategoryListViewController.h
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZConvenienceViewController.h"


//这个代理用来传 家教家政里面每一个分支里的列表的数据
@protocol CommonlyDataSendDelegate<NSObject>
@optional
-(void)sendData:(NSDictionary *)dict Name:(NSString*)title;
@end


@interface RZCategoryListViewController : UIViewController<MyDataSendDelegate>

@property(nonatomic,weak)id<CommonlyDataSendDelegate>delegate;
@end
