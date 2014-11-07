//
//  RZActivity_oneTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-5.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZActivity_oneTableViewCell.h"

@implementation RZActivity_oneTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _label = [[UILabel alloc] init];
        _label.textColor = UIColorFromRGB(0x7c7c7c);
        _label.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:_label];

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = CGRectMake(0,5, self.frame.size.width, 20);
}
- (void)awakeFromNib {
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
