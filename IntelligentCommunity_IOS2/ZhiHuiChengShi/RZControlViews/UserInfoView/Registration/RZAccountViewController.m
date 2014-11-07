//
//  RZAccountViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-29.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZAccountViewController.h"
#import "RZAppDelegate.h"

@interface RZAccountViewController ()
{
        IBOutlet UITableView *_tableview;
        IBOutlet UITextField *txtuserName;
        IBOutlet UITextField *txtusernumber;
        IBOutlet UITextField *txtCaptcha;
        IBOutlet UITextField *txtuserPassWord;
        IBOutlet UITextField *txtuserPassWord2;
        IBOutlet UIButton *btnCaptcha;
        IBOutlet UIButton *btnNext;
        IBOutlet UIImageView *imgPass;
    NSString *Captcha;
    NSMutableDictionary *userRegistration;
    NSTimer *timer;
    NSInteger timecount;
    UIAlertView *alertHud;
    CGSize size;
    BOOL btnBool;
}
-(IBAction)btngetCaptcha:(id)sender;

-(IBAction)btnSelectNext:(id)sender;

@end

@implementation RZAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"账户信息";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;

    }
    return self;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
//取得当前程序的委托
-(RZAppDelegate *)appDelegate{
    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnBool = YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
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
    NSDictionary *temp=[[NSUserDefaults standardUserDefaults] objectForKey:REGISTRATION];
    userRegistration=[NSMutableDictionary dictionaryWithDictionary:temp];
    
    [imgPass setImage:[UIImage imageNamed:@"1.png"] ];
  
 
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:singleTap];
    
    btnNext.layer.masksToBounds=YES;
    btnNext.layer.cornerRadius=5;
    [btnNext setBackgroundColor:[UtilCheck getRZColor:70 green:128 blue:218 alpha:1]];
 
    btnCaptcha.layer.masksToBounds=YES;
    btnCaptcha.layer.cornerRadius=2;
    [btnCaptcha setBackgroundColor:[UtilCheck getRZColor:72 green:190 blue:88 alpha:1]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self Ext];
}
-(void)Ext{
    if([txtuserName isFirstResponder]){
        [txtuserName resignFirstResponder];
    }
   else if([txtCaptcha isFirstResponder]){
        [txtCaptcha resignFirstResponder];
    }
   else if([txtusernumber isFirstResponder]){
        [txtusernumber resignFirstResponder];
    }
   else if([txtuserPassWord isFirstResponder]){
        [txtuserPassWord resignFirstResponder];
    }
  else  if([txtuserPassWord2 isFirstResponder]){
        [txtuserPassWord2 resignFirstResponder];
    }
 
    
}
-(IBAction)btngetCaptcha:(id)sender{
    [self Ext];
    btnCaptcha.titleLabel.text = [NSString stringWithFormat:@"(%d)秒内有效",90-timecount];
    if (btnBool == NO) return;
    NSString *msg=nil;
    
    
    if([txtuserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet ]].length<1){
        msg=@"请您输入你的用户名";
    }
    else if(![UtilCheck isValidateMobile:[txtusernumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
        msg=@"请输入正确的手机号码";
    }
    if(msg==nil){
        //转的
         [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
         [self performSelector:@selector(Captchas) withObject:nil afterDelay:1];
        
          }
    else{
        btnBool = YES;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"瑞洲科技" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }


    
}
-(void)Captchas{
    [SVProgressHUD dismiss];
    btnBool = NO;
    Captcha=[NSString stringWithFormat:@"%d",arc4random()];
    if(timer!=nil){
        [timer invalidate];
    }
    timecount=0;
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shoutime)  userInfo:nil repeats:YES];
    
    txtCaptcha.text=Captcha;

}
-(void)shoutime{
    timecount++;
    
    if(timecount>90){
        btnCaptcha.enabled=YES;
        btnBool = YES;
        [timer invalidate];
        [btnCaptcha setTitle:[NSString stringWithFormat:@"%@",@"重新获取"] forState:UIControlStateNormal ];
        
    }
    else{
        [btnCaptcha setTitle:[NSString stringWithFormat:@"(%d)秒内有效",90-timecount] forState:UIControlStateNormal ];
    }
}
-(IBAction)btnSelectNext:(id)sender{
       [self Ext];
 
    NSString *msg=nil;
 
    
    if([txtuserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet ]].length<1){
        msg=@"请您输入你的用户名";
    }
    else if(![UtilCheck isValidateMobile:[txtusernumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
        msg=@"请输入正确的手机号码";
    }
    else if(Captcha.length<1){
        msg=@"请先获取验证码在注册";
    }
    else if(![[txtCaptcha.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:Captcha]){
        msg=@"输入的验证码无效";
        [imgPass setImage:[UIImage imageNamed:@"2.png"]];
    }
    else if( [txtuserPassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<1){
        msg=@"请设置密码";
    }
    else if([txtuserPassWord2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<1){
        msg=@"请确认密码";
    }
    else if(![[txtuserPassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:[txtuserPassWord2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
        msg=@"前后两次输入密码不匹配";
    }
    else if([txtuserPassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<6||[[txtuserPassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@"111111"]){
        txtuserPassWord.text=@"";
        txtuserPassWord2.text=@"";
                msg=@"您设置的密码过于简单，请重新设置。";
    }
    if([[txtCaptcha.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:Captcha]){
        [imgPass setImage:[UIImage imageNamed:@"3.png"]];
    }
    
    if(msg==nil){
        [userRegistration setObject:txtuserName.text forKey:@"userName"];
                [userRegistration setObject:txtusernumber.text forKey:@"userNumber"];
                [userRegistration setObject:txtuserPassWord2.text forKey:@"userPassWord"];
        NSUserDefaults *userregistration=[NSUserDefaults standardUserDefaults];
        [userregistration setValue:userRegistration forKeyPath:REGISTRATION];
        [userregistration synchronize];
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
 
        [self performSelector:@selector(datarequest) withObject:nil afterDelay:CLEAR_TIME];
 
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"瑞洲科技" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)datarequest{
    [SVProgressHUD dismiss];
    alertHud=[[UIAlertView alloc] initWithTitle:nil message:@"          恭喜您！注册成功            " delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alertHud show];
     [self performSelector:@selector(Registrations) withObject:nil afterDelay:CLEAR_TIME];
}
-(void)Registrations{
    [alertHud dismissWithClickedButtonIndex:0 animated:YES];
    [self.navigationController removeFromParentViewController];
    [[self appDelegate] goInfo:NO];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField isEqual:txtCaptcha]){
          if(![[txtCaptcha.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:Captcha]){
            [imgPass setImage:[UIImage imageNamed:@"2.png"]];
        }
        else if([[txtCaptcha.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:Captcha]){
            [imgPass setImage:[UIImage imageNamed:@"3.png"]];
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([textField isEqual:txtuserName]){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length >20) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:19],string];
            
            return NO;
            
        }
        return YES;
    }
    else if([textField isEqual:txtusernumber]){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 11) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:10],string];
            
            return NO;
            
        }
        return YES;
    }
    else if([textField isEqual:txtCaptcha]){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 6) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:5],string];
            
            return NO;
            
        }
        return YES;
    }
    
    else if([textField isEqual:txtuserPassWord]){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 20) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:19],string];
            
            return NO;
            
        }
        return YES;
    }
    else if([textField isEqual:txtuserPassWord2]){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 20) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:19],string];
            
            return NO;
            
        }
        return YES;
    }
    return YES;
    
}

//缩短uitableview 滑动
-(void) keyBoardWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [_tableview   setFrame:CGRectMake(_tableview.frame.origin.x, _tableview.frame.origin.y, _tableview.frame.size.width, self.view.frame.size.height - size.height)];
   [_tableview setContentOffset:CGPointMake(0,_tableview.contentOffset.y+10)];
}
//还原
-(void) keyBoardWillHide:(NSNotification *)note{
    
    [_tableview setFrame:CGRectMake(_tableview.frame.origin.x, _tableview.frame.origin.y, _tableview.frame.size.width, _tableview.frame.size.height+size.height)];
       [_tableview setContentOffset:CGPointMake(0, _tableview.contentOffset.y-10)];
}
@end
