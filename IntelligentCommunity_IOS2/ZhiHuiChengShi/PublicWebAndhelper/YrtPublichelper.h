//
//  YrtPublichelper.h
//  RcYiRenTang
//
//  Created by H.DX on 14-6-21.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpQueue.h"
@interface YrtPublichelper : NSObject{
    
    
    HttpQueue *queue;
    id delegate;

    
}
//初始化
-(id)init:(id)target;
//上传文件
-(void)updateFile:(NSMutableDictionary*)temp CallBack:(SEL)callback;



//获取验证码
-(void)getCaptcha:(NSMutableDictionary*)temp CallBack:(SEL)callback;



//将推送数据 提交给服务器
-(void)postNotificationsWithDeviceToken:(NSMutableDictionary *)temp CallBack:(SEL)callback;

@end
