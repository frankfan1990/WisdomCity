//
//  RZActivityListCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-25.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZActivityListCell : UITableViewCell

@property(nonatomic,retain)  IBOutlet UIImageView *image;
@property(nonatomic,retain)IBOutlet UIImageView *icon;
@property(nonatomic,retain)IBOutlet UILabel *lbimgTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbSubTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbOtherTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbaddress;

@property(nonatomic,retain)IBOutlet UILabel *lbline;
@end
