//
//  RZDetails_OneTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-13.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDetails_OneTableViewCell.h"

@implementation RZDetails_OneTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _btnOfComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOfZan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOfShare = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        _btnOfZan.layer.borderWidth = 1;
        _btnOfZan.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
        _btnOfShare.layer.borderWidth = 1;
        _btnOfShare.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
        _btnOfComment.layer.borderWidth = 1;
        _btnOfComment.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
        
        _btnOfComment.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnOfShare.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnOfZan.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnOfComment.titleLabel.adjustsFontSizeToFitWidth = YES;
        _btnOfShare.titleLabel.adjustsFontSizeToFitWidth = YES;
        _btnOfZan.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        UIImageView *imageV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评论.png"]];
        UIImageView *imageV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"赞实心.png"]];
        UIImageView *imageV3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"分享.png"]];
        imageV1.frame = CGRectMake(10, 10, 30, 20);
        imageV2.frame = CGRectMake(20, 8, 25, 25);
        imageV3.frame = CGRectMake(20, 10, 25, 23);
        [_btnOfComment addSubview:imageV1];
        [_btnOfZan addSubview:imageV2];
        [_btnOfShare addSubview:imageV3];
     
        [self.contentView addSubview:_btnOfComment];
        [self.contentView addSubview:_btnOfShare];
        [self.contentView addSubview:_btnOfZan];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _btnOfComment.frame = CGRectMake(0, 0, self.frame.size.width/3, 40);
    _btnOfZan.frame = CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3, 40);
    _btnOfShare.frame = CGRectMake(self.frame.size.width*2/3, 0, self.frame.size.width/3, 40);
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
