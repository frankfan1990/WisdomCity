//
//  RZRepairTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-15.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZRepairTableViewCell.h"

@implementation RZRepairTableViewCell
@synthesize  lbStates;
@synthesize  lbTime;
@synthesize  lbContent;
@synthesize  lbLine;
@synthesize  rightview;
@synthesize  imageMark;
@synthesize  imageArrow;
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
