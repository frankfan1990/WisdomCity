//
//  RZCommonlyListViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZCommonlyListViewController.h"
#import "RZCommonlyListTableViewCell.h"
#import "RZDetailsTakeoutViewController.h"
@interface RZCommonlyListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *_dict;
    NSString *_titleStr;
    NSMutableArray *arrOfName;
    NSMutableArray *arrOfAddress;
    NSMutableArray *arrOfImageUrl;
    NSMutableArray *arrOfDistance;
    UITableView *_tableView;
}
@end

@implementation RZCommonlyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
    [self Variableinitialization];
   
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view  addSubview:_tableView];
    
}
-(void)Variableinitialization
{
    arrOfName = [NSMutableArray arrayWithObjects:@"阳光家政公司",@"盛百银家政",@"云轩家政",@"希望家政",@"美丽家政", nil];
    arrOfDistance = [NSMutableArray arrayWithObjects:@"123",@"421",@"234",@"560",@"25",nil];
    arrOfAddress =[NSMutableArray arrayWithObjects:@"长沙市开福区金霞新区10号38栋西门1号旁边的厕所",@"地球亚洲中国湖南省长沙市岳麓区天马小区9999栋8888楼6666室",@"长沙市开福区金霞新区10号38栋",@"地球亚洲中国湖南省长沙市岳麓区天马小区9999栋8888楼6666室",@"长沙市开福区金霞新区10号38栋西门1号旁边的厕所",nil] ;
    arrOfImageUrl = [NSMutableArray arrayWithObjects:@"家政公司图片",@"煲仔饭",@"家政公司图片",@"煲仔饭",@"家政公司图片",nil];
}
-(void)setTabar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]];
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
    self.title = NSLocalizedString(@" ", @"");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    RZCommonlyListTableViewCell *cell = (RZCommonlyListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[RZCommonlyListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageV.image = [UIImage imageNamed:arrOfImageUrl[indexPath.row]];
    cell.labelOfTitle.text = arrOfName[indexPath.row];
    cell.labelOfDistance.frame = CGRectMake(Mywidth-100, 15, 90, 20);
    cell.labelOfAddress.text = [NSString stringWithFormat:@"地址：%@",arrOfAddress[indexPath.row]];
    cell.labelOfDistance.text = [NSString stringWithFormat:@"%@m",arrOfDistance[indexPath.row]];
    cell.labelOfAddress.frame = CGRectMake(80+8, 42, Mywidth-98, [self caculateTheTextHeight:cell.labelOfAddress.text andFontSize:13 andDistance:100]);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_titleStr isEqualToString:@"外卖"]) {
        RZDetailsTakeoutViewController *takeoutCtrl = [[RZDetailsTakeoutViewController alloc] init];
        takeoutCtrl.nameStr = arrOfName[indexPath.row];
        takeoutCtrl.addressStr = [NSString stringWithFormat:@"地址：%@",arrOfAddress[indexPath.row]];
        takeoutCtrl.distanceStr = arrOfDistance[indexPath.row];
        takeoutCtrl.image = [UIImage imageNamed:arrOfImageUrl[indexPath.row]];
        
        [self.navigationController pushViewController:takeoutCtrl animated:YES];
    }
}

//从家政或家教里面来的代理
-(void)sendData:(NSDictionary *)dict Name:(NSString *)title
{
    _dict = dict;
    _titleStr = title;
}
//从便民首页来的代理
-(void)sendData:(NSDictionary *)dict Type:(NSInteger)type Name:(NSString *)title
{
    _dict = dict;
    _titleStr = title;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 根据字长算 高度或宽度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(self.view.bounds.size.width-distance, CGFLOAT_MAX);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
