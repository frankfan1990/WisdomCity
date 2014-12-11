//
//  RZStarRatingView.h
//  RZStarRatingView
//
//  Created by RZ on 14-09-10.
//  Copyright (c) 2013年 RZ. All rights reserved.
//


#import <UIKit/UIKit.h>
@class RZStarRatingView;

@protocol StarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(RZStarRatingView *)view score:(float)score;

@end

@interface RZStarRatingView : UIView

@property (nonatomic, readonly) int numberOfStar;
@property (nonatomic) BOOL IsPanEnable;
@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;

/**
 *  初始化RZStarRatingView
 *
 *  @param frame  Rectangles
 *  @param number 星星个数
 *
 *  @return RZStarRatingViewObject
 */
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;

/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate;

/**
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － 1 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;

@end

#define kBACKGROUND_STAR @"星星未填充"
#define kFOREGROUND_STAR @"星星填充"
#define kNUMBER_OF_STAR  5