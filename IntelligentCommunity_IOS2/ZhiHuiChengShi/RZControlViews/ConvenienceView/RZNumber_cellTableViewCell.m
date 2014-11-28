//
//  RZNumber_cellTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-27.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZNumber_cellTableViewCell.h"

@implementation RZNumber_cellTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _labelofName = [[UILabel alloc] init];
        _labelofNumber = [[UILabel alloc] init];
        _labelofAddress = [[UILabel alloc] init];
        _labelofIntroduce = [[UILabel alloc] init];
        _labelofTimes = [[UILabel alloc] init];
        _labelofboda = [[UILabel alloc] init];
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _imageV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"电话1"]];
        _imageV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"地标2"]];
        _imageV3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"简介1.png"]];
        
        _labelofboda.text = @"次拨打";
        _labelofName.textColor = [UIColor blackColor];
        _labelofTimes.textColor = UIColorFromRGB(0x5695e2);
        _labelofNumber.textColor = UIColorFromRGB(0x5695e2);
        _labelofAddress.textColor = UIColorFromRGB(0x7c7c7c);
        _labelofboda.textColor = UIColorFromRGB(0x7c7c7c);
        _labelofIntroduce.textColor = UIColorFromRGB(0x7c7c7c);
        
        _labelofName.textAlignment = NSTextAlignmentLeft;
        _labelofNumber.textAlignment = NSTextAlignmentLeft;
        _labelofAddress.textAlignment = NSTextAlignmentLeft;
        _labelofIntroduce.textAlignment = NSTextAlignmentLeft;
        _labelofTimes.textAlignment = NSTextAlignmentCenter;
        _labelofboda.textAlignment = NSTextAlignmentLeft;
        
        
        _labelofboda.adjustsFontSizeToFitWidth = YES;
        _labelofNumber.adjustsFontSizeToFitWidth = YES;
        _labelofName.adjustsFontSizeToFitWidth = YES;
        _labelofAddress.adjustsFontSizeToFitWidth = YES;
        _labelofIntroduce.adjustsFontSizeToFitWidth = YES;
        _labelofTimes.adjustsFontSizeToFitWidth = YES;
        
        _labelofboda.font = [UIFont systemFontOfSize:12];
        _labelofNumber.font = [UIFont systemFontOfSize:12];
        _labelofIntroduce.font = [UIFont systemFontOfSize:12];
        _labelofAddress.font = [UIFont systemFontOfSize:12];
        _labelofTimes.font = [UIFont systemFontOfSize:12];
        _labelofName.font = [UIFont systemFontOfSize:15];
        
        
        [_button setTitle:@"拨打" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.backgroundColor = UIColorFromRGB(0x5496DF);
        _button.layer.cornerRadius = 6;
        _button.layer.masksToBounds = YES;
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        
        [self.contentView addSubview:_labelofName];
        [self.contentView addSubview:_labelofNumber];
        [self.contentView addSubview:_labelofIntroduce];
        [self.contentView addSubview:_labelofAddress];
        [self.contentView addSubview:_labelofTimes];
        [self.contentView addSubview:_labelofboda];
        [self.contentView addSubview:_imageV2];
        [self.contentView addSubview:_imageV1];
        [self.contentView addSubview:_imageV3];
        [self.contentView addSubview:_button];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    footView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:footView];
    _imageV1.frame = CGRectMake(15,40-2,15, 15);
    _imageV2.frame = CGRectMake(15,40+25-5,15, 15);
    _imageV3.frame = CGRectMake(15,65+25-8,15, 15);
    
    _labelofName.frame = CGRectMake(15, 10, self.frame.size.width-100, 20);
    
    _labelofNumber.frame = CGRectMake(30+10, 40-3, self.frame.size.width-100, 15);
    _labelofAddress.frame = CGRectMake(30+10, 40+25-6, self.frame.size.width-100, 15);
    _labelofIntroduce.frame = CGRectMake(30+10, 40+50-9, self.frame.size.width-100, 15);
    
    _button.frame = CGRectMake(self.frame.size.width-15-65, 20, 65, 30);
    _labelofTimes.frame = CGRectMake(self.frame.size.width-80, 65-8, 30, 15);
    _labelofboda.frame = CGRectMake(self.frame.size.width-50, 65-8, 50, 15);
}

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    [super willTransitionToState:state];
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask)
    {
        for (UIView *subview in self.subviews)
        {
            for (UIView *subview2 in subview.subviews) {
                if ([NSStringFromClass([subview2 class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"])
                {
                    UIImageView *deleteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 33)];
                    [deleteBtn setImage:[UIImage imageNamed:@"删除.png"]];
                    [[subview2.subviews objectAtIndex:0] addSubview:deleteBtn];
                }
            }
        }
    }
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
