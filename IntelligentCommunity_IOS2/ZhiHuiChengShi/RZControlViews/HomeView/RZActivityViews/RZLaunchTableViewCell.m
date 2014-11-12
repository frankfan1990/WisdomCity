//
//  RZLaunchTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZLaunchTableViewCell.h"

@implementation RZLaunchTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1 = [[UILabel alloc] init];
        _label2 = [[UILabel alloc] init];
        _textField = [[UITextField alloc] init];
        _image1 = [[UIImageView alloc] init];
        _image1.image = [UIImage imageNamed:@"右箭头.png"];
        
        _image1.hidden = YES;
        _textField.adjustsFontSizeToFitWidth  = YES;
        _textField.textColor = UIColorFromRGB(0x000000);
        _label1.font = [UIFont systemFontOfSize:16];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.textColor = UIColorFromRGB(0x888888);
        
        _label2.textColor = UIColorFromRGB(0x5496DF);
        _label2.text = @"*";
        _label2.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_label1];
        [self.contentView addSubview:_label2];
        [self.contentView addSubview:_textField];
        [self.contentView addSubview:_image1];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _textField.frame = CGRectMake(125, 0, self.frame.size.width-150, 45);
    _image1.frame = CGRectMake(self.frame.size.width-30, 10, 20, 30);
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
