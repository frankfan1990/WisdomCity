//
//  RZDeliveryAddressTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-3.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDeliveryAddressTableViewCell.h"

@implementation RZDeliveryAddressTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelOfName = [[UILabel alloc] init];
        _labelofAdrr = [[UILabel alloc] init];
        _labelOfCity= [[UILabel alloc] init];
        
        _labelOfCity.textAlignment = NSTextAlignmentLeft;
        _labelofAdrr.textAlignment = NSTextAlignmentLeft;
        _labelOfName.textAlignment = NSTextAlignmentLeft;
        
        _labelOfName.font = [UIFont systemFontOfSize:18];
        _labelOfCity.font = [UIFont systemFontOfSize:15.5];
        _labelofAdrr.font = [UIFont systemFontOfSize:15.5];
        _labelofAdrr.adjustsFontSizeToFitWidth = YES;
        _btnOfselected = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnOfselected setBackgroundImage:[UIImage imageNamed:@"未选中2"] forState:UIControlStateNormal];
        [_btnOfselected setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateSelected];
        
        
        
        [self.contentView addSubview:_labelOfName];
        [self.contentView addSubview:_labelofAdrr];
        [self.contentView addSubview:_labelOfCity];
        [self.contentView addSubview:_btnOfselected];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _btnOfselected.frame = CGRectMake(10, 50-12.5, 25, 25);
    _labelOfName.frame = CGRectMake(50, 10, self.frame.size.width-60, 20);
    _labelOfCity.frame = CGRectMake(50, 40, self.frame.size.width-60, 20);
    _labelofAdrr.frame = CGRectMake(50, 70, self.frame.size.width-60, 20);
    
}
- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
