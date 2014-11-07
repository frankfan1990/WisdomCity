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
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor grayColor]];
   
    
    //顶部按钮
    {
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
        return 1;
    }
      return 3;
    
    //    return [_tableData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 55.0f;
    }
    else{
        return 55.0f;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 55.0f)];
    
    UIImageView *imghead=[[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 88, 25)];
    
    [view addSubview:imghead];
    
    
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 15, 88, 25)];
    labTitle.font=[UIFont systemFontOfSize:20.0f];
    labTitle.textColor=UIColorFromRGB(0xffffff);
    labTitle.backgroundColor=[UIColor clearColor];
    labTitle.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:labTitle];
    
    
    if(section==0){
        [imghead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
        
        labTitle.text=[NSString stringWithFormat:@"报修描述"];
    }
    else if (section==1){
        [imghead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
        
        labTitle.text=[NSString stringWithFormat:@"报修进程"];
    }
    else{
        [imghead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
        
        labTitle.text=[NSString stringWithFormat:@"报修前后"];
    }
    
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(indexPath.section==0){
        static NSString *SystemCellIdentifier = @"UITableViewCell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SystemCellIdentifier];
        if(cell==nil){
            cell=[ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemCellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor clearColor];
        
 
        UIView *NewView=[[UIView alloc] initWithFrame:CGRectMake(20, 8, tableView.frame.size.width-40, 0)];
        [NewView setBackgroundColor:[UIColor clearColor]];
        UILabel *labOrder=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, NewView.frame.size.width, 25)];
 
        labOrder.font=[UIFont systemFontOfSize:14.0f];
        labOrder.textColor=UIColorFromRGB(0x00FF00);
        labOrder.backgroundColor=[UIColor clearColor];
        labOrder.text=[NSString stringWithFormat:@"单号:%@",@"20140712008GTR"];
        [NewView addSubview:labOrder];
        
        UILabel *labContent=[[UILabel alloc] initWithFrame:CGRectMake(0,labOrder.frame.size.height+labOrder.frame.origin.y +8, NewView.frame.size.width, 25)];
        
        
        labContent.font=[UIFont systemFontOfSize:16.0f];
        labContent.textColor=UIColorFromRGB(0x000000);
        labContent.backgroundColor=[UIColor clearColor];
        labContent.text=[NSString stringWithFormat:@"%@",@"我家天华板裂开了没有没有师傅来过来修理下 不修理我就去修理你去了 你说我说的对不对我家天华板裂开了没有没有师傅来过来修理下 不修理我就去修理你去了 你说我说的对不对我家天华板裂开了没有没有师傅来过来修理下 不修理我就去修理你去了 你说我说的对不对我家天华板裂开了没有没有师傅来过来修理下 不修理我就去修理你去了 你说我说的对不对我家天华板裂开了没有没有师傅来过来修理下 不修理我就去修理你去了 你说我说的对不对"];
        CGSize size=[labContent.text sizeWithFont:labContent.font constrainedToSize:CGSizeMake(280, 90000.0f) lineBreakMode:NSLineBreakByCharWrapping];
        labContent.numberOfLines=size.height/14+2;
        [labContent setFrame:CGRectMake(0, labOrder.frame.size.height+labOrder.frame.origin.y , cell.frame.size.width-40, (NSInteger)size.height+14)];
        [NewView addSubview:labContent];

        [NewView setFrame:CGRectMake(20, 8, tableView.frame.size.width-40, labContent.frame.size.height+labContent.frame.origin.y +8)];
        
        
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
            
            CGSize size=[cell.lbContent.text sizeWithFont:cell.lbContent.font constrainedToSize:CGSizeMake(cell.lbContent.frame.size.width, 90000.0f) lineBreakMode:NSLineBreakByCharWrapping];
            cell.lbContent.numberOfLines=size.height/14+2;
            [cell.lbContent setFrame:CGRectMake(10, 30, cell.lbContent.frame.size.width, (NSInteger)size.height+14)];
            [cell.rightview setFrame:CGRectMake(90, 5, 215, cell.lbContent.frame.size.height+ cell.lbContent.frame.origin.y+2)];
            
            
            [cell.imageMark setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [cell.imageArrow setImage:[UIImage imageNamed:@"2.png"]];
            
            [cell.rightview setBackgroundColor:[UIColor clearColor]];
            cell.rightview.layer.masksToBounds=YES;
            cell.rightview.layer.cornerRadius=5;
            cell.rightview.layer.borderWidth=2;
            cell.rightview.layer.borderColor=UIColorFromRGB(0xff00ff).CGColor;
        [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,cell.rightview.frame.size.height+cell.rightview.frame.origin.y+25)];
            
        }
        else  if(indexPath.row==1){
            cell.lbTime.text=[NSString stringWithFormat:@"%@",@"07月12日 15:30:45"];
            [cell.lbLine setFrame:CGRectMake(cell.lbLine.frame.origin.x, 0, 2, cell.imageMark.frame.origin.y+cell.imageMark.frame.size.height/2)];
            cell.lbLine.backgroundColor=UIColorFromRGB(0x00ff00);
            cell.lbStates.text=[NSString stringWithFormat:@"%@",@"处理中"];
            cell.lbContent.text=[NSString stringWithFormat:@"%@",@"报修正在处理"];
            
            CGSize size=[cell.lbContent.text sizeWithFont:cell.lbContent.font constrainedToSize:CGSizeMake(cell.lbContent.frame.size.width, 90000.0f) lineBreakMode:NSLineBreakByCharWrapping];
            cell.lbContent.numberOfLines=size.height/14+2;
            [cell.lbContent setFrame:CGRectMake(15, 30, cell.lbContent.frame.size.width, (NSInteger)size.height+14)];
            [cell.rightview setFrame:CGRectMake(90, 25, 215, cell.lbContent.frame.size.height+ cell.lbContent.frame.origin.y+2)];
            
            
            [cell.imageMark setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [cell.imageArrow setImage:[UIImage imageNamed:@"2.png"]];
            
            [cell.rightview setBackgroundColor:[UIColor clearColor]];
            cell.rightview.layer.masksToBounds=YES;
            cell.rightview.layer.cornerRadius=5;
            cell.rightview.layer.borderWidth=2;
            cell.rightview.layer.borderColor=UIColorFromRGB(0xff00ff).CGColor;
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,cell.rightview.frame.size.height+cell.rightview.frame.origin.y+25)];
        }
        else if(indexPath.row==2){
            cell.lbTime.text=[NSString stringWithFormat:@"%@",@"等候中"];
            cell.lbTime.font=[UIFont systemFontOfSize:14.0f];
            [cell.lbLine setFrame:CGRectMake(cell.lbLine.frame.origin.x, 0, 2, cell.imageMark.frame.origin.y+cell.imageMark.frame.size.height/2)];
             cell.lbLine.backgroundColor=UIColorFromRGB(0xcbcbcb);
            cell.lbTime.textColor=UIColorFromRGB(0xcbcbcb);
            cell.lbStates.textColor=UIColorFromRGB(0xcbcbcb);
            cell.lbContent.textColor=UIColorFromRGB(0xcbcbcb);
            cell.lbStates.text=[NSString stringWithFormat:@"%@",@"已受完成"];
            cell.lbContent.text=[NSString stringWithFormat:@"%@",@"报修已完成"];
            
            CGSize size=[cell.lbContent.text sizeWithFont:cell.lbContent.font constrainedToSize:CGSizeMake(cell.lbContent.frame.size.width, 90000.0f) lineBreakMode:NSLineBreakByCharWrapping];
            cell.lbContent.numberOfLines=size.height/14+2;
            [cell.lbContent setFrame:CGRectMake(15, 30, cell.lbContent.frame.size.width, (NSInteger)size.height+14)];
            [cell.rightview setFrame:CGRectMake(90, 25, 215, cell.lbContent.frame.size.height+ cell.lbContent.frame.origin.y+2)];
            
            
            [cell.imageMark setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [cell.imageArrow setImage:[UIImage imageNamed:@"2.png"]];
            
            [cell.rightview setBackgroundColor:[UIColor clearColor]];
            cell.rightview.layer.masksToBounds=YES;
            cell.rightview.layer.cornerRadius=5;
            cell.rightview.layer.borderWidth=2;
            cell.rightview.layer.borderColor=UIColorFromRGB(0xff00ff).CGColor;
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,cell.rightview.frame.size.height+cell.rightview.frame.origin.y+25)];
        }
        
//        //添加四个边阴影
//        cell.rightview.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色为黑色
//        cell.rightview.layer.shadowOffset = CGSizeMake(2, 2);//设置阴影的偏移量
//         cell.rightview.layer.shadowOpacity = 1.0;//设置阴影的不透明度
//        cell.rightview.layer.shadowRadius = 1.0; //设置阴影的半径
 
//        //添加两个边阴影
//        cell.rightview.layer.shadowColor = [UIColor blackColor].CGColor;
//        cell.rightview.layer.shadowOffset = CGSizeMake(4, 4);
//        cell.rightview.layer.shadowOpacity = 0.5;
//        cell.rightview.layer.shadowRadius = 2.0;
        
        return cell;
    }
    else  {
        static NSString *SystemCellIdentifier = @"UITableViewCells";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SystemCellIdentifier];
        if(cell==nil){
            cell=[ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemCellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        UIView *oldView=[[UIView alloc] initWithFrame:CGRectMake(20, 0, tableView.frame.size.width-40, (tableView.frame.size.width-40)*3/4 )];
        [oldView setBackgroundColor:[UIColor grayColor]];
        [cell addSubview:oldView];
        
        
        UIView *NewView=[[UIView alloc] initWithFrame:CGRectMake(20, oldView.frame.size.height+oldView.frame.origin.y+8, tableView.frame.size.width-40, (tableView.frame.size.width-40)*3/4 )];
        [NewView setBackgroundColor:[UIColor redColor]];
        [cell addSubview:NewView];
        
        [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width,NewView.frame.size.height+NewView.frame.origin.y+10)];
        return cell;
    }
    
 
}

@end
