//
//  RZConfigTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-4.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZConfigTableViewCell.h"

@implementation RZConfigTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labeTitle = [[UILabel alloc] init];
        _image = [[UIImageView alloc] init];
        _labeTitle.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labeTitle];
        [self.contentView addSubview:_image];
    }
    return  self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _labeTitle.frame = CGRectMake(15, 15, 80, 20);
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
