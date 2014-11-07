//
//  UserSignLn.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-10-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSignLn : NSObject
@property(nonatomic,strong) NSArray *array;
@property (nonatomic, copy) NSString *urlstr;
@property (nonatomic, copy) NSDictionary *paramter;
-(void)getData;
@end
