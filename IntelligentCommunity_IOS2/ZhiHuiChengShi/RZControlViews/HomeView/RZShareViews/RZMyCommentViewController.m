//
//  RZMyCommentViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark    首页 - 右上角的信息 - 所有评论 我的帖子

#import "RZMyCommentViewController.h"

#import "RZMyPostTableViewCell.h"

#import "RZMyCommentTableViewCell.h"


#import "RZHomeDetailsViewController.h"

@interface RZMyCommentViewController ()
{
    UIButton *btnleft;
    UIButton *btnright;
    BOOL isStartOnclick;
    IBOutlet UITableView *_tableview;
    NSMutableArray *_tableData;//显示数据
    NSMutableArray *commentArray;//评论列表
   NSMutableArray *PostArray;//帖子列表
}
@end

@implementation RZMyCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 7, 200, 35);
        UIView *topview=[[UIView alloc] initWithFrame:rect];        
        btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnleft setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
        [btnleft setBackgroundColor:[UIColor clearColor]];
        [btnleft setTitle:@"所有评论" forState:UIControlStateNormal];
        [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18]];
 
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边未选中.png"] forState:UIControlStateNormal];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边选中.png"] forState:UIControlStateSelected];
        [btnleft setTag:101];
        [btnleft addTarget:self action:@selector(SelectTop:) forControlEvents:UIControlEventTouchUpInside];
        
        btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright setTitle:@"我的帖子" forState:UIControlStateNormal];
        [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnright.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边未选中.png"] forState:UIControlStateNormal];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边选中.png"] forState:UIControlStateSelected];
        [btnright setTag:102];
        [btnright addTarget:self action:@selector(SelectTop:) forControlEvents:UIControlEventTouchUpInside];
 
        [topview addSubview:btnleft];
        [topview addSubview:btnright];
        topview.layer.masksToBounds=YES;
        topview.layer.cornerRadius=15;
        self.navigationItem.titleView = topview;
        
    }
    return self;
}

//点击切换显示内容 首次点击 或者加载无数据重新请求 否则取旧数据
-(void)SelectTop:(UIButton*)sender{
    if(sender.tag==101){
        _tableview.backgroundColor=[UIColor whiteColor];
        self.view.backgroundColor=[UIColor whiteColor];

        btnleft.selected=YES;
        btnright.selected=NO;
        [UIView animateWithDuration:0.5 animations:^{
            [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
                        [btnright.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        }];
        if([commentArray count]>0){
            [_tableData removeAllObjects];
            _tableData=[NSMutableArray arrayWithArray:[commentArray copy]];
            [_tableview reloadData];
        }
        else{
            [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeNone];
            NSLog(@"http:1");
            [commentArray removeAllObjects];
            
            commentArray=[NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"http://g.hiphotos.baidu.com/image/w%3D400/sign=4be7f3c141166d223877149476230945/e850352ac65c10384d5fbac8b0119313b07e8992.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                 [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/meinvbizhi0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                 [NSDictionary dictionaryWithObjectsAndKeys:@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                 [NSDictionary dictionaryWithObjectsAndKeys:@"http://a.hiphotos.baidu.com/image/w%3D400/sign=55af4af479899e51788e3b1472a7d990/f9198618367adab42ab8824a89d4b31c8701e44b.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                 [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/a50f4bfbfbedab64947d23a7f536afc379311e4d.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                 [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                 [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/6a.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
            [_tableData removeAllObjects];
            _tableData=[NSMutableArray arrayWithArray:[commentArray copy]];
            [_tableview reloadData];
                    [SVProgressHUD dismiss];
            
        }

        
    }
    else if(sender.tag==102){
        _tableview.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];

        btnright.selected=YES;
        btnleft.selected=NO;
        [UIView animateWithDuration:0.5 animations:^{
            [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18]];
            [btnright.titleLabel setFont:[UIFont systemFontOfSize:18]];
        }];
        if([PostArray count]>0){
        [_tableData removeAllObjects];
        _tableData=[NSMutableArray arrayWithArray:[PostArray copy]];
        [_tableview reloadData];
        }
        else{
             [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeNone];
             NSLog(@"http:2");
            [PostArray removeAllObjects];
            
            PostArray=[NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"http://g.hiphotos.baidu.com/image/w%3D400/sign=4be7f3c141166d223877149476230945/e850352ac65c10384d5fbac8b0119313b07e8992.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                          [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/meinvbizhi0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                          [NSDictionary dictionaryWithObjectsAndKeys:@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                          [NSDictionary dictionaryWithObjectsAndKeys:@"http://a.hiphotos.baidu.com/image/w%3D400/sign=55af4af479899e51788e3b1472a7d990/f9198618367adab42ab8824a89d4b31c8701e44b.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                          [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/a50f4bfbfbedab64947d23a7f536afc379311e4d.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                          [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                          [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/6a.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
            [_tableData removeAllObjects];
            _tableData=[NSMutableArray arrayWithArray:[PostArray copy]];
            [_tableview reloadData];
                    [SVProgressHUD dismiss];
            
        }
    }

}
-(void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];
 
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableview.delegate = self;
    _tableview.dataSource = self;
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
    UIBarButtonItem *btnright1 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright1];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright1;
    }
 
    _tableData=[[NSMutableArray alloc] initWithCapacity:0];
    commentArray=[[NSMutableArray alloc] initWithCapacity:0];
    PostArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    
    btnleft.selected=YES;
    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeNone];
    NSLog(@"http:1");
    [commentArray removeAllObjects];
    
    commentArray=[NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"http://g.hiphotos.baidu.com/image/w%3D400/sign=4be7f3c141166d223877149476230945/e850352ac65c10384d5fbac8b0119313b07e8992.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                  [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/meinvbizhi0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                  [NSDictionary dictionaryWithObjectsAndKeys:@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                  [NSDictionary dictionaryWithObjectsAndKeys:@"http://a.hiphotos.baidu.com/image/w%3D400/sign=55af4af479899e51788e3b1472a7d990/f9198618367adab42ab8824a89d4b31c8701e44b.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                  [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/a50f4bfbfbedab64947d23a7f536afc379311e4d.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                  [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                  [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/6a.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
    [_tableData removeAllObjects];
    _tableData=[NSMutableArray arrayWithArray:[commentArray copy]];
    [_tableview reloadData];
    [SVProgressHUD dismiss];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview delete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(btnleft.selected){
        return 112.0f;
    }
    else  {
        return 200.0f;
    }
 
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(btnleft.selected){
        RZMyCommentTableViewCell *cell = (RZMyCommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"RZMyCommentTableViewCell"];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RZMyCommentTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        //    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
              cell.contentView.backgroundColor=[UIColor clearColor];
        NSDictionary *temp=[_tableData objectAtIndex:indexPath.row];
        cell.lbTitle.text=[temp objectForKey:@"text"];
        cell.lbSubTitle.text=[temp objectForKey:@"text"];
        cell.lbTime.text=@"07-14 20:35";
        
        CGSize size=[cell.lbSubTitle.text sizeWithFont:cell.lbSubTitle.font constrainedToSize:CGSizeMake(223, cell.lbSubTitle.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
        if(size.height<20){
            cell.lbSubTitle.numberOfLines=1;
            [cell.lbSubTitle setFrame:CGRectMake(cell.lbSubTitle.frame.origin.x, cell.lbSubTitle.frame.origin.y, cell.lbSubTitle.frame.size.width, 25)];
            
        }
        else if(size.height<20){
            cell.lbSubTitle.numberOfLines=2;
            [cell.lbSubTitle setFrame:CGRectMake(cell.lbSubTitle.frame.origin.x, cell.lbSubTitle.frame.origin.y, cell.lbSubTitle.frame.size.width, 43)];
            
        }
        else{
            cell.lbSubTitle.numberOfLines=3;
            
        }

        
        [cell.rightImage setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",[temp objectForKey:@"image0"]]] placeholderImage:[UIImage imageNamed:@"Default"] ];
        
        [cell.lbLine setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.png"] ]];
//        [cell.lbLine setBackgroundImage:[[UIImage imageNamed:@"1.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault]
        
        return cell;
 
    }
    else{
        RZMyPostTableViewCell *cell = (RZMyPostTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"RZMyPostTableViewCell"];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RZMyPostTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        //    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
         cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        NSDictionary *temp=[_tableData objectAtIndex:indexPath.row];
        
        cell.lbTitle.text=[temp objectForKey:@"text"];
        CGSize size=[cell.lbTitle.text sizeWithFont:cell.lbTitle.font constrainedToSize:CGSizeMake(278, cell.lbTitle.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
        if(size.height<20){
            cell.lbTitle.numberOfLines=1;
            [cell.lbTitle setFrame:CGRectMake(cell.lbTitle.frame.origin.x, cell.lbTitle.frame.origin.y, cell.lbTitle.frame.size.width, 25)];
            
        }
        else{
            cell.lbTitle.numberOfLines=2;
            
        }
        cell.lbTime.text=@"2014-07-11 15:30";
        cell.lbcomment.text=[NSString stringWithFormat:@"%@评论",@"112"];
        cell.lbnice.text=[NSString stringWithFormat:@"%@赞",@"65"];
    
        [cell.imageTop setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",[temp objectForKey:@"image0"]]] placeholderImage:[UIImage imageNamed:@"赞.png"] ];
        
        cell.contentview.layer.borderWidth=1;
        cell.contentview.layer.borderColor=UIColorFromRGB(0xcbcbcb).CGColor;
        return cell;

    }
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZHomeDetailsViewController *view=[[RZHomeDetailsViewController alloc] initWithNibName:@"RZHomeDetailsViewController" bundle:nil];
    

    [self.navigationController pushViewController:view animated:YES];
    
    
}

-(void)didExit:(UIButton *)sender
{
    NSLog(@"更多");
}
@end
