//
//  RZFoodListTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-8.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZFoodListTableViewCell.h"

@implementation RZFoodListTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _btnFoodOrer = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFoodImage = [UIButton buttonWithType:UIButtonTypeCustom];
        _labelFoodName = [[UILabel alloc] init];
        _labelFoodPirce = [[UILabel alloc] init];
        _labelFoodPirce.textAlignment = NSTextAlignmentLeft;
        _labelFoodName.textAlignment = NSTextAlignmentLeft;
        
        _labelFoodName.textColor = [UIColor blackColor];
        _labelFoodPirce.textColor = [UIColor colorWithRed:225/255.0 green:86/255.0 blue:86/255.0 alpha:1];
        
        _labelFoodName.font = [UIFont systemFontOfSize:15];
        _labelFoodPirce.font = [UIFont systemFontOfSize:15];
        
        [_btnFoodOrer setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnFoodOrer setTitleColor:MyTitleBlueColr forState:UIControlStateNormal];
        
        
        [_btnFoodOrer setTitle:@"已点" forState:UIControlStateSelected];
        [_btnFoodOrer setTitle:@"点餐" forState:UIControlStateNormal];
        
        _btnFoodOrer.layer.masksToBounds = YES;
        _btnFoodOrer.layer.cornerRadius = 4;
        
        _btnFoodOrer.layer.borderWidth = 0.7;
        _btnFoodOrer.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
        
        _labelFoodName.adjustsFontSizeToFitWidth = YES;
        _labelFoodPirce.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:_btnFoodOrer];
        
        [self.contentView addSubview:_labelFoodName];
        [self.contentView addSubview:_labelFoodPirce];
        [self.contentView addSubview:_btnFoodImage];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:lineView];
    _btnFoodImage.frame = CGRectMake(10, 10, 80, 65);
    _labelFoodName.frame = CGRectMake(105, 15, 170, 20);
    _labelFoodPirce.frame = CGRectMake(105, 45, 170, 20);
    _btnFoodOrer.frame = CGRectMake(self.frame.size.width-85, self.frame.size.height/2-16, 70, 33);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
