//
//  RZHot_FormalViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-19.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHot_FormalViewController.h"
#import "RZHot_FormalDetailsTableViewCell.h"
#import "RZActivity_FiveTableViewCell.h"
#import "RZSendOpinionViewController.h"
#import "RZEditOpinionViewController.h"
@interface RZHot_FormalViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{

    UIButton *btnleft;
    UIButton *btnright;
    CGFloat height;
    
    UITableView *_tableView;
    UIView *headView;
    UIView *footView;
    
    //head 数据
    NSString *imageUrl;
    NSString *nameStr;
    NSString *timeStr;
    NSString *otherTime;
    NSString *contentStr;
    NSString *numberOfhead;
    NSString *numberofneed;
    NSString *sexStr;
    BOOL isAttention;
    //评论 重用cell的数据
    NSMutableArray *arrOfimage_comment;
    NSMutableArray *arrOfName;
    NSMutableArray *arrOfName_comment;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfSex;
    NSMutableArray *arrOfType;
    NSMutableArray *arrOf_number;
    
    UIView *commentView;
    UITextField *textField;
}
@end
@implementation RZHot_FormalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 7, 200, 35);
        UIView *topview=[[UIView alloc] initWithFrame:rect];
        btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnleft setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
        [btnleft setBackgroundColor:[UIColor clearColor]];
        [btnleft setTitle:@"议题详情" forState:UIControlStateNormal];
        [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边未选中.png"] forState:UIControlStateNormal];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边选中.png"] forState:UIControlStateSelected];
        [btnleft setTag:101];
        [btnleft addTarget:self action:@selector(SelectTop_left:) forControlEvents:UIControlEventTouchUpInside];
        
        btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright setTitle:@"讨论区" forState:UIControlStateNormal];
        [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnright.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边未选中.png"] forState:UIControlStateNormal];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边选中.png"] forState:UIControlStateSelected];
        [btnright setTag:102];
        [btnright addTarget:self action:@selector(SelectTop_right:) forControlEvents:UIControlEventTouchUpInside];
        
        btnleft.selected = YES;
        btnright.selected = NO;
        
        [topview addSubview:btnleft];
        [topview addSubview:btnright];
        topview.layer.masksToBounds=YES;
        topview.layer.cornerRadius=15;
        self.navigationItem.titleView = topview;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
    [self Variableinitialization];
    [self createTableView];
    [self createCommentView];
}
-(void)Variableinitialization
{
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSendOut)];
    [self.view addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    isAttention = NO;
    imageUrl = @"头像_4";
    nameStr = @"JM_思密达";
    numberOfhead = @"9999";
    numberofneed = @"10";
    sexStr = @"男";
    otherTime = @"2014-06-03 09:44";
    timeStr = @"2014-07-02 11:30";
    contentStr = @"测就是的测试文字阿双方嘎哈健康是一个个按设计开发嘎哈就是的测试文字阿双方嘎哈健康是一个个按设计开发嘎哈就是的的再重新注册的的";
    
    arrOfSex = [[NSMutableArray alloc] initWithObjects:@"男",@"男",@"女",@"男",@"男",@"女",nil];
    arrOfimage_comment = [[NSMutableArray alloc] initWithObjects:@"个人中心_03",@"110.jpg",@"个人中心_03",@"个人中心_03",@"110.jpg",@"个人中心_03",nil];
    arrOfDate = [[NSMutableArray alloc] initWithObjects:@"05-12 20:04:24",@"06-12 20:04:24",@"06-13 17:30:23",@"05-12 20:04:24",@"06-12 20:04:24",@"06-13 17:30:23",nil];
    arrOfName = [[NSMutableArray alloc] initWithObjects:@"飞翔的小鸡",@"小小爱",@"大大爱",@"飞翔的小鸡",@"小小爱",@"大大爱",nil];
    arrOfName_comment = [[NSMutableArray alloc] initWithObjects:@"飞翔的小鸡",@"小小爱 回复 飞翔的小鸡",@"大大爱",@"小小爱 回复 飞翔的小鸡",@"小小爱",@"小小爱 回复 飞翔的小鸡",nil];
    arrOfcontent = [[NSMutableArray alloc] initWithObjects:@"测试文字:哦也！！！！！！！",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 ",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快速的回复过",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快放",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 ",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快速的回复过",nil];
    arrOfType = [[NSMutableArray alloc] initWithObjects:@"编辑",@"赞同",@"已赞",@"已赞",@"赞同",@"已赞",nil];
    arrOf_number = [[NSMutableArray alloc] initWithObjects:@"10",@"0",@"25",@"10",@"0",@"25",nil];
    
}
-(void)setTabar{
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
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"更多"]  forState:UIControlStateNormal];
    
    
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 addTarget:self action:@selector(didExit) forControlEvents:UIControlEventTouchUpInside];
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

}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 66) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(UIView *)createHeadView
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, height+80+20+5)];
    headView.backgroundColor =[UIColor whiteColor];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 45, 45)];
    imageV.layer.cornerRadius = 22.5;
    imageV.layer.masksToBounds = YES;
    
    imageV.image = [UIImage imageNamed:@"头像_1"];
    [headView addSubview:imageV];
    
    
    UIImageView *seximage = [[UIImageView alloc] initWithFrame:CGRectMake(65, 18,18, 15)];
    if ([sexStr isEqualToString:@"男"]) {
        seximage.image = [UIImage imageNamed:@"男.png"];
    }else if ([sexStr isEqualToString:@"女"]) {
        seximage.image = [UIImage imageNamed:@"女1.png"];
    }
    [headView addSubview:seximage];
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(65+25, 15, Mywidth-70, 20)];
    namelabel.text = nameStr;
    namelabel.textColor = [UIColor blackColor];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.font = [UIFont systemFontOfSize:16];
    [headView addSubview:namelabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 38, Mywidth-70, 20)];
    timeLabel.text = timeStr;
    timeLabel.textColor = UIColorFromRGB(0xaeaeae);
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:16];
    [headView addSubview:timeLabel];
    
    
    
    UILabel *_labelOfnumber_head = [[UILabel alloc] init];
    _labelOfnumber_head.frame = CGRectMake(10,68,50, 20);
    _labelOfnumber_head.textColor = [UIColor whiteColor];
    _labelOfnumber_head.textAlignment = NSTextAlignmentCenter;
    _labelOfnumber_head.layer.masksToBounds = YES;
    _labelOfnumber_head.layer.cornerRadius = 10;
    _labelOfnumber_head.adjustsFontSizeToFitWidth = YES;
    _labelOfnumber_head.backgroundColor = UIColorFromRGB(0x5496DF);
    _labelOfnumber_head.font = [UIFont systemFontOfSize:15];
    _labelOfnumber_head.text = numberOfhead;
    [headView addSubview:_labelOfnumber_head];
    
    UILabel *contentLbael = [[UILabel alloc] initWithFrame:CGRectMake(10,68, Mywidth-20,height)];
    contentLbael.numberOfLines = 1000;
    contentLbael.font = [UIFont systemFontOfSize:17];
    contentLbael.text = [NSString stringWithFormat:@"           %@",contentStr];
    contentLbael.textAlignment = NSTextAlignmentLeft;
    contentLbael.textColor = [UIColor blackColor];
    [headView addSubview:contentLbael];
    
    UILabel *otherTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75+height, Mywidth - 30, 15)];
    otherTimeLabel.text = [NSString stringWithFormat:@"转为正式议题时间: %@",otherTime];
    otherTimeLabel.textColor = UIColorFromRGB(0xa9a9a9);
    otherTimeLabel.font = [UIFont systemFontOfSize:27/2];
    [headView addSubview:otherTimeLabel];
    
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, height+80+25-1, Mywidth, 1)];
    lineview.backgroundColor = UIColorFromRGB(0xd9d9d9);
    [headView addSubview:lineview];
    return headView;
}



#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(btnleft.selected)
    {
         return arrOfName.count+1;
    }
    else{
        return arrOfName.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( btnleft.selected) {
        if (indexPath.row == 0) {
            height =  [self caculateTheTextHeight:contentStr andFontSize:17 andWith:40];
            return height + 80 +20+5;
        }
        //如果是第二个cell 就要下移 加一个label
        int aa;
        if (indexPath.row == 1) {
            aa = 25;
        }else{
            aa = 0;
        }
        return [self caculateTheTextHeight:arrOfcontent[indexPath.row-1] andFontSize:14 andWith:75]+60+20+5+aa;
    }else{
        
        return [self caculateTheTextHeight:arrOfcontent[indexPath.row] andFontSize:14 andWith:70]+60+15;
        
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (btnleft.selected) {
        return 80;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (btnright.selected) {
        return nil;
    }
    
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, Mywidth, 80)];
    footView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.userInteractionEnabled = YES;
    btn.frame = CGRectMake(20, 15, Mywidth-40, 42);
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;

    [btn setTitle:@"发表观点" forState:UIControlStateNormal];
    btn.backgroundColor = UIColorFromRGB(0x5496DF);
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];

    return footView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (btnleft.selected) {
        static NSString *cellname = @"cell";
        RZHot_FormalDetailsTableViewCell  *cell= (RZHot_FormalDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        if (indexPath.row == 0) {
            [cell1 addSubview:[self createHeadView]];
            return cell1;
        }
        if (cell == nil) {
            cell = [[RZHot_FormalDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        int a = 1;
        if (indexPath.row == 1) {
            a = 25;
            cell.newlabel.hidden = NO;
        }else{
            a = 0;
            cell.newlabel.hidden = YES;
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.labelOfContent.frame = CGRectMake(60, 65+a, self.view.frame.size.width-75,[self caculateTheTextHeight:arrOfcontent[indexPath.row-1] andFontSize:14 andWith:75]);
        cell.btn1.frame = CGRectMake(self.view.frame.size.width-60, 10+a, 40, 20);
        cell.imageV1.frame = CGRectMake(10, 10+a, 40, 40);
        cell.imageV2.frame = CGRectMake(60, 12+a, 20, 18);
        cell.labelOfName.frame = CGRectMake(85, 10+a, cell.frame.size.width-85-90, 20);
        cell.labelOfDate.frame = CGRectMake(60, 35+2+a, cell.frame.size.width-60, 20);
        cell.labelOfnumber.frame = CGRectMake(Mywidth - 110, 35+2+a, 50 ,20);
        cell.labelofZan.frame = CGRectMake(Mywidth - 55, 35+2+a, 50 ,20);
        
        [cell.btn1 setTitle:@"赞同"  forState:UIControlStateNormal];
        [cell.btn1 setTitle:@"已赞"  forState:UIControlStateSelected];
        [cell.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [cell.btn1 setTitleColor:UIColorFromRGB(0x5695e2) forState:UIControlStateNormal];
        if ([arrOfType[indexPath.row-1] isEqualToString:@"已赞"]) {
            [cell.btn1 setBackgroundColor:UIColorFromRGB(0x5695e2)];
            cell.btn1.selected = YES;
        }else  {
            [cell.btn1 setBackgroundColor:[UIColor whiteColor]];
            cell.btn1.selected = NO;
        }
        cell.btn1.tag = indexPath.row-1;
        [cell.btn1 addTarget:self action:@selector(didbtnfromCell:) forControlEvents:UIControlEventTouchUpInside];
        if ([arrOfType[indexPath.row-1] isEqualToString:@"编辑"]) {
            [cell.btn1 setTitle:@"编辑"  forState:UIControlStateNormal];
            [cell.btn1 setTitle:@"编辑"  forState:UIControlStateSelected];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row-1]];
        cell.labelOfName.text = arrOfName[indexPath.row-1];
        cell.labelOfDate.text = arrOfDate[indexPath.row-1];
        cell.labelOfContent.text = arrOfcontent[indexPath.row-1];
        cell.labelOfnumber.text = arrOf_number[indexPath.row-1];
        
        if ([arrOfSex[indexPath.row-1] isEqualToString:@"男"]) {
            cell.imageV2.image = [UIImage imageNamed:@"男.png"];
        }else if ([arrOfSex[indexPath.row-1] isEqualToString:@"女"])
        {
            cell.imageV2.image = [UIImage imageNamed:@"女1.png"];
        }
        return cell;

    }
    else{
        static NSString * cell_name = @"cell_other";
        RZActivity_FiveTableViewCell * cell_comment = (RZActivity_FiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_name];
        if (cell_comment == nil) {
            cell_comment = [[RZActivity_FiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_name];
        }
    
        cell_comment.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_comment.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row]];
        cell_comment.labelOfName.text = arrOfName[indexPath.row];
        cell_comment.labelOfDate.text = arrOfDate[indexPath.row];
        cell_comment.labelOfContent.text = arrOfcontent[indexPath.row];
        cell_comment.labelOfContent.frame = CGRectMake(65, 60, self.view.frame.size.width-75, 60+[self caculateTheTextHeight:arrOfcontent[indexPath.row] andFontSize:14 andWith:70]-56);
        cell_comment.btn1.frame = CGRectMake(self.view.frame.size.width-50, 15, 33, 25);
        [cell_comment.btn1 setBackgroundImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
        [cell_comment.btn1 addTarget:self action:@selector(didComment) forControlEvents:UIControlEventTouchUpInside];
        if ([arrOfSex[indexPath.row] isEqualToString:@"男"]) {
            cell_comment.imageV2.image = [UIImage imageNamed:@"男.png"];
        }else if ([arrOfSex[indexPath.row] isEqualToString:@"女"])
        {
            cell_comment.imageV2.image = [UIImage imageNamed:@"女1.png"];
        }
        
        return cell_comment;
        
    }
    
}


-(void)createCommentView
{
    commentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40-66, self.view.frame.size.width, 40)];
    commentView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(8, 5, 30, 30);
    [btn setImage:[UIImage imageNamed:@"表情.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didbiaoqing) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:btn];
    textField = [[UITextField alloc] initWithFrame:CGRectMake(46, 4, self.view.frame.size.width - 46 -46, 34-2)];
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
    commentView.hidden = YES;
    [self.view addSubview:commentView];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
        commentView.frame = CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40);
    }];
}
-(void)didbiaoqing
{
    
}
-(void)didSendOut
{
    [textField resignFirstResponder];
}
-(void)didbtnfromCell:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
        RZEditOpinionViewController *editCtrl = [[RZEditOpinionViewController alloc] init];
        RZHot_FormalDetailsTableViewCell *cell = (RZHot_FormalDetailsTableViewCell *)[[sender superview] superview];
        editCtrl.textStr = cell.labelOfContent.text;
        [self.navigationController pushViewController:editCtrl animated:YES];
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = UIColorFromRGB(0x5695e2);
        arrOfType[sender.tag] = @"已赞";
    }else{
        sender.backgroundColor = [UIColor whiteColor];
        arrOfType[sender.tag] = @"赞同";
    }
    
}
-(void)didBtn:(UIButton *)sender
{
    RZSendOpinionViewController *sendCtrl = [[RZSendOpinionViewController alloc] init];
    [self.navigationController pushViewController:sendCtrl animated:YES];
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didExit
{
    NSLog(@".......");
}
-(void)didComment
{
    [textField becomeFirstResponder];
}
-(void)SelectTop_left:(UIButton *)sender
{
    
    btnright.selected = NO;
    btnleft.selected = YES;
    commentView.hidden = YES;
    _tableView.frame = CGRectMake(0, 0, Mywidth, Myheight );
    [_tableView reloadData];
}
-(void)SelectTop_right:(UIButton *)sender
{
    
   
    btnright.selected = YES;
    btnleft.selected = NO;
    commentView.hidden = NO;
     _tableView.frame = CGRectMake(0, 0, Mywidth, Myheight - 42);
    [_tableView reloadData];
}

- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andWith:(int)with{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(Mywidth-with, CGFLOAT_MAX);
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
