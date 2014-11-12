//
//  RZAddAddressViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-3.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZAddAddressViewController.h"
#import "RZMyMaterialCell.h"
#import "RZRule.h"
@interface RZAddAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    NSArray *arrName;
    NSArray *arrMessage;
    UITextField *field1;
    UITextField *field2;
    UITextField *field3;
    UITextView *field4;
    NSString *nameStr;
    UITableView *tableView;
    UITapGestureRecognizer *tapGesture2;
}
@end

@implementation RZAddAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"增加地址";
        [label setFont:[UIFont systemFontOfSize:20]];
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
    self.view.backgroundColor = [UIColor whiteColor];
    //一些变量的初始化
    [self VariableInitialization];
    
    [self createBarButtonItems];
    
    [self createTableView];
    
    [self createFootView];
}
-(void)VariableInitialization
{
    arrName = [[NSArray alloc] initWithObjects:@"收货人",@"手机号码",@"所在地址",nil];
    arrMessage = [[NSArray alloc] initWithObjects:@"",@"",@"湖南 长沙 开福区",nil];
    nameStr = [NSString string];
    
    
}
-(void)createBarButtonItems
{
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
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 40, 40)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@ selector(didfinish) forControlEvents:UIControlEventTouchUpInside];
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

-(void)createTableView
{
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+10, 53*arrName.count) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [tableView reloadData];
    [self.view addSubview:tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtap)];
     UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtap)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap1];
     self.navigationItem.titleView.userInteractionEnabled = YES;
    [self.navigationItem.titleView addGestureRecognizer:tap];
    
}
-(void)createFootView
{
    field4 = [[UITextView alloc] initWithFrame:CGRectMake(10, 53*arrName.count+25, self.view.frame.size.width-20, 100)];
    field4.layer.cornerRadius = 8;
    field4.layer.masksToBounds = YES;
    field4.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1].CGColor;
    field4.text = @"  地址详情";
    field4.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    field4.layer.borderWidth = 1;
    field4.delegate = self;
    field4.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:field4];
}
-(void)didfinish
{
    [self didtap];
    NSString *message = [NSString string];
    if ( ![field1.text length]) {
        message = @"\n收货人不能为空";
    }else if(![field2.text length]){
        message = @"\n手机号码不能为空";
    }else if(![field3.text length]){
        message = @"\n所在地址不能为空";
    }else if (!isValidatePhone(field2.text))
    {
        message =@"\n请填写正确的电话号码";
    }
    
    
    if(![message length]){
        [SVProgressHUD setStatus:@"正在提交"];
        [SVProgressHUD show];
        [SVProgressHUD showSuccessWithStatus:@"增加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - textView
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.32 animations:^{
        self.view.frame = CGRectMake(0, -25, self.view.frame.size.width, self.view.frame.size.height);
    }];
    if ([textView.text isEqualToString:@"  地址详情"]) {
        textView.text = @"  ";
        textView.textColor = [UIColor blackColor];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.32 animations:^{
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);;
    }];
}

#pragma mark - tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cellName";
    RZMyMaterialCell *cell = (RZMyMaterialCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[RZMyMaterialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (indexPath.row == 0) {
        field1 = cell.textmessage;
    }else if(indexPath.row == 1){
        field2 = cell.textmessage;
        field2.keyboardType = UIKeyboardTypeNumberPad;
    }else if(indexPath.row == 2){
        field3 = cell.textmessage;
    }
    
    cell.textmessage.enabled = YES;
    cell.imagegoto.hidden = NO;
    cell.imagegoto.image = [UIImage imageNamed:@"向右.png"];
    cell.textmessage.text = arrMessage[indexPath.row];
    cell.textmessage.textAlignment = NSTextAlignmentRight;
    cell.textmessage.delegate = self;
    cell.labname.text = arrName[indexPath.row];
    cell.textmessage.textColor = cell.labname.textColor;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 ) {
        if (indexPath.row == 0) {
//            RZMyPhoneViewController *phoneCtrl = [[RZMyPhoneViewController alloc] init];
//            [self.navigationController pushViewController:phoneCtrl animated:YES];
        }

    }
}

-(void)didtap
{
    if ([field1 isFirstResponder]) {
        [field1 resignFirstResponder];
    }
    else if ([field2 isFirstResponder]) {
        [field2 resignFirstResponder];
    }
    else if ([field3 isFirstResponder]) {
        [field3 resignFirstResponder];
    }
    else if ([field4 isFirstResponder]) {
        [field4 resignFirstResponder];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
