//
//  RZHotChamberListViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-4.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZStarRatingView.h"
#import <QuartzCore/QuartzCore.h>

@class TextStepperField;

@interface RZHotChamberListViewController : UIViewController<StarRatingViewDelegate>

@property (nonatomic, strong) RZStarRatingView *starRatingView;


@end
