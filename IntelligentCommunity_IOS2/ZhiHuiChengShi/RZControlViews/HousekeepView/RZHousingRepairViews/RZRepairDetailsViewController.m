//
//  RZRepairDetailsViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-15.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark 我的 -  四个VIew的第一个 - 投诉记录 - 报修详情
#import "RZRepairDetailsViewController.h"
#import "RZRepairTableViewCell.h"

@interface RZRepairDetailsViewController ()
{
    IBOutlet UITableView *_tableview;
    NSMutableArray *_tableData;
    NSString *contentStr;
    NSMutableArray *arrOfStatus;
    
}
@end

@implementation RZRepairDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel*  label= [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"报修详情";
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}
 
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    contentStr = @"我家天华板裂开了没有没有师傅来过来修理下 不修理我就去修理你去了 你说我说的对不对我家天华板裂开了没有没有师傅来过来修理下 不修理我就去修理你去了 你说我说的对不对我家天华板裂开了没有没有师傅来过来修理下 不修理我";
    arrOfStatus = [NSMutableArray arrayWithObjects:@"1",@"1",@"0", nil];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor grayColor]];
   
    
    //顶部按钮
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
    [btn2 setBackgroundImage:[UIImage imageNamed:@"更多"]  forState:UIControlStateNormal];
   
    
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 addTarget:self action:@selector(didExit:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [_tableview setBackgroundColor:[UIColor whiteColor]];
    _tableData=[[NSMutableArray alloc] initWithCapacity:0];
 

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if(section==0){
        return 1;
    }
    else if(section==1){
        return 3;
    }
    else if(section==2){
        return 2;
    }
      return 3;
    
    //    return [_tableData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 40.0f;
    }
    else{
        return 50.0f;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50.0f)];
    UIImageView *imghead=[[UIImageView alloc] initWithFrame:CGRectMake(88, 11, 10, 33)];
    imghead.image = [UIImage imageNamed:@"三角边"];
    [view addSubview:imghead];
    
    
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 15, 88, 25)];
    labTitle.font=[UIFont systemFontOfSize:15.0f];
    labTitle.textColor=UIColorFromRGB(0xffffff);
    labTitle.backgroundColor = UIColorFromRGB(0x58d158);
    labTitle.textAlignment=NSTextAlignmentCenter;
    [view addSubview:labTitle];
    
    
    if(section==0){
        labTitle.text=[NSString stringWithFormat:@"报修描述"];
    }
    else if (section==1){
        labTitle.text=[NSString stringWithFormat:@"报修进程"];
    }
    else{
        labTitle.text=[NSString stringWithFormat:@"报修前后"];
    }
    
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 200;
    }
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(indexPath.section==0){
        UITableViewCell * cell=[ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor clearColor];
        
 
        UIView *NewView=[[UIView alloc] initWithFrame:CGRectMake(20, 8, tableView.frame.size.width-40, 0)];
        [NewView setBackgroundColor:[UIColor clearColor]];
        UILabel *labOrder=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, NewView.frame.size.width, 25)];
 
        labOrder.font=[UIFont systemFontOfSize:14.0f];
        labOrder.textColor=MyTitleBlueColr;
        labOrder.backgroundColor=[UIColor clearColor];
        labOrder.text=[NSString stringWithFormat:@"单号:%@",@"20140712008GTR"];
        [NewView addSubview:labOrder];
        
        CGSize size = [self caculateTheTextHeight:contentStr andFontSize:14 andDistance:40];
        
        UILabel *labContent=[[UILabel alloc] initWithFrame:CGRectMake(0,labOrder.frame.size.height+labOrder.frame.origin.y +8, NewView.frame.size.width, size.height)];
        
        labContent.backgroundColor=[UIColor clearColor];
        labContent.font = [UIFont systemFontOfSize:14];
        labContent.text=[NSString stringWithFormat:@"%@",contentStr];

        labContent.numberOfLines=size.height/14+2;
        [NewView addSubview:labContent];

        [NewView setFrame:CGRectMake(20, 8, tableView.frame.size.width-40, labContent.frame.size.height+labContent.frame.origin.y)];
        
        [cell addSubview:NewView];
        
        [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,NewView.frame.size.height+NewView.frame.origin.y)];
        return cell;

    }
    else if(indexPath.section==1){
        static NSString *CustomCellIdentifier = @"RZRepairTableViewCell";
        
        RZRepairTableViewCell * cell=  (RZRepairTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        if (cell == nil) {
            
            cell= [[[NSBundle mainBundle] loadNibNamed:@"RZRepairTableViewCell" owner:self options:nil] objectAtIndex:0] ;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        if(indexPath.row==0){
            cell.lbTime.text=[NSString stringWithFormat:@"%@",@"07月12日 15:30:45"];
            cell.lbLine.hidden=YES;
            cell.lbStates.text=[NSString stringWithFormat:@"%@",@"已受理"];
            cell.lbContent.text=[NSString stringWithFormat:@"%@",@"报修已受理，期望上门日期：2014-07-24 18:00～19:00"];
            CGSize size = [self caculateTheTextHeight:cell.lbContent.text andFontSize:14 andDistance:140];
            
            [cell.lbContent setFrame:CGRectMake(20, 30, cell.lbContent.frame.size.width,size.height)];
            cell.lbContent.numberOfLines=size.height/14+2;
            [cell.rightview setFrame:CGRectMake(90, 20, 215, cell.lbContent.frame.size.height+ cell.lbContent.frame.origin.y+2)];
            
           [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,cell.rightview.frame.size.height+cell.rightview.frame.origin.y+25)];
            
        }
        else  if(indexPath.row==1){
            cell.lbTime.text=[NSString stringWithFormat:@"%@",@"07月12日 15:30:45"];
            cell.lbLine.backgroundColor=UIColorFromRGB(0x00ff00);
            cell.lbStates.text=[NSString stringWithFormat:@"%@",@"处理中"];
            cell.lbContent.text=[NSString stringWithFormat:@"%@",@"报修正在处理"];
            cell.lbContent.textColor = MyTitleBlueColr;
            
           CGSize size = [self caculateTheTextHeight:cell.lbContent.text andFontSize:14 andDistance:140];
            cell.lbContent.numberOfLines=size.height/14+2;
            [cell.lbContent setFrame:CGRectMake(15, 30, cell.lbContent.frame.size.width, (NSInteger)size.height+14)];
            [cell.rightview setFrame:CGRectMake(90, 25, 215, cell.lbContent.frame.size.height+ cell.lbContent.frame.origin.y+2)];
            
            
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,cell.rightview.frame.size.height+cell.rightview.frame.origin.y+25)];
        }
        else if(indexPath.row==2){
            

            cell.lbStates.text=[NSString stringWithFormat:@"%@",@"已受完成"];
            cell.lbContent.text=[NSString stringWithFormat:@"%@",@"报修已完成"];
            CGSize size = [self caculateTheTextHeight:cell.lbContent.text andFontSize:14 andDistance:140];
            cell.lbContent.numberOfLines=size.height/14+2;
            
            [cell.lbContent setFrame:CGRectMake(15, 30, cell.lbContent.frame.size.width, (NSInteger)size.height+14)];
            [cell.rightview setFrame:CGRectMake(90, 25, 215, cell.lbContent.frame.size.height+ cell.lbContent.frame.origin.y+2)];

            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,cell.rightview.frame.size.height+cell.rightview.frame.origin.y+25)];
        }
        

        
//        //添加两个边阴影
        cell.rightview.backgroundColor = [UIColor whiteColor];
        cell.rightview.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.rightview.layer.shadowOffset = CGSizeMake(-4, 0);
        cell.rightview.layer.shadowOpacity = 0.3;
        cell.rightview.layer.shadowRadius = 10;

        cell.rightview.layer.cornerRadius=5;
        cell.rightview.layer.borderWidth=0.1;
        cell.rightview.layer.borderColor=UIColorFromRGB(0x9f9f9f).CGColor;
       
        
        [cell.imageArrow setImage:[UIImage imageNamed:@"三角_2"]];
        if([arrOfStatus[indexPath.row] intValue]){
            cell.lbTime.font = [UIFont systemFontOfSize:12];
            cell.imageMark.image = [UIImage imageNamed:@"勾"];
            cell.lbContent.textColor = [UIColor blackColor];
            cell.lbStates.textColor = MyTitleBlueColr;
            cell.lbTime.textColor = MyTitleBlueColr;
            cell.lbLine.backgroundColor = UIColorFromRGB(0xbad9fe);
            cell.lbLine2.backgroundColor = UIColorFromRGB(0xbad9fe);
        }else{
            cell.imageMark.image = [UIImage imageNamed:@"报修时间轴_23"];
            cell.lbTime.text=[NSString stringWithFormat:@"%@",@"等候中"];
            cell.lbTime.font = [UIFont systemFontOfSize:14];
            cell.lbTime.textColor = UIColorFromRGB(0x9f9f9f);
            cell.lbContent.textColor = UIColorFromRGB(0x9f9f9f);
            cell.lbStates.textColor = UIColorFromRGB(0x9f9f9f);
            cell.lbLine.backgroundColor = UIColorFromRGB(0xf1f1f1);
             cell.lbLine2.backgroundColor = UIColorFromRGB(0xf1f1f1);
        }

        if (indexPath.row == 2) {
            cell.lbLine2.hidden = YES;
        }
        return cell;
    }
    else  {
        
        
        static NSString *SystemCellIdentifier = @"UITableViewCell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SystemCellIdentifier];
        if(cell==nil){
            cell=[ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemCellIdentifier];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 10, Mywidth-40, 180)];
            view.backgroundColor = UIColorFromRGB(0xdcdcdc);
            view.tag = 1000+indexPath.row;
            [cell.contentView addSubview:view];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, Mywidth-20, 20)];
            label.text = @"暂无图片";
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            
            
            UIImageView *image2 = [[UIImageView alloc] initWithFrame:view.bounds];
            image2.tag = 555+indexPath.row;
            [view addSubview:image2];
            
            UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -2, 70, 70)];
            image1.tag = 10000+indexPath.row;
            [view addSubview:image1];
            
            
        }
        UIImageView *image1 = (UIImageView *)[cell.contentView viewWithTag:10000+indexPath.row];
        UIImageView *image2 = (UIImageView *)[cell.contentView viewWithTag:555+indexPath.row];
        if (indexPath.row == 0) {
            image1.image = [UIImage imageNamed:@"处理前"];
            [image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://picview01.baomihua.com/photos/20120801/m_14_634794220804218750_41722879.jpg"]]];
        }else if(indexPath.row == 1){
            image1.image = [UIImage imageNamed:@"处理后"];
            [image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://picview01.baomihua.com/photos/20120801/m_14_634794220804218750_41722879.jpg"]]];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor clearColor];
        return cell;
    }
    
 
}
-(void)didExit:(UIButton *)sender
{
    
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
