//
//  RZRegistrationActivityViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZRegistrationActivityViewController.h"
#import "RZRule.h"
#import "RZRegistrationTableViewCell.h"
@interface RZRegistrationActivityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView *headView;
    UITableView *tableView;
    NSArray *arrOfname;
    UITextField *field1;
    UITextField *field2;
    UITextField *field3;
}
@end

@implementation RZRegistrationActivityViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, -15, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"报名信息";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self Variableinitialization];
    [self createTabBar];
    [self createView];
    
}
-(void)Variableinitialization
{

    arrOfname = [[NSArray alloc] initWithObjects:@"姓名",@"手机",@"参加人数", nil];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap1];
    self.navigationItem.titleView.userInteractionEnabled = YES;
    [self.navigationItem.titleView addGestureRecognizer:tap];
}
-(void)createView
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 190+38*3+20+50)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:headView];
    
    UILabel *labelOfname = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 40)];
    labelOfname.text = _nameOfactivityStr;
    labelOfname.textAlignment = NSTextAlignmentLeft;
    labelOfname.numberOfLines = 2;
    labelOfname.adjustsFontSizeToFitWidth = YES;
    labelOfname.font = [UIFont systemFontOfSize:14];
    [headView addSubview:labelOfname];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 160-50, 17, 17)];
    image1.image = [UIImage imageNamed:@"时间.png"];
    [headView addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 160-50+17+8, 17, 17)];
    image2.image = [UIImage imageNamed:@"地标2.png"];
    [headView addSubview:image2];
    
    UILabel *labelOftime = [[UILabel alloc] initWithFrame:CGRectMake(15+17+7, 160-50, self.view.frame.size.width-15-17-7, 17)];
    labelOftime.text = [NSString stringWithFormat:@"%@ -- %@",_startTimeStr,_endTimeStr];
    labelOftime.textAlignment = NSTextAlignmentLeft;
    labelOftime.font = [UIFont systemFontOfSize:12];
    [headView addSubview:labelOftime];
    
    UILabel *labelOfAddress = [[UILabel alloc] initWithFrame:CGRectMake(15+17+7, 160-50+17+8, self.view.frame.size.width-15-17-7, 17)];
    labelOfAddress.text = _addressStr;
    labelOfAddress.textAlignment = NSTextAlignmentLeft;
    labelOfAddress.font = [UIFont systemFontOfSize:12];
    [headView addSubview:labelOfAddress];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 30)];
    label1.text = @"    填写报名信息";
    label1.backgroundColor = UIColorFromRGB(0xdddddd);
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = UIColorFromRGB(0x5e5e5e);
    label1.font = [UIFont systemFontOfSize:15];
    [headView addSubview:label1];

    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 190, self.view.frame.size.width, 38*3) style:UITableViewStylePlain];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [headView addSubview:tableView];
    
    
    UIButton *btnOfExit = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOfExit.backgroundColor = UIColorFromRGB(0x5496DF);
    btnOfExit.layer.cornerRadius = 5;
    btnOfExit.layer.masksToBounds = YES;
    btnOfExit.frame = CGRectMake(15, 190+38*3+20, self.view.frame.size.width-30, 40);
    [btnOfExit addTarget:self action:@selector(didGoTo) forControlEvents:UIControlEventTouchUpInside];
    btnOfExit.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnOfExit setTitle:@"提交" forState:UIControlStateNormal];
    [btnOfExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:btnOfExit];
    
}

#pragma mark - TabBar的设置
-(void)createTabBar{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
//    [self.view setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
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

-(void)didGoTo
{
    [self didTap];
    NSString *msg = @"";
    if ([field1.text isEqualToString:@""]) {
        msg = @"\n姓名不能为空";
    }else if ([field2.text isEqualToString:@""]){
        msg = @"\n手机号码不能为空";
    }else if(!isValidatePhone(field2.text)){
         msg = @"\n请填写正确的号码";
    }
    if ([msg isEqualToString:@""]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mrak - tableView 的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    RZRegistrationTableViewCell *cell = (RZRegistrationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[RZRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (indexPath.row == 0) {
        field1 = cell.textField;
         field1.delegate = self;
         field1.tag = 11;
    }else if(indexPath.row == 1){
        field2 = cell.textField;
         field2.delegate = self;
        field2.keyboardType = UIKeyboardTypeNumberPad;
        field2.tag = 22;
    } else if(indexPath.row == 2){
        field3 = cell.textField;
        field3.delegate = self;
        field3.keyboardType = UIKeyboardTypeNumberPad;
        field3.tag = 33;
        cell.label2.hidden = YES;
    }
    cell.label1.text = arrOfname[indexPath.row];
    
   
   
    
   
    
    
    return cell;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.3 animations:^{
        headView.frame = CGRectMake(0, -120, self.view.frame.size.width, 190+38*3+20+50);
    }];
 
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
          headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 190+38*3+20+50);
    }];
  
}

-(void)didTap{
    if ([field1 isFirstResponder]) {
        [field1 resignFirstResponder];
    }
    else if ([field2 isFirstResponder]) {
        [field2 resignFirstResponder];
    }
    else if ([field3 isFirstResponder]) {
        [field3 resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
