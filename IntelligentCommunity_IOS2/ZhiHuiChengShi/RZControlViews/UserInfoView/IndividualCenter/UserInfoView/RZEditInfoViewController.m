//
//  RZEditInfoViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-10-30.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZEditInfoViewController.h"
#import "RZMyPhoneViewController.h"
#import "RZMyMaterialCell.h"
@interface RZEditInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *arrName;
    NSArray *arrMessage;
    UITextField *field1;
    UITextField *field2;
    NSString *nameStr;
    UITapGestureRecognizer *tapGesture2;
}
@end

@implementation RZEditInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"编辑资料";
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
    //一些变量的初始化
    [self VariableInitialization];

    [self createBarButtonItems];
    
    [self createTableView];
}
-(void)VariableInitialization
{
    arrName = [[NSArray alloc] initWithObjects:@"手机",@"昵称",@"性别",@"住址",@"个性签名", nil];
    arrMessage = [[NSArray alloc] initWithObjects:@"15111111111",@"飞翔的小鸡",@"男",@"湘江世纪城二期",@"中国好邻居", nil];
    nameStr = [NSString string];
    tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtapGesture)];
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
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 40, 40)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@ selector(edit) forControlEvents:UIControlEventTouchUpInside];
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+10, 53*5) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [tableView reloadData];
    [self.view addSubview:tableView];
    
}
-(void)didtapGesture
{
    if ([field1 isFirstResponder]) {
        [field1 resignFirstResponder];
    }
    if ([field2 isFirstResponder]) {
        [field2 resignFirstResponder];
    }
}
-(void)edit
{
    if([field1.text length]){
        [SVProgressHUD setStatus:@"正在提交"];
        [SVProgressHUD show];
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n昵称不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
    

    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3) {
        cell.textmessage.enabled = NO;
        cell.imagegoto.hidden = NO;
    }else{
        if (indexPath.row == 1) {
            field1 = cell.textmessage;
            
        }else if (indexPath.row == 4){
            field2 = cell.textmessage;
        }
        cell.textmessage.enabled = YES;
        cell.imagegoto.hidden = YES;
    }
    cell.textmessage.text = arrMessage[indexPath.row];
    cell.textmessage.textAlignment = NSTextAlignmentRight;
    cell.textmessage.delegate = self;
    cell.labname.text = arrName[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 ) {
        if (indexPath.row == 0) {
            RZMyPhoneViewController *phoneCtrl = [[RZMyPhoneViewController alloc] init];
            [self.navigationController pushViewController:phoneCtrl animated:YES];
        }
        [self didtapGesture];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
