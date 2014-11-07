//
//  CustomAlertview.m
//  Dm
//
//  Created by H.DX on 14-5-12.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "CustomAlertview.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomAlertview
{
 
}
@synthesize view;
@synthesize altwidth;
@synthesize deleta;



-(void)CreatAlt:(UIImage*)backimg altTitle:(NSString *)Title Content:(NSString *)content altButton:(NSArray *)altbtnArray altbtnTcolor:(UIColor *)color altselectbtnTcolor:(UIColor *)selectcolor
{
        view=[[UIView alloc] init];
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=10;
      UILabel *alttitle=[[UILabel alloc] init];
    alttitle.text=Title;
    [alttitle setTextAlignment:NSTextAlignmentCenter];
    [alttitle setFont:[UIFont systemFontOfSize:16]];
    [alttitle setTextColor:[UIColor  redColor]];
    [alttitle setFrame:CGRectMake(0, 0, altwidth, 30)];
    [view addSubview:alttitle];
    
    UIImageView *Ximg=[[UIImageView alloc] initWithFrame:CGRectMake(altwidth-30, 2, 25, 25)];
    [Ximg setImage:[UIImage imageNamed:@"1.png"]];
    [Ximg setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [Ximg addGestureRecognizer:singleTap];
    [view addSubview:Ximg];
    
    
    UILabel *altcontent=[[UILabel alloc] init];
    [altcontent setText:content];
    [altcontent setFont:_font];
    [altcontent setTextAlignment:NSTextAlignmentLeft];
    [altcontent setTextColor:[UIColor whiteColor]];
    [altcontent setLineBreakMode:NSLineBreakByCharWrapping];
 
    CGSize size=[altcontent.text  sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(altwidth-20, 700.0f) lineBreakMode:NSLineBreakByCharWrapping ];
    [altcontent setFrame:CGRectMake(10, 30,altwidth-20, (int)size.height+15)];
      altcontent.numberOfLines = (int)size.height/20+1;
    altheight=35+altcontent.frame.size.height;
    [view addSubview:altcontent];
    
  if(altbtnArray==nil)
  {
      
      UIButton *altbut=[UIButton buttonWithType:UIButtonTypeCustom];
      [altbut setTitle:@"取消" forState:UIControlStateNormal];
      [altbut setTitle:@"取消" forState:UIControlStateHighlighted];
      [altbut setTitleColor:color forState:UIControlStateNormal];
      [altbut setTitleColor:selectcolor forState:UIControlStateHighlighted];
      [altbut setBackgroundColor:[UIColor whiteColor]];
      [altbut setTag:0];
      [altbut setFrame:CGRectMake((altwidth/2-100)/2, altheight+5,100, 35)];
      altbut.layer.masksToBounds=YES;
      altbut.layer.cornerRadius=3;
      [altbut addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
      
      
      
      UIButton *altbut1=[UIButton buttonWithType:UIButtonTypeCustom];
      [altbut1 setTitle:@"确认" forState:UIControlStateNormal];
       [altbut1 setTitle:@"确认" forState:UIControlStateHighlighted];
      [altbut1 setTitleColor:color forState:UIControlStateNormal];
      [altbut1 setTitleColor:selectcolor forState:UIControlStateHighlighted];
      [altbut1 setBackgroundColor:[UIColor whiteColor]];
      [altbut1 setTag:1];
      [altbut1 setFrame:CGRectMake(altwidth/2+(altwidth/2-100)/2, altheight+5,100, 35)];
      altbut1.layer.masksToBounds=YES;
      altbut1.layer.cornerRadius=3;
      [altbut1 addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
      
      [view addSubview:altbut];
      [view addSubview:altbut1];
      altheight+=50;
  }
  else
  {
    
      
  }
    
   [view setFrame:CGRectMake((320-altwidth)/2, ([UIScreen mainScreen].bounds.size.height-altheight)/2-64, altwidth , altheight)];
    if(backimg==nil)
    {
        [view setBackgroundColor:[UIColor colorWithRed:0 green:167/255.0f blue:193/255.0f alpha:1]];
    }
    else
    {
      [view setBackgroundColor:[UIColor colorWithPatternImage:backimg]];
    }
 
 
}

-(void)CreatStandardAlt:(NSString*)CancelimgName altTitle:(NSString *)Title Content:(NSString *)content buttonTitle:(NSString *)buttonTitle otherbuttonTitle:(NSString *)otherTitle
{
    view=[[UIView alloc] init];
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=10;
    
    UILabel *alttitle=[[UILabel alloc] init];
    alttitle.text=Title;
    [alttitle setTextAlignment:NSTextAlignmentCenter];
    [alttitle setFont:[UIFont systemFontOfSize:16]];
    [alttitle setTextColor:[UIColor  redColor]];
    [alttitle setFrame:CGRectMake(0, 0, altwidth, 30)];
    [view addSubview:alttitle];
    
    UIImageView *Ximg=[[UIImageView alloc] initWithFrame:CGRectMake(altwidth-30, 2, 25, 25)];
    [Ximg setImage:[UIImage imageNamed:CancelimgName]];
    [Ximg setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [Ximg addGestureRecognizer:singleTap];
    [view addSubview:Ximg];
    
    
    UILabel *altcontent=[[UILabel alloc] init];
    [altcontent setText:content];
    [altcontent setFont:_font];
    [altcontent setTextAlignment:NSTextAlignmentLeft];
    [altcontent setTextColor:[UIColor whiteColor]];
    [altcontent setLineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize size=[altcontent.text  sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(altwidth-20, 700.0f) lineBreakMode:NSLineBreakByCharWrapping ];
    if(size.height<25){
            [altcontent setTextAlignment:NSTextAlignmentCenter];
    }
    [altcontent setFrame:CGRectMake(10, 30,altwidth-20, (int)size.height+15)];
    altcontent.numberOfLines = (int)size.height/20+1;
    altheight=35+altcontent.frame.size.height;
    [view addSubview:altcontent];
    
 
        
        UIButton *altbut=[UIButton buttonWithType:UIButtonTypeCustom];
        [altbut setTitle:otherTitle forState:UIControlStateNormal];
        [altbut setTitle:otherTitle forState:UIControlStateHighlighted];
        [altbut setTitleColor:Defaultcolor forState:UIControlStateNormal];
        [altbut setTitleColor:Defaultcolor forState:UIControlStateHighlighted];
        [altbut setBackgroundColor:[UIColor whiteColor]];
        [altbut setTag:0];
        [altbut setFrame:CGRectMake((altwidth/2-100)/2, altheight+5,100, 35)];
        altbut.layer.masksToBounds=YES;
        altbut.layer.cornerRadius=3;
        [altbut addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIButton *altbut1=[UIButton buttonWithType:UIButtonTypeCustom];
        [altbut1 setTitle:buttonTitle forState:UIControlStateNormal];
        [altbut1 setTitle:buttonTitle forState:UIControlStateHighlighted];
        [altbut1 setTitleColor:Defaultcolor forState:UIControlStateNormal];
        [altbut1 setTitleColor:Defaultcolor forState:UIControlStateHighlighted];
        [altbut1 setBackgroundColor:[UIColor whiteColor]];
        [altbut1 setTag:1];
        [altbut1 setFrame:CGRectMake(altwidth/2+(altwidth/2-100)/2, altheight+5,100, 35)];
        altbut1.layer.masksToBounds=YES;
        altbut1.layer.cornerRadius=3;
        [altbut1 addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:altbut];
        [view addSubview:altbut1];
        altheight+=60;
   [view setBackgroundColor:[UIColor colorWithRed:0 green:167/255.0f blue:193/255.0f alpha:1]];
       [view setFrame:CGRectMake((320-altwidth)/2, ([UIScreen mainScreen].bounds.size.height-altheight)/2-64, altwidth , altheight)];

}
 
-(void)alertview:(id)altview clickbuttonIndex:(NSInteger)index
{
    NSLog(@"abcderfv");
     [deleta alertview:self clickbuttonIndex:index];
}
-(void)showmessage
{
    NSLog(@"asd");
}
-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self hide];
}
-(void)checkbtn:(UIButton *)sender
{
//    [deleta showmessage];
    [deleta alertview:self clickbuttonIndex:sender.tag];
//    [self hide];
}

-(void)show
{
    if(view==nil)
    {
        view=[[UIView alloc] init];
    }
    [view setHidden:NO];
}
-(void)hide
{
    if(view==nil)
    {
        view=[[UIView alloc] init];
    }
    [view setHidden:YES];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
