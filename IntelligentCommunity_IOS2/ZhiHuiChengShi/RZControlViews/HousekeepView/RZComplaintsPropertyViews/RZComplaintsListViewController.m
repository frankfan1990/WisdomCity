//
//  RZComplaintsListViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-20.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark 我的 -  四个VIew的第一个 - 投诉记录

#import "RZComplaintsListViewController.h"
#import "RZComplaintsTableViewCell.h"
#import "RZComplaintsDetailsViewController.h"
#import "RZAddComplaintsViewController.h"


@interface RZComplaintsListViewController ()
{
    UILabel *label;
    IBOutlet UITableView *_tableview;
    NSMutableArray *_tableData;
    
}
@end

@implementation RZComplaintsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
       label= [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"投诉记录";
        [label setFont:[UIFont systemFontOfSize:18]];
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
-(void)goRight{
    RZAddComplaintsViewController *view=[[RZAddComplaintsViewController alloc] initWithNibName:@"RZAddComplaintsViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor grayColor]];
    {
        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
    
        
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
        
        UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnRight setFrame:CGRectMake(0, 0, 40, 40)];;
        [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnRight setTitle:@"投诉" forState:UIControlStateNormal];
//        [btnRight setBackgroundImage:[UIImage imageNamed:@"Rzback.png"] forState:UIControlStateNormal];
//        [btnRight setBackgroundImage:[UIImage imageNamed:@"Rzback.png"] forState:UIControlStateHighlighted];
        btnRight.titleLabel.font = [UIFont systemFontOfSize:17];
        [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnRight addTarget:self action:@selector(goRight) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *btnRightitem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
        
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -10;
            self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnRightitem];
        }else{
            self.navigationItem.rightBarButtonItem = btnRightitem;
        }

    }
    
    [_tableview setBackgroundColor:[UIColor whiteColor]];
    _tableData=[[NSMutableArray alloc] initWithCapacity:0];
//    if([_tableData count]==1&&[_titleName rangeOfString:@"投诉"].location== NSNotFound){
//        UILabel * lab= [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 280, 25)];
//        lab.textColor =[UIColor grayColor];
//        lab.backgroundColor = [UIColor clearColor];
//        lab.text = @"您还没有报修记录哦~";
//        [lab setFont:[UIFont systemFontOfSize:20]];
//        //    label.adjustsFontSizeToFitWidth=YES;
//        lab.textAlignment =NSTextAlignmentCenter;
//        [_tableview addSubview:lab];
//    }
    // Do any additional setup after loading the view.
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
    //    return [_tableData count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    RZComplaintsTableViewCell *cell = (RZComplaintsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"RZComplaintsTableViewCell"];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RZComplaintsTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lbProgressState1.layer.masksToBounds=YES;
    cell.lbProgressState1.layer.cornerRadius=  cell.lbProgressState1.frame.size.width/2;
    cell.lbProgressState2.layer.masksToBounds=YES;
    cell.lbProgressState2.layer.cornerRadius=cell.lbProgressState2.frame.size.width/2;
    cell.lbProgressState3.layer.masksToBounds=YES;
    cell.lbProgressState3.layer.cornerRadius=cell.lbProgressState3.frame.size.width/2;
    cell.lbLine.backgroundColor=UIColorFromRGB(0xcdcdcd);
    cell.lbProgressLine1.backgroundColor=UIColorFromRGB(0xcdcdcd);
    cell.lbProgressState1.backgroundColor=UIColorFromRGB(0xcdcdcd);
    cell.lbProgressLine2.backgroundColor=UIColorFromRGB(0xcdcdcd);
    cell.lbProgressState2.backgroundColor=UIColorFromRGB(0xcdcdcd);
    cell.lbProgressLine3.backgroundColor=UIColorFromRGB(0xcdcdcd);
    cell.lbProgressState3.backgroundColor=UIColorFromRGB(0xcdcdcd);
    
   if(indexPath.row+1==1){
        cell.lbProgressLine1.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressState1.backgroundColor=UIColorFromRGB(0x5597e1);
        
    }
    else if(indexPath.row+1==2){
        cell.lbProgressLine1.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressState1.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressLine2.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressState2.backgroundColor=UIColorFromRGB(0x5597e1);
    }
    else if(indexPath.row+1==3){
        cell.lbProgressLine1.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressState1.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressLine2.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressState2.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressLine3.backgroundColor=UIColorFromRGB(0x5597e1);
        cell.lbProgressState3.backgroundColor=UIColorFromRGB(0x5597e1);
    }
 
    [cell.btnProgress setTag:indexPath.row];
    [cell.btnProgress addTarget:self action:@selector(goprogress:) forControlEvents:UIControlEventTouchUpInside];
 
 
    cell.lbTime.text=[NSString stringWithFormat:@"投诉时间:%@",@"2014-12-12 12:00"];
    cell.lbTime.textColor = UIColorFromRGB(0x909090);
    cell.lbTime.font = [UIFont systemFontOfSize:12];

    cell.lbTypeName.text=[NSString stringWithFormat:@"%@",@"投诉类型"];
    cell.lbTypeName.font = [UIFont systemFontOfSize:15];
    cell.lbSubTitle.font = [UIFont systemFontOfSize:13];
    cell.lbSubTitle.text=[NSString stringWithFormat:@"%@",@"详情数据,详细内容,详情数据,详细内容,详情数据,详细内容,详情数据,详细内容,详情数据,详细内容,详情数据,详细内容,详情数据,详细内容"];
 
    CGSize size = [self caculateTheTextHeight:cell.lbSubTitle.text andFontSize:14 andDistance:20];
    cell.lbSubTitle.numberOfLines=size.height/14+2;
    
    [cell.lbSubTitle setFrame:CGRectMake(cell.lbSubTitle.frame.origin.x, cell.lbSubTitle.frame.origin.y, cell.lbSubTitle.frame.size.width,(NSInteger)size.height+14)];
    
    float height=cell.lbSubTitle.frame.origin.y+cell.lbSubTitle.frame.size.height+8;
    //显示图片
    cell.scrollview.delegate=self;
    cell.scrollview.layer.masksToBounds=YES;
    cell.scrollview.layer.cornerRadius= 4;
    cell.scrollview.backgroundColor = UIColorFromRGB(0xeeeeee);
    [cell.scrollview setContentOffset:CGPointMake(0, 0)];
    [[cell.scrollview subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(int i=0;i<arc4random()%4+1;i++){
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(12+70*i, 6, 65, 64)];
        [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://picview01.baomihua.com/photos/20120801/m_14_634794220804218750_41722879.jpg"]] placeholderImage:nil];
        [cell.scrollview addSubview:img];
        [cell.scrollview setContentSize:CGSizeMake(img.frame.size.width+img.frame.origin.x, cell.scrollview.frame.size.height)];

    }
     height=height+cell.scrollview.frame.size.height+8;
    
      height+= cell.btnAppraise.frame.size.height+8;
    
    //判断现实评价 还是评分
    if(indexPath.row%3==0){
         cell.starRatingView.IsPanEnable=NO;
        [cell.starRatingView setScore:0.2 withAnimation:YES];
        [cell.starRatingView setHidden:NO];
        [cell.btnAppraise setHidden:YES];
    }
    else{
        [cell.starRatingView setHidden:YES];
        [cell.btnAppraise setHidden:NO];
        [cell.btnAppraise setTag:indexPath.row];
        [cell.btnAppraise addTarget:self action:@selector(goAppraise:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    cell.btnAppraise.layer.borderWidth = 0.5;
    cell.btnAppraise.layer.borderColor = MyTitleBlueColr.CGColor;
    [cell.btnAppraise setTitleColor:MyTitleBlueColr forState:UIControlStateNormal];
    [cell.btnDetails setTag:indexPath.row];
    [cell.btnDetails addTarget:self action:@selector(goDetails:) forControlEvents:UIControlEventTouchUpInside];
 
    [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, height+5)];

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(void)goprogress:(UIButton *)sender{
    NSLog(@"1");
    RZComplaintsDetailsViewController *view=[[RZComplaintsDetailsViewController alloc] initWithNibName:@"RZComplaintsDetailsViewController" bundle:nil];
    view.type=102;//投诉详情101  投诉进度102  报修详情103
    [self.navigationController pushViewController:view animated:YES];
}
-(void)goAppraise:(UIButton *)sender{
      NSLog(@"2");
}
-(void)goDetails:(UIButton *)sender{
    RZComplaintsDetailsViewController *view=[[RZComplaintsDetailsViewController alloc] initWithNibName:@"RZComplaintsDetailsViewController" bundle:nil];
    view.type=101;//投诉详情101  投诉进度102  报修详情103
    [self.navigationController pushViewController:view animated:YES];
    NSLog(@"3");
}


#pragma mark - 根据字长算 高度或宽度
- (CGSize)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
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

    return size;
}
@end
