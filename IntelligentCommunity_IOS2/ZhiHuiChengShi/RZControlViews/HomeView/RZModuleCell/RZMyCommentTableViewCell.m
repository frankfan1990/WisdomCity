//
//  RZMyCommentTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZMyCommentTableViewCell.h"

@implementation RZMyCommentTableViewCell

@synthesize  lbTitle;
@synthesize lbTime;
@synthesize lbSubTitle;
@synthesize  lbLine;
@synthesize rightImage;
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
