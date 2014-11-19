//
//  RZHot_PrepareTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-19.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHot_PrepareTableViewCell.h"

@implementation RZHot_PrepareTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelOfnumber_head = [[UILabel alloc] init];
        _labelOftitle = [[UILabel alloc] init];
        _labelOftime = [[UILabel alloc] init];
        _labelOfattention = [[UILabel alloc] init];
        _labelOfnumber_attention = [[UILabel alloc] init];
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"眼睛.png"]];
        
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [self.contentView addSubview:_lineView];
        
        _labelOftitle.font = [UIFont systemFontOfSize:17];
        _labelOftitle.textColor = [UIColor blackColor];
        _labelOftitle.textAlignment = NSTextAlignmentLeft;
        
        _labelOfnumber_head.textColor = [UIColor whiteColor];
        _labelOfnumber_head.textAlignment = NSTextAlignmentCenter;
        _labelOfnumber_head.layer.masksToBounds = YES;
        _labelOfnumber_head.layer.cornerRadius = 10;
        _labelOfnumber_head.adjustsFontSizeToFitWidth = YES;
        _labelOfnumber_head.backgroundColor = UIColorFromRGB(0x5496DF);
        _labelOfnumber_head.font = [UIFont systemFontOfSize:15];
        
        _labelOfattention.textColor = UIColorFromRGB(0xababab);
        _labelOfattention.text = @"位邻居关注";
        _labelOfattention.textAlignment = NSTextAlignmentLeft;
        _labelOfattention.font = [UIFont systemFontOfSize:14];
        
        _labelOftime.font = [UIFont systemFontOfSize:14];
        _labelOftime.textColor = UIColorFromRGB(0xababab);
        _labelOftime.textAlignment = NSTextAlignmentRight;
        
        _labelOfnumber_attention.font = [UIFont systemFontOfSize:15];
        _labelOfnumber_attention.textColor = UIColorFromRGB(0x5496DF);
        _labelOfnumber_attention.textAlignment = NSTextAlignmentCenter;
        
        _labelOftitle.numberOfLines = 100;
        
        [self.contentView addSubview:_labelOfnumber_attention];
        [self.contentView addSubview:_labelOftime];
        [self.contentView addSubview:_labelOfattention];
        [self.contentView addSubview:_labelOfnumber_head];
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_labelOftitle];
        [self.contentView addSubview:_lineView];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _lineView.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
