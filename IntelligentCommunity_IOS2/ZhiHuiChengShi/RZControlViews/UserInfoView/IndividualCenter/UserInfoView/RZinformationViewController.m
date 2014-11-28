//
//  RZinformationViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZinformationViewController.h"
#import "RZMyMaterialViewController.h"
#import "MyCell_PersonalCenter.h"
#import "RZDengLuViewController.h"
#import "RZUnderRealAccountViewController.h"
#import "RZDeliveryAddressViewController.h"
#import "RZAppDelegate.h"
#import "RZUserInfoData.h"
@interface RZinformationViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *arrOfTitle;
    NSArray *arrOfimageName;
    UIImagePickerController *imagePicker;
    UIImageView  *imagev;
    RZUserInfoData *UserData;
}
@end

@implementation RZinformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"个人中心";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        self.navigationController.navigationBar.backgroundColor = UIColorFromRGB(0x5496DF);
        self.navigationController.navigationBar.translucent = NO;
    
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}
-(void)back{

    [self.navigationController popToRootViewControllerAnimated:YES];
 
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if(IOS7){
//        self.navigationController.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
//    }
//    else{
//        self.navigationController.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
//    }
}
//取得当前程序的委托
-(RZAppDelegate *)appDelegate{
    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"]];
    UserData = [RZUserInfoData modelWithDictionary:dict error:nil];
    
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
    
    
    UIButton *btnOfExit = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOfExit.backgroundColor = UIColorFromRGB(0x5496DF);
    btnOfExit.layer.cornerRadius = 5;
    btnOfExit.layer.masksToBounds = YES;
    btnOfExit.frame = CGRectMake(15, self.view.frame.size.height-170, self.view.frame.size.width-30, 50);
    [btnOfExit addTarget:self action:@selector(didGoto) forControlEvents:UIControlEventTouchUpInside];
    [btnOfExit setTitle:@"退出账号" forState:UIControlStateNormal];
    [btnOfExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self.view addSubview:btnOfExit];
    
    arrOfTitle = [[NSArray alloc] initWithObjects:@"我的资料",@"房下账号",@"修改密码",@"收货地址", nil];
    
    arrOfimageName = [[NSArray alloc] initWithObjects:@"资料",@"账号",@"修改密码",@"收货地址", nil];

    [self createTableView];
    
    imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //系统照片
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;

    }else{
        //手机相册
         imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }

    imagePicker.delegate = self;
}


-(void)createTableView
{
   UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-200) style:UITableViewStylePlain];
    [tableView setBackgroundColor:[UIColor clearColor]] ;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    [tableView reloadData];
    
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
#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfTitle.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    headview.backgroundColor = UIColorFromRGB(0x5496DF);
    
    
    imagev = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 20, 80, 80)];
    imagev.userInteractionEnabled = YES;
    [imagev setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostIP,UserData.headUrl]] placeholderImage:[UIImage imageNamed:@"个人中心_03.png"]];
    imagev.layer.cornerRadius = 40;
    imagev.layer.masksToBounds = YES;
    [headview addSubview:imagev];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, 30)];
    label.text = UserData.nickname;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [headview addSubview:label];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+[label.text length]*9+2,5,20, 20)];
    if ([UserData.sex isEqualToString:@"男"]) {
        image2.image = [UIImage imageNamed:@"个人中心_07.png"];
    }else{
         image2.image = [UIImage imageNamed:@"个人中心_07.png"];
    }
    
    [label addSubview:image2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 80);
    btn.userInteractionEnabled = YES;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(didBtn) forControlEvents:UIControlEventTouchUpInside];
    [imagev  addSubview:btn];
    
    return headview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellname = @"cell";
    MyCell_PersonalCenter *cell = (MyCell_PersonalCenter *)[tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[MyCell_PersonalCenter alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    cell.label.text = arrOfTitle[indexPath.row];
    cell.imageV.image = [UIImage imageNamed:arrOfimageName[indexPath.row]];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RZMyMaterialViewController *myMaterial = [[RZMyMaterialViewController alloc] init];
        [self.navigationController pushViewController:myMaterial animated:YES];
    }else if (indexPath.row == 1) {
        RZUnderRealAccountViewController *underCtrl = [[RZUnderRealAccountViewController alloc] init];
        [self.navigationController pushViewController:underCtrl animated:YES];
    }else if (indexPath.row == 3) {
        RZDeliveryAddressViewController *addressCtrl = [[RZDeliveryAddressViewController alloc] init];
        [self.navigationController pushViewController:addressCtrl animated:YES];
    }
    
}



#pragma mark - UIImagePickerController代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imagev.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    NSLog(@"%@",info);
}
-(void)didBtn
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0;
    view.tag = 10000;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 44)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha  = 0;
    view1.tag = 100001;
    [self.navigationController.navigationBar addSubview:view1];
    
    
    
    
    UIButton *btnshoot = [UIButton buttonWithType:UIButtonTypeSystem];
    btnshoot.frame = CGRectMake(8, 150, self.view.frame.size.width-16, 55);
    btnshoot.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"拍照.png"]];
    imageView1.frame = CGRectMake(8, 5, 45, 45);
    [btnshoot addSubview:imageView1];
    [btnshoot addTarget:self action:@selector(didBtnShoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnshoot];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 150+54, self.view.frame.size.width-16, 2)];
    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:lineView];
    
    
    
    UIButton *btnpicture = [UIButton buttonWithType:UIButtonTypeSystem];
    btnpicture.frame = CGRectMake(8, 150+55, self.view.frame.size.width-16, 55);
    [btnpicture addTarget:self action:@selector(didBtnPicture) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"相册拿.png"]];
    imageView2.frame = CGRectMake(8, 5, 45, 45);
    [btnpicture addSubview:imageView2];
    [self.view addSubview:btnpicture];
    btnpicture.backgroundColor = [UIColor whiteColor];
    
    btnshoot.tag = 111;
    btnpicture.tag = 110;
    lineView.tag = 999;
    
    btnshoot.alpha = 0;
    btnpicture.alpha = 0;
    lineView.alpha = 0;
    
    [btnpicture setTitle:@"相册选取                           " forState:UIControlStateNormal];
    [btnshoot setTitle:@"拍照                                " forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.3;
        view1.alpha = 0.3;
        btnshoot.alpha = 1;
        btnpicture.alpha = 1;
        lineView.alpha = 1;
    }];
}
-(void)didBtnPicture
{
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)didBtnShoot
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.showsCameraControls = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)didTap
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    [view removeFromSuperview];
    
    UIView *view3 = (UIView *)[self.navigationController.navigationBar viewWithTag:100001];
    [view3 removeFromSuperview];
    
    UIView *view1 = (UIView *)[self.view viewWithTag:999];
    [view1 removeFromSuperview];
    
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:111];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:110];
    [btn1 removeFromSuperview];
    [btn2 removeFromSuperview];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self didTap];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
