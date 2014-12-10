//
//  RZCategoryListViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZCategoryListViewController.h"
#import "RZCommonlyListViewController.h"
@interface RZCategoryListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *_dict;
    NSString  *_title;
    NSInteger _type;
    NSMutableArray *arrofCategory;
    UITableView *_tableView;
}
@end

@implementation RZCategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
    [self Variableinitialization];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight- 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
-(void)Variableinitialization
{
    if (_type == 1004) {
        arrofCategory = [NSMutableArray arrayWithObjects:@"小学",@"初中",@"高中",@"艺人", nil];
    }else if(_type == 1003){
        arrofCategory = [NSMutableArray arrayWithObjects:@"搬家",@"保姆",@"保洁",@"疏通", nil];
    }
}
-(void)setTabar
{
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
    label.text = _title;
    [label setFont:[UIFont systemFontOfSize:19]];
    //    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrofCategory.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 25)];
    label.text = arrofCategory[indexPath.row];
    label.textAlignment = NSTextAlignmentLeft;
    label.tag = 1000+indexPath.row;
    label.font = [UIFont systemFontOfSize:16];
    [cell addSubview:label];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"向右灰"]];
    imageV.frame = CGRectMake(Mywidth - 35, 7.5, 28, 30);
    [cell addSubview:imageV];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-0.5, Mywidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [cell addSubview:lineView];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:indexPath.row+1000];
    RZCommonlyListViewController *commonlyCtrl = [[RZCommonlyListViewController alloc] init];
    self.delegate = commonlyCtrl;
    [self.delegate sendData:@{@"key":@"value"} Name:label.text];
    [self.navigationController pushViewController:commonlyCtrl animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
//代理
-(void)sendData:(NSDictionary *)dict Type:(NSInteger)type Name:(NSString *)title
{
    _dict = dict;
    _title = title;
    _type = type;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
