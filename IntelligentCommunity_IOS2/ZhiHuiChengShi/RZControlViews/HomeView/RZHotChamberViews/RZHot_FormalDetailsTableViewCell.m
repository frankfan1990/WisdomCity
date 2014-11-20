//
//  RZHot_FormalDetailsTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHot_FormalDetailsTableViewCell.h"

@implementation RZHot_FormalDetailsTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageV1 = [[UIImageView alloc] init];
        _imageV2 = [[UIImageView alloc] init];
        _imageV0 = [[UIImageView alloc] init];
        _btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _labelOfDate = [[UILabel alloc] init];
        _labelOfName = [[UILabel alloc] init];
        _labelOfContent = [[UILabel alloc] init];
        _labelofZan = [[UILabel alloc] init];
        _labelOfnumber = [[UILabel alloc] init];
        
        _labelOfName.textAlignment = NSTextAlignmentLeft;
        _labelOfDate.textAlignment = NSTextAlignmentLeft;
        _labelOfContent.textAlignment = NSTextAlignmentLeft;
        
        _labelOfName.font = [UIFont systemFontOfSize:14];
        _labelOfDate.font = [UIFont systemFontOfSize:13.5];
        _labelOfContent.font = [UIFont systemFontOfSize:15];
        _labelOfDate.textColor = UIColorFromRGB(0x8b8b8b);
        
        _labelOfContent.numberOfLines = 100;
        _imageV1.layer.cornerRadius = 20;
        _imageV1.layer.masksToBounds = YES;
        
        _labelOfName.adjustsFontSizeToFitWidth = YES;
        _imageV0.image = [UIImage imageNamed:@"虚线2.png"];
        
        _btn1.layer.cornerRadius = 5;
        _btn1.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
        _btn1.layer.borderWidth = 1;
        _btn1.layer.masksToBounds = YES;
        
        _labelofZan.textColor = UIColorFromRGB(0x8b8b8b);
        _labelOfnumber.textColor = UIColorFromRGB(0x5496DF);
        _labelofZan.text = @"人赞同";
        _labelofZan.textAlignment = NSTextAlignmentLeft;
        _labelOfnumber.textAlignment = NSTextAlignmentRight;
        
        _labelOfnumber.font = [UIFont systemFontOfSize:13.5];
        _labelofZan.font = [UIFont systemFontOfSize:13.5];
        
        _newlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 15)];
        _newlabel.text = @"最新观点";
        _newlabel.textAlignment = NSTextAlignmentLeft;
        _newlabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_newlabel];
        
        
        [self.contentView addSubview:_imageV1];
        [self.contentView addSubview:_imageV2];
        
        [self.contentView addSubview:_labelOfContent];
        [self.contentView addSubview:_labelOfName];
        [self.contentView addSubview:_labelOfDate];
        [self.contentView addSubview:_btn1];
        [self.contentView addSubview:_imageV0];
        
        [self.contentView addSubview:_labelOfnumber];
        [self.contentView addSubview:_labelofZan];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
   _imageV0.frame = CGRectMake(0, self.frame.size.height-2,self.frame.size.width, 2);
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
