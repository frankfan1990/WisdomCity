//
//  RZuserConfigViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZuserConfigViewController.h"
#import "RZAppDelegate.h"
#import "RZConfigTableViewCell.h"
#import "RZvViewController.h"
#import "RZAppDelegate.h"
@interface RZuserConfigViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
   NSArray * arrOftitle;
    
}
@end

@implementation RZuserConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"设置";
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
    
    arrOftitle = [[NSArray alloc] initWithObjects:@"推送通知",@"欢迎页",@"给评分",@"关于我们",@"清除缓存", nil];

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, arrOftitle.count*50) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView reloadData];
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
    
    UIButton *btnOfExit = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOfExit.backgroundColor = UIColorFromRGB(0x5496DF);
    btnOfExit.layer.cornerRadius = 5;
    btnOfExit.layer.masksToBounds = YES;
    btnOfExit.frame = CGRectMake(15, arrOftitle.count*50+20, self.view.frame.size.width-30, 50);
    [btnOfExit addTarget:self action:@selector(didGoto) forControlEvents:UIControlEventTouchUpInside];
    [btnOfExit setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnOfExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btnOfExit];
    
    
}


-(void)didGoto
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n是否退出该账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:USERISLOGIN];
        [user removeObjectForKey:REGISTRATION];
        [user removeObjectForKey:USERINFO];
        [self.navigationController removeFromParentViewController];
        [[self appDelegate] goInfo:NO];
    }
}
-(RZAppDelegate *)appDelegate{
    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOftitle.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellname = @"cell";
    RZConfigTableViewCell * cell = (RZConfigTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[RZConfigTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    cell.labeTitle.text = arrOftitle[indexPath.row];
    if (indexPath.row == 0) {
        UISwitch *switchV = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 10, 40, 40)];
        [switchV addTarget:self action:@selector(didChange:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:switchV];
    }else{
       
        cell.image.frame = CGRectMake(self.view.frame.size.width-35, 10, 30,30);
        cell.image.image = [UIImage imageNamed:@"向右.png"];
    }
    return cell;
}
-(void)didChange:(UISwitch *)sw
{
    if (sw.on) {
         NSLog(@"开");
    }else{
         NSLog(@"关");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
