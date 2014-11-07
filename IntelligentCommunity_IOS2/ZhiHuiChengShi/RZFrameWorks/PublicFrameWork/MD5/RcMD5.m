//
//  RcMD5.m
//  Rching
//
//  Created by rching on 13-9-6.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import "RcMD5.h"

@implementation RcMD5


+ (NSString *)RcMD5rule:(NSString *)Rcstr
{
    NSString *ret = [RcMD5 md5HexDigest:Rcstr];
    NSString *subMD5 = [ret substringWithRange:NSMakeRange(2, 28)];
    
    
    NSString *top = [subMD5 substringToIndex:13];
    NSString *next = [subMD5 substringFromIndex:15];
    
    NSString *tatol = [NSString stringWithFormat:@"%@%@%@",top,@"rching",next];
    
    NSString *tatolmd5= [RcMD5 md5HexDigest:tatol];
    
    NSLog(@"RcStr=%@",Rcstr);
    NSLog(@"ret=%@",ret);
    NSLog(@"subMd5=%@",subMD5);
    
    NSLog(@"top=%@",top);
    NSLog(@"next=%@",next);
    NSLog(@"tatol=%@",tatol);
    NSLog(@"tatolmd5=%@",tatolmd5);
    
    return tatolmd5;
}

+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(NSString *) md5: (NSString *) str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


@end
