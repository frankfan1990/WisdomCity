//
//  YrtPublichelper.m
//  RcYiRenTang
//
//  Created by H.DX on 14-6-21.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "YrtPublichelper.h"

@implementation YrtPublichelper
//初始化
-(id)init:(id)target
{
    self= [super init];
    queue=[[HttpQueue alloc] init];
    delegate=target;

    return self;
}


-(void)updateFile:(NSMutableDictionary*)temp CallBack:(SEL)callback{
  

 
    
    NSMutableDictionary *datadic = [[NSMutableDictionary alloc] init];
 
    [datadic setObject:@"ycs" forKey:@"type"];

    NSMutableDictionary *filedic = [[NSMutableDictionary alloc] init];
    
   [filedic setObject:[temp objectForKey:@"filepath"] forKey:@"file"];
  
    NSString *Url = [NSString  stringWithFormat:@"http://%@/attachment.json?uploadFile",hostIP];
    [queue createRequestPost:[NSURL URLWithString:Url] data:datadic files:filedic callback:callback orgObj:delegate];

}




//获取验证码
-(void)getCaptcha:(NSMutableDictionary*)temp CallBack:(SEL)callback{
   
    
    NSString *Url=[NSString stringWithFormat:@"http://%@/producer.json?forgotPassword",hostIP];
     
    NSMutableDictionary *datadic = [[NSMutableDictionary alloc] init];
    [datadic setObject:[temp objectForKey:@"iphone"] forKey:@"iphone"];
 
    [queue createRequestPost:[NSURL URLWithString:Url] data:datadic callback:callback orgObj:delegate];

}

 

-(void)postNotificationsWithDeviceToken:(NSMutableDictionary *)temp CallBack:(SEL)callback{
 
    NSMutableDictionary *datadic = [[NSMutableDictionary alloc] initWithDictionary:temp];
 
    NSString *Url = [NSString  stringWithFormat:@"http://%@/message.json?push",hostIP];
    
    [queue createRequestPost:[NSURL URLWithString:Url] data:datadic  callback:callback orgObj:delegate];
}

@end
