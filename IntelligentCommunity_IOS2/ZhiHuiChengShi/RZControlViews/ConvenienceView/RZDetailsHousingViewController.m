//
//  RZDetailsHousingViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-1.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDetailsHousingViewController.h"
@interface RZDetailsHousingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableVew;
}
@end

@implementation RZDetailsHousingViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"房屋交易";
        [label setFont:[UIFont systemFontOfSize:19]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
    
    _tableVew = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStylePlain];
    _tableVew.delegate = self;
    _tableVew.dataSource = self;
    _tableVew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableVew];
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
}
#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2){
        return 90;
    }else{
        return 120;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 35, 20)];
        UILabel *labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(15+35, 20, Mywidth-60, 30)];
        UILabel *labelDate = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, Mywidth-30, 20)];
        labeltitle.text = @"房价:";
        labelPrice.text = _priceStr;
        labelDate.text = _dateStr;
        labelDate.font = [UIFont systemFontOfSize:14];
        labelPrice.font = [UIFont systemFontOfSize:20];
        labeltitle.font = [UIFont systemFontOfSize:14];
        labeltitle.textAlignment = NSTextAlignmentLeft;
        labelPrice.textAlignment = NSTextAlignmentLeft;
        labelDate.textAlignment = NSTextAlignmentLeft;
        
        labelPrice.textColor = UIColorFromRGB(0x5695e2);
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 90-0.5, Mywidth-30, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell1 addSubview:lineView];
        [cell1 addSubview:labeltitle];
        [cell1 addSubview:labelDate];
        [cell1 addSubview:labelPrice];
        
        return cell1;
    }else if(indexPath.row == 1){
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UILabel *labelOftitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 35, 20)];
        labelOftitle.text = @"房型:";
        labelOftitle.font = [UIFont systemFontOfSize:14];
        labelOftitle.textAlignment = NSTextAlignmentLeft;
        UILabel *labelOfContent = [[UILabel alloc] initWithFrame:CGRectMake(15+38, 14, Mywidth-60, 30)];
        labelOfContent.text = _contentStr;
        labelOfContent.textAlignment = NSTextAlignmentLeft;
        labelOfContent.textColor =
        labelOfContent.textColor = UIColorFromRGB(0x5695e2);
        labelOfContent.font = [UIFont systemFontOfSize:20];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 55-3, Mywidth/2-15, 20)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 55+27-3, Mywidth/2-15, 20)];
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake( Mywidth/2+15-3, 55, Mywidth/2-15, 20)];
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake( Mywidth/2+15-3, 55+27, Mywidth/2-15, 20)];
        
        label1.text = @"装修：精装";
        label2.text = @"楼层：16/1";
        label3.text = @"朝向：南";
        label4.text = @"现状：自主";
        label1.font = [UIFont systemFontOfSize:14];
        label2.font = [UIFont systemFontOfSize:14];
        label3.font = [UIFont systemFontOfSize:14];
        label4.font = [UIFont systemFontOfSize:14];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 120-0.5, Mywidth-30, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell2 addSubview:lineView];
        [cell2 addSubview:labelOftitle];
        [cell2 addSubview:labelOfContent];
        [cell2 addSubview:label1];
        [cell2 addSubview:label2];
        [cell2 addSubview:label3];
        [cell2 addSubview:label4];
        return cell2;
    }else{
        UITableViewCell *cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, Mywidth/2-15, 20)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20+27-3, Mywidth/2-15, 20)];
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake( Mywidth/2+15-3, 20, Mywidth/2-15, 20)];
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake( Mywidth/2+15-3, 20+27, Mywidth/2-15, 20)];
        
        label1.text = @"家具：齐全";
        label2.text = @"用途：住宅";
        label3.text = @"家电：齐全";
        label4.text = @"产权：商品用房";
        label1.font = [UIFont systemFontOfSize:14];
        label2.font = [UIFont systemFontOfSize:14];
        label3.font = [UIFont systemFontOfSize:14];
        label4.font = [UIFont systemFontOfSize:14];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 90-0.5, Mywidth-30, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell3 addSubview:lineView];
        [cell3 addSubview:label1];
        [cell3 addSubview:label2];
        [cell3 addSubview:label3];
        [cell3 addSubview:label4];
        return cell3;
    }
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
