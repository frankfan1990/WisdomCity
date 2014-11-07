//
//  RZMyMaterialCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-10-30.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZMyMaterialCell.h"

@implementation RZMyMaterialCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        _labname = [[UILabel alloc] init];
        _labname.textColor = UIColorFromRGB(0x848484);
        
        _textmessage = [[UITextField alloc] init];
        _labname.textAlignment = NSTextAlignmentLeft;
        _textmessage.textAlignment = NSTextAlignmentLeft;
        _imagegoto = [[UIImageView alloc] init];
        _imagegoto.image = [UIImage imageNamed:@"箭头icon.png"];
        
        _textmessage.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_imagegoto];
        [self addSubview:_labname];
        [self addSubview:_textmessage];

    }
    return self;
}

- (void)awakeFromNib
{
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _textmessage.frame = CGRectMake(90, 0, self.frame.size.width-160, 53);
    _labname.frame = CGRectMake(10, 0,80,53);
    _imagegoto.frame = CGRectMake(self.frame.size.width-45, 12, 30, 30);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
