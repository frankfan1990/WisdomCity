//
//  HttpQueue.h
//  ydcb
//
//  Created by li on 13-4-11.
//  Copyright 2013年 Apple inc. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "HttpRequestJson.h"


@interface HttpQueue : NSObject {
    NSMutableArray *requestQueue;
}
//一次普通的请求
-(void) createRequest:(NSURL*)url callback:(SEL)callback orgObj:(id)obj;
//一次没有附件的post请求
-(void) createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data  callback:(SEL)callback orgObj:(id)obj;
//一次拥有附件的post请求
-(void) createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data files:(NSDictionary*)files callback:(SEL)callback orgObj:(id)obj;
//一个测试性请求
-(void) createTestRequest:(NSString *)jsonStr callback:(SEL)callback orgObj:(id)obj;


#if NS_BLOCKS_AVAILABLE
-(void) createRequest:(NSURL *)url requestFinished:(RequestFinished)requestFinished;

-(void) createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data  callback:(SEL)callback orgObj:(id)obj requestFinished:(RequestFinished)requestFinished;

-(void) createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data files:(NSDictionary*)files callback:(SEL)callback orgObj:(id)obj requestFinished:(RequestFinished)requestFinished;

#endif
@end
