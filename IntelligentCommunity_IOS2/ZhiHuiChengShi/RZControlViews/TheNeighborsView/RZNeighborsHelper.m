//
//  RZNeighborsHelper.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZNeighborsHelper.h"

@implementation RZNeighborsHelper

//初始化
-(id)init:(id)target{
    self= [super init];
    queue=[[HttpQueue alloc] init];
    delegate=target;
    
    return self;
}
/*
 -------------
 eg: get 请求
 -------------
 */
//获取搜索条件
-(void)getDemoData:(NSMutableDictionary*)temp CallBack:(SEL)callback{
    NSString *url=[NSString stringWithFormat:@"%@/pageb/%@",hostIP,[temp objectForKey:@"key"]];
    [queue createRequest:[NSURL URLWithString:url]   callback:callback orgObj:delegate];
}
/*
 -------------
 eg: post 请求
 -------------
 */
-(void)posthttp:(NSMutableDictionary*)temp CallBack:(SEL)callback{
    NSString *url=[NSString stringWithFormat:@"%@/pageb",hostIP];
    NSMutableDictionary *datadic = [[NSMutableDictionary alloc] init];
    [datadic setObject:@"keyvalue" forKey:@"key"];
    [queue createRequestPost:[NSURL URLWithString:url] data:datadic   callback:callback orgObj:delegate];
}

@end
