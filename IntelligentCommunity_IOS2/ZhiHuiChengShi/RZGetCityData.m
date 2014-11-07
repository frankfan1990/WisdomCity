//
//  RZGetCityData.m
//  ZhiHuiChengShi
//
//  Created by apple on 14-10-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZGetCityData.h"
#import "AFNetworking.h"
@interface RZGetCityData()
{

    NSDictionary  *dict;
}
@end
@implementation RZGetCityData
-(void)getData
{
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:_urlstr parameters:_paramter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dict = responseObject;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dictdata" object:self userInfo:dict];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"error" object:self userInfo:dict];
        NSLog(@"error:%@",[error localizedDescription]);
    }];
    
}
@end
