//
//  RZDetailsMyNumberViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-27.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDetailsMyNumberViewController.h"
#import "RZDetail_NumberTableViewCell.h"
#import "RZDetail_OtherCellTableViewCell.h"
#import "RZCommentViewController.h"

//!!!: 更多按钮功能没做（纠错 分享  复制链接等。）
@interface RZDetailsMyNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UITableView *_tableViewOther;
    NSMutableArray *arrOfName;
    NSMutableArray *arrOfsex;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfimage;
    NSMutableArray *arrOfdate;
    NSMutableArray *arrofUseful_Number;
    NSMutableArray *arrOfUseless_Nmuber;
    NSMutableArray *arrofUseful_State;
    NSMutableArray *arrOfUseless_State;
 
    NSArray *arrOfImageName;
    NSArray *arrOftext;
    UIImageView *imageV;
}
@end

@implementation RZDetailsMyNumberViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"号码详情";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setTabBar];
    [self Variableinitialization];
    [self createTableView];
    
     
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 444;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _tableViewOther= [[UITableView alloc] initWithFrame:CGRectMake(Mywidth-140, 0, 130, 44*4+10) style:UITableViewStylePlain];
    _tableViewOther.delegate =self;
    _tableViewOther.dataSource = self;
    _tableViewOther.alpha = 0;
    _tableViewOther.tag = 555;
    _tableViewOther.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewOther.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableViewOther];
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(Mywidth-40, 64-9.5, 15, 13)];
    imageV.image = [UIImage imageNamed:@"三角黑色"];
    imageV.alpha = 0;
    [self.navigationController.view addSubview:imageV];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [_tableView addGestureRecognizer:tap];
}
-(void)Variableinitialization
{
    arrOfName = [NSMutableArray arrayWithObjects:@"小宝",@"思密达",@"德源",@"卡特琳娜", nil];
    arrOfsex = [NSMutableArray arrayWithObjects:@"男",@"男",@"男",@"男", nil];
    arrOfdate = [NSMutableArray arrayWithObjects:@"06-12 20:02:22",@"06-12 20:02:22",@"06-12 20:02:22",@"06-12 20:02:22", nil];
    arrOfimage = [NSMutableArray arrayWithObjects:@"个人中心_03",@"头像_2",@"个人中心_03",@"110.jpg", nil];
    arrOfcontent = [NSMutableArray arrayWithObjects:@"号码已失效",@"打不通", @"可以打通问的可以打通没问的 可以打通呀,没问的 可以打通呀，没问的 可以打通呀，没问的",@"死骗子",nil];
    
    arrofUseful_Number = [NSMutableArray arrayWithObjects:@"23",@"12",@"0",@"3", nil];
    arrOfUseless_Nmuber = [NSMutableArray arrayWithObjects:@"3",@"2",@"10",@"3", nil];
    
    arrofUseful_State = [NSMutableArray arrayWithObjects:@"1",@"1",@"0",@"0", nil];
    arrOfUseless_State = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"1",nil];
    
    arrOftext = @[@"纠错",@"分享",@"复制链接",@"移除常用"];
    arrOfImageName = @[@"纠错",@"白色分享",@"链接",@"删除"];
   
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
    
   UIButton*  btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
     [btn2 setBackgroundImage:[UIImage imageNamed:@"更多"]  forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didBtn2) forControlEvents:UIControlEventTouchUpInside];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 444) {
      return  1+arrOfName.count;
    }
    return arrOfImageName.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 555) {
        return 45;
    }
    if (indexPath.row ==0) {
        return 135;
    }
    return   60+[self caculateTheTextHeight:arrOfcontent[indexPath.row-1] andFontSize:14 andDistance:75]+10+30+10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 555) {
        static NSString * cellStr = @"Other_cell";
        UITableViewCell *cell_Other = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell_Other == nil) {
            cell_Other = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arrOfImageName[indexPath.row]]];
            image.frame = CGRectMake(10, 10, 25, 25);
            [cell_Other addSubview:image];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(44, 10, 90, 25)];
            label.text = arrOftext[indexPath.row];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            [cell_Other addSubview:label];
        }
        cell_Other.backgroundColor = [UIColor blackColor];
        cell_Other.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell_Other;
    }
    
    
    
    static NSString *cellName = @"cell";
    if (indexPath.row == 0) {
        RZDetail_NumberTableViewCell *cell_one = [[RZDetail_NumberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell_one.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_one.labelofName.text = _nameStr;
        cell_one.labelofTimes.text = _timesStr;
        cell_one.labelofNumber.text = _numberStr;
        cell_one.labelofAddress.text = _addressStr;
        cell_one.labelofIntroduce.text = _contentStr;
        cell_one.labelOfState.text = @"已认证商户";
        cell_one.imageV4.image = [UIImage imageNamed:@"认证"];
        [cell_one.button addTarget:self action:@selector(didBoDa:) forControlEvents:UIControlEventTouchUpInside];
        [cell_one.bntOfComment addTarget:self action:@selector(didComent) forControlEvents:UIControlEventTouchUpInside];
        return cell_one;
    }
    RZDetail_OtherCellTableViewCell *cell_other = (RZDetail_OtherCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell_other == nil) {
        cell_other = [[RZDetail_OtherCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell_other.imageV1.image = [UIImage imageNamed:arrOfimage[indexPath.row-1]];
    if ([arrOfsex[indexPath.row-1] isEqualToString:@"男"]) {
        cell_other.imageV2.image = [UIImage imageNamed:@"男.png"];
    }else if ([arrOfsex[indexPath.row-1] isEqualToString:@"女"])
    {
        cell_other.imageV2.image = [UIImage imageNamed:@"女1.png"];
    }
    CGFloat heigth = [self caculateTheTextHeight:arrOfcontent[indexPath.row-1] andFontSize:14 andDistance:75];
    cell_other.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_other.labelOfContent.frame = CGRectMake(60, 58, self.view.frame.size.width-75,heigth);
    cell_other.btnOfUseful.frame = CGRectMake(60, 58+heigth + 15, 65, 22.5);
    cell_other.btnOfUseless.frame = CGRectMake(60+65+15, 58+heigth + 15, 65, 22.5);
    
    [cell_other.btnOfUseful setTitle:[NSString stringWithFormat:@"有用 %@",arrofUseful_Number[indexPath.row-1]] forState:UIControlStateNormal];
    
    [cell_other.btnOfUseless setTitle:[NSString stringWithFormat:@"没用 %@",arrOfUseless_Nmuber[indexPath.row-1]] forState:UIControlStateNormal];
    if ([arrofUseful_State[indexPath.row-1] intValue] == 0) {
        cell_other.btnOfUseful.selected = NO;
        cell_other.btnOfUseful.backgroundColor = [UIColor whiteColor];
    }else{
        cell_other.btnOfUseful.selected = YES;
        cell_other.btnOfUseful.backgroundColor = UIColorFromRGB(0x5496DF);
    }
    cell_other.btnOfUseful.tag = 5555+indexPath.row-1;
    cell_other.btnOfUseless.tag = 55550+indexPath.row-1;
    if ([arrOfUseless_State[indexPath.row-1] intValue] == 0) {
        cell_other.btnOfUseless.selected = NO;
        cell_other.btnOfUseless.backgroundColor = [UIColor whiteColor];
    }else{
        cell_other.btnOfUseless.selected = YES;
        cell_other.btnOfUseless.backgroundColor = UIColorFromRGB(0x5496DF);
    }
    [cell_other.btnOfUseful addTarget:self action:@selector(didUserful:) forControlEvents:UIControlEventTouchUpInside];
    [cell_other.btnOfUseless addTarget:self action:@selector(didUseless:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell_other.labelOfName.text = arrOfName[indexPath.row-1];
    cell_other.labelOfDate.text = arrOfdate[indexPath.row-1];
    cell_other.labelOfContent.text = arrOfcontent[indexPath.row -1];
    return cell_other;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 555) {
        
    }
}
-(void)didTap{
    [UIView animateWithDuration:0.5 animations:^{
        _tableViewOther.alpha = 0;
        imageV.alpha = 0;
        
    }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    imageV.alpha = 0;
}
-(void)didBtn2
{
    [UIView animateWithDuration:0.5 animations:^{
        _tableViewOther.alpha = 1;
        imageV.alpha =1;
    }];
}
//评论
-(void)didComent
{
    RZCommentViewController *commentCtrl = [[RZCommentViewController alloc] init];
    [self.navigationController pushViewController:commentCtrl animated:YES];
}
//拨号
-(void)didBoDa:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",_numberStr]]];
    NSLog(@"%@",_numberStr);
}
-(void)didUserful:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [arrofUseful_State removeObjectAtIndex:sender.tag-5555];
    [arrofUseful_State insertObject:[NSString stringWithFormat:@"%d",sender.selected] atIndex:sender.tag-5555];
    RZDetail_OtherCellTableViewCell *cell = (RZDetail_OtherCellTableViewCell *)[[sender superview]superview];
    UIButton *btn1 = (UIButton *)[cell viewWithTag:sender.tag-5555+55550];
    if (btn1.selected) {
        btn1.selected = !btn1.selected;
        [arrOfUseless_State removeObjectAtIndex:btn1.tag-55550];
        [arrOfUseless_State insertObject:[NSString stringWithFormat:@"%d",btn1.selected] atIndex:btn1.tag-55550];
    }
    [_tableView reloadData];
}
-(void)didUseless:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [arrOfUseless_State removeObjectAtIndex:sender.tag-55550];
    [arrOfUseless_State insertObject:[NSString stringWithFormat:@"%d",sender.selected] atIndex:sender.tag-55550];
    
    RZDetail_OtherCellTableViewCell *cell = (RZDetail_OtherCellTableViewCell *)[[sender superview]superview];
    UIButton *btn1 = (UIButton *)[cell viewWithTag:sender.tag-55550+5555];
    if (btn1.selected) {
        btn1.selected = !btn1.selected;
        [arrofUseful_State removeObjectAtIndex:btn1.tag-5555];
        [arrofUseful_State insertObject:[NSString stringWithFormat:@"%d",btn1.selected] atIndex:btn1.tag-5555];
    }
     [_tableView reloadData];
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
-(void)viewWillDisappear:(BOOL)animated
{
    imageV.hidden = YES;
}
@end
