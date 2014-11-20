//
//  RZHot_otherViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHot_otherViewController.h"
#import "RZCreateHotViewController.h"
#import "RZHot_FormalTableViewCell.h"
#import "RZHot_PrepareTableViewCell.h"
#import "RZHot_PrepareViewController.h"
#import "RZHot_FormalViewController.h"
#import "TextStepperField.h"
#import "MarkupParser.h"
#import "RESideMenu.h"
#import "MJRefresh.h"
#import "CustomLabel.h"
#define MyWidth (self.view.frame.size.width)
@interface RZHot_otherViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *formalBtn;
    UIButton *prepareBtn;
    UITableView * _tableView;
    CGFloat height;
    int Postpage;//分页
    BOOL IsSvPOPen;
    BOOL isFirst;
    BOOL isCancel;
    NSInteger Type;//加载数据类别
    UILabel *lbload;//提示
    NSMutableArray *arr_numberhead_formal;
    NSMutableArray *arr_title_formal;
    NSMutableArray *arr_numbercomment_formal;
    NSMutableArray *arr_numberoption_formal;
    NSMutableArray *arr_time_formal;
    NSMutableArray *arr_image_formal;
    NSMutableArray *arr_Hotcontent_formal;
    
    
    NSMutableArray *arr_numberhead_prepare;
    NSMutableArray *arr_title_prepare;
    NSMutableArray *arr_numberattention_prepare;
    NSMutableArray *arr_time_prepare;
    
    UIView *_headView;
    
}
@end

@implementation RZHot_otherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"热点议事厅";
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
    isCancel = NO;
    Type=1;
    arr_numberhead_formal = [NSMutableArray arrayWithObjects:@"1000",@"9",nil];
    arr_title_formal = [NSMutableArray arrayWithObjects:@"强烈要求先满足四期业主车位，现在小区外来停车的太多了，搞得大妈没地方跳舞，你造吗？？？？？？尤其是按时间快点发货阿里地方很近捩手覆羹冬季施工速度发货价格",@"这个垃圾物业！！！的！的的",nil];
    arr_numbercomment_formal = [NSMutableArray arrayWithObjects:@"999",@"9",nil];
    arr_numberoption_formal = [NSMutableArray arrayWithObjects:@"100",@"9",nil];
    arr_time_formal = [NSMutableArray arrayWithObjects:@"2014-06-11 11:35",@"2014-06-11 11:35",nil];
    arr_image_formal = [NSMutableArray arrayWithObjects:@"头像_4.png",@"头像_4.png",nil];
    arr_Hotcontent_formal = [NSMutableArray arrayWithObjects:@" 支持！这地方简直没办法亭车了 没办法跳舞了！",@"物业！小心我提刀上门", nil];
    
    
    arr_title_prepare = [NSMutableArray arrayWithObjects:@"强烈要求先满足四期业主车位，现在小区外来停车的太多了，搞得大妈没地方跳舞，你造吗？？？？？？尤其是按时间快点发货阿里地方很近捩手覆羹冬季施工速度发货价格",@"这个垃圾物业！！！！",@"强烈要求先满足四期业主车位，现在小区外来停车的太多了，搞得大妈没地方跳舞，你造吗？？？？？？尤其是按时间快点发货阿里地方很近捩手覆羹冬季施工速度发货价格",nil];
    arr_numberhead_prepare = [NSMutableArray arrayWithObjects:@"1000",@"9",@"9990",nil];
    arr_time_prepare = [NSMutableArray arrayWithObjects:@"2014-06-11 11:35",@"2014-06-11 11:35",@"2014-06-11 11:35",nil];
    arr_numberattention_prepare = [NSMutableArray arrayWithObjects:@"100",@"9",@"1101",nil];
    
    
    
}
-(void)setTabar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:UIColorFromRGB(0xf0f0f0)];
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
    [btn2 setTitle:@"发起" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didFaQi) forControlEvents:UIControlEventTouchUpInside];
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
-(void)createSegment
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 12+35+10)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(12, 10, MyWidth-30, 35)];
    [segmentView setBackgroundColor:[UIColor clearColor]];
    segmentView.layer.cornerRadius = 7;
    segmentView.layer.masksToBounds = YES;
    segmentView.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
    segmentView.layer.borderWidth = 1;
    [backView addSubview:segmentView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 12+35+9, MyWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [backView addSubview:lineView];
    
    formalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [formalBtn setTitle:@"正式议题" forState:UIControlStateNormal];
    formalBtn.selected = YES;
    [formalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [formalBtn setTitleColor:UIColorFromRGB(0x5496DF) forState:UIControlStateNormal];
    formalBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [formalBtn addTarget:self action:@selector(didFormal) forControlEvents:UIControlEventTouchUpInside];
    formalBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    
    
    formalBtn.frame = CGRectMake(0, 0, (self.view.frame.size.width-30)/2, 35);
    [segmentView addSubview:formalBtn];
    
    prepareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [prepareBtn setTitle:@"预备议题" forState:UIControlStateNormal];
    prepareBtn.backgroundColor = [UIColor whiteColor];
    prepareBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [prepareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [prepareBtn setTitleColor:UIColorFromRGB(0x5496DF) forState:UIControlStateNormal];
    [prepareBtn addTarget:self action:@selector(didPrepare) forControlEvents:UIControlEventTouchUpInside];
    prepareBtn.frame = CGRectMake((self.view.frame.size.width-30)/2, 0, (self.view.frame.size.width-30)/2, 35);
    [segmentView addSubview:prepareBtn];
    
}
-(void)createTableView
{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 12+35+10, self.view.frame.size.width, self.view.frame.size.height-66) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColorFromRGB(0xf0f0f0);
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
    if (formalBtn.selected) {
        return arr_title_formal.count+1;
    }else{
        return arr_title_prepare.count+1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (formalBtn.selected) {
        if (indexPath.row == arr_numbercomment_formal.count) {
            return 50;
        }else{
            
            if([arr_title_formal[indexPath.row] length] >= 14)
            {
                return 200+10;
            }else{
                
                return 180+10;
            }
        }
    }else{
        if (indexPath.row == arr_title_prepare.count) {
            return 50;
        }else{
            
            if([arr_title_prepare[indexPath.row] length] >= 14)
            {
                return 90;
            }else{
                
                return 70;
            }
        }
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 30)];
    _headView.backgroundColor = UIColorFromRGB(0xefefef);
    
    UILabel *headlebel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MyWidth-35, 30)];
    headlebel.text = @"  关注数达到10即可成为正式议题";
    headlebel.textColor = UIColorFromRGB(0x888888);
    headlebel.backgroundColor = UIColorFromRGB(0xefefef);
    
    [_headView addSubview:headlebel];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"取消.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(didCancel) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(MyWidth - 35, 5, 20, 20);
    [_headView addSubview:btn];
    _headView.userInteractionEnabled = YES;
    
    return _headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (formalBtn.selected || isCancel) {
        return 0;
    }else{
        return 30;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *celllast = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    celllast.backgroundColor = UIColorFromRGB(0xf0f0f0);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = UIColorFromRGB(0x7c7c7c);
    label.text = @"没有更多了...";
    label.textAlignment = NSTextAlignmentCenter;
    [celllast addSubview:label];
    
    if (formalBtn.selected)
    {
        static NSString * cellname = @"formal_cell";
        RZHot_FormalTableViewCell *cell = (RZHot_FormalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (cell == nil) {
            cell = [[RZHot_FormalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        
        if (indexPath.row == [arr_title_formal count]) {
            return celllast;
        }
        if([arr_title_formal[indexPath.row] length] >= 14)
        {
            height = 43;
        }else{
            height = 20;
        }
        CGFloat width = [self caculateTheTextHeight:arr_numbercomment_formal[indexPath.row] andFontSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.labelOftitle.frame = CGRectMake(10, 10,MyWidth-20,height);
        cell.labelOfnumber_head.frame = CGRectMake(10, 10, 50, 20);
        cell.blueView.frame = CGRectMake(15, 20+height+2.5, 10, 10);
        cell.labelOfNumber_comment.frame = CGRectMake(15+10+10, 20+height,width, 15);
        cell.labelOfComment.frame = CGRectMake(30+width+13, 20+height, 40, 15);
        cell.orangeView.frame = CGRectMake(140, 20+height+2.5, 10, 10);
        cell.labelOfoption.frame = CGRectMake(140+10+3, 20+height-1, 80, 20);
        cell.labelOftime.frame = CGRectMake(12, height+20+15+10, 150, 15);
        cell.imageV1.frame = CGRectMake(40, height+20+15+10+15+4, 25, 20);
        cell.footView.frame = CGRectMake(10, height+20+15+10+15+10+10, MyWidth-20, 60);
        cell.imageV2.frame = CGRectMake(10, 8, 45, 45);
        cell.labelOfHotComent.frame = CGRectMake(68, 12, MyWidth-20-65-10, 40);
        
        cell.backgroundColor = [UIColor whiteColor];
        MarkupParser *hotcomment = [[MarkupParser alloc] init];
        hotcomment.fontSize = 15;
        NSAttributedString *hotCommentStr = [hotcomment attrStringFromMarkup:[NSString stringWithFormat:@"<font color=\"orange\">#最热观点# <font color=\"black\">%@",arr_Hotcontent_formal[indexPath.row]]];
        [cell.labelOfHotComent setAttString:hotCommentStr];
        
        MarkupParser *option = [[MarkupParser alloc] init];
        option.fontSize = 14;
        NSAttributedString *optionStr = [option attrStringFromMarkup:[NSString stringWithFormat:@"<font color=\"orange\"> %@ <font color=\"black\"> 观点",arr_numberoption_formal[indexPath.row]]];
        [cell.labelOfoption setAttString:optionStr];
        
        cell.labelOftitle.text = [NSString stringWithFormat:@"             %@",arr_title_formal[indexPath.row]];
        cell.labelOfnumber_head.text = arr_numberhead_formal[indexPath.row];
        cell.labelOfNumber_comment.text = arr_numbercomment_formal[indexPath.row];
        cell.labelOftime.text = arr_time_formal[indexPath.row];
        cell.imageV2.image = [UIImage imageNamed:arr_image_formal[indexPath.row]];
        
        return cell;
        
    }else
    {
        static NSString *cellStr = @"Prepare_cell";
        RZHot_PrepareTableViewCell *cell1 = (RZHot_PrepareTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell1 == nil) {
            cell1 = [[RZHot_PrepareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        
        if(indexPath.row == arr_title_prepare.count){
            return celllast;
        }
        
        if([arr_title_prepare[indexPath.row] length] >= 14)
        {
            height = 43;
        }else{
            height = 20;
        }
        CGFloat width = [self caculateTheTextHeight:arr_numberattention_prepare[indexPath.row] andFontSize:16];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.labelOftitle.frame = CGRectMake(10, 10,MyWidth-20,height);
        cell1.labelOfnumber_head.frame = CGRectMake(10, 10, 50, 20);
        
        cell1.imageV.frame = CGRectMake(13, height+20+5+2-5, 20, 12);
        cell1.labelOfnumber_attention.frame = CGRectMake(13+20+5, height+20+5-5, width, 15);
        cell1.labelOfattention.frame = CGRectMake(13+20+width+10, height+20+5-5, 80, 15);
        cell1.labelOftime.frame = CGRectMake(MyWidth-165, height+20+5-5, 150, 15);
        
        cell1.labelOftime.text = arr_time_prepare[indexPath.row];
        cell1.labelOftitle.text = [NSString stringWithFormat:@"             %@",arr_title_prepare[indexPath.row]];
        cell1.labelOfnumber_attention.text = arr_numberattention_prepare[indexPath.row];
        cell1.labelOfnumber_head.text = arr_numberhead_prepare[indexPath.row];
        
        return cell1;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(Type == 2)
    {
        RZHot_PrepareViewController *prepareCtrl = [[RZHot_PrepareViewController alloc] init];
        [self.navigationController pushViewController:prepareCtrl animated:YES];
    }else if (Type == 1)
    {
        RZHot_FormalViewController *formalCtrl = [[RZHot_FormalViewController alloc] init];
        [self.navigationController pushViewController:formalCtrl animated:YES];
    }
    
    
}
-(void)didFormal
{
    Type = 1;
    formalBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    prepareBtn.backgroundColor = [UIColor whiteColor];
    formalBtn.selected = YES;
    prepareBtn.selected = NO;
    [self postResultDate:nil request:nil];
    
    
    
    
}
-(void)didPrepare
{
    Type = 2;
    formalBtn.backgroundColor = [UIColor whiteColor];
    prepareBtn.backgroundColor = UIColorFromRGB(0x5496DF);
    formalBtn.selected = NO;
    prepareBtn.selected = YES;
    [self postResultDate:nil request:nil];
    
}
-(void)didCancel
{
    isCancel = YES;
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFaQi
{
    RZCreateHotViewController *createCtrl = [[RZCreateHotViewController alloc] init];
    [self.navigationController pushViewController:createCtrl animated:YES];
    
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
//}

@end
