//
//  RZActivity_zeroTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-6.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZActivity_zeroTableViewCell.h"

@implementation RZActivity_zeroTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellView = [[UIView alloc] init];
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellView];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _cellView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
