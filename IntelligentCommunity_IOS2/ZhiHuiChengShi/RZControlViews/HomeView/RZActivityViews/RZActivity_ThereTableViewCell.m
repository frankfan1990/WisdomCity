//
//  RZActivity_ThereTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-6.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZActivity_ThereTableViewCell.h"

@implementation RZActivity_ThereTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1 = [[UILabel alloc] init];
        _label2 = [[UILabel alloc] init];
        _label3 = [[UILabel alloc] init];
        _label4 = [[UILabel alloc] init];
        _label5 = [[UILabel alloc] init];
        
        _label1.textColor = UIColorFromRGB(0x8b8b8b);
        _label2.textColor = UIColorFromRGB(0x8b8b8b);
        _label3.textColor = UIColorFromRGB(0x8b8b8b);
        _label4.textColor = UIColorFromRGB(0x5496DF);
        _label5.textColor = UIColorFromRGB(0x8b8b8b);
        
        _label1.textAlignment = NSTextAlignmentCenter;
        _label2.textAlignment = NSTextAlignmentLeft;
        _label3.textAlignment = NSTextAlignmentLeft;
        _label4.textAlignment = NSTextAlignmentCenter;
        _label5.textAlignment = NSTextAlignmentLeft;
        
        _label4.adjustsFontSizeToFitWidth = YES;
        
        _label1.font = [UIFont systemFontOfSize:13];
        _label2.font = [UIFont systemFontOfSize:13];
        _label3.font = [UIFont systemFontOfSize:13];
        _label4.font = [UIFont systemFontOfSize:13];
        _label5.font = [UIFont systemFontOfSize:13];
        
     
        
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.backgroundColor = UIColorFromRGB(0x5496DF);
        _btn.layer.cornerRadius = 5;
        _btn.layer.masksToBounds = YES;
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
         [self.contentView addSubview:_label1];
         [self.contentView addSubview:_label2];
         [self.contentView addSubview:_label3];
         [self.contentView addSubview:_label4];
         [self.contentView addSubview:_label5];
         [self.contentView addSubview:_btn];
        
        
    }
    return  self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _label1.frame = CGRectMake(0, 8, self.frame.size.width, 20);
    _btn.frame = CGRectMake(10, 35, self.frame.size.width-20, 40);
    _label2.frame = CGRectMake(self.frame.size.width/4-15, 80 ,self.frame.size.width/4+15, 20);
    _label3.frame = CGRectMake(self.frame.size.width/2+10, 80, 50, 20);
    _label4.frame = CGRectMake(self.frame.size.width/2+10+50, 80, 25, 20);
    _label5.frame = CGRectMake(self.frame.size.width/2+10+50+25, 80, 15, 20);
    
    
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
