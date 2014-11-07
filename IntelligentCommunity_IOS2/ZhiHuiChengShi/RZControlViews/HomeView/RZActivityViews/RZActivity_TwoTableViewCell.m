//
//  RZActivity_TwoTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-6.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZActivity_TwoTableViewCell.h"

@implementation RZActivity_TwoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1  = [[UILabel alloc] init];
        _label2 = [[UILabel alloc] init];
        _image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"标签"]];
        _label2.numberOfLines = 100;
        _label2.font = [UIFont systemFontOfSize:15];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_label1];
        [self.contentView addSubview:_label2];
        [self.contentView addSubview:_image1];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _image1.frame = CGRectMake(10, 10, 25, 25);
    _label1.frame = CGRectMake(38, 12, 100, 20);
    _label2.frame = CGRectMake(10, 35, self.frame.size.width-20, self.frame.size.height-35);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
