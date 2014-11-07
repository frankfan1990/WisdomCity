//
//  RZCollectionViewTwoFallsCell.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-21.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
/*二分图集瀑布流标准cell*/
@interface RZCollectionViewTwoFallsCell : UICollectionViewCell


@property (nonatomic, retain) IBOutlet UIView *viewContent;

@property (nonatomic, retain) IBOutlet UIImageView *imageTopView;

@property (nonatomic, retain) IBOutlet UIView *viewFooter;

@property (nonatomic, retain) IBOutlet UIImageView *leftBackImageView;

@property (nonatomic, retain) IBOutlet UILabel *lbleftTitle;
@property (nonatomic, retain) IBOutlet UILabel *lbContent;
@property (nonatomic, retain) IBOutlet UIImageView *imageIconNo1;

@property (nonatomic, retain) IBOutlet UILabel *lbIconNo1Title;

@property (nonatomic, retain) IBOutlet UILabel *lbDate;

@end
