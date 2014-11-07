//
//  RZActivity_FiveTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-6.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZActivity_FiveTableViewCell.h"

@implementation RZActivity_FiveTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageV1 = [[UIImageView alloc] init];
        _imageV2 = [[UIImageView alloc] init];
        _imageV0 = [[UIImageView alloc] init];
        _btn1 = [[UIButton alloc] init];
        _labelOfDate = [[UILabel alloc] init];
        _labelOfName = [[UILabel alloc] init];
        _labelOfContent = [[UILabel alloc] init];
        
        _labelOfName.textAlignment = NSTextAlignmentLeft;
        _labelOfDate.textAlignment = NSTextAlignmentLeft;
        _labelOfContent.textAlignment = NSTextAlignmentLeft;
        
        _labelOfName.font = [UIFont systemFontOfSize:14];
        _labelOfDate.font = [UIFont systemFontOfSize:12];
        _labelOfContent.font = [UIFont systemFontOfSize:14];
        _labelOfDate.textColor = UIColorFromRGB(0x8b8b8b);
        
        _labelOfContent.numberOfLines = 100;
        _imageV1.layer.cornerRadius = 20;
        _imageV1.layer.masksToBounds = YES;
        
        [_btn1 setBackgroundImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
        
        _imageV0.image = [UIImage imageNamed:@"虚线2.png"];
        
         [self.contentView addSubview:_imageV0];
         [self.contentView addSubview:_imageV1];
         [self.contentView addSubview:_imageV2];
         [self.contentView addSubview:_btn1];
         [self.contentView addSubview:_labelOfContent];
         [self.contentView addSubview:_labelOfName];
         [self.contentView addSubview:_labelOfDate];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageV1.frame = CGRectMake(10, 10, 40, 40);
    _imageV2.frame = CGRectMake(60, 10, 20, 20);
    _imageV0.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
    _btn1.frame = CGRectMake(self.frame.size.width-50, 15, 33, 23);
    
    _labelOfName.frame = CGRectMake(85, 10, self.frame.size.width-135, 20);
    _labelOfDate.frame = CGRectMake(60, 35,  self.frame.size.width-60, 20);
    _labelOfContent.frame = CGRectMake(60, 55, self.frame.size.width-75, self.frame.size.height-56);
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
