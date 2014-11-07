//
//  RZMessageDetailsViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-11.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RcFaceView.h"
#import "RcMessaageTextImage.h"
#import "HPGrowingTextView.h"
#import "ZYQAssetPickerController.h"//多选
#import "FileManage.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
@interface RZMessageDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,RcFaceViewDelegate,HPGrowingTextViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate>
 
////表情
//-(IBAction)face:(id)sender;
//-(IBAction)fas:(id)sender;
@end
