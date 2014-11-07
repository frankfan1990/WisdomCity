//
//  RZKeepCommentTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-12.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZKeepCommentTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *lbTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbTime;
@property(nonatomic,retain)IBOutlet UILabel *lbSubTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbLine;
@property(nonatomic,retain)IBOutlet UIImageView *imageHead;
@property(nonatomic,retain)IBOutlet UIImageView *imagesex;
@property(nonatomic,retain)IBOutlet UIButton *btncomment;
@end
