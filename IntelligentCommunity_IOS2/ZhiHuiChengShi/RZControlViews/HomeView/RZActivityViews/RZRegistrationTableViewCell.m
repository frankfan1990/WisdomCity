//
//  RZRegistrationTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZRegistrationTableViewCell.h"

@implementation RZRegistrationTableViewCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1 = [[UILabel alloc] init];
        _label2 = [[UILabel alloc] init];
        _textField = [[UITextField alloc] init];
        
        _label1.font = [UIFont systemFontOfSize:14];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.textColor = UIColorFromRGB(0x888888);
        
        _label2.textColor = UIColorFromRGB(0x5496DF);
        _label2.text = @"*";
        _label2.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_label1];
        [self.contentView addSubview:_label2];
        [self.contentView addSubview:_textField];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _label1.frame = CGRectMake( 15, 0, 60, 38);
    _label2.frame = CGRectMake( 50, 10, 18, 18);
    _textField.frame = CGRectMake(100, 0, self.frame.size.width-100, 38);

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
