//
//  RZIdentityViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-26.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZIdentityViewController.h"
#import "RZAccountViewController.h"
@interface RZIdentityViewController ()
{
    IBOutlet UILabel *lbNumber;
    IBOutlet UITextField *txtNumber1;
    IBOutlet UITextField *txtNumber2;
    IBOutlet UITextField *txtRole;

    IBOutlet UIButton *btnRole;
    IBOutlet UIButton *btnHousePropertyCard;
    IBOutlet UIButton *btnFamilyMembers;
    IBOutlet UIButton *btnTenant;
    IBOutlet UIButton *btnNext;
    
     NSMutableDictionary *userRegistration;
    NSString *defaultnumber;//预留手机号
}
-(IBAction)btnSelectRole:(id)sender;
-(IBAction)btnSelectHousePropertyCard:(id)sender;

-(IBAction)btnSelectFamilyMembers:(id)sender;
-(IBAction)btnSelectTenant:(id)sender;
-(IBAction)btnSelectNext:(id)sender;

@end

@implementation RZIdentityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"身份信息";
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
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
    userRegistration=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSDictionary *temp=[[NSUserDefaults standardUserDefaults] objectForKey:REGISTRATION];
    userRegistration=[NSMutableDictionary dictionaryWithDictionary:temp];
    defaultnumber=@"15344452696";
    if(defaultnumber.length==11){
    
     lbNumber.text=[NSString stringWithFormat:@"%@ — %@                    —                    %@",[defaultnumber substringWithRange:NSMakeRange(0,3)],[defaultnumber substringWithRange:NSMakeRange(3,2)],[defaultnumber substringWithRange:NSMakeRange(9,2)]];
    }
    if([temp objectForKey:@"Role"]!=nil){
        txtRole.text=[temp objectForKey:@"Role"];
    }
    [btnHousePropertyCard setImage:[UIImage imageNamed:@"未选中勾.png"] forState:UIControlStateNormal];
    [btnHousePropertyCard setImage:[UIImage imageNamed:@"勾选中.png"] forState:UIControlStateSelected];
    btnHousePropertyCard.tag = 1;
    
    [btnFamilyMembers setImage:[UIImage imageNamed:@"未选中勾.png"] forState:UIControlStateNormal];
    [btnFamilyMembers setImage:[UIImage imageNamed:@"勾选中.png"] forState:UIControlStateSelected];
    
    btnFamilyMembers.tag = 2;
    
    [btnTenant setImage:[UIImage imageNamed:@"未选中勾.png"] forState:UIControlStateNormal];
    [btnTenant setImage:[UIImage imageNamed:@"勾选中.png"] forState:UIControlStateSelected];
    
    btnTenant.tag = 3;
    
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:singleTap];
    
    btnNext.layer.masksToBounds=YES;
    btnNext.layer.cornerRadius=5;
    [btnNext setBackgroundColor:[UtilCheck getRZColor:70 green:128 blue:218 alpha:1]];
    
    txtNumber1.delegate=self;
    txtNumber2.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIBUTTON EVENT

-(IBAction)btnSelectRole:(id)sender{
        [self Ext];
    RZSelectViewController *view=[[RZSelectViewController alloc] initWithNibName:@"RZSelectViewController" bundle:nil];
    view.type=4;
    view.titleName=@"选择角色";
    view.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    nav.navigationBar.backgroundColor = UIColorFromRGB(0x5496DF);
    if(IOS7){
        nav.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
        nav.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    
//    [nav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"navBackimage"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)selectData:(NSString *)DataString Type:(NSInteger)type Id:(NSString *)ID{
    
    if(type==4){
        txtRole.text=DataString;
    }
       [userRegistration setObject:txtRole.text forKey:@"Role"];
 
}
- (IBAction)didBtn:(UIButton *)sender {
    [self Ext];
    btnHousePropertyCard.selected = NO;
    btnFamilyMembers.selected = NO;
    btnTenant.selected = NO;
    sender.selected = YES;
    
}

//-(IBAction)btnSelectHousePropertyCard:(id)sender{
//        [self Ext];
//    UIButton *btn=(UIButton*)sender;
//    btn.selected=!btn.selected;
//}
//
//-(IBAction)btnSelectFamilyMembers:(id)sender{
//        [self Ext];
//    UIButton *btn=(UIButton*)sender;
//    btn.selected=!btn.selected;
//}
//-(IBAction)btnSelectTenant:(id)sender{
//        [self Ext];
//    UIButton *btn=(UIButton*)sender;
//    btn.selected=!btn.selected;
//}

-(IBAction)btnSelectNext:(id)sender{
    [self Ext];
    NSString *msg=nil;
    NSString *numberstr=[[NSString stringWithFormat:@"%@%@%@%@%@",[defaultnumber substringWithRange:NSMakeRange(0,3)],[defaultnumber substringWithRange:NSMakeRange(3,2)],txtNumber1.text,txtNumber2.text,[defaultnumber substringWithRange:NSMakeRange(9,2)]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    

    if(![numberstr isEqualToString:defaultnumber]){
        msg=@"您输入的手机号码与预留号码不一致";
     }
     else if(txtRole.text.length<1){
         msg=@"请选择您在家庭中的角色";
     }
    else if(!btnHousePropertyCard.selected&&!btnFamilyMembers.selected&&!btnTenant.selected){
            msg=@"请选择您和房屋的联系";
    }
    if(msg==nil){
        [userRegistration setObject:txtRole.text forKey:@"Role"];
 
        NSUserDefaults *userregistration=[NSUserDefaults standardUserDefaults];
        [userregistration setValue:userRegistration forKeyPath:REGISTRATION];
        [userregistration synchronize];
 
        RZAccountViewController *view=[[RZAccountViewController alloc] initWithNibName:@"RZAccountViewController" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"瑞洲科技" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }

}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self Ext];
}
-(void)Ext{
    [txtNumber1 resignFirstResponder];
    [txtNumber2 resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length >2) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:1],string];
            
            return NO;
            
        }
        return YES;
 
   
    return YES;
    
}
@end
