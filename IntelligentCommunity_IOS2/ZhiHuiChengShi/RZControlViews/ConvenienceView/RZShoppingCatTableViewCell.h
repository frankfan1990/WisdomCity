//
//  RZShoppingCatTableViewCell.h
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZShoppingCatTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UILabel *labelOfFoodName;
@property(nonatomic,strong)UILabel *labelOfprice;
@property(nonatomic,strong)UILabel *labelOfStoreName;
@property(nonatomic,strong)UIButton *btnOfAdd;
@property(nonatomic,strong)UIButton *btnOfSubStract;
@property(nonatomic,strong)UITextField *numberField;
@property(nonatomic,strong)UIImageView *imageV0;//虚线
@end
