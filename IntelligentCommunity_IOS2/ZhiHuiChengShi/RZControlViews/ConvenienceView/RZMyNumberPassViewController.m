//
//  RZMyNumberPassViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-26.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZMyNumberPassViewController.h"
#import "RZNumber_cellTableViewCell.h"
#import "RZDetailsMyNumberViewController.h"
@interface RZMyNumberPassViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIButton *btnleft;
    UIButton *btnright;
    UIButton *btn2;
    
    NSMutableArray *arrOfName;
    NSMutableArray *arrOfAddress;
    NSMutableArray *arrOfIntroduce;
    NSMutableArray *arrOfNumber;
    NSMutableArray *arrOfTimes;
    
    NSMutableArray *arrOfName_other;
    NSMutableArray *arrOfAddress_other;
    NSMutableArray *arrOfIntroduce_other;
    NSMutableArray *arrOfNumber_other;
    NSMutableArray *arrOfTimes_other;
    
}
@end

@implementation RZMyNumberPassViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 7, 200, 35);
        UIView *topview=[[UIView alloc] initWithFrame:rect];
        btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnleft setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
        [btnleft setBackgroundColor:[UIColor clearColor]];
        [btnleft setTitle:@"我的常用" forState:UIControlStateNormal];
        [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边未选中.png"] forState:UIControlStateNormal];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边选中.png"] forState:UIControlStateSelected];
        [btnleft setTag:101];
        [btnleft addTarget:self action:@selector(SelectTop_left:) forControlEvents:UIControlEventTouchUpInside];
        
        
        btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright setTitle:@"拨打记录" forState:UIControlStateNormal];
        [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnright.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边未选中.png"] forState:UIControlStateNormal];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边选中.png"] forState:UIControlStateSelected];
        [btnright setTag:102];
        [btnright addTarget:self action:@selector(SelectTop_right:) forControlEvents:UIControlEventTouchUpInside];
        btnleft.selected = YES;
        btnright.selected = NO;
        
        [topview addSubview:btnleft];
        [topview addSubview:btnright];
        topview.layer.masksToBounds=YES;
        topview.layer.cornerRadius=15;
        self.navigationItem.titleView = topview;
        
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
    arrOfName = [NSMutableArray arrayWithObjects:@"医保就诊卡遗失申补",@"格塞干洗店",@"德源包点",@"绿源电动车", nil];
    arrOfNumber = [NSMutableArray arrayWithObjects:@"0731-8888666888",@"0731-8888666888",@"0731-8888666888",@"0731-8888666888", nil];
    arrOfAddress = [NSMutableArray arrayWithObjects:@"此处显示地址",@"此处显示地址",@"此处显示地址",@"此处显示地址", nil];
    arrOfIntroduce = [NSMutableArray arrayWithObjects:@"此处显示一句话简介",@"此处显示一句话简介",@"此处显示一句话简介",@"此处显示一句话简介", nil];
    arrOfTimes = [NSMutableArray arrayWithObjects:@"110",@"119", @"114",@"112",nil];

    arrOfName_other = [NSMutableArray arrayWithObjects:@"医保就诊卡遗失申补1",@"格塞干洗店1",@"德源包点",@"绿源电动车1", nil];
    arrOfNumber_other = [NSMutableArray arrayWithObjects:@"0731-8888666888",@"0731-8888666888",@"0731-8888666888",@"0731-8888666888", nil];
    arrOfAddress_other = [NSMutableArray arrayWithObjects:@"此处显示地址",@"此处显示地址",@"此处显示地址",@"此处显示地址", nil];
    arrOfIntroduce_other = [NSMutableArray arrayWithObjects:@"此处显示一句话简介",@"此处显示一句话简介",@"此处显示一句话简介",@"此处显示一句话简介", nil];
    arrOfTimes_other = [NSMutableArray arrayWithObjects:@"110",@"119", @"114",@"112",nil];
}
-(void)setTabBar{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
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
    [btn2 setTitle:@"清空" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    btn2.hidden = YES;
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
    if (btnleft.selected) {
     return arrOfName.count;
    }
    return arrOfName_other.count;
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
    if (btnleft.selected) {
        cell.labelofName.text = arrOfName[indexPath.row];
        cell.labelofNumber.text = arrOfNumber[indexPath.row];
        cell.labelofAddress.text = arrOfAddress[indexPath.row];
        cell.labelofIntroduce.text = arrOfIntroduce[indexPath.row];
        cell.labelofTimes.text = arrOfTimes[indexPath.row];
    }else{
        cell.labelofName.text = arrOfName_other[indexPath.row];
        cell.labelofNumber.text = arrOfNumber_other[indexPath.row];
        cell.labelofAddress.text = arrOfAddress_other[indexPath.row];
        cell.labelofIntroduce.text = arrOfIntroduce_other[indexPath.row];
        cell.labelofTimes.text = arrOfTimes_other[indexPath.row];
    }
    [cell.button addTarget:self action:@selector(didcellButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZDetailsMyNumberViewController *detailsCtrl = [[RZDetailsMyNumberViewController alloc] init];
    if (btnleft.selected) {
        detailsCtrl.nameStr = arrOfName[indexPath.row];
        detailsCtrl.addressStr = arrOfAddress[indexPath.row];
        detailsCtrl.numberStr = arrOfNumber[indexPath.row];
        detailsCtrl.contentStr = arrOfIntroduce[indexPath.row];
        detailsCtrl.timesStr = arrOfTimes[indexPath.row];
    }else{
        detailsCtrl.nameStr = arrOfName_other[indexPath.row];
        detailsCtrl.addressStr = arrOfAddress_other[indexPath.row];
        detailsCtrl.numberStr = arrOfNumber_other[indexPath.row];
        detailsCtrl.contentStr = arrOfIntroduce_other[indexPath.row];
        detailsCtrl.timesStr = arrOfTimes_other[indexPath.row];
    }
   
    [self.navigationController pushViewController:detailsCtrl animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(btnleft.selected == NO)
    {
         return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(btnleft.selected == NO)
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

//点击删除进来的事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)SelectTop_left:(UIButton *)sender
{
    btnleft.selected = YES;
    btnright.selected = NO;
    btn2.hidden = YES;
    [_tableView reloadData];
}
-(void)SelectTop_right:(UIButton *)sender
{
    btnleft.selected = NO;
    btnright.selected = YES;
    btn2.hidden = NO;
    [_tableView reloadData];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didBtn2{
    [arrOfName_other removeAllObjects];
    [_tableView reloadData];
    NSLog(@"清空");
}
//拨号按钮
-(void)didcellButton:(UIButton *)sender
{
    RZNumber_cellTableViewCell *cell = (RZNumber_cellTableViewCell *)[[sender superview] superview];
    NSLog(@"%@",cell.labelofNumber.text);
}
@end
