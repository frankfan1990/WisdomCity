//
//  UserSignLn.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-10-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "UserSignLn.h"
#import "AFNetworking.h"
@interface UserSignLn()
{
    
    NSDictionary  *dict;
}
@end
@implementation UserSignLn
-(void)getData
{
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:_urlstr parameters:_paramter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dict = responseObject;
        if([dict[@"success"] intValue] == 0)
        {
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:nil message:@"账号或密码错误" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [aler show];
        }
           [[NSNotificationCenter defaultCenter] postNotificationName:@"succ" object:self userInfo:dict];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"网络异常" message:@"请检查网络设置" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [aler show];
    }];
    
}
@end
