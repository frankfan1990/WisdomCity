//
//  NSDictionary+MutableDeepCopy.m
//  WXHN
//
//  Created by heyue on 13-5-31.
//  Copyright (c) 2013年 Apple inc. All rights reserved.
//

#import "NSDictionary+MutableDeepCopy.h"

@implementation NSDictionary (MutableDeepCopy)

-(NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] initWithCapacity:[self count]];
    
    //获取字典里的所有键进行便利
    for (id key in [self allKeys]) {
        
        //这里用id的原因是此时并不知道value里是否还含有其他类型数据(字典，数组：非字符串)。
        id value=[self valueForKey:key];
        id tmpvalue=nil;
        if ([value respondsToSelector:@selector(mutableDeepCopy)]) {
            tmpvalue=[value mutableDeepCopy];
        }else if ([value respondsToSelector:@selector(mutableCopy)]) {
            tmpvalue=[value mutableCopy];
        }
        [mudic setValue:tmpvalue forKey:key];
    }
    return mudic;
}

@end
