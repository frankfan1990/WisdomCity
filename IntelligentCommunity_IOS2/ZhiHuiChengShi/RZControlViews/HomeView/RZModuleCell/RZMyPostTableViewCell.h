//
//  RZMyPostTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZMyPostTableViewCell : UITableViewCell



@property(nonatomic,retain)IBOutlet UILabel *lbTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbTime;
@property(nonatomic,retain)IBOutlet UILabel *lbcomment;
@property(nonatomic,retain)IBOutlet UILabel *lbnice;
@property(nonatomic,retain)IBOutlet UIView *contentview;
@property(nonatomic,retain)IBOutlet UIImageView *imageTop;
@property(nonatomic,retain)IBOutlet UIImageView *imagecomment;
@property(nonatomic,retain)IBOutlet UIImageView *imagenice;


@end
