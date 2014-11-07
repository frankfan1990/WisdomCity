//
//  CustomPageControl.m
//  WXHN
//
//  Created by HDX on 13-6-6.
//  Copyright (c) 2013年 Apple inc. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl

- (id)initWithFrame:(CGRect)frame currentImageName:(NSString *)current commonImageName:(NSString *)common spacing:(float) spacing marginLeft:(float) leftmargin
{
    self= [super initWithFrame:frame];
    if ([self respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)] && [self respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        [self setCurrentPageIndicatorTintColor:[UIColor clearColor]];
        [self setPageIndicatorTintColor:[UIColor clearColor]];
    }
    marginLeft=leftmargin;
    [self setBackgroundColor:[UIColor clearColor]];
    _activeImage= [[UIImage imageNamed:current] retain];
    _inactiveImage= [[UIImage imageNamed:common] retain];
    _kSpacing=spacing;  //点于点之间的距离
    //hold住原来pagecontroll的subview
    _usedToRetainOriginalSubview=[NSArray arrayWithArray:self.subviews];
    for (UIView *su in self.subviews) {
        [su removeFromSuperview];
    }
    self.contentMode=UIViewContentModeRedraw;
    return self;
}
-(void)dealloc
{
    //释放原来hold住的那些subview
    _usedToRetainOriginalSubview=nil;
    _activeImage=nil;
    _inactiveImage=nil;
    
    [super dealloc];
}
- (void)updateDots
{
    
    for (int i = 0; i< [self.subviews count]; i++) {
        UIImageView* dot =[self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=_activeImage;
            }
            
        } else {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=_inactiveImage;
            }
        }
    }
    
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <=6.0) {
        [self updateDots];
    }
    [self setNeedsDisplay];
}
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <=6.0) {
        [self updateDots];
    }
    [self setNeedsDisplay];
    
}
-(void)drawRect:(CGRect)iRect
{
    int i;
    CGRect rect;
    
    UIImage *image;
    iRect = self.bounds;
    
    if ( self.opaque ) {
        [self.backgroundColor set];
        UIRectFill( iRect );
    }
    
    if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
    
    rect.size.height = _activeImage.size.height;  //点高度
    rect.size.width = self.numberOfPages * _activeImage.size.width + ( self.numberOfPages - 1 ) * _kSpacing;
    rect.origin.x = floorf( ( iRect.size.width - rect.size.width ) / 2.0 )+marginLeft;
    rect.origin.y = floorf( ( iRect.size.height - rect.size.height ) / 2.0 );
    rect.size.width = _activeImage.size.width;   //点宽度
    
    for ( i = 0; i < self.numberOfPages; ++i ) {
        image = i == self.currentPage ? _activeImage : _inactiveImage;
        
        [image drawInRect: rect];
        
        rect.origin.x += _activeImage.size.width + _kSpacing;
    }
}


@end
