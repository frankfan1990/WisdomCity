
//
//  RZPhotographViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZPhotographViewController.h"
#import "RZAppDelegate.h"

@interface RZPhotographViewController ()

@end

@implementation RZPhotographViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"随手拍";
     [label setFont:[UIFont systemFontOfSize:20]];
//    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
}
//取得当前程序的委托
-(RZAppDelegate *)appDelegate{
    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    [self.view setBackgroundColor:[UIColor grayColor]];
    [[self appDelegate] clearUserInfos];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
