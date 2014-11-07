//
//  HttpRequestJson.m
//  DT_nearevent
//
//  Created by li on 13-1-17.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import "HttpRequestJson.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation HttpRequestJson
@synthesize requestMethod;
@synthesize requestURL;
@synthesize isDEBUG;
@synthesize testData;
@synthesize isAuto;
@synthesize isRequestFinished;

-(id)init{

    self.requestMethod=@"GET";
    isDEBUG=NO;
    isCallBack=YES;
    NSLog(@"request init");
    return self;
}
-(id)initWithUrl:(NSURL*)url{
    maxRequestTime=60;
    self.requestURL=url;
    NSLog(@"request initURl%@",url);      
    isCallBack=YES;
    return self;
}
-(NSArray*)parserDataForResponseString:(NSString*)responseString{
    
   NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
   // NSString *result = [responseString copy];
    
    if(![result hasPrefix:@"["]){
        result=[NSString stringWithFormat:@"[%@]",result];
    }
    if([result hasPrefix:@"[\""]&&[result hasSuffix:@"\"]"]){
        result=[result stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        result=[result stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    }
    if (HTTP_DEBUG) {
        NSLog(@"HttpRequestJson_url\n:%@\nHttpRequestJson_response_string\n:%@",requestURL.absoluteString,responseString);
    }
    //
    ////////////////////////////替换控制字符
    result=[result stringByReplacingOccurrencesOfString:@"%" withString:@"%%"];
    result=[result stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
    result=[result stringByReplacingOccurrencesOfString:@"?" withString:@" "];
    result=[result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"\v" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"\f" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"\b" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"\a" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"\e" withString:@""];
    result=[result stringByReplacingOccurrencesOfString:@"':," withString:@"':'',"];
    result=[result stringByReplacingOccurrencesOfString:@"':}" withString:@"':''}"];
    result=[result stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];



    if([result length]<=4){
        return nil;
    }
    NSArray *array=[result objectFromJSONString];
    if ([array count]==0) {
        [array release];
        return nil;//[NSArray arrayWithObjects:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"error",@"1",@"dataCheck",@"",@"data",@"解析异常或者请求失效",@"message",nil], nil];//本地验证
    }else{
        
        return array;//[UtilCheck dataCheck:array];//校验json 是否官方返回数据
        

    }
}

-(void)addFiles:(NSDictionary *)files{
    if ([httpRequest isKindOfClass:[ASIFormDataRequest class]]) {
        ASIFormDataRequest *form=(ASIFormDataRequest*)httpRequest;
        for (NSString *key in [files keyEnumerator]) {
            if (![[NSString stringWithFormat:@"%@",[files objectForKey:key] ] isEqualToString:@""]) {
                [form setFile:[files objectForKey:key] forKey:@"file"];
//        [form setFile:[files objectForKey:key] withFileName:[[files objectForKey:key] lastPathComponent] andContentType:@"multipart/form-data" forKey:@"enctype"];
            }
        }
    }
}

-(NSArray *)getData{
    isRequestFinished=NO;
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:requestURL];
    [request startSynchronous];
    NSInteger status=request.responseStatusCode;
    if(status==200){
        NSString *responseString=[request responseString];
        [request release];
        return [self parserDataForResponseString:responseString];
    }
    
    isRequestFinished=YES;
    [request release];
    return nil;   
}
//普通请求回调方法
-(void)getDataByCallBackGet:(SEL)methods obj:(NSObject *)obj{
    
    isRequestFinished=NO;
    httpRequest=[[ASIHTTPRequest alloc] initWithURL:requestURL];
    [httpRequest setResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setTimeOutSeconds:maxRequestTime];
    method=methods;
    orgObj=obj ;
    if(isDEBUG){
        [self requestFinished:nil];
        return;
    }
    [httpRequest setDelegate:self]; 
    dispatch_async(dispatch_queue_create("sendrequest" ,NULL), ^(void) {
        [httpRequest startAsynchronous];
    });
}
//不带附件请求
-(void)getDataByCallBackPost:(SEL)methods obj:(NSObject *)obj data:(NSMutableDictionary*)data{  
    
    isRequestFinished=NO;
    httpRequest=[[ASIFormDataRequest alloc] initWithURL:requestURL];
    httpRequest.timeOutSeconds = 300;
    [httpRequest setTimeOutSeconds:maxRequestTime];
    [httpRequest setResponseEncoding:NSUTF8StringEncoding];    
    for (NSString* key in [data keyEnumerator]) {        
        [httpRequest setPostValue:[data objectForKey:key] forKey:key];
    }
    //
    if (HTTP_DEBUG) {
       NSLog(@"post data :\r\n%@",data);
    }
    method=methods;
    orgObj=obj;
    if(isDEBUG){
        [self requestFinished:nil];
        return;
    }
    [httpRequest setDelegate:self];
    dispatch_async(dispatch_queue_create("sendrequest" ,NULL), ^(void) {  
        [httpRequest startAsynchronous];
    });
    
}
//带附件下载
-(void)getDataByCallBackPost:(SEL)methods obj:(NSObject *)obj data:(NSMutableDictionary*)data files:(NSDictionary *)files{  
    
    isRequestFinished=NO;
    httpRequest=[[ASIFormDataRequest alloc] initWithURL:requestURL];
    httpRequest.timeOutSeconds = 300;
    [httpRequest setTimeOutSeconds:maxRequestTime];
    [httpRequest setResponseEncoding:NSUTF8StringEncoding];    
    for (NSString* key in [data keyEnumerator]) {        
        [httpRequest setPostValue:[data objectForKey:key] forKey:key];
    }
    //NSLog(@"post data :\r\n%@",data);
    [self addFiles:files];
    method=methods;
    orgObj=obj;
    if(isDEBUG){
        [self requestFinished:nil];
        return;
    }
    [httpRequest setDelegate:self];
    dispatch_async(dispatch_queue_create("sendrequest" ,NULL), ^(void) {  
        [httpRequest startAsynchronous];
    });
    
}
//同步从连接取得数据
-(NSArray *)getDataForURL:(NSURL *)url{
    isRequestFinished=NO;
    httpRequest=[[ASIHTTPRequest alloc] initWithURL:url];
    [httpRequest startSynchronous];
    NSInteger status=[httpRequest responseStatusCode];
    if(status==200){
        NSString *responseString=[httpRequest responseString];
        [httpRequest release];
        return [self parserDataForResponseString:responseString];
    }    
    [httpRequest release];
    return nil;
}


//请求数据完成,并组解析成为JSON
-(void)requestFinished:(ASIHTTPRequest *)request{
    isRequestFinished=YES;
    NSInteger status=[request responseStatusCode];
    //请求返回状态码
    NSArray *array=nil;
    if(status==200||isDEBUG){      
        NSString *result;
        if(isDEBUG){
            result=testData;
        }else{
            result=[request responseString]; 
        }
        array=[self parserDataForResponseString:result]; 
    }else{
        NSLog(@"error code %d",status);
    }
    if (isCallBack) {
        if (orgObj && [orgObj respondsToSelector:method]) {            
            [orgObj performSelector:method withObject:array withObject:request ];  
        }
    }
    if (isAuto) {        
        [self autorelease];
    }
    
}
//请求失败
-(void)requestFailed:(ASIHTTPRequest *)request{    
    isRequestFinished=YES;
    NSLog(@"request is failed link is:\n %@",[[request url] absoluteURL]);
    if (isCallBack) {        
        if(orgObj&&[orgObj respondsToSelector:method]){   
            NSLog(@"post msg to delegate");
            [orgObj performSelector:method withObject:nil withObject:request];     
        } else{
            NSLog(@"not have delegate");
            UIAlertView *view=[[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络响应失败,请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease];
            [view show];
            
        }
    }   
    
    if (isAuto) {        
        [self autorelease];
    }
}

-(void)cancelRequest{
    isCallBack=NO;
    orgObj=nil;
}

//释放资源
-(void)dealloc{
    NSLog(@"http request dealloc");
    [requestURL release];
    if ([httpRequest isKindOfClass:[ASIHTTPRequest class]]) {        
        NSLog(@"http request cancel");
        [httpRequest clearDelegatesAndCancel];
        [httpRequest cancel];
    }
    orgObj=nil;
    isCallBack=NO;
    [httpRequest release];
    [super dealloc];
}
@end
