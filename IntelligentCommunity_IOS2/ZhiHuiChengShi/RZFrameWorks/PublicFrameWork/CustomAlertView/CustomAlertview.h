//
//  CustomAlertview.h
//  Dm
//
//  Created by H.DX on 14-5-12.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Customaltviewdelete;


@protocol Customaltviewdelete <NSObject>
////默认必须实现
//-(void)showmessage;
//
////@required 必须实现
@optional///表示不必须实现
-(void)showmessage;
-(void)alertview:(id)altview clickbuttonIndex:(NSInteger)index;

@end

@interface CustomAlertview : UIView<Customaltviewdelete>
{
//   id <Customalertdelete> _delegate;
 
    float altheight;

}
 
//初始化显示结果
-(void)CreatAlt:(UIImage*)backimg altTitle:(NSString *)Title Content:(NSString *)content altButton:(NSArray *)altbtnArray altbtnTcolor:(UIColor *)color altselectbtnTcolor:(UIColor *)selectcolor;
//初始化标准视图
-(void)CreatStandardAlt:(NSString*)CancelimgName altTitle:(NSString *)Title Content:(NSString *)content buttonTitle:(NSString *)buttonTitle otherbuttonTitle:(NSString *)otherTitle;

//显示
-(void)show;
//隐藏
-(void)hide;
@property(nonatomic)  float  altwidth;
@property(nonatomic)  UIFont  *font;
@property(nonatomic,retain)  UIView *view;
@property(nonatomic,assign)id<Customaltviewdelete> deleta;

@end

