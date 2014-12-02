//
//  RZHousingTransactionsViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-1.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHousingTransactionsViewController.h"
#import "RZDetailsHousingViewController.h"
#import "RZHousing_otherTableViewCell.h"
#import "RZNewHouseViewController.h"
#import "MJRefresh.h"
@interface RZHousingTransactionsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *buyBtn;
    UIButton *rentalBtn;
    UITableView * _tableView;
    CGFloat height;
    int Postpage;//分页
    BOOL IsSvPOPen;
    BOOL isFirst;
    NSInteger Type;//加载数据类别
    UILabel *lbload;//提示
    NSMutableArray *arrOfContent;
    NSMutableArray *arrOfPrice;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfAveragePrice;
    
    NSMutableArray *arrOfContentOther;
    NSMutableArray *arrOfPriceOther;
    NSMutableArray *arrOfDateOther;
    
    UIView *_footView;
    UIButton *btn;
}
@end

@implementation RZHousingTransactionsViewController

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
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self Variableinitialization];
    [self createTableView];
    [self setTabar];
    [self createSegment];
    [self postResultDate:nil request:nil];
    
}
-(void)Variableinitialization
{
    Postpage=0;
    IsSvPOPen=YES;
    isFirst = YES;
    Type=1;
  
    arrOfContent = [NSMutableArray arrayWithObjects:@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²", nil];
    arrOfPrice = [NSMutableArray arrayWithObjects:@"187", @"187", @"87", @"187", @"187", nil];
    arrOfAveragePrice = [NSMutableArray arrayWithObjects:@"26714",@"26714",@"26714",@"26714",@"26714", nil];
    arrOfDate = [NSMutableArray arrayWithObjects:@"2014-06-01", @"2014-06-01", @"2014-06-01", @"2014-06-01", @"2014-06-01", nil];
    
    arrOfContentOther = [NSMutableArray arrayWithObjects:@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²",@"2室1厅1阳台/70m²", nil];
    arrOfPriceOther = [NSMutableArray arrayWithObjects:@"4500", @"4500", @"2000", @"2888", @"6888", nil];
    arrOfDateOther = [NSMutableArray arrayWithObjects:@"2015-06-01", @"2015-06-01", @"2015-06-01", @"2014-08-01", @"2014-06-06", nil];
    
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
-(void)createSegment
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 12+35+10)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(12, 10, Mywidth-30, 35)];
    [segmentView setBackgroundColor:[UIColor clearColor]];
    segmentView.layer.cornerRadius = 7;
    segmentView.layer.masksToBounds = YES;
    segmentView.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
    segmentView.layer.borderWidth = 1;
    [backView addSubview:segmentView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 12+35+9, Mywidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [backView addSubview:lineView];
    
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"房屋买卖" forState:UIControlStateNormal];
    buyBtn.selected = YES;
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [buyBtn setTitleColor:UIColorFromRGB(0x5496DF) forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [buyBtn addTarget:self action:@selector(didFormal) forControlEvents:UIControlEventTouchUpInside];
    buyBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    
    
    buyBtn.frame = CGRectMake(0, 0, (self.view.frame.size.width-30)/2, 35);
    [segmentView addSubview:buyBtn];
    
    rentalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rentalBtn setTitle:@"房屋出租" forState:UIControlStateNormal];
    rentalBtn.backgroundColor = [UIColor whiteColor];
    rentalBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rentalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rentalBtn setTitleColor:UIColorFromRGB(0x5496DF) forState:UIControlStateNormal];
    [rentalBtn addTarget:self action:@selector(didPrepare) forControlEvents:UIControlEventTouchUpInside];
    rentalBtn.frame = CGRectMake((self.view.frame.size.width-30)/2, 0, (self.view.frame.size.width-30)/2, 35);
    [segmentView addSubview:rentalBtn];
    
}
-(void)createTableView
{
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 65)];
    _footView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Mywidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [_footView addSubview:lineView];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 14, Mywidth - 30, 40);
    [btn setTitle:@"我要买房/卖房" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor =  UIColorFromRGB(0x5496DF);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(didAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:btn];
    _footView.userInteractionEnabled = YES;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 12+35+10, self.view.frame.size.width, self.view.frame.size.height-66-57) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    Postpage=0;
    IsSvPOPen=YES;
    [self postResultDate:nil request:nil];
    [self.view addSubview:_tableView];
    
    lbload=[[UILabel alloc] initWithFrame:CGRectMake(0, _tableView.frame.origin.y, 320, 25)];
    lbload.text=@"休息会儿,没有更多内容了!!!";
    lbload.font=[UIFont systemFontOfSize:13.0f];
    lbload.textAlignment=NSTextAlignmentCenter;
    lbload.backgroundColor=  [UIColor colorWithRed:62/255.0f green:180/255.0f blue:180/255.0f alpha:0.8];
    lbload.textColor=[UIColor whiteColor];
    lbload.hidden=YES;
    [self.view addSubview:lbload];
    [self setupRefresh];
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (buyBtn.selected) {
        return arrOfContent.count;
    }
    return arrOfContentOther.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 111;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
 
    return 65;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"houseCell";
    RZHousing_otherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[RZHousing_otherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if (buyBtn.selected) {
        cell.labelOfContent.text = arrOfContent[indexPath.row];
        cell.labelOfDate.text = [NSString stringWithFormat:@"成交日期:  %@",arrOfDate[indexPath.row]];
        cell.labelOfPirce.text = [NSString stringWithFormat:@"￥%@万",arrOfPrice[indexPath.row]];
        cell.labelOfAveragePrice.text = [NSString stringWithFormat:@"￥%@",arrOfAveragePrice[indexPath.row]];
        cell.labelOfAveragePrice.hidden = NO;
        
    }else{
        cell.labelOfContent.text = arrOfContentOther[indexPath.row];
        cell.labelOfDate.text = [NSString stringWithFormat:@"成交日期:%@",arrOfDateOther[indexPath.row]];
        cell.labelOfPirce.text = [NSString stringWithFormat:@"￥%@/月",arrOfPriceOther[indexPath.row]];
        cell.labelOfAveragePrice.hidden = YES;
    }

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    RZHousing_otherTableViewCell *cell = (RZHousing_otherTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    RZDetailsHousingViewController *detailCtrl = [[RZDetailsHousingViewController alloc] init];
    detailCtrl.contentStr = cell.labelOfContent.text;
    detailCtrl.priceStr = cell.labelOfPirce.text;
    detailCtrl.dateStr = cell.labelOfDate.text;
    [self.navigationController pushViewController:detailCtrl animated:YES];
  
    
}
-(void)didFormal
{
    
    Type = 1;
    [btn setTitle:@"我要买房/卖房" forState:UIControlStateNormal];
    buyBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    rentalBtn.backgroundColor = [UIColor whiteColor];
    buyBtn.selected = YES;
    rentalBtn.selected = NO;
    [_tableView reloadData];
}
-(void)didPrepare
{
    Type = 2;
    [btn setTitle:@"我要租房/出租" forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor whiteColor];
    rentalBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    buyBtn.selected = NO;
    rentalBtn.selected = YES;
    if (isFirst) {
        isFirst = NO;
        [self postResultDate:nil request:nil];
    }else{
         [_tableView reloadData];
    }
}
-(void)didAddBtn
{
    RZNewHouseViewController *newsCtrl = [[RZNewHouseViewController alloc] init];
    if (buyBtn.selected) {
        newsCtrl.titleStr = @"我要卖房/买房";
    }else{
        newsCtrl.titleStr = @"我要租房/出租";
    }
    [self.navigationController pushViewController:newsCtrl animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//算label的高度或者长度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(CGFLOAT_MAX,15);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    return size.width;
}


#pragma mark 刷新
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [_tableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView.headerRefreshingText = @"正在努力刷新中...";
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView.footerRefreshingText = @"正在努力加载中...";
    
}


- (void)headerRereshing
{
    if(IsSvPOPen){
        IsSvPOPen=NO;
        Postpage=0;
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithCapacity:0];
        [temp setObject:[NSString stringWithFormat:@"%d",Postpage] forKey:@"page"];
        [self postResultDate:nil request:nil];
        
    }
    
    
}

//- (void)footerRereshing
//{
//    if(IsSvPOPen){
//        IsSvPOPen=NO;
//        Postpage++;
//        NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithCapacity:0];
//        [temp setObject:[NSString stringWithFormat:@"%d",Postpage] forKey:@"page"];
//
//        [self postResultDateAdd:nil request:nil];
//
//    }
//
//}
#pragma mark 请求回调


//刷新  下拉
-(void)postResultDate:(NSArray *)array request:(id)requset {
    
    
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeClear];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        
        IsSvPOPen=YES;

        [SVProgressHUD  dismiss];
    });
}
////加载 上拉
//-(void)postResultDateAdd:(NSArray *)array request:(id)requset {
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        IsSvPOPen=YES;
//        [_tableView reloadData];
//        [_tableView footerEndRefreshing];
//        [_tableView setContentOffset:CGPointMake(0, _tableView.contentOffset.y-30) animated:YES];
//
//    });
//
//}  // Pass the selected object to the new view controller.


@end
