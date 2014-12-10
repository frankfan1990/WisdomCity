//
//  RZFoodCommentTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-9.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZFoodCommentTableViewCell.h"

@implementation RZFoodCommentTableViewCell
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
        
        _labelOfcomment = [[UILabel alloc] init];
        _labelOfcomment.text = @"评分";
        _labelOfcomment.font = [UIFont systemFontOfSize:13];
        _labelOfcomment.textAlignment = NSTextAlignmentRight;

        _star = [[EDStarRating alloc] init];
        _star.starImage = [UIImage imageNamed:@"星星未填充"];
        _star.starHighlightedImage = [UIImage imageNamed:@"星星填充"];
        _star.displayMode = EDStarRatingDisplayHalf;
        _star.maxRating = 5;
        [_star setNeedsDisplay];
        
        [self.contentView addSubview:_imageV0];
        [self.contentView addSubview:_imageV1];
        [self.contentView addSubview:_imageV2];
        [self.contentView addSubview:_labelOfContent];
        [self.contentView addSubview:_labelOfName];
        [self.contentView addSubview:_labelOfDate];
        [self.contentView addSubview:_labelOfcomment];
        [self.contentView addSubview:_star];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageV1.frame = CGRectMake(10, 10, 40, 40);
    _imageV2.frame = CGRectMake(60, 12, 20, 18);
    _imageV0.frame = CGRectMake(10, self.frame.size.height-2, self.frame.size.width-20, 2);
    _labelOfcomment.frame = CGRectMake(self.frame.size.width- 135 , 10, 30, 20);
    _star.frame = CGRectMake(self.frame.size.width - 109, 8.7, 100, 20);
    _labelOfName.frame = CGRectMake(85, 9.5, self.frame.size.width-85-130, 20);
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
