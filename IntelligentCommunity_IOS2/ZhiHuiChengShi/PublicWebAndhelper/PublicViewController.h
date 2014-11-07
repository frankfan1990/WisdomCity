//
//  PublicViewController.h
//  RcYiRenTang
//
//  Created by H.DX on 14-6-9.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic) NSInteger Type;
@property(nonatomic,retain)NSString *url;
@property(nonatomic) NSInteger Types;

@end
