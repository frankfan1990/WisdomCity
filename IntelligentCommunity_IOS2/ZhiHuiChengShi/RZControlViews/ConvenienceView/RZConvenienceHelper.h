//
//  RZConvenienceHelper.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpQueue.h"
@interface RZConvenienceHelper : NSObject
{
    HttpQueue *queue;
    id delegate;
}
//初始化
-(id)init:(id)target;
/*
 -------------
 eg: get 请求
 -------------
 */
//获取搜索条件
-(void)getDemoData:(NSMutableDictionary*)temp CallBack:(SEL)callback;

/*
 -------------
 eg: post 请求
 -------------
 */
-(void)posthttp:(NSMutableDictionary*)temp CallBack:(SEL)callback;

@end
