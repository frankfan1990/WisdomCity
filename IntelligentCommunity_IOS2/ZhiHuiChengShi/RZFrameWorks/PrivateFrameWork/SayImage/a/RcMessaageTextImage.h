//
//  RcMessaageTextImage.h
//  Rching
//
//  Created by rching on 13-9-13.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RcMessaageTextImage : UIView

/*
//+(void)getImageRange:(NSString*)message : (NSMutableArray*)array;
//组合文字和表情
+(UIView *)assembleMessageAtIndex:(NSString *)message cellX:(float)cellX cellY:(float)cellY;
//返回这个view的高度
+(float)getMessageViewHeight:(NSString*)message;
**/

//+(void)getImageRange:(NSString*)message : (NSMutableArray*)array;
//组合文字和表情
+(UIView *)assembleMessageAtIndex:(NSString *)message cellX:(float)cellX cellY:(float)cellY;
//组合文字和表情 家背景色彩
+(UIView *)assembleMessageAtIndex:(NSString *)message cellX:(float)cellX cellY:(float)cellY backcolor:(UIColor*)color;

//组合文字和表情
+(UIView *)assembleMessageAtIndex:(NSString *)message cellX:(float)cellX cellY:(float)cellY cellwidth:(float)Width;

//返回这个view的高度
+(float)getMessageViewHeight:(NSString*)message;


@end
