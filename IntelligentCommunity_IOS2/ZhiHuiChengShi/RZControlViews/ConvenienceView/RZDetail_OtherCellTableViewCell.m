//
//  RZDetail_OtherCellTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-27.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDetail_OtherCellTableViewCell.h"

@implementation RZDetail_OtherCellTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageV1 = [[UIImageView alloc] init];
        _imageV2 = [[UIImageView alloc] init];
        _imageV0 = [[UIImageView alloc] init];
        _labelOfDate = [[UILabel alloc] init];
        _labelOfName = [[UILabel alloc] init];
        _labelOfContent = [[UILabel alloc] init];
        
        _btnOfUseful = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOfUseless = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnOfUseless.layer.masksToBounds = YES;
        _btnOfUseful.layer.masksToBounds = YES;
        _btnOfUseful.layer.cornerRadius = 3;
        _btnOfUseless.layer.cornerRadius = 3;
        [_btnOfUseless setTitleColor:MyTitleBlueColr forState:UIControlStateNormal];
        [_btnOfUseful setTitleColor:MyTitleBlueColr forState:UIControlStateNormal];
        
        [_btnOfUseless setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnOfUseful setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        _btnOfUseful.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnOfUseless.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnOfUseless.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
        _btnOfUseless.layer.borderWidth = 0.5;
      
        _btnOfUseful.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
        _btnOfUseful.layer.borderWidth = 0.5;
        
        _btnOfUseful.selected = NO;
        _btnOfUseless.selected= NO;
        _labelOfName.textAlignment = NSTextAlignmentLeft;
        _labelOfDate.textAlignment = NSTextAlignmentLeft;
        _labelOfContent.textAlignment = NSTextAlignmentLeft;
        
        _labelOfName.font = [UIFont systemFontOfSize:14];
        _labelOfDate.font = [UIFont systemFontOfSize:13];
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
        [self.contentView addSubview:_btnOfUseless];
        [self.contentView addSubview:_btnOfUseful];
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
    _labelOfDate.frame = CGRectMake(60, 35,  self.frame.size.width-60, 20);
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
