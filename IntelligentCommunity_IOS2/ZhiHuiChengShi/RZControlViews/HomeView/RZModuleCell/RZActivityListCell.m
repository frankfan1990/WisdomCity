//
//  RZActivityListCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-25.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZActivityListCell.h"

@implementation RZActivityListCell
@synthesize  image;
@synthesize icon;
@synthesize lbimgTitle;
@synthesize lbTitle;
@synthesize lbSubTitle;
@synthesize lbOtherTitle;
@synthesize  lbaddress;
@synthesize  lbline;

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
