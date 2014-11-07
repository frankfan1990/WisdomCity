//
//  RcMD5.h
//  Rching
//
//  Created by rching on 13-9-6.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface RcMD5 : NSObject

+ (NSString *)md5HexDigest:(NSString*)str;
+(NSString *) md5: (NSString *) str;
//经过公司内部规则加密后的MD5值
+ (NSString *)RcMD5rule:(NSString *)Rcstr;

@end
