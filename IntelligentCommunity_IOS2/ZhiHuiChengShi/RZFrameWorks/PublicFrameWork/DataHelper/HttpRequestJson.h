//
//  HttpRequestJson.h
//  DT_nearevent
//
//  Created by li on 13-1-17.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#define HTTP_DEBUG 1

typedef void(^RequestFinished)(NSArray* array,id request);

@interface HttpRequestJson : NSObject<ASIHTTPRequestDelegate> {
    NSURL *requestURL;
    NSString *requestMethod;
    NSObject *orgObj;
    ASIHTTPRequest *httpRequest;
    BOOL isCallBack;
    SEL method;
    NSInteger maxRequestTime;
}
@property (nonatomic,assign) BOOL isAuto;
@property (nonatomic,retain) NSURL *requestURL;
@property (nonatomic,retain) NSString *requestMethod;
@property (nonatomic,retain) NSString *testData;
@property (nonatomic) BOOL isDEBUG;
@property (nonatomic,readonly) BOOL isRequestFinished;
-(id)init;
-(id)initWithUrl:(NSURL*)url;
-(NSArray*)getDataForURL:(NSURL*)url;
-(NSArray*)getData;
-(void)getDataByCallBackGet:(SEL)method obj:(NSObject*)obj;
-(void)getDataByCallBackPost:(SEL)method obj:(NSObject*)obj data:(NSMutableDictionary*)data;
-(void)getDataByCallBackPost:(SEL)method obj:(NSObject*)obj data:(NSMutableDictionary*)data files:(NSDictionary*)files;
-(void)addFiles:(NSDictionary*)files;
-(void)cancelRequest;
-(NSArray*)parserDataForResponseString:(NSString*)responseString;

#if NS_BLOCKS_AVAILABLE
-(void)getDataByCallBackGet:(SEL)method obj:(NSObject*)obj requestFinished:(RequestFinished)requestFinished;
-(void)getDataByCallBackPost:(SEL)method obj:(NSObject*)obj data:(NSMutableDictionary*)data requestFinished:(RequestFinished)requestFinished;;
-(void)getDataByCallBackPost:(SEL)method obj:(NSObject*)obj data:(NSMutableDictionary*)data files:(NSDictionary*)files requestFinished:(RequestFinished)requestFinished;;
#endif
@end
