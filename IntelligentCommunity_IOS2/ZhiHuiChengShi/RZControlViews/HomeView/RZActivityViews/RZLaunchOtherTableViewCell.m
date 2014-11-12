//
//  RZLaunchOtherTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-11.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZLaunchOtherTableViewCell.h"

@implementation RZLaunchOtherTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] init];
        _label2 = [[UILabel alloc] init];
        _textView = [[UITextView alloc] init];
       
        _label2.textAlignment = NSTextAlignmentRight;
        _label2.textColor = UIColorFromRGB(0x969696);
      
        _label.textColor = UIColorFromRGB(0x969696);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"上传照片吧！";
        _label.font = [UIFont systemFontOfSize:19];
        _label.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        _textView.text = @"  输入活动详情";
        _textView.textColor = UIColorFromRGB(0xc5c5c5);
        _textView.font = [UIFont systemFontOfSize:19];
        _textView.layer.cornerRadius = 8;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
        _textView.layer.borderWidth = 1;
        
        _label.layer.cornerRadius = 5;
        _label.layer.masksToBounds = YES;
        _label.userInteractionEnabled = YES;
        [self.contentView addSubview:_label];
        [self.contentView addSubview:_textView];
        [self.contentView addSubview:_label2];
    }
    return  self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = CGRectMake(10, 25, self.frame.size.width-20, 75);
    _textView.frame = CGRectMake( 10, 25+75+20, self.frame.size.width-20, 180);
    _label2.frame = CGRectMake(self.frame.size.width-100, 25+75+20+155, 80, 20);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
