//
//  RZHot_FormalTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomLabel;
@interface RZHot_FormalTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *labelOfnumber_head;
@property(nonatomic,strong)UILabel *labelOftitle;
@property(nonatomic,strong)UILabel *labelOftime;
@property(nonatomic,strong)UILabel *labelOfNumber_comment;
@property(nonatomic,strong)UILabel *labelOfComment;
@property(nonatomic,strong)CustomLabel *labelOfoption;
@property(nonatomic,strong)UIView *blueView;
@property(nonatomic,strong)UIView *orangeView;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)UIImageView *imageV1;
@property(nonatomic,strong)UIImageView *imageV2;
@property(nonatomic,strong)CustomLabel *labelOfHotComent;
@property(nonatomic,strong)UIView *lineView;
@end
