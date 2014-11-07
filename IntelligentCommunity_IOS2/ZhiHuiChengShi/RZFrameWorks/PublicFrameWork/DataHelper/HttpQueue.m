//
//  HttpQueue.m
//  ydcb
//
//  Created by li on 13-4-11.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import "HttpQueue.h"


@implementation HttpQueue
{
    RequestFinished requestFinishedBlock;
}
-(id)init{
    self=[super init];
    requestQueue=[[NSMutableArray alloc] init];
    return self;
}
-(HttpRequestJson *)getRequestFinishedHttpRequest{
    for (HttpRequestJson *http in requestQueue) {
        if (http.isRequestFinished==YES) {
            return http;
        }
    }
    return nil;
}
-(HttpRequestJson *) initHttp:(NSURL*)url{
    HttpRequestJson *request=[self getRequestFinishedHttpRequest];
    if (request==nil) {
        request=[[[HttpRequestJson alloc] initWithUrl:url] autorelease];
    }else{
        [request setRequestURL:url];
    }
    return request;
}

-(void)createRequest:(NSURL *)url callback:(SEL)callback  orgObj:(id)obj{
    HttpRequestJson *request=[self initHttp:url];
    [request getDataByCallBackGet:callback obj:obj];
    [requestQueue addObject:request];
}
-(void)createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data callback:(SEL)callback  orgObj:(id)obj {
    HttpRequestJson *request=[self initHttp:url];
    [request getDataByCallBackPost:callback obj:obj data:data];
    [requestQueue addObject:request];
}
-(void)createRequestPost:(NSURL *)url data:(NSMutableDictionary*)data files:(NSDictionary*)files callback:(SEL)callback  orgObj:(id)obj {
    HttpRequestJson *request=[self initHttp:url];
    [request getDataByCallBackPost:callback obj:obj data:data files:files];
    [requestQueue addObject:request];
}
-(void)createTestRequest:(NSString *)jsonStr callback:(SEL)callback orgObj:(id)obj{    
    HttpRequestJson *request=[self initHttp:[NSURL URLWithString:@"http://www.baidu.com" ]];    sleep(1);
    [obj performSelector:callback withObject:[request parserDataForResponseString:jsonStr] withObject:nil ];
}

-(void)createRequest:(NSURL *)url requestFinished:(RequestFinished)requestFinished{
    HttpRequestJson *request=[self initHttp:url];
    requestFinishedBlock=[[requestFinished copy] autorelease];
    [request getDataByCallBackGet:@selector(requestFinished:request:) obj:self];
    [requestQueue addObject:request];
}

-(void)requestFinished:(NSArray *)array request:(id)request{
    if (requestFinishedBlock) {
        requestFinishedBlock(array,request);
    }
}

-(void)dealloc{
    [requestQueue makeObjectsPerformSelector:@selector(cancelRequest)];
    [requestQueue release];
    [super dealloc];
}
@end
