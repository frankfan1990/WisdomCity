//
//  RZInviteFamilyViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//
#pragma mark  邀请家人
#import "RZInviteFamilyViewController.h"

@interface RZInviteFamilyViewController ()<UITextViewDelegate>
{
    UITextView *textView;
}
@end

@implementation RZInviteFamilyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"邀请家人";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}
-(void)back{
 
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(IOS7){
        self.navigationController.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        self.navigationController.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
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
    [btn2 setTitle:@"转发" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 40, 40)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:19];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    //    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 200)];
    textView.delegate = self;
    textView.layer.cornerRadius = 10;
    textView.layer.masksToBounds = YES;
    textView.text = @"   说点啥";
    textView.font = [UIFont systemFontOfSize:17];
    textView.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.view addSubview:textView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-20-60, 190, 60, 20)];
    label.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.view addSubview:textView];
    label.text = @"500字";
    label.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label];
    
    
    UIButton *btnOfExit = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOfExit.backgroundColor = UIColorFromRGB(0x5496DF);
    btnOfExit.layer.cornerRadius = 5;
    btnOfExit.layer.masksToBounds = YES;
    btnOfExit.frame = CGRectMake(15, 230, self.view.frame.size.width-30, 50);
    [btnOfExit addTarget:self action:@selector(didgoto) forControlEvents:UIControlEventTouchUpInside];
    [btnOfExit setTitle:@"复制" forState:UIControlStateNormal];
    btnOfExit.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnOfExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btnOfExit];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)didgoto
{
    NSLog(@"复制");
}
//字数限制
- (BOOL)textView:(UITextView *)textView1 shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * toBeString = [textView1.text stringByReplacingCharactersInRange:range withString:text];
    if (toBeString.length >500) {
        
        textView1.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:499],text];
        
        return NO;
        
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView1
{
    if ([textView.text isEqualToString:@"   说点啥"]) {
        textView.text = @"   ";
        textView.textColor = [UIColor blackColor];
    }
}
-(void)edit
{
    if ([textView.text length]) {
        [SVProgressHUD setStatus:@"正在提交"];
        [SVProgressHUD show];
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    }else{
        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:nil message:@"\n请说点啥再提交" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [aletView show];
    }
}- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
