//
//  RZOtherNumberViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZOtherNumberViewController.h"
#import "RZNumber_cellTableViewCell.h"
@interface RZOtherNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation RZOtherNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self Variableinitialization];
    [self createTableView];
}
-(void)Variableinitialization
{
    arrOfName = [NSMutableArray arrayWithObjects:@"顺丰快递",@"天天快递",@"申通快递",@"韵达快递", nil];
    arrOfNumber = [NSMutableArray arrayWithObjects:@"0731-887836221",@"0731-887836221",@"0731-887836221",@"0731-887836221", nil];
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
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = _titleStr;
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
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
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didcellButton:(UIButton *)sender
{
    RZNumber_cellTableViewCell *cell = (RZNumber_cellTableViewCell *)[[sender superview] superview];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",cell.labelofNumber.text]]];

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
