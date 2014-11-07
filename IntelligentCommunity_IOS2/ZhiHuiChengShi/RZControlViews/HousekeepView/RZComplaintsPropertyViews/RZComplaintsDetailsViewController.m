//
//  RZComplaintsViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-12.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark 我的 -  四个VIew的第一个 - 投诉记录 - 投诉详情

#import "RZComplaintsDetailsViewController.h"
#import "RZKeepCommentTableViewCell.h"
#import "RZComplaintProcessTableViewCell.h"

@interface RZComplaintsDetailsViewController ()
{
    IBOutlet UITableView *_tableview;
    NSMutableArray *_tableData;
    
    UIButton *btnleft;
    UIButton *btnright;
    BOOL isStartOnclick;
}
@end

@implementation RZComplaintsDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel*  label= [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"投诉详情";
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
    
    {
        CGRect rect = CGRectMake(0, 7, 200, 30);
        UIView *topview=[[UIView alloc] initWithFrame:rect];
        [topview setBackgroundColor:UIColorFromRGB(0xffffff)];
        
        btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [btnleft setBackgroundColor:[UIColor clearColor]];
        
        [btnleft setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
        [btnleft setTitle:@"投诉详情" forState:UIControlStateNormal];
        
        
        [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:20]];
        
        [btnleft setBackgroundImage:[UIImage imageNamed:@"navBackimage.png"] forState:UIControlStateNormal];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"navBackimage.png"] forState:UIControlStateSelected];
        [btnleft setTag:101];
        [btnleft addTarget:self action:@selector(SelectTop:) forControlEvents:UIControlEventTouchUpInside];
        
        btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake(rect.size.width/2+1, 0, rect.size.width/2, rect.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright setTitle:@"处理进度" forState:UIControlStateNormal];
        [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnright.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [btnright setBackgroundImage:[UIImage imageNamed:@"navBackimage.png"] forState:UIControlStateNormal];
        [btnright setBackgroundImage:[UIImage imageNamed:@"navBackimage.png"] forState:UIControlStateSelected];
        [btnright setTag:102];
        [btnright addTarget:self action:@selector(SelectTop:) forControlEvents:UIControlEventTouchUpInside];
        [topview addSubview:btnright];
        [topview addSubview:btnleft];
        
        topview.layer.masksToBounds=YES;
        topview.layer.cornerRadius=15;
        topview.layer.borderWidth=1;
        topview.layer.borderColor=UIColorFromRGB(0xffffff).CGColor;
        
        self.navigationItem.titleView = topview;
        
    }
}

//点击切换显示内容 首次点击 或者加载无数据重新请求 否则取旧数据
-(void)SelectTop:(UIButton*)sender{
    _type=sender.tag;
    if(sender.tag==101){
        
        btnleft.selected=YES;
        btnright.selected=NO;
        [UIView animateWithDuration:0.5 animations:^{
            [btnleft.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
            [btnright.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
        }];
        
    }
    else if(sender.tag==102){
        
        btnright.selected=YES;
        btnleft.selected=NO;
        [UIView animateWithDuration:0.5 animations:^{
            [btnleft.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
            [btnright.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
        }];
        
    }
    [_tableview reloadData];
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
    
    if(_type==101){
        btnleft.selected=YES;
    }
    else  {
        btnright.selected=YES;
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return   2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_type==101){
        if(section==0){
            return 1;
        }
        else{
            return 4;
        }
    }
    else {
        if(section==0){
            return 3;
        }
        else{
            return 1;
        }
    }
    
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
    if(_type==101)
    {
        if(section==0){
            UIImageView *imghead=[[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 40, 40)];
            [imghead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [view addSubview:imghead];
            
            UIImageView *imgsex=[[UIImageView alloc] initWithFrame:CGRectMake(55, 8, 14, 14)];
            [imgsex setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [view addSubview:imgsex];
            
            UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(75, 8, 150, 25)];
            labTitle.font=[UIFont systemFontOfSize:14.0f];
            labTitle.textColor=UIColorFromRGB(0xcbcbcb);
            labTitle.backgroundColor=[UIColor clearColor];
            
            labTitle.text=[NSString stringWithFormat:@"我在世界杯"];
            [view addSubview:labTitle];
            
            UILabel *labTime=[[UILabel alloc] initWithFrame:CGRectMake(75, 8+25, 150, 25)];
            labTime.font=[UIFont systemFontOfSize:14.0f];
            labTime.textColor=UIColorFromRGB(0xcbcbcb);
            labTime.backgroundColor=[UIColor clearColor];
            
            labTime.text=[NSString stringWithFormat:@"06-12 20:04:24"];
            [view addSubview:labTime];
            
            UIImageView *imgClass=[[UIImageView alloc] initWithFrame:CGRectMake(225, 8, 70, 30)];
            [imgClass setImage:[UIImage imageNamed:@"2"]];
            [view addSubview:imgClass];
            
        }
        else{
            UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(10, 4,  tableView.frame.size.width-20, 47.0f)];
            backview.backgroundColor=UIColorFromRGB(0xcbcbcb);
            
            UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setFrame:CGRectMake(1, 1, (tableView.frame.size.width-20)/3-1, backview.frame.size.height-2)];
            btn1.backgroundColor=UIColorFromRGB(0xffffff);
            [btn1 setTitle:[NSString stringWithFormat:@"%@评论",@"100"] forState:UIControlStateNormal];
            
            btn1.titleLabel.font=[UIFont systemFontOfSize:14.0f];
            btn1.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, -10);
            [btn1 setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
            [btn1 setTag:101];
            [btn1 addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *imgbtn1=[[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 14, 14)];
            [imgbtn1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [btn1 addSubview:imgbtn1];
            
            [backview addSubview:btn1];
            
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setFrame:CGRectMake(((tableView.frame.size.width-20)/3-1)*1+2,1, (tableView.frame.size.width-20)/3-1, backview.frame.size.height-2)];
            btn2.backgroundColor=UIColorFromRGB(0xffffff);
            [btn2 setTitle:[NSString stringWithFormat:@"%@赞",@"10"] forState:UIControlStateNormal];
            btn2.titleLabel.font=[UIFont systemFontOfSize:14.0f];
            btn2.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, -10);
            [btn2 setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
            [btn2 setTag:102];
            [btn2 addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *imgbtn2=[[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 14, 14)];
            [imgbtn2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [btn2 addSubview:imgbtn2];
            [backview addSubview:btn2];
            
            UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn3 setFrame:CGRectMake(((tableView.frame.size.width-20)/3-1)*2+3,1, (tableView.frame.size.width-20)/3-2, backview.frame.size.height-2)];
            btn3.backgroundColor=UIColorFromRGB(0xffffff);
            [btn3 setTitle:[NSString stringWithFormat:@"%@",@"分享"] forState:UIControlStateNormal];
            btn3.titleLabel.font=[UIFont systemFontOfSize:14.0f];
            btn3.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, -10);
            [btn3 setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
            [btn3 setTag:103];
            [btn3 addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *imgbtn3=[[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 14, 14)];
            [imgbtn3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            [btn3 addSubview:imgbtn3];
            [backview addSubview:btn3];
            
            
            
            [view addSubview:backview];
            
            
        }
    }
    else{
        if(section==0){
            UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(20, 8, 150, 25)];
            labTitle.font=[UIFont systemFontOfSize:14.0f];
            labTitle.textColor=UIColorFromRGB(0xcbcbcb);
            labTitle.backgroundColor=[UIColor clearColor];
            
            labTitle.text=[NSString stringWithFormat:@"🕘时间进程"];
            [view addSubview:labTitle];
        }
        else{
            UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(20, 8, 150, 25)];
            labTitle.font=[UIFont systemFontOfSize:14.0f];
            labTitle.textColor=UIColorFromRGB(0xcbcbcb);
            labTitle.backgroundColor=[UIColor clearColor];
            
            labTitle.text=[NSString stringWithFormat:@"⌛️处理结果:"];
            [view addSubview:labTitle];
        }
        
    }
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    return view;
}
//评论 赞 分享
-(void)btnSelect:(UIButton*)sender{
    if(sender.tag==101){
        
        
    }
    else     if(sender.tag==101){
        
        
    }
    else{
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_type==101){
        if(indexPath.section==0){
            static NSString *SystemCellIdentifier = @"UITableViewCell";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SystemCellIdentifier];
            if(cell==nil){
                cell=[ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemCellIdentifier];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor=[UIColor clearColor];
            UILabel *labcontent=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            labcontent.font=[UIFont systemFontOfSize:14.0f];
            labcontent.textColor=UIColorFromRGB(0xcbcbcb);
            labcontent.backgroundColor=[UIColor clearColor];
            
            labcontent.text=[NSString stringWithFormat:@"热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊热力世界杯！有木有人在看啊"];
            
            CGSize size=[labcontent.text sizeWithFont:labcontent.font constrainedToSize:CGSizeMake(280, 90000.0f) lineBreakMode:NSLineBreakByCharWrapping];
            labcontent.numberOfLines=size.height/14+2;
            [labcontent setFrame:CGRectMake(20, 5, cell.frame.size.width-40, (NSInteger)size.height+14)];
            [cell.contentView addSubview:labcontent];
            
            float height=labcontent.frame.size.height+5;
            if(1==1){
                //有图片
                for(int i=0;i<2;i++)
                {
                    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(20,height+8, cell.frame.size.width-40,(NSInteger)(cell.frame.size.width-40)*3/4)];
                    [img  setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
                    
                    [cell.contentView addSubview:img];
                    height=height+8+(NSInteger)(cell.frame.size.width-40)*3/4+2;
                }
                [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
                return cell;
            }
            else{
                [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, height+2)];
                return cell;
                
            }
            
            
        }
        else{
            
            static NSString *CustomCellIdentifier = @"RZKeepCommentTableViewCell";
            
            RZKeepCommentTableViewCell * cell=  (RZKeepCommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
            if (cell == nil) {
                
                cell= [[[NSBundle mainBundle] loadNibNamed:@"RZKeepCommentTableViewCell" owner:self options:nil] objectAtIndex:0] ;
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor=[UIColor clearColor];
            cell.btncomment.tag=1001;
            [cell.btncomment addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.lbTitle.text=[NSString stringWithFormat:@"%@",@""];
            cell.lbTime.text=@"06-14 20:15:04";
            cell.lbSubTitle.text=@"只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有";
            
            CGSize size=[cell.lbSubTitle.text sizeWithFont:cell.lbSubTitle.font constrainedToSize:CGSizeMake(cell.lbSubTitle.frame.size.width, 90000.0f) lineBreakMode:NSLineBreakByCharWrapping];
            cell.lbSubTitle.numberOfLines=size.height/14+2;
            
            [cell.lbSubTitle setFrame:CGRectMake(cell.lbSubTitle.frame.origin.x, cell.lbSubTitle.frame.origin.y, cell.lbSubTitle.frame.size.width,(NSInteger)size.height+14)];
            
            [cell.imageHead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            
            [cell.imagesex setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
            
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, cell.lbSubTitle.frame.origin.y+cell.lbSubTitle.frame.size.height+20)];
            
            return cell;
        }
    }
    else{
        if(indexPath.section==0){
            static NSString *CustomCellIdentifier = @"RZComplaintProcessTableViewCell";
            
            RZComplaintProcessTableViewCell * cell=  (RZComplaintProcessTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
            if (cell == nil) {
                
                cell= [[[NSBundle mainBundle] loadNibNamed:@"RZComplaintProcessTableViewCell" owner:self options:nil] objectAtIndex:0] ;
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor=[UIColor clearColor];
            cell.lbState.layer.masksToBounds=YES;
            cell.lbState.layer.cornerRadius= cell.lbState.frame.size.width/2;
            if(indexPath.row==0){
                cell.lbTimeMM.text=[NSString stringWithFormat:@"%@",@"07月12日"];
                cell.lbTimeHH.text=[NSString stringWithFormat:@"%@",@"15:30:01"];
                cell.lbState.backgroundColor=UIColorFromRGB(0xff0000);
                cell.lbTitle.text=[NSString stringWithFormat:@"%@",@"已受理"];
                cell.lbSubTitle.text=[NSString stringWithFormat:@"%@",@"投诉记录已受理"];
            }
            else  if(indexPath.row==1){
                cell.lbTimeMM.text=[NSString stringWithFormat:@"%@",@"07月12日"];
                cell.lbTimeHH.text=[NSString stringWithFormat:@"%@",@"15:30:02"];
                cell.lbState.backgroundColor=UIColorFromRGB(0xcbcbcb);
                cell.lbTitle.text=[NSString stringWithFormat:@"%@",@"处理中"];
                cell.lbSubTitle.text=[NSString stringWithFormat:@"%@",@"投诉记录处理中"];
            }
            else if(indexPath.row==2){
                cell.lbTimeMM.text=[NSString stringWithFormat:@"%@",@"07月12日"];
                cell.lbTimeHH.text=[NSString stringWithFormat:@"%@",@"15:30:03"];
                cell.lbState.backgroundColor=UIColorFromRGB(0xcbcbcb);
                cell.lbTitle.text=[NSString stringWithFormat:@"%@",@"未完成"];
                cell.lbSubTitle.text=[NSString stringWithFormat:@"%@",@"投诉记录未完成"];
            }
            [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, cell.lbSubTitle.frame.size.height+cell.lbSubTitle.frame.origin.y+10)];
            
            
            return cell;
        }
        else{
            
            
            static NSString *SystemCellIdentifier = @"UITableViewCell";
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
}
-(void)comment:(UIButton*)sender{
    NSLog(@"comment");
}
@end
