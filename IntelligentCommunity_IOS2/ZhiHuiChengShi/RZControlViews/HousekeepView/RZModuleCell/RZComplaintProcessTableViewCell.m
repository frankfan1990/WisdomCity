//
//  RZComplaintProcessTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-12.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZComplaintProcessTableViewCell.h"

@implementation RZComplaintProcessTableViewCell
@synthesize  lbTitle;
@synthesize  lbTimeMM;
@synthesize  lbSubTitle;
@synthesize  lbTimeHH;
@synthesize  lbState;
@synthesize  lbLine;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
