//
//  RZMyCommentTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZMyCommentTableViewCell : UITableViewCell

@property(nonatomic,retain)IBOutlet UILabel *lbTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbTime;
@property(nonatomic,retain)IBOutlet UILabel *lbSubTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbLine;
@property(nonatomic,retain)IBOutlet UIImageView *rightImage;
@end
