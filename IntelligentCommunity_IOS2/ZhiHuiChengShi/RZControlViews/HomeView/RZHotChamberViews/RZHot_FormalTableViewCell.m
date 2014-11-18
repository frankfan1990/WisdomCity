//
//  RZHot_FormalTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHot_FormalTableViewCell.h"
#import "CustomLabel.h"
@implementation RZHot_FormalTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelOfnumber_head = [[UILabel alloc] init];
        _labelOftitle = [[UILabel alloc] init];
        _labelOftime = [[UILabel alloc] init];
        _labelOfNumber_comment = [[UILabel alloc] init];
        _labelOfComment = [[UILabel alloc] init];
        _labelOfoption = [[CustomLabel alloc] init];
        _blueView = [[UIView alloc] init];
        _orangeView = [[UIView alloc] init];
        _footView = [[UIView alloc] init];
        _imageV1 = [[UIImageView alloc] init];
        _imageV2 = [[UIImageView alloc] init];
        _labelOfHotComent = [[CustomLabel alloc] init];
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [self.contentView addSubview:_lineView];

        _labelOfnumber_head.textColor = [UIColor whiteColor];
        _labelOfnumber_head.textAlignment = NSTextAlignmentCenter;
        _labelOfnumber_head.layer.masksToBounds = YES;
        _labelOfnumber_head.layer.cornerRadius = 10;
        _labelOfnumber_head.adjustsFontSizeToFitWidth = YES;
        _labelOfnumber_head.backgroundColor = UIColorFromRGB(0x5496DF);
        _labelOfnumber_head.font = [UIFont systemFontOfSize:15];
        
        _labelOftitle.font = [UIFont systemFontOfSize:17];
        _labelOftitle.textColor = [UIColor blackColor];
        _labelOftitle.textAlignment = NSTextAlignmentLeft;

        _labelOftime.font = [UIFont systemFontOfSize:13];
        _labelOftime.textColor = UIColorFromRGB(0xababab);
        _labelOftime.textAlignment = NSTextAlignmentLeft;
       
        
        _labelOfNumber_comment.font = [UIFont systemFontOfSize:14];
        _labelOfNumber_comment.textColor = UIColorFromRGB(0x5496DF);
        _labelOfNumber_comment.textAlignment = NSTextAlignmentCenter;
        
        _labelOfComment.textColor = [UIColor blackColor];
        _labelOfComment.text = @"评论";
        _labelOfComment.textAlignment = NSTextAlignmentLeft;
        _labelOfComment.font = [UIFont systemFontOfSize:14];
        
        _orangeView.backgroundColor = [UIColor orangeColor];
        _blueView.backgroundColor = UIColorFromRGB(0x5496DF);
        
        
        _footView.backgroundColor = [UIColor whiteColor];
        _footView.layer.borderColor = UIColorFromRGB(0xcfcfcf).CGColor;
        _footView.layer.borderWidth = 1;
        
        _imageV1.image = [UIImage imageNamed:@"三角_1.png"];
        
        _labelOftitle.numberOfLines = 100;
        _labelOfHotComent.numberOfLines = 100;
        
        
        [self.contentView addSubview:_labelOftitle];
        [self.contentView addSubview:_labelOftime];
        [self.contentView addSubview:_labelOfNumber_comment];
        [self.contentView addSubview:_labelOfComment];
        [self.contentView addSubview:_labelOfoption];
        [self.contentView addSubview:_blueView];
        [self.contentView addSubview:_orangeView];
        [self.contentView addSubview:_footView];
        [self.contentView addSubview:_imageV1];
        [_footView addSubview:_imageV2];
        [_footView addSubview:_labelOfHotComent];
        [self.contentView addSubview:_labelOfnumber_head];
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

    // Configure the view for the selected state
}

@end
