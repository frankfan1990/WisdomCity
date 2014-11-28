//
//  RZAddSerViceNumberViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

//!!!:三个按钮没实现
#import "RZAddSerViceNumberViewController.h"

@interface RZAddSerViceNumberViewController ()

@end

@implementation RZAddSerViceNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"添加";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, Mywidth, 20)];
    label.text = @"请添加你居住小区的服务号码";
    label.textColor = [UIColor blackColor];
    label.textAlignment =  NSTextAlignmentCenter;
    label.alpha = 0.9;
//     NSArray *arr=  [UIFont familyNames];
//    NSLog(@"%@",arr);
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.backgroundColor = UIColorFromRGB(0x5496DF);
    btn1.frame = CGRectMake(15, 120, Mywidth-30, 45);
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 7;
    [btn1 addTarget:self action:@selector(didBtn1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"从手机通讯录选取号码" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.backgroundColor = UIColorFromRGB(0x5496DF);
    btn2.frame = CGRectMake(15, 120+60+5, Mywidth-30, 45);
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 7;
    [btn2 addTarget:self action:@selector(didBtn2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"拍照片" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.backgroundColor = UIColorFromRGB(0x5496DF);
    [btn3 addTarget:self action:@selector(didBtn3) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(15, 120+55+65+10, Mywidth-30, 45);
    btn3.layer.masksToBounds = YES;
    btn3.layer.cornerRadius = 7;
     [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"手动输入添加" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
}
-(void)setTabBar{
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
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
}
-(void)didBtn1
{
    NSLog(@"11111");
}
-(void)didBtn2
{
    NSLog(@"22222");
}
-(void)didBtn3
{
    NSLog(@"33333");
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
