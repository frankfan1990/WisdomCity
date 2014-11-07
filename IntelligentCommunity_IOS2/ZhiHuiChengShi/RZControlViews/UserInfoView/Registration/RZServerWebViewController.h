//
//  RZServerWebViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface RZServerWebViewController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate,MFMessageComposeViewControllerDelegate>
{
      UILabel *lblLoadstat;
 
    IBOutlet UIActivityIndicatorView *loadingActi;
    UIScrollView *imageScroll;
 
    UIImageView *imageView;
    UIView *backView;
    
   IBOutlet UIView *bottomView;
    IBOutlet UIWebView *webviews;
    

}

@property(nonatomic,retain) NSString  *webviewUrl;
@property(nonatomic) BOOL  hideBottom;

-(IBAction) mainPage;
-(IBAction) backPage;
-(IBAction) forward;
-(IBAction) refresh;
@end
