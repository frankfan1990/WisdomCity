//
//  RZHotChamberListViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-4.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark ** 找一找/首页 - 热点议事厅
#import "RZCreateHotViewController.h"
#import "RZHotChamberListViewController.h"
#import "RESideMenu.h"
#import "TextStepperField.h"

@interface RZHotChamberListViewController ()
{
    UIButton *formalBtn;
    UIButton *prepareBtn;
}
@end

@implementation RZHotChamberListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"热点议事厅";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}
-(void)back{
 
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabar];
    [self createSegment];
    
}

-(void)setTabar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"发起" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didFaQi) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
}
-(void)createSegment
{
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, self.view.frame.size.width-30, 40)];
    [segmentView setBackgroundColor:[UIColor clearColor]];
    segmentView.layer.cornerRadius = 7;
    segmentView.layer.masksToBounds = YES;
    segmentView.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
    segmentView.layer.borderWidth = 1;
    [self.view addSubview:segmentView];
    
    
    formalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [formalBtn setTitle:@"正式议题" forState:UIControlStateNormal];
    formalBtn.selected = YES;
    [formalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [formalBtn setTitleColor:UIColorFromRGB(0x5496DF) forState:UIControlStateNormal];
    formalBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [formalBtn addTarget:self action:@selector(didFormal) forControlEvents:UIControlEventTouchUpInside];
    formalBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    
    
    formalBtn.frame = CGRectMake(0, 0, (self.view.frame.size.width-30)/2, 40);
    [segmentView addSubview:formalBtn];
    
    prepareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [prepareBtn setTitle:@"预备议题" forState:UIControlStateNormal];
     prepareBtn.backgroundColor = [UIColor whiteColor];
    prepareBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [prepareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [prepareBtn setTitleColor:UIColorFromRGB(0x5496DF) forState:UIControlStateNormal];
    [prepareBtn addTarget:self action:@selector(didPrepare) forControlEvents:UIControlEventTouchUpInside];
    prepareBtn.frame = CGRectMake((self.view.frame.size.width-30)/2, 0, (self.view.frame.size.width-30)/2, 40);
    [segmentView addSubview:prepareBtn];
    
}

-(void)didFormal
{
    formalBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    prepareBtn.backgroundColor = [UIColor whiteColor];
    formalBtn.selected = YES;
    prepareBtn.selected = NO;
}
-(void)didPrepare
{
    formalBtn.backgroundColor = [UIColor whiteColor];
    prepareBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    formalBtn.selected = NO;
    prepareBtn.selected = YES;
}
-(void)starRatingView:(RZStarRatingView *)view score:(float)score
{
    NSLog(@"%f",score/2);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFaQi
{
    RZCreateHotViewController *createCtrl = [[RZCreateHotViewController alloc] init];
    [self.navigationController pushViewController:createCtrl animated:YES];
    
}
@end
