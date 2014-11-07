//
//  RZUderTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-3.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZUderTableViewCell.h"

@implementation RZUderTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lableOfName = [[UILabel alloc] init];
        _labelOfSignature = [[UILabel alloc] init];
        _image1 = [[UIImageView alloc] init];
        _image2 = [[UIImageView alloc] init];
        
        _labelOfSignature.textAlignment = NSTextAlignmentLeft;
        _labelOfSignature.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        
        
        _lableOfName.textAlignment = NSTextAlignmentLeft;
        
        _image1.layer.masksToBounds = YES;
        _image1.layer.cornerRadius = 30;
        [self.contentView addSubview:_labelOfSignature];
        [self.contentView addSubview:_lableOfName];
        [self.contentView addSubview:_image1];
        [self.contentView addSubview:_image2];
    }
    return self;
}
- (void)awakeFromNib {

    // Initialization code
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _image1.frame = CGRectMake(10,10, 60, 60);
    _image2.frame = CGRectMake(80, 10, 28, 30);
    
    _lableOfName.frame = CGRectMake(110, 15, self.frame.size.width-100, 20);
    _labelOfSignature.frame = CGRectMake(80, 45,  self.frame.size.width-100, 20);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
