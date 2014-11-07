//
//  RZComplaintsTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-12.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZStarRatingView.h"

@interface RZComplaintsTableViewCell : UITableViewCell


@property(nonatomic,retain)IBOutlet UILabel *lbTypeName;
@property(nonatomic,retain)IBOutlet UILabel *lbTime;
@property(nonatomic,retain)IBOutlet UILabel *lbSubTitle;

@property(nonatomic,retain)IBOutlet UILabel *lbProgressLine1;
@property(nonatomic,retain)IBOutlet UILabel *lbProgressState1;

@property(nonatomic,retain)IBOutlet UILabel *lbProgressLine2;
@property(nonatomic,retain)IBOutlet UILabel *lbProgressState2;

@property(nonatomic,retain)IBOutlet UILabel *lbProgressLine3;
@property(nonatomic,retain)IBOutlet UILabel *lbProgressState3;

@property(nonatomic,retain)IBOutlet RZStarRatingView *starRatingView;
@property(nonatomic,retain)IBOutlet UILabel *lbLine;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollview;
@property(nonatomic,retain)IBOutlet UIView *topview;
@property(nonatomic,retain)IBOutlet UIButton *btnAppraise;
@property(nonatomic,retain)IBOutlet UIButton *btnProgress;
@property(nonatomic,retain)IBOutlet UIButton *btnDetails;
@end
