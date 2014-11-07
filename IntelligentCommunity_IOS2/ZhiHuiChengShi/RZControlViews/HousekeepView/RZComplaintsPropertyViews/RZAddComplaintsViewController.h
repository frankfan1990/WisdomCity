//
//  RZAddComplaintsViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-15.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
@interface RZAddComplaintsViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIGestureRecognizerDelegate,MWPhotoBrowserDelegate>
{
    NSArray *_photos;
}
@end
