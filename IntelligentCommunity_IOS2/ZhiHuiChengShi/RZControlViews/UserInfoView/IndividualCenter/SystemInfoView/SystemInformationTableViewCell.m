//
//  SystemInformationTableViewCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-3.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "SystemInformationTableViewCell.h"

@implementation SystemInformationTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelOfName = [[UILabel alloc] init];
        _labelOfDate = [[UILabel alloc] init];
        _labelOfContent = [[UILabel alloc] init];
        
        _labelOfName.textAlignment = NSTextAlignmentLeft;
        _labelOfContent.textAlignment = NSTextAlignmentLeft;
        _labelOfDate.textAlignment = NSTextAlignmentRight;
        
        _labelOfDate.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        _labelOfContent.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        _labelOfContent.numberOfLines = 2;
        _labelOfName.font = [UIFont systemFontOfSize:17];
        
        [self.contentView addSubview:_labelOfDate];
        [self.contentView addSubview:_labelOfContent];
        [self.contentView addSubview:_labelOfName];
    }
    
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _labelOfName.frame = CGRectMake(10, 10, self.frame.size.width-120, 20);
    _labelOfContent.frame = CGRectMake(10, 40, self.frame.size.width-20, 50);
    _labelOfDate.frame = CGRectMake(self.frame.size.width-100, 10, 90, 20);
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
