//
//  RZRepairTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-15.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZRepairTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *lbStates;
@property(nonatomic,retain)IBOutlet UILabel *lbTime;
@property(nonatomic,retain)IBOutlet UILabel *lbContent;
@property(nonatomic,retain)IBOutlet UILabel *lbLine;
@property(nonatomic,retain)IBOutlet UIView *rightview;
@property(nonatomic,retain)IBOutlet UIImageView *imageMark;
@property(nonatomic,retain)IBOutlet UIImageView *imageArrow;

@end
