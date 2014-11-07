//
//  RZCustomTextField.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-26.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZCustomTextField : UITextField
/*
-(void)textRectForBounds;　　    //重写来重置文字区域
– drawTextInRect:　　       //改变绘文字属性.重写时调用super可以按默认图形属性绘制,若自己完全重写绘制函数，就不用调用super了.
– placeholderRectForBounds:　　//重写来重置占位符区域
– drawPlaceholderInRect:　　//重写改变绘制占位符属性.重写时调用super可以按默认图形属性绘制,若自己完全重写绘制函数，就不用调用super了
– borderRectForBounds:　　//重写来重置边缘区域
– editingRectForBounds:　　//重写来重置编辑区域
– clearButtonRectForBounds:　　//重写来重置clearButton位置,改变size可能导致button的图片失真
– leftViewRectForBounds:
– rightViewRectForBounds:
 */
/*
 
//控制清除按钮的位置
-(CGRect)clearButtonRectForBounds:(CGRect)bounds;

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds;
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds;
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds;
//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds;

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect;*/

@end
