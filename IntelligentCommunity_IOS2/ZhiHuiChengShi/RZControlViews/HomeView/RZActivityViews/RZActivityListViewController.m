//
//  RZActivityListViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//


#pragma mark ** 找一找/首页 - 活动召集令

#import "RZActivityListViewController.h"
#import "RZLaunchViewController.h"
#import "MJRefresh.h"
#import "RZActivityListCell.h"
#import "RZNewActivityViewController.h"

@interface RZActivityListViewController ()
{
    IBOutlet UIView *topview;
    IBOutlet UIButton *btnActivityNew;
    IBOutlet UIButton *btnActivityPartake;
    IBOutlet UIButton *btnActivityLaunch;
    IBOutlet UILabel *lbbtnback;
    
    UILabel *lbload;//提示
    int Postpage;//分页
    UIAlertView *_althud;//通用弹窗
    NSInteger Type;//加载数据类别
    BOOL IsSvPOPen;
    IBOutlet UITableView *_tableview;
    NSMutableArray *_tableData;
    NSMutableArray *_tableData1;
    NSMutableArray *_tableData2;
    NSMutableArray *_tableData3;
    
}
-(IBAction)btnSelect:(UIButton *)sender;
@end

@implementation RZActivityListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, -15, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"活动召集令";
        [label setFont:[UIFont systemFontOfSize:20]];
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
    Type = 1;
    _tableview.backgroundColor = UIColorFromRGB(0xf0f0f0);
    btnActivityPartake.layer.borderColor = [UIColor colorWithRed:45/255.0f green:130/255.0f blue:220/255.0f alpha:1].CGColor;
    btnActivityPartake.layer.borderWidth = 1;
    
    [btnActivityNew setBackgroundColor:UIColorFromRGB(0x5597E1)];
    [btnActivityLaunch setBackgroundColor:[UIColor clearColor]];
    [btnActivityPartake setBackgroundColor:[UIColor clearColor]];
    btnActivityNew.selected = YES;
    [btnActivityNew setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
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
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"发起" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
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
    
    
    topview.layer.masksToBounds=YES;
    topview.layer.cornerRadius=5;
    topview.layer.borderWidth=1;
    topview.layer.borderColor=[UIColor colorWithRed:45/255.0f green:130/255.0f blue:220/255.0f alpha:1].CGColor;
//    topview.backgroundColor=[UIColor colorWithRed:45/255.0f green:130/255.0f blue:220/255.0f alpha:1];
    topview.backgroundColor = [UIColor clearColor];
    lbbtnback.backgroundColor=[UIColor colorWithRed:45/255.0f green:130/255.0f blue:220/255.0f alpha:1];

    
    lbload=[[UILabel alloc] initWithFrame:CGRectMake(0, _tableview.frame.origin.y, 320, 25)];
    lbload.text=@"休息会儿,没有更多内容了!!!";
    lbload.font=[UIFont systemFontOfSize:13.0f];
    lbload.textAlignment=NSTextAlignmentCenter;
    lbload.backgroundColor=  [UIColor colorWithRed:62/255.0f green:180/255.0f blue:180/255.0f alpha:0.8];
    lbload.textColor=[UIColor whiteColor];
    lbload.hidden=YES;
    [self.view addSubview:lbload];
    _tableData=[[NSMutableArray alloc] initWithCapacity:0];
    _tableData1=[[NSMutableArray alloc] initWithCapacity:0];
    _tableData2=[[NSMutableArray alloc] initWithCapacity:0];
    _tableData3=[[NSMutableArray alloc] initWithCapacity:0];
    _tableData1=[NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"http://g.hiphotos.baidu.com/image/w%3D400/sign=4be7f3c141166d223877149476230945/e850352ac65c10384d5fbac8b0119313b07e8992.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
     [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/meinvbizhi0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
     [NSDictionary dictionaryWithObjectsAndKeys:@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
     [NSDictionary dictionaryWithObjectsAndKeys:@"http://a.hiphotos.baidu.com/image/w%3D400/sign=55af4af479899e51788e3b1472a7d990/f9198618367adab42ab8824a89d4b31c8701e44b.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
     [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/a50f4bfbfbedab64947d23a7f536afc379311e4d.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
     [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
     [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/6a.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
    
    _tableData2=[NSMutableArray arrayWithObjects:
                [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/6a.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
    _tableData3=[NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"http://g.hiphotos.baidu.com/image/w%3D400/sign=4be7f3c141166d223877149476230945/e850352ac65c10384d5fbac8b0119313b07e8992.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/meinvbizhi0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    Postpage=0;
    IsSvPOPen=YES;
    Type=1;
    // 2.集成刷新控件
    [self setupRefresh];
    
    [SVProgressHUD showWithStatus:@""];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
    
     [self postResultDate:nil request:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnSelect:(UIButton *)sender{
    
    

    if(sender.tag==101&&!sender.selected){
       
        Type=1;
        _tableData = [NSMutableArray arrayWithArray:_tableData1];
        [btnActivityNew setBackgroundColor:UIColorFromRGB(0x5597E1)];
        [btnActivityLaunch setBackgroundColor:[UIColor whiteColor]];
        [btnActivityPartake setBackgroundColor:[UIColor whiteColor]];
        btnActivityLaunch.selected=NO;
        btnActivityPartake.selected=NO;
        btnActivityNew.selected= YES;
        [SVProgressHUD showWithStatus:@""];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
        
        [self postResultDate:nil request:nil];
        
        
    }
    else if(sender.tag==101&&sender.selected){
        Type=1;
        _tableData = [NSMutableArray arrayWithArray:_tableData1];
        [self headerRereshing];
    }
    else if(sender.tag==102&&!sender.selected){
        _tableData = [NSMutableArray arrayWithArray:_tableData2];
        Type=2;
        [btnActivityNew setBackgroundColor:[UIColor whiteColor]];
        [btnActivityLaunch setBackgroundColor:[UIColor whiteColor]];
        [btnActivityPartake setBackgroundColor:UIColorFromRGB(0x5597E1)];

        btnActivityNew.selected=NO;
        btnActivityLaunch.selected=NO;
        btnActivityPartake.selected= YES;
        [UIView animateWithDuration:0.3 animations:^{
            [lbbtnback setFrame:CGRectMake(100, 0, 100, 42)];
        }];
        [SVProgressHUD showWithStatus:@""];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
        [self postResultDate:nil request:nil];
    }
    else if(sender.tag==102&&sender.selected){
        _tableData = [NSMutableArray arrayWithArray:_tableData2];
        Type=2;
        [self headerRereshing];
    }
    else if(sender.tag==103&&!sender.selected){
        _tableData = [NSMutableArray arrayWithArray:_tableData3];
        Type=3;
        [btnActivityNew setBackgroundColor:[UIColor whiteColor]];
        [btnActivityLaunch setBackgroundColor:UIColorFromRGB(0x5597E1)];
        [btnActivityPartake setBackgroundColor:[UIColor whiteColor]];
        btnActivityPartake.selected=NO;
        btnActivityNew.selected=NO;
        btnActivityLaunch.selected= YES;
        [UIView animateWithDuration:0.3 animations:^{
            [lbbtnback setFrame:CGRectMake(200, 0, 100, 42)];
        }];
        [SVProgressHUD showWithStatus:@""];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
        [self postResultDate:nil request:nil];
        
    }
    else if(sender.tag==103&&sender.selected){
        _tableData = [NSMutableArray arrayWithArray:_tableData3];
        Type=3;
        [self headerRereshing];
    }
}
#pragma mark 刷新
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [_tableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableview.headerPullToRefreshText = @"下拉可以刷新了";
    _tableview.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableview.headerRefreshingText = @"正在努力刷新中...";
    _tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableview.footerRefreshingText = @"正在努力加载中...";

}


- (void)headerRereshing
{
    if(IsSvPOPen){
        IsSvPOPen=NO;
        Postpage=0;
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithCapacity:0];
        [temp setObject:[NSString stringWithFormat:@"%d",Postpage] forKey:@"page"];
        [temp setObject:[NSString stringWithFormat:@"%d",Type] forKey:@"type"];
        [self postResultDate:nil request:nil];
   
    }
    
    
}

- (void)footerRereshing
{
    if(IsSvPOPen){
        IsSvPOPen=NO;
        Postpage++;
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithCapacity:0];
        [temp setObject:[NSString stringWithFormat:@"%d",Postpage] forKey:@"page"];
        [temp setObject:[NSString stringWithFormat:@"%d",Type] forKey:@"type"];
        
        [self postResultDateAdd:nil request:nil];
        
    }
    
}
#pragma mark 请求回调


//刷新  下拉
-(void)postResultDate:(NSArray *)array request:(id)requset {
    
    if (Type == 1)
    {
        _tableData  = [NSMutableArray arrayWithArray:_tableData1];
    }else if (Type == 2)
    {
        _tableData = [NSMutableArray arrayWithArray:_tableData2];
    }else
    {
        _tableData = [NSMutableArray arrayWithArray:_tableData3];
    }
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableview reloadData];
        [_tableview headerEndRefreshing];
        IsSvPOPen=YES;
        [SVProgressHUD  dismiss];
    });
}
//加载 上拉
-(void)postResultDateAdd:(NSArray *)array request:(id)requset {

    if (Type == 1) {
         [_tableData addObjectsFromArray:_tableData1];
    }
  
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    IsSvPOPen=YES;
    [_tableview reloadData];
    [_tableview footerEndRefreshing];
    [_tableview setContentOffset:CGPointMake(0, _tableview.contentOffset.y-30) animated:YES];
    
      });
    
    
    
}

-(void)hidelbload{
    [lbload setHidden:YES];
}

#pragma mark Tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count]+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZActivityListCell *cell = (RZActivityListCell*)[tableView dequeueReusableCellWithIdentifier:@"RZActivityListCell"];
    UITableViewCell *celllast = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.row == [_tableData count]) {
        celllast.backgroundColor = UIColorFromRGB(0xf0f0f0);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = UIColorFromRGB(0x7c7c7c);
        label.text = @"没有更多了。。。。";
        label.textAlignment = NSTextAlignmentCenter;
        [celllast addSubview:label];
        return celllast;
    }
    
    
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RZActivityListCell" owner:nil options:nil] objectAtIndex:0];
    }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    
    NSDictionary *temp=[_tableData objectAtIndex:indexPath.row];
    cell.lbTitle.text=[temp objectForKey:@"text"];
    cell.lbimgTitle.text = @"进行中";
    cell.lbimgTitle.backgroundColor = UIColorFromRGB(0x5597E1);
    [cell.image setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",[temp objectForKey:@"image0"]]] placeholderImage:[UIImage imageNamed:@"Default"] ];
//    cell.lbSubTitle.text=@"";
//    cell.lbOtherTitle.text=@"";
//    cell.lbaddress.text=@"";
    if(arc4random()%3==0){
        cell.lbimgTitle.text=@"已结束";
        cell.lbimgTitle.backgroundColor=[UIColor grayColor];
    }
//    [NSString stringWithFormat:@"%@", [UtilCheck flattenHTML:[NSString stringWithFormat:@"%@",[temp objectForKey:@"keyWord"]]  trimWhiteSpace:YES] ];
    //    [cell.lbcontent setFrame:CGRectMake(108, 32, 203, 80)];
 

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        RZNewActivityViewController *newActivityCtrl = [[RZNewActivityViewController alloc] init];
    
        newActivityCtrl.type = Type;
        newActivityCtrl.dictData = _tableData[indexPath.row];
        [self.navigationController pushViewController:newActivityCtrl animated:YES];
}
-(void)didBtn2
{
    RZLaunchViewController *launchCtrl = [[RZLaunchViewController alloc] init];
    [self.navigationController pushViewController:launchCtrl animated:YES];
}

@end
