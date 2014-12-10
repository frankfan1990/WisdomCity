//
//  RZDetailTakeoutTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-3.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDetailTakeoutTableViewCell.h"

@implementation RZDetailTakeoutTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1 = [[UILabel alloc] init];
        _label3 = [[UILabel alloc] init];
        _label2 = [[UILabel alloc] init];
        _numberlabel = [[UILabel alloc] init];
        _label4 = [[UILabel alloc] init];
        _imageV2 = [[UIImageView alloc] init];
        _imageV1 = [[UIImageView alloc] init];
        
        _label1.textColor = [UIColor whiteColor];
        _label1.text = @"优惠";
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.font = [UIFont systemFontOfSize:12];
        _label1.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_label1];
        
        _label2.textAlignment = NSTextAlignmentLeft;
        _label2.numberOfLines = 1000;
        _label2.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_label2];
        
        _label3.textAlignment = NSTextAlignmentLeft;
        _label3.textColor = UIColorFromRGB(0xa9a9a9);
        _label3.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_label3];
        
        _numberlabel.textColor = UIColorFromRGB(0x5695e2);
        _numberlabel.font = [UIFont systemFontOfSize:12];
        _numberlabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_numberlabel];
        
        _label4.text = @"回复";
        _label4.textColor = UIColorFromRGB(0xa9a9a9);
        _label4.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_label4];
        
        _imageV2.image = [UIImage imageNamed:@"向右灰"];
        [self.contentView addSubview:_imageV2];
        
        
        _imageV1.image = [UIImage imageNamed:@"虚线3"];
        [self.contentView addSubview:_imageV1];
    }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
