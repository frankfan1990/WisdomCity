//
//  RZDeliveryAddressViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-3.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDeliveryAddressViewController.h"
#import "RZAddAddressViewController.h"
#import "RZDeliveryAddressTableViewCell.h"
@interface RZDeliveryAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrOfName;
    NSArray *arrOfNumber;
    NSArray *arrOfProvince;
    NSArray *arrOfCity;
    NSArray *arrOfaddress;
    NSArray *arrOfZipCode;
}
@end

@implementation RZDeliveryAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"收货地址";
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
    
    
    // Do any additional setup after loading the view.
}
-(void)VariableInitialization
{
    arrOfName = [[NSArray alloc] initWithObjects:@"樊大师",@"樊大师", nil];
    arrOfNumber = [[NSArray alloc] initWithObjects:@"15111111111",@"15111111111", nil];
    arrOfProvince = [[NSArray alloc] initWithObjects:@"湖南省",@"湖南省", nil];
    arrOfCity = [[NSArray alloc] initWithObjects:@"长沙",@"岳阳", nil];
    arrOfZipCode = [[NSArray alloc] initWithObjects:@"410000",@"410000", nil];
    arrOfaddress= [[NSArray alloc] initWithObjects:@"开福区湘江世纪城富弯国际七栋2802",@"开福区湘江世纪城富弯国际七栋2802", nil];
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
    [btn2 setTitle:@"增加" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 50, 50)];
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didAdd) forControlEvents:UIControlEventTouchUpInside];
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+10, 100*arrOfName.count) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [tableView reloadData];
    [self.view addSubview:tableView];
}
-(void)didAdd
{
    RZAddAddressViewController *addCtrl = [[RZAddAddressViewController alloc] init];
    [self.navigationController pushViewController:addCtrl animated:YES];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cellName";
    RZDeliveryAddressTableViewCell *cell = (RZDeliveryAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[RZDeliveryAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.labelOfName.text = [NSString stringWithFormat:@"%@ %@",arrOfName[indexPath.row],arrOfNumber[indexPath.row]];
    cell.labelOfCity.text = [NSString stringWithFormat:@"%@ %@ %@",arrOfProvince[indexPath.row],arrOfCity[indexPath.row],arrOfZipCode[indexPath.row]];
    cell.labelofAdrr.text = arrOfaddress[indexPath.row];
    [cell.btnOfselected addTarget:self action:@selector(didSelected:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}




-(void)didSelected:(UIButton *)sender
{
   NSArray *arr = [[[[sender superview] superview] superview]  subviews];
    for (RZDeliveryAddressTableViewCell *cell in arr) {
        cell.btnOfselected.selected = NO;
    }
    sender.selected = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
