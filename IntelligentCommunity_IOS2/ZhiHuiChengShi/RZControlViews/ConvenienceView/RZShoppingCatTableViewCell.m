//
//  RZShoppingCatTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZShoppingCatTableViewCell.h"

@implementation RZShoppingCatTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelOfFoodName = [[UILabel alloc] init];
        _labelOfStoreName = [[UILabel alloc] init];
        _labelOfprice = [[UILabel alloc] init];
        _imageV = [[UIImageView alloc] init];
        _btnOfAdd = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnOfSubStract = [UIButton buttonWithType:UIButtonTypeSystem];
        _numberField = [[UITextField alloc] init];
        _imageV0 = [[UIImageView alloc] init];
        _labelOfFoodName.textAlignment = NSTextAlignmentLeft;
        _labelOfStoreName.textAlignment = NSTextAlignmentLeft;
        _labelOfprice.textAlignment = NSTextAlignmentRight;
        
        _labelOfprice.textColor = [UIColor colorWithRed:1 green:78/255.0 blue:3/255.0 alpha:1];
        _labelOfFoodName.textColor = [UIColor blackColor];
        _labelOfStoreName.textColor = UIColorFromRGB(0x7c7c7c);
        
        _labelOfStoreName.font = [UIFont systemFontOfSize:12];
        _labelOfFoodName.font = [UIFont systemFontOfSize:16];
        _labelOfprice.font = [UIFont systemFontOfSize:15];
        
        _btnOfAdd.layer.borderWidth = 1;
        _btnOfAdd.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1].CGColor;
        _btnOfSubStract.layer.borderWidth = 1;
        _btnOfSubStract.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1].CGColor;

        [_btnOfAdd setTitle:@"+" forState:UIControlStateNormal];
        [_btnOfAdd setTitleColor:UIColorFromRGB(0x7c7c7c) forState:UIControlStateNormal];
        [_btnOfSubStract setTitle:@"-" forState:UIControlStateNormal];
        [_btnOfSubStract setTitleColor:UIColorFromRGB(0x7c7c7c) forState:UIControlStateNormal];
        [_btnOfSubStract.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        _btnOfSubStract.titleLabel.font = [UIFont systemFontOfSize:18];
        _btnOfAdd.titleLabel.font = [UIFont systemFontOfSize:20];
        
        _numberField.layer.borderWidth = 1;
        _numberField.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1].CGColor;
        
        _labelOfFoodName.adjustsFontSizeToFitWidth = YES;
        
        _imageV0.image = [UIImage imageNamed:@"虚线2.png"];
        
        [self.contentView addSubview:_imageV0];
        [self.contentView addSubview:_labelOfprice];
        [self.contentView addSubview:_labelOfStoreName];
        [self.contentView addSubview:_labelOfFoodName];
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_btnOfSubStract];
        [self.contentView addSubview:_btnOfAdd];
        [self.contentView addSubview:_numberField];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageV.frame = CGRectMake(10, 18, 80, 70);
    _labelOfprice.frame = CGRectMake(self.frame.size.width - 85, 10, 60, 20);
    _labelOfFoodName.frame = CGRectMake(105, 10, self.frame.size.width -95-85, 20);
    _labelOfStoreName.frame = CGRectMake(105, 10+30-5, self.frame.size.width -95, 20);
    _btnOfSubStract.frame = CGRectMake(105, 10+50+10-5, 35, 27.5);
    _numberField.frame = CGRectMake(105+27.5+18, 10+50+10-5, 45, 27.5);
    _btnOfAdd.frame = CGRectMake(105+27.5+20+45+8, 10+50+10-5, 35, 27.5);
    _imageV0.frame = CGRectMake(10, self.frame.size.height-2, self.frame.size.width-20, 2);
    
}
- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
