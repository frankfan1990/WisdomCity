//
//  CustomPageControl.h
//  WXHN
//
//  Created by HDX on 13-6-6.
//  Copyright (c) 2013年 Apple inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomPageControl : UIPageControl
{
    UIImage *_activeImage;
    UIImage *_inactiveImage;
    NSArray *_usedToRetainOriginalSubview;
    
    float _kSpacing;
    float marginLeft;
}

- (id)initWithFrame:(CGRect)frame currentImageName:(NSString *)current commonImageName:(NSString *)common spacing:(float) spacing marginLeft:(float) leftmargin;


@end
