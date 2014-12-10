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
        _btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _labelOfDate = [[UILabel alloc] init];
        _labelOfName = [[UILabel alloc] init];
        _labelOfContent = [[UILabel alloc] init];
        
        _labelOfContent.adjustsFontSizeToFitWidth = YES;
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

        _labelOfName.adjustsFontSizeToFitWidth = YES;
        _imageV0.image = [UIImage imageNamed:@"虚线2.png"];
        
         [self.contentView addSubview:_imageV0];
         [self.contentView addSubview:_imageV1];
         [self.contentView addSubview:_imageV2];
        
         [self.contentView addSubview:_labelOfContent];
         [self.contentView addSubview:_labelOfName];
         [self.contentView addSubview:_labelOfDate];
         [self.contentView addSubview:_btn1];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageV1.frame = CGRectMake(10, 10, 40, 40);
    _imageV2.frame = CGRectMake(60, 12, 20, 18);
    _imageV0.frame = CGRectMake(10, self.frame.size.height-2, self.frame.size.width-20, 2);
    _labelOfName.frame = CGRectMake(85, 9.5, self.frame.size.width-85-90, 20);
    _labelOfDate.frame = CGRectMake(65, 35,  self.frame.size.width-60, 20);
   
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
