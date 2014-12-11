//
//  RZRegistrationViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-26.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZRegistrationViewController.h"
#import "RZAppDelegate.h"
#import "RZIdentityViewController.h"
#import "RZServerWebViewController.h"
#import "MMLocationManager.h"

@interface RZRegistrationViewController ()
{
    IBOutlet UITextField *txtuserCity;
    IBOutlet UITextField *txtuserResidentialQuarters;
    IBOutlet UITextField *txtuserRoomNumber;

    IBOutlet UIButton *btnRule;
    
    IBOutlet UIButton *isAgreeRule;
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnActivationCode;
    NSString *strId;
    NSString *strIdtwo;
    NSString *locationCity;
    NSMutableDictionary *userRegistration;
    
}
-(IBAction)btnSelectCity:(id)sender;
-(IBAction)btnSelectResidentialQuarters:(id)sender;
-(IBAction)btnSelectRoomNumber:(id)sender;

-(IBAction)btnSelectisAgreeRule:(id)sender;

-(IBAction)btnSelectRule:(id)sender;
-(IBAction)btnSelectNext:(id)sender;
-(IBAction)btnSelectActivationCode:(id)sender;
@end

@implementation RZRegistrationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"房屋信息";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
 
    }
    return self;
}
-(void)back{
    
    NSUserDefaults *userregistration=[NSUserDefaults standardUserDefaults];
    [userregistration setValue:userRegistration forKeyPath:REGISTRATION];
    [userregistration synchronize];
    
    [[self appDelegate] goInfo:NO];
    
}
//取得当前程序的委托
-(RZAppDelegate *)appDelegate{
    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[MMLocationManager shareLocation] getCity:^(NSString *addressString) {
        locationCity = [addressString description];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    strId = [NSString string];
    strIdtwo = [NSString string];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

    [self.view setBackgroundColor:[UIColor grayColor]];
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
    userRegistration=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    [isAgreeRule setImage:[UIImage imageNamed:@"未选中勾.png"] forState:UIControlStateNormal];
    [isAgreeRule setImage:[UIImage imageNamed:@"勾选中.png"] forState:UIControlStateSelected];
    btnNext.layer.masksToBounds=YES;
    btnNext.layer.cornerRadius=5;
    [btnNext setBackgroundColor:[UtilCheck getRZColor:70 green:128 blue:218 alpha:1]];
    
    btnActivationCode.layer.masksToBounds=YES;
    btnActivationCode.layer.cornerRadius=5;
    [btnActivationCode setBackgroundColor:[UtilCheck getRZColor:108 green:202 blue:54 alpha:1]];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake((btnActivationCode.bounds.size.width-btnActivationCode.titleLabel.bounds.size.width)/2-btnActivationCode.titleLabel.bounds.size.height-5, (btnActivationCode.bounds.size.height-btnActivationCode.titleLabel.bounds.size.height)/2, btnActivationCode.titleLabel.bounds.size.height, btnActivationCode.titleLabel.bounds.size.height)];
    [image setImage:[UIImage imageNamed:@"二维码"]];
    [btnActivationCode addSubview:image];
        NSUserDefaults *userregistration=[NSUserDefaults standardUserDefaults];
    if([userregistration objectForKey:REGISTRATION]!=nil){
        NSDictionary *temp=[userregistration objectForKey:REGISTRATION];
        txtuserCity.text=[temp objectForKey:@"City"];
            txtuserResidentialQuarters.text=[temp objectForKey:@"ResidentialQuarters"];
            txtuserRoomNumber.text=[temp objectForKey:@"RoomNumber"];
    }
 
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIBUTTON EVENT
-(IBAction)btnSelectCity:(id)sender{
    RZSelectViewController *view=[[RZSelectViewController alloc] initWithNibName:@"RZSelectViewController" bundle:nil];
    view.type=1;
    view.titleName=@"选择城市";
    view.delegate = self;
    if ([self.cityStr length]) {
        view.locationCity = self.cityStr;
    }else{
        view.locationCity = locationCity;
    }
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
//    [nav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"navBackimage"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    if(IOS7){
        nav.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
        nav.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    [self presentViewController:nav animated:YES completion:nil];
}
-(IBAction)btnSelectResidentialQuarters:(id)sender{
    if(txtuserCity.text.length>0){
    RZSelectViewController *view=[[RZSelectViewController alloc] initWithNibName:@"RZSelectViewController" bundle:nil];
    view.type=2;
    view.titleName=@"选择小区";
    view.delegate = self;
    view.titleId = strId;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
//    [nav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"navBackimage"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
        if(IOS7){
            nav.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
        }
        else{
            nav.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
        }
    [self presentViewController:nav animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"\n请选择所在城市" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
}
-(IBAction)btnSelectRoomNumber:(id)sender{
    if(txtuserResidentialQuarters.text.length>0){
        RZSelectViewController *view=[[RZSelectViewController alloc] initWithNibName:@"RZSelectViewController" bundle:nil];
        view.type=3;
        view.titleName=@"选择房号";
        view.delegate = self;
        view.titletwo = strIdtwo;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
        //    [nav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"navBackimage"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
        if(IOS7){
            nav.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
        }
        else{
            nav.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
        }
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"\n请选择所在城市小区" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
}

//selectView的代理
-(void)selectData:(NSString *)DataString Type:(NSInteger)type Id:(NSString *)ID{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if(type==1){
        strId = ID;

        if([txtuserCity.text isEqualToString:DataString]){
            
        }
        else{
            txtuserCity.text=DataString;
            txtuserResidentialQuarters.text=@"";
            txtuserRoomNumber.text=@"";
        }
        
        
    }
    else if(type==2){
        strIdtwo = ID;
        if([txtuserResidentialQuarters.text isEqualToString:DataString]){
            
        }
        else{
            txtuserResidentialQuarters.text=DataString;
            txtuserRoomNumber.text=@"";
        }
    }
    else if(type==3){
        txtuserRoomNumber.text=DataString;
    }
    
    [userRegistration setObject:txtuserCity.text forKey:@"City"];
    [userRegistration setObject:txtuserResidentialQuarters.text forKey:@"ResidentialQuarters"];
    [userRegistration setObject:txtuserRoomNumber.text forKey:@"RoomNumber"];
}

-(IBAction)btnSelectisAgreeRule:(id)sender{
    UIButton *btn=(UIButton*)sender;
    btn.selected=!btn.selected;
}

-(IBAction)btnSelectRule:(id)sender{
 
    RZServerWebViewController *view=[[RZServerWebViewController alloc] initWithNibName:@"RZServerWebViewController" bundle:nil];
    view.webviewUrl=@"http://www.hao123.com/?tn=96547827_s_hao_pg";
    view.hideBottom=NO;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
 
    if(IOS7){
        nav.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
        nav.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    [self.navigationController presentViewController:nav animated:YES completion:nil];

    
}
-(IBAction)btnSelectNext:(id)sender{
    NSString *msg=nil;
    if(txtuserCity.text.length<1){
        msg=@"\n请选择所在城市";
    }
    else if(txtuserResidentialQuarters.text.length<1){
        msg=@"\n请选择所在城市小区";
    }
    else if (txtuserRoomNumber.text.length<1){
        msg=@"\n请选择所在小区房号";
    }
    else if(!isAgreeRule.selected){
         msg=@"\n请阅读并同意《智慧小区应用使用条款与隐私规则》";
    }
    if(msg==nil){
        [userRegistration setObject:txtuserCity.text forKey:@"City"];
        [userRegistration setObject:txtuserResidentialQuarters.text forKey:@"ResidentialQuarters"];
        [userRegistration setObject:txtuserRoomNumber.text forKey:@"RoomNumber"];
        NSUserDefaults *userregistration=[NSUserDefaults standardUserDefaults];
        //?????
        [userregistration setValue:userRegistration forKeyPath:REGISTRATION];
        
        
        [userregistration synchronize];
        RZIdentityViewController *view=[[RZIdentityViewController alloc] initWithNibName:@"RZIdentityViewController" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
}
-(IBAction)btnSelectActivationCode:(id)sender{
    
}
@end
