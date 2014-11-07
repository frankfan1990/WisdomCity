//
//  RZUserInfoData.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-5.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//
#import "MTLJSONAdapter.h"
#import "RZUserInfoData.h"
@interface RZUserInfoData()
{
    
}
@end
@implementation RZUserInfoData

- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key];  // For NSInteger/CGFloat/BOOL
}

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"identifier":@"id"
             };
}
@end
