//
//  RZCommonlyUseViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZCommonlyUseViewController.h"
#import "RZNumber_cellTableViewCell.h"
#import "RZDetailsMyNumberViewController.h"
#import "RZAddSerViceNumberViewController.h"
@interface RZCommonlyUseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIButton *btn2;
    
    NSMutableArray *arrOfName;
    NSMutableArray *arrOfAddress;
    NSMutableArray *arrOfIntroduce;
    NSMutableArray *arrOfNumber;
    NSMutableArray *arrOfTimes;
}
@end

@implementation RZCommonlyUseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"号码详情";
        [label setFont:[UIFont systemFontOfSize:20]];
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Variableinitialization];
    [self setTabBar];
    [self createTableView];
}
-(void)Variableinitialization
{
    arrOfName = [NSMutableArray arrayWithObjects:@"天马小区分店",@"格塞干洗店",@"德源包点",@"绿源电动车", nil];
    arrOfNumber = [NSMutableArray arrayWithObjects:@"0731-8888666888",@"0731-8888666888",@"0731-8888666888",@"0731-8888666888", nil];
    arrOfAddress = [NSMutableArray arrayWithObjects:@"此处显示地址",@"此处显示地址",@"此处显示地址",@"此处显示地址", nil];
    arrOfIntroduce = [NSMutableArray arrayWithObjects:@"此处显示一句话简介",@"此处显示一句话简介",@"此处显示一句话简介",@"此处显示一句话简介", nil];
    arrOfTimes = [NSMutableArray arrayWithObjects:@"110",@"119", @"114",@"112",nil];
}
-(void)setTabBar{
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
    
    btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"添加" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didBtn2) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnright1 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright1];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright1;
    }
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellname = @"cell";
    RZNumber_cellTableViewCell *cell = (RZNumber_cellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[RZNumber_cellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.labelofName.text = arrOfName[indexPath.row];
        cell.labelofNumber.text = arrOfNumber[indexPath.row];
        cell.labelofAddress.text = arrOfAddress[indexPath.row];
        cell.labelofIntroduce.text = arrOfIntroduce[indexPath.row];
        cell.labelofTimes.text = arrOfTimes[indexPath.row];
    [cell.button addTarget:self action:@selector(didcellButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZDetailsMyNumberViewController *detailsCtrl = [[RZDetailsMyNumberViewController alloc] init];
    detailsCtrl.nameStr = arrOfName[indexPath.row];
    detailsCtrl.addressStr = arrOfAddress[indexPath.row];
    detailsCtrl.numberStr = arrOfNumber[indexPath.row];
    detailsCtrl.contentStr = arrOfIntroduce[indexPath.row];
    detailsCtrl.timesStr = arrOfTimes[indexPath.row];
    [self.navigationController pushViewController:detailsCtrl animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didBtn2{
    RZAddSerViceNumberViewController *addCtrl = [[RZAddSerViceNumberViewController alloc] init];
    [self.navigationController pushViewController:addCtrl animated:YES];
}

-(void)didcellButton:(UIButton *)sender
{
    RZNumber_cellTableViewCell *cell = (RZNumber_cellTableViewCell *)[[sender superview] superview];
    NSLog(@"%@",cell.labelofNumber.text);
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
