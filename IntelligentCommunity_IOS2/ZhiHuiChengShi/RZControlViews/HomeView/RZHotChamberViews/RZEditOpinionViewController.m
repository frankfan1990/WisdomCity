//
//  RZEditOpinionViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-21.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZEditOpinionViewController.h"

@interface RZEditOpinionViewController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    UITextView *textView;
    int number;
    UILabel *label;
}
@end

@implementation RZEditOpinionViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label1 = [[UILabel alloc] initWithFrame:rect];
        label1.textColor =[UIColor whiteColor];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = @"编辑观点";
        [label1 setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label1.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label1;
        
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    
    [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 200)];
    textView.delegate = self;
    textView.layer.cornerRadius = 10;
    textView.layer.masksToBounds = YES;
    textView.text = _textStr;
    textView.font = [UIFont systemFontOfSize:15];
    textView.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.view addSubview:textView];
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-20-60, 190, 60, 20)];
    label.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.view addSubview:textView];
    label.text = @"500字";
    label.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label];
    
    
    UIButton *btnOfExit = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOfExit.backgroundColor = [UIColor whiteColor];
    btnOfExit.layer.cornerRadius = 5;
    btnOfExit.layer.masksToBounds = YES;
    btnOfExit.frame = CGRectMake(15, 230, self.view.frame.size.width/2-30, 40);
    [btnOfExit addTarget:self action:@selector(Delete) forControlEvents:UIControlEventTouchUpInside];
    [btnOfExit setTitle:@"删除观点" forState:UIControlStateNormal];
    btnOfExit.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnOfExit setTitleColor:UIColorFromRGB(0x5496DF) forState:UIControlStateNormal];
    [self.view addSubview:btnOfExit];
    
    
    UIButton *btnOfDelete = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOfDelete.backgroundColor = UIColorFromRGB(0x5496DF);
    btnOfDelete.layer.cornerRadius = 5;
    btnOfDelete.layer.masksToBounds = YES;
    btnOfDelete.frame = CGRectMake(self.view.frame.size.width/2 + 15, 230, self.view.frame.size.width/2-30, 40);
    [btnOfDelete addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [btnOfDelete setTitle:@"提交观点" forState:UIControlStateNormal];
    btnOfDelete.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnOfDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btnOfDelete];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    self.navigationItem.titleView.userInteractionEnabled = YES;
    [self.navigationItem.titleView addGestureRecognizer:tapGesture];
    
    
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
- (void)textViewDidChange:(UITextView *)textView
{
    number = 500 -[textView.text length];
    label.text = [NSString stringWithFormat:@"%d字",number];
}
-(void)textViewDidBeginEditing:(UITextView *)textView1
{
    if ([textView.text isEqualToString:@"   每人仅可发表一次观点"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
-(void)edit
{
    if ([textView.text isEqualToString:_textStr]) {
        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:nil message:@"\n没有修改观点" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [aletView show];
    }else if ( [textView.text isEqualToString:@""]) {
        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:nil message:@"\n议题不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [aletView show];
    }else{
        [SVProgressHUD setStatus:@"正在提交"];
        [SVProgressHUD show];
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
       
    }
}
-(void)didTap
{
    [textView resignFirstResponder];
}
-(void)Delete
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"删除观点" message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alterView.delegate = self;
    [alterView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
