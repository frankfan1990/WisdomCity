//
//  IIILocalizedIndex.h
//  IIILocalizedIndexDemo
//
//  Created by sehone on 1/23/13.
//  Copyright (c) 2013 sehone <sehone@gmail.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IIILocalizedIndex : NSObject
{
    NSMutableDictionary *delimiters;
    NSMutableDictionary *indexes;
}

- (NSString *)getIndex:(NSString *)str;

- (NSDictionary *)indexed:(NSArray *)data;

@end
