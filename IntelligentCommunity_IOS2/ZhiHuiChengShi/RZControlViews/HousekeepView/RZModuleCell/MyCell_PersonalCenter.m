//
//  MyCell_PersonalCenter.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-10-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "MyCell_PersonalCenter.h"

@implementation MyCell_PersonalCenter

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:14];
        
        _imageV = [[UIImageView alloc] init];
        _imageV.layer.cornerRadius = 5;
        _imageV.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_label];
        [self.contentView addSubview:_imageV];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = CGRectMake(75, 5, self.frame.size.width-60, 43);
    _imageV.frame = CGRectMake(15, 5, 43, 43);
}
- (void)awakeFromNib
{
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
