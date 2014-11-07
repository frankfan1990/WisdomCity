//
//  RZMyPhoneViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-10-30.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZMyPhoneViewController.h"
#import "RZRule.h"
#import "SVProgressHUD.h"
@interface RZMyPhoneViewController ()<UITextFieldDelegate>
{
    UITextField *numberField;
    UITextField *verificationField;
    UIButton *btn;
}
@end

@implementation RZMyPhoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"手机验证";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        self.navigationController.navigationBar.backgroundColor = UIColorFromRGB(0x5496DF);
        self.navigationController.navigationBar.translucent = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarButtonItems];
    [self createTextField];
    [self createLineView];
    [self createBtn];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(edit)];
    [self.view addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(edit)];
    self.navigationItem.titleView.userInteractionEnabled = YES;
    [self.navigationItem.titleView addGestureRecognizer:tapGesture2];
}
-(void)createBarButtonItems
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
    [btn2 setTitle:@"提交" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 40, 40)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@ selector(submit) forControlEvents:UIControlEventTouchUpInside];
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
}
-(void)createTextField
{
    numberField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width-130, 60)];
    verificationField = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, self.view.frame.size.width-30, 60)];
    numberField.placeholder = @"请输入绑定的手机号码";
    verificationField.placeholder = @"输入收到的验证码";
    
    numberField.tag = 101;
    verificationField.tag = 102;
    
    numberField.delegate = self;
    verificationField.delegate = self;
    [self.view addSubview:numberField];
    [self.view addSubview:verificationField];
}
-(void)createLineView
{
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 1)];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(10, 150, self.view.frame.size.width-20, 1)];
    
    line1.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    line2.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    
    [self.view addSubview:line1];
    [self.view addSubview:line2];
}
-(void)createBtn
{
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(self.view.frame.size.width-110, 20, 90, 35);
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didbtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor colorWithRed:107/255.0 green:209/255.0 blue:39/255.0 alpha:1];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
}
-(void)didbtn:(UIButton *)sender
{
    if ([numberField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"\n手机号码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if(!isValidatePhone(numberField.text)){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"\n请填写正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [SVProgressHUD setStatus:@"正在获取"];
        [SVProgressHUD show];
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
         [btn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
   
}
-(void)edit
{
    if([numberField isFirstResponder])
    {
        [numberField resignFirstResponder];
    }
    if([verificationField isFirstResponder])
    {
        [verificationField resignFirstResponder];
    }
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)submit
{
    if ([verificationField.text isEqualToString:@"520131"]) {
         [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"\n请输入正确的验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

//字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.tag==101){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length >11) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:10],string];
            
            return NO;
            
        }
        return YES;
    }
    else if(textField.tag==102){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 6) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:5],string];
            
            return NO;
            
        }
        return YES;
    }
    return YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
