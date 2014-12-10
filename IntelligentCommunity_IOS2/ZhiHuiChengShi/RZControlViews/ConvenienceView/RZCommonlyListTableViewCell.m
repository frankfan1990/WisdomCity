//
//  RZCommonlyListTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//


#import "RZCommonlyListTableViewCell.h"

@implementation RZCommonlyListTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageV = [[UIImageView alloc] init];
        _labelOfTitle = [[UILabel alloc] init];
        _labelOfAddress  = [[UILabel alloc] init];
        _labelOfDistance = [[UILabel alloc] init];
        
        _labelOfTitle.textColor = [UIColor blackColor];
        _labelOfDistance.textColor = UIColorFromRGB(0xa9a9a9);
        _labelOfAddress.textColor = UIColorFromRGB(0xa9a9a9);
        
        _labelOfAddress.textAlignment = NSTextAlignmentLeft;
        _labelOfDistance.textAlignment = NSTextAlignmentRight;
        _labelOfTitle.textAlignment = NSTextAlignmentLeft;
        
        
        _labelOfAddress.numberOfLines = 20;
        _labelOfAddress.adjustsFontSizeToFitWidth = YES;
        _labelOfTitle.font = [UIFont systemFontOfSize:16];
        _labelOfAddress.font = [UIFont systemFontOfSize:13];
        _labelOfDistance.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_labelOfDistance];
        [self.contentView addSubview:_labelOfAddress];
        [self.contentView addSubview:_labelOfTitle];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:lineView];
    
    _imageV.frame = CGRectMake(10, 15, 70, 60);
    _labelOfTitle.frame = CGRectMake(80+8, 15, self.frame.size.width-150, 20);
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
