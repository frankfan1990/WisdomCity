//
//  RZGetCityData.h
//  ZhiHuiChengShi
//
//  Created by apple on 14-10-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZGetCityData : NSObject
@property(nonatomic,strong) NSArray *array;
@property (nonatomic, copy) NSString *urlstr;
@property (nonatomic, copy) NSDictionary *paramter;

-(void)getData;
@end
