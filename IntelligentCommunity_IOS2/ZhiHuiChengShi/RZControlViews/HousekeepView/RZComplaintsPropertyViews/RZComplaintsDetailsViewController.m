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
#import "RZActivity_FiveTableViewCell.h"
#import "RZDetails_OneTableViewCell.h"
@interface RZComplaintsDetailsViewController ()<UITextFieldDelegate>
{
     UITableView *_tableview;
    NSMutableArray *_tableData;
    
    UIButton *btnleft;
    UIButton *btnright;
    BOOL isStartOnclick;
    
    
    UIView *commentView;
    UITextField *textField;
    

    //评论 重用cell的数据
    NSMutableArray *arrOfimage_comment;
    NSMutableArray *arrOfName;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfSex;
    
    BOOL isZan;
    NSArray *detailImages;
}
@end

@implementation RZComplaintsDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 7, 200, 35);
        UIView *topview=[[UIView alloc] initWithFrame:rect];
        btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnleft setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
        [btnleft setBackgroundColor:[UIColor clearColor]];
        [btnleft setTitle:@"投诉详情" forState:UIControlStateNormal];
        [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边未选中.png"] forState:UIControlStateNormal];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边选中.png"] forState:UIControlStateSelected];
        [btnleft setTag:101];
        [btnleft addTarget:self action:@selector(SelectTop:) forControlEvents:UIControlEventTouchUpInside];
        
        btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright setTitle:@"处理进度" forState:UIControlStateNormal];
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

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//点击切换显示内容 首次点击 或者加载无数据重新请求 否则取旧数据
-(void)SelectTop:(UIButton*)sender{
    _type=sender.tag;
    if(sender.tag==101){
        
        btnleft.selected=YES;
        btnright.selected=NO;

    }
    else if(sender.tag==102){
        
        btnright.selected=YES;
        btnleft.selected=NO;
        
    }
    [_tableview reloadData];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    btnleft.selected = YES;
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
    [self Variableinitialization];
    [self createTableView];
    [self createCommentView];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)Variableinitialization
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    detailImages = [[NSArray alloc] initWithObjects:@"车1.jpg",@"车2.jpg", nil];
    arrOfSex = [[NSMutableArray alloc] initWithObjects:@"男",@"男",@"女",nil];
    arrOfimage_comment = [[NSMutableArray alloc] initWithObjects:@"个人中心_03",@"110.jpg",@"110.jpg",nil];
    arrOfDate = [[NSMutableArray alloc] initWithObjects:@"05-12 20:04:24",@"06-12 20:04:24",@"06-13 17:30:23",nil];
    arrOfName = [[NSMutableArray alloc] initWithObjects:@"飞翔的小鸡",@"小小爱",@"大大爱 回复 小小爱",nil];
    arrOfcontent = [[NSMutableArray alloc] initWithObjects:@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快速的回复过 阿飞哥按时发放",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 ",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快速的回复过 阿飞哥当事人特色",nil];
    
    
}
-(void)createTableView
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-66) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableview];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_type == 101){
        return 1;
    }
    return   2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_type==101){
         return arrOfName.count + 2;
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
   
    if (_type == 101) {
        return 0;
    }
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
        return nil;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (_type == 101) {
        if (indexPath.row == 0) {
            return 60+[self caculateTheTextHeight:arrOfcontent[indexPath.row] andFontSize:14 andDistance:20];
        }else if (indexPath.row == 1)
        {
            return  detailImages.count * 260;
        }else if (indexPath.row == 2){
            return  40;
        }
        return 60+[self caculateTheTextHeight:arrOfcontent[indexPath.row-2] andFontSize:14 andDistance:75]+10;
    }
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_type==101){

        static NSString *cellname = @"cell";
        RZActivity_FiveTableViewCell * cell = (RZActivity_FiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (cell == nil) {
            cell = [[RZActivity_FiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        RZActivity_FiveTableViewCell *cell_zero = [[RZActivity_FiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UITableViewCell *cell_one = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        RZDetails_OneTableViewCell *cell_two = [[RZDetails_OneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        
        if(indexPath.row == 0)
        {
            
            cell_zero.selectionStyle = UITableViewCellSelectionStyleNone;
            cell_zero.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row]];
            cell_zero.labelOfName.text = arrOfName[indexPath.row];
            cell_zero.labelOfDate.text = arrOfDate[indexPath.row];
            cell_zero.labelOfContent.text = arrOfcontent[indexPath.row];
            cell_zero.btn1.layer.borderColor = UIColorFromRGB(0x5496DF).CGColor;
            cell_zero.btn1.layer.borderWidth = 1;
            cell_zero.btn1.frame = CGRectMake(self.view.frame.size.width-80, 10, 70, 30);
            [cell_zero.btn1 setTitle:@"投诉" forState:UIControlStateNormal];
            [cell_zero.btn1 addTarget:self action:@selector(didBtnPinChe) forControlEvents:UIControlEventTouchUpInside];
            cell_zero.imageV0.hidden = YES;
            cell_zero.labelOfContent.frame = CGRectMake(10, 55, self.view.frame.size.width-20, 60+[self caculateTheTextHeight:arrOfcontent[indexPath.row] andFontSize:14 andDistance:20]-56);
            if ([arrOfSex[indexPath.row] isEqualToString:@"男"]) {
                cell_zero.imageV2.image = [UIImage imageNamed:@"男.png"];
            }else if ([arrOfSex[indexPath.row] isEqualToString:@"女"])
            {
                cell_zero.imageV2.image = [UIImage imageNamed:@"女1.png"];
            }
            return cell_zero;
        }
        else if (indexPath.row == 1)
        {
            for (int i = 0; i<detailImages.count; i++) {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 255*i+10, self.view.frame.size.width-30, 245)];
                image.image = [UIImage imageNamed:detailImages[i]];
                cell_one.selectionStyle = UITableViewCellStyleDefault;
                [cell_one addSubview:image];
            }
            return cell_one;
        }else if (indexPath.row == 2)
        {
            [cell_two.btnOfComment addTarget:self action:@selector(didBtnComment) forControlEvents:UIControlEventTouchUpInside];
            [cell_two.btnOfZan addTarget:self action:@selector(didBtnZan:) forControlEvents:UIControlEventTouchUpInside];
            [cell_two.btnOfShare addTarget:self action:@selector(sharePage) forControlEvents:UIControlEventTouchUpInside];
            
            [cell_two.btnOfComment setTitle:[NSString stringWithFormat:@"     %d评论",arrOfName.count-1] forState:UIControlStateNormal];
            [cell_two.btnOfZan setTitle:[NSString stringWithFormat:@"         %d赞",arrOfName.count-1+997] forState:UIControlStateNormal];
            [cell_two.btnOfShare setTitle:[NSString stringWithFormat:@"    分享"] forState:UIControlStateNormal];
            [cell_two.btnOfComment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell_two.btnOfZan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell_two.btnOfShare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            return cell_two;
        }else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row-2]];
            cell.labelOfName.text = arrOfName[indexPath.row-2];
            cell.labelOfDate.text = arrOfDate[indexPath.row-2];
            cell.labelOfContent.text = arrOfcontent[indexPath.row-2];
            cell.labelOfContent.frame = CGRectMake(60, 55, self.view.frame.size.width-75, 60+[self caculateTheTextHeight:arrOfcontent[indexPath.row-2] andFontSize:14 andDistance:75]-56);
            cell.btn1.frame = CGRectMake(self.view.frame.size.width-50, 15, 33, 23);
            [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
            
            if ([arrOfSex[indexPath.row-2] isEqualToString:@"男"]) {
                cell.imageV2.image = [UIImage imageNamed:@"男.png"];
            }else if ([arrOfSex[indexPath.row-2] isEqualToString:@"女"])
            {
                cell.imageV2.image = [UIImage imageNamed:@"女1.png"];
            }
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
#pragma mark - 创建分享页面
-(void)didBtnZan:(UIButton *)sender
{
    NSLog(@"赞");
    isZan = !isZan;
    if (isZan) {
        [sender setTitle:[NSString stringWithFormat:@"        取消赞"] forState:UIControlStateNormal];
    }else{
        [sender setTitle:[NSString stringWithFormat:@"         %d赞",arrOfName.count-1+997] forState:UIControlStateNormal];
    }
    
}
-(void)sharePage
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0;
    view.tag = 10000;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 44)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha  = 0;
    view1.tag = 10001;
    [self.navigationController.navigationBar addSubview:view1];
    
    
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(8, 130, self.view.frame.size.width-16, 45);
    btn1.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"微博.png"]];
    imageView1.frame = CGRectMake(8, 5, 35, 35);
    [btn1 addSubview:imageView1];
    [btn1 addTarget:self action:@selector(didBtnWeiBo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 150+40, self.view.frame.size.width-16, 2)];
    //    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //    [self.view addSubview:lineView];
    
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(8, 130+45, self.view.frame.size.width-16, 45);
    [btn2 addTarget:self action:@selector(didBtnWeiXin) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"活动召集令-详情-分享_06.png"]];
    imageView2.frame = CGRectMake(8, 5, 35, 35);
    [btn2 addSubview:imageView2];
    [self.view addSubview:btn2];
    btn2.layer.borderWidth = 1;
    btn2.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1].CGColor;
    btn2.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(8, 130+45+45, self.view.frame.size.width-16, 45);
    [btn3 addTarget:self action:@selector(didBtnWeiXin) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"活动召集令-详情-分享_06.png"]];
    imageView3.frame = CGRectMake(8, 5, 35, 35);
    [btn3 addSubview:imageView3];
    [self.view addSubview:btn3];
    btn3.backgroundColor = [UIColor whiteColor];
    
    
    btn1.tag = 10002;
    btn2.tag = 10003;
    btn3.tag = 10004;
    //    lineView.tag = 9999;
    
    btn1.alpha = 0;
    btn2.alpha = 0;
    btn3.alpha = 0;
    //    lineView.alpha = 0;
    
    
    [btn1 setTitle:@"分享到新浪微博                     " forState:UIControlStateNormal];
    [btn2 setTitle:@"分享到微信朋友圈                   " forState:UIControlStateNormal];
    [btn3 setTitle:@"分享到微信朋友                     " forState:UIControlStateNormal];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.7;
        view1.alpha = 0.7;
        btn1.alpha = 1;
        btn2.alpha = 1;
        btn3.alpha = 1;
        //        lineView.alpha = 1;
    }];
    
}



-(void)didBtnWeiBo
{
    
}
-(void)didBtnWeiXin
{
    
}
-(void)didBtnWeiXinFriends
{
    
}
-(void)didTap
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    UIView *view2 = (UIView *)[self.view viewWithTag:9999];
    UIView *view3 = (UIView *)[self.navigationController.navigationBar viewWithTag:10001];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:10002];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:10003];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:10004];
    [UIView animateWithDuration:0.8 animations:^{
        
        [view2 removeFromSuperview];
        [view removeFromSuperview];
        [view3 removeFromSuperview];
        [btn1 removeFromSuperview];
        [btn2 removeFromSuperview];
        [btn3 removeFromSuperview];
    }];
    
}
#pragma mark - 创建评论的View
-(void)createCommentView
{
    commentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 40)];
    commentView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(8, 5, 30, 30);
    [btn setImage:[UIImage imageNamed:@"表情.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didbiaoqing) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:btn];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(46, 3, self.view.frame.size.width - 46 -46, 34)];
    textField.placeholder = @"说点什么";
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    [commentView addSubview:textField];
    
    UIButton *sendbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendbtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendbtn addTarget:self action:@selector(didSendOut) forControlEvents:UIControlEventTouchUpInside];
    sendbtn.frame = CGRectMake(self.view.frame.size.width - 43, 5, 40, 30);
    [commentView addSubview:sendbtn];
    
    [self.view addSubview:commentView];
}


-(void)didbiaoqing
{
    
}
-(void)didSendOut
{
    [textField resignFirstResponder];
}
-(void)didExit:(UIButton *)sender
{
    
}
-(void)didBtnPinChe
{
    NSLog(@"拼车");
}
-(void)didBtnComment
{
    [textField becomeFirstResponder];
    NSLog(@"评论");
}
-(void)keyboardWillShow:(NSNotification *)note
{
    [UIView animateWithDuration:0.35 animations:^{
        commentView.frame = CGRectMake(0, self.view.frame.size.height-292, self.view.frame.size.width, 40);
    }];
    NSLog(@"%@",note.userInfo);
}
-(void)keyboardWillHide:(NSNotification *)note
{
    [UIView animateWithDuration:0.35 animations:^{
        commentView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 40);
    }];
}
@end
