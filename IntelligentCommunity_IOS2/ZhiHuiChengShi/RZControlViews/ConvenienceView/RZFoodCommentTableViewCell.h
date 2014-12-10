//
//  RZFoodCommentTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-9.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
@interface RZFoodCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imageV0;
@property(nonatomic,strong)UIImageView *imageV1;
@property(nonatomic,strong)UIImageView *imageV2;
@property(nonatomic,strong)UILabel *labelOfName;
@property(nonatomic,strong)UILabel *labelOfDate;
@property(nonatomic,strong)UILabel *labelOfContent;
@property(nonatomic,strong)UILabel *labelOfcomment;
@property(nonatomic,strong)EDStarRating *star;
@end
