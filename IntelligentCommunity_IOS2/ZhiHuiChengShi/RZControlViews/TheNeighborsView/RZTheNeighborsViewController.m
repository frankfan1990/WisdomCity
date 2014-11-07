//
//  RZTheNeighborsViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//


#pragma mark   专题   邻居

#import "RZTheNeighborsViewController.h"
#import "RESideMenu.h"
@interface RZTheNeighborsViewController ()

@end

@implementation RZTheNeighborsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)showMeun{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [btnLeft setBackgroundImage:[UIImage imageNamed:@"面包按钮.png"] forState:UIControlStateNormal];
//        [btnLeft setBackgroundImage:[UIImage imageNamed:@"RzMenuIcon.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(showMeun) forControlEvents:UIControlEventTouchUpInside];
    //    [btnLeft addTarget:self action:@selector(meun:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setFrame:CGRectMake(5, 5, 30, 30)];
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRight setTitle:@"⬆️" forState:UIControlStateNormal];
    //    [btnRight setBackgroundImage:[UIImage imageNamed:@"RZback.png"] forState:UIControlStateNormal];
    //    [btnRight setBackgroundImage:[UIImage imageNamed:@"backh.png"] forState:UIControlStateHighlighted];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //    [btnRight addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnRightitem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnRightitem];
    }else{
        self.navigationItem.rightBarButtonItem = btnRightitem;
    }

        [self.view setBackgroundColor:[UIColor grayColor]];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"邻居";
    [label setFont:[UIFont systemFontOfSize:20]];
//    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
