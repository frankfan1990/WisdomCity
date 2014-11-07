//
//  RZActivity_FourTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-6.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZActivity_FourTableViewCell.h"

@implementation RZActivity_FourTableViewCell




-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         _btnone = [UIButton buttonWithType:UIButtonTypeSystem];
         _btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn2.layer.borderWidth = 1;
        _btn2.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
        _btnone.layer.borderWidth = 1;
        _btnone.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
        [self.contentView addSubview:_btnone];
        [self.contentView addSubview:_btn2];
        
        UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评论.png"]];
        image1.frame = CGRectMake(40, 10, 30, 25);
        UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"分享.png"]];
        image2.frame = CGRectMake(40, 10, 27, 25);
        
        [_btnone addSubview:image1];
        [_btn2 addSubview:image2];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 50, 45)];
        label2.text = @"分享";
        label2.font =[UIFont systemFontOfSize:15];
        [_btn2 addSubview:label2];
      
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _btnone.frame = CGRectMake(0, 0, self.frame.size.width/2, 45);
    _btn2.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, 45);
}
- (void)awakeFromNib {
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
