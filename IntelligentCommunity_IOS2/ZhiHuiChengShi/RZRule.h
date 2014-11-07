//
//  RZRule.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-10-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZRule : NSObject
BOOL isValidateEmail(NSString *email);
BOOL isValidatePhone(NSString *mobile);
@end
