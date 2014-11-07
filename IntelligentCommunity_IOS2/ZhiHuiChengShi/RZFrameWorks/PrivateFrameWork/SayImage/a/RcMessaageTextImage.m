//
//  RcMessaageTextImage.m
//  Rching
//
//  Created by rching on 13-9-13.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import "RcMessaageTextImage.h"
#import <QuartzCore/QuartzCore.h>


#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
#define MAX_WIDTH 200 //决定每行的宽度


#define BEGIN_FLAG @"[#"
#define END_FLAG @"]"


@implementation RcMessaageTextImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//图文混排

+(void)getImageRange:(NSString*)message :(NSMutableArray*)array
{
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
        [array addObject:message];
    }
}
+(UIView *)assembleMessageAtIndex:(NSString *)message cellX:(float)cellX cellY:(float)cellY cellwidth:(float)Width
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //    NSLog(@"message =%@",message);
    
    
    [self getImageRange:message :array];
    UIView *returnView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [returnView setBackgroundColor:[UIColor clearColor]];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    //    NSLog(@" str  Array = %@",data);
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            //         NSLog(@"str--->%@",str);
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= Width)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = Width;
                    Y = upY;
                }
                
                // NSLog(@"str(image)---->%@",str);
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                [img release];
                img = nil;
                upX=KFacialSizeWidth+upX;
                if (X<Width)
                    X = upX;
                
                
            } else {
                if([data count] == 1)  //全是文字
                {
                    CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(Width, 50000)];
                    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY, size.width, size.height)];
                    lb.lineBreakMode = UILineBreakModeWordWrap;
                    lb.numberOfLines = 0;
                    lb.font = fon;
                    lb.text = str;
                    
                    lb.backgroundColor = [UIColor clearColor];
                    [lb setTextColor:[UIColor redColor]];
                    [returnView addSubview:lb];
                    [lb release];
                    lb = nil;
                    upX=size.width;
                    upY = size.height-18;
                    X = upX;
                    Y = size.height-18;
                    if(upX<Width)
                    {
                        upY = size.height-16;
                        Y = size.height-16;
                    }
                    break;
                }
                //for (int j = 0; j < [str length]; j++) {
                
                while (1) {
                    int j=0;
                    //NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    // temp = @"天下";
                    // NSLog(@"temp=%@",temp);
                    if (upX >= Width || (Width-upX) <fon.pointSize)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = Width;
                        Y =upY;
                    }
                    
                    if([str isEqualToString:@""] || str == nil){
                        break;
                    }
                    
                    
                    CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    
                    
                    int space = size.width>Width-upX?Width-upX:size.width;
                    
                    UILabel *lbcontent = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY, space, [@"字" sizeWithFont:fon constrainedToSize:CGSizeMake(Width, 50000)].height)];
                    lbcontent.lineBreakMode = 0;
                    lbcontent.font = fon;
                    lbcontent.backgroundColor = [UIColor clearColor];
                    [lbcontent setTextColor:[UIColor blackColor]];
                    //    lbcontent.text = [str substringWithRange:NSMakeRange(j, space/fon.pointSize)]; //13字体宽度
                    int k = 1;
                    while (1) {
                        if ([str isEqualToString:@""]) {
                            break;
                        }
                        NSString * str1 = [str substringWithRange:NSMakeRange(j,k)];
                        CGSize  size1 = [str1 sizeWithFont:fon constrainedToSize:CGSizeMake(Width, 50000)];
                        if ((int)size1.width>space) {
                            
                            lbcontent.text = [str substringWithRange:NSMakeRange(j, k-1)];
                            j=j+k-1-1;
                            
                            break;
                        }
                        if (k<str.length-j) {
                            k++;
                        }else{
                            lbcontent.text = [str substringWithRange:NSMakeRange(j, k)];
                            j=j+k-1;
                            
                            break;
                        }
                    }
                    
                    //     j=j+space/fon.pointSize-1;
                    
                    [returnView addSubview:lbcontent];
                    [lbcontent release];
                    lbcontent = nil;
                    
                    upX=upX+space;
                    
                    str = [str substringFromIndex:j+1];
                    
                    if (X<Width) {
                        X = upX;
                    }
                    
                    
                    if([str isEqualToString:@""] || str == nil){
                        break;
                    }
                    //CGSize size1=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    //                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    //                    la.lineBreakMode = 0;
                    //                    la.font = fon;
                    //                    la.text = temp;
                    //                    la.backgroundColor = [UIColor clearColor];
                    //                    [returnView addSubview:la];
                    //                    [la release];
                    //                    la = nil;
                    //                    upX=upX+size.width;
                    
                }
            }
        }
    }
    [array release];
    array = nil;
    returnView.frame = CGRectMake(cellX,cellY, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    // NSLog(@"width=%.1f height=%.1f", X, Y);
    return returnView;
    
}

//组合文字和表情 家背景色彩
+(UIView *)assembleMessageAtIndex:(NSString *)message cellX:(float)cellX cellY:(float)cellY backcolor:(UIColor*)color
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //    NSLog(@"message =%@",message);
    
    
    [self getImageRange:message :array];
    UIView *returnView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [returnView setBackgroundColor:[UIColor clearColor]];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    //    NSLog(@" str  Array = %@",data);
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            //         NSLog(@"str--->%@",str);
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MAX_WIDTH)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = MAX_WIDTH;
                    Y = upY;
                }
                
                // NSLog(@"str(image)---->%@",str);
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                [img release];
                img = nil;
                upX=KFacialSizeWidth+upX;
                if (X<MAX_WIDTH)
                    X = upX;
                
                
            } else {
                if([data count] == 1)  //全是文字
                {
                    CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY, size.width, size.height)];
                    lb.lineBreakMode = UILineBreakModeWordWrap;
                    lb.numberOfLines = 0;
                    lb.font = fon;
                    lb.text = str;
                    
                    lb.backgroundColor = [UIColor clearColor];
                    [lb setTextColor:[UIColor redColor]];
                    [returnView addSubview:lb];
                    [lb release];
                    lb = nil;
                    upX=size.width;
                    upY = size.height-18;
                    X = upX;
                    Y = size.height-18;
                    if(upX<MAX_WIDTH)
                    {
                        upY = size.height-16;
                        Y = size.height-16;
                    }
                    break;
                }
                //for (int j = 0; j < [str length]; j++) {
                
                while (1) {
                    int j=0;
                    //NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    // temp = @"天下";
                    // NSLog(@"temp=%@",temp);
                    if (upX >= MAX_WIDTH || (MAX_WIDTH-upX) <fon.pointSize)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = MAX_WIDTH;
                        Y =upY;
                    }
                    
                    if([str isEqualToString:@""] || str == nil){
                        break;
                    }
                    
                    
                    CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    
                    
                    int space = size.width>MAX_WIDTH-upX?MAX_WIDTH-upX:size.width;
                    
                    UILabel *lbcontent = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY, space, [@"字" sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)].height)];
                    lbcontent.lineBreakMode = 0;
                    lbcontent.font = fon;
                    lbcontent.backgroundColor = [UIColor clearColor];
                    [lbcontent setTextColor:[UIColor blackColor]];
                    //    lbcontent.text = [str substringWithRange:NSMakeRange(j, space/fon.pointSize)]; //13字体宽度
                    int k = 1;
                    while (1) {
                        if ([str isEqualToString:@""]) {
                            break;
                        }
                        NSString * str1 = [str substringWithRange:NSMakeRange(j,k)];
                        CGSize  size1 = [str1 sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                        if ((int)size1.width>space) {
                            
                            lbcontent.text = [str substringWithRange:NSMakeRange(j, k-1)];
                            j=j+k-1-1;
                            
                            break;
                        }
                        if (k<str.length-j) {
                            k++;
                        }else{
                            lbcontent.text = [str substringWithRange:NSMakeRange(j, k)];
                            j=j+k-1;
                            
                            break;
                        }
                    }
                    
                    //     j=j+space/fon.pointSize-1;
                    
                    [returnView addSubview:lbcontent];
                    [lbcontent release];
                    lbcontent = nil;
                    
                    upX=upX+space;
                    
                    str = [str substringFromIndex:j+1];
                    
                    if (X<MAX_WIDTH) {
                        X = upX;
                    }
                    
                    
                    if([str isEqualToString:@""] || str == nil){
                        break;
                    }
                    //CGSize size1=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    //                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    //                    la.lineBreakMode = 0;
                    //                    la.font = fon;
                    //                    la.text = temp;
                    //                    la.backgroundColor = [UIColor clearColor];
                    //                    [returnView addSubview:la];
                    //                    [la release];
                    //                    la = nil;
                    //                    upX=upX+size.width;
                    
                }
            }
        }
    }
    [array release];
    array = nil;
    returnView.frame = CGRectMake(cellX,cellY, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    // NSLog(@"width=%.1f height=%.1f", X, Y);
    
    returnView.backgroundColor=color;
    return returnView;
    
}
+(UIView *)assembleMessageAtIndex:(NSString *)message cellX:(float)cellX cellY:(float)cellY
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //    NSLog(@"message =%@",message);
    
    
    [self getImageRange:message :array];
    UIView *returnView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [returnView setBackgroundColor:[UIColor clearColor]];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    //    NSLog(@" str  Array = %@",data);
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            //         NSLog(@"str--->%@",str);
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MAX_WIDTH)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = MAX_WIDTH;
                    Y = upY;
                }
                
                // NSLog(@"str(image)---->%@",str);
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                [img release];
                img = nil;
                upX=KFacialSizeWidth+upX;
                if (X<MAX_WIDTH)
                    X = upX;
                
                
            } else {
                if([data count] == 1)  //全是文字
                {
                    CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY, size.width, size.height)];
                    lb.lineBreakMode = UILineBreakModeWordWrap;
                    lb.numberOfLines = 0;
                    lb.font = fon;
                    lb.text = str;
                    
                    lb.backgroundColor = [UIColor clearColor];
                    [lb setTextColor:[UIColor redColor]];
                    [returnView addSubview:lb];
                    [lb release];
                    lb = nil;
                    upX=size.width;
                    upY = size.height-18;
                    X = upX;
                    Y = size.height-18;
                    if(upX<MAX_WIDTH)
                    {
                        upY = size.height-16;
                        Y = size.height-16;
                    }
                    break;
                }
                //for (int j = 0; j < [str length]; j++) {
                
                while (1) {
                    int j=0;
                    //NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    // temp = @"天下";
                    // NSLog(@"temp=%@",temp);
                    if (upX >= MAX_WIDTH || (MAX_WIDTH-upX) <fon.pointSize)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = MAX_WIDTH;
                        Y =upY;
                    }
                    
                    if([str isEqualToString:@""] || str == nil){
                        break;
                    }
                    
                    
                    CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    
                    
                    int space = size.width>MAX_WIDTH-upX?MAX_WIDTH-upX:size.width;
                    
                    UILabel *lbcontent = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY, space, [@"字" sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)].height)];
                    lbcontent.lineBreakMode = 0;
                    lbcontent.font = fon;
                    lbcontent.backgroundColor = [UIColor clearColor];
                    [lbcontent setTextColor:[UIColor blackColor]];
                    //    lbcontent.text = [str substringWithRange:NSMakeRange(j, space/fon.pointSize)]; //13字体宽度
                    int k = 1;
                    while (1) {
                        if ([str isEqualToString:@""]) {
                            break;
                        }
                        NSString * str1 = [str substringWithRange:NSMakeRange(j,k)];
                        CGSize  size1 = [str1 sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                        if ((int)size1.width>space) {
                            
                            lbcontent.text = [str substringWithRange:NSMakeRange(j, k-1)];
                            j=j+k-1-1;
                            
                            break;
                        }
                        if (k<str.length-j) {
                            k++;
                        }else{
                            lbcontent.text = [str substringWithRange:NSMakeRange(j, k)];
                            j=j+k-1;
                            
                            break;
                        }
                    }
                    
                    //     j=j+space/fon.pointSize-1;
                    
                    [returnView addSubview:lbcontent];
                    [lbcontent release];
                    lbcontent = nil;
                    
                    upX=upX+space;
                    
                    str = [str substringFromIndex:j+1];
                    
                    if (X<MAX_WIDTH) {
                        X = upX;
                    }
                    
                    
                    if([str isEqualToString:@""] || str == nil){
                        break;
                    }
                    //CGSize size1=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    //                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    //                    la.lineBreakMode = 0;
                    //                    la.font = fon;
                    //                    la.text = temp;
                    //                    la.backgroundColor = [UIColor clearColor];
                    //                    [returnView addSubview:la];
                    //                    [la release];
                    //                    la = nil;
                    //                    upX=upX+size.width;
                    
                }
            }
        }
    }
    [array release];
    array = nil;
    returnView.frame = CGRectMake(cellX,cellY, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    // NSLog(@"width=%.1f height=%.1f", X, Y);
    return returnView;
}

+(float)getMessageViewHeight:(NSString*)message
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                if (upX >= MAX_WIDTH)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = MAX_WIDTH;
                    Y = upY;
                }
                upX=KFacialSizeWidth+upX;
                if (X<MAX_WIDTH) X = upX;
                
                
            } else {
                if([data count] == 1)  //全是文字
                {
                    CGSize size=[str sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    upX=size.width;
                    upY = size.height-18;
                    X = upX;
                    Y = size.height-18;
                    if(upX<MAX_WIDTH)
                    {
                        upY = size.height-16;
                        Y = size.height-16;
                    }
                    break;
                }
                
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX >= MAX_WIDTH)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = MAX_WIDTH;
                        Y =upY;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 50000)];
                    upX=upX+size.width;
                    if (X<MAX_WIDTH) {
                        X = upX;
                    }
                }
            }
        }
    }
    // returnView.frame = CGRectMake(0,0, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    // float height = returnView.frame.size.height;
    [returnView release];
    returnView = nil;
    [array release];
    array = nil;
    return Y;  //返回view的高度
}


@end
