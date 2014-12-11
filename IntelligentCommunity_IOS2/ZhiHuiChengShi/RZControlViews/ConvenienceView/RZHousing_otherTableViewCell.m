//
//  RZHousing_otherTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-1.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHousing_otherTableViewCell.h"

@implementation RZHousing_otherTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelOfPirce = [[UILabel alloc] init];
        _labelOfContent = [[UILabel alloc] init];
        _labelOfAveragePrice = [[UILabel alloc] init];
        _labelOfDate = [[UILabel alloc] init];

        _labelOfContent.font = [UIFont systemFontOfSize:15.5];
        _labelOfPirce.font = [UIFont systemFontOfSize:21];
        _labelOfAveragePrice.font = [UIFont systemFontOfSize:15.5];
        _labelOfDate.font = [UIFont systemFontOfSize:13.5];
        
        _labelOfContent.textColor = [UIColor blackColor];
        _labelOfDate.textColor = UIColorFromRGB(0xa9a9a9);
        _labelOfAveragePrice.textColor = UIColorFromRGB(0xa9a9a9);
        _labelOfPirce.textColor = MyTitleBlueColr;
        
        _labelOfContent.textAlignment = NSTextAlignmentLeft;
        _labelOfDate.textAlignment = NSTextAlignmentLeft;
        _labelOfAveragePrice.textAlignment = NSTextAlignmentCenter;
        _labelOfPirce.textAlignment = NSTextAlignmentCenter;
        
        _labelOfContent.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:_labelOfDate];
        [self.contentView addSubview:_labelOfContent];
        [self.contentView addSubview:_labelOfPirce];
        [self.contentView addSubview:_labelOfAveragePrice];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:lineView];
    _labelOfContent.frame = CGRectMake(20, 15, 200, 20);
    _labelOfPirce.frame = CGRectMake(self.frame.size.width-120, 10, 120, 30);
    _labelOfAveragePrice.frame = CGRectMake(self.frame.size.width-120, 10+35, 120, 20);
    _labelOfDate.frame = CGRectMake(20, self.frame.size.height-30, 300, 20);
    
    
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
