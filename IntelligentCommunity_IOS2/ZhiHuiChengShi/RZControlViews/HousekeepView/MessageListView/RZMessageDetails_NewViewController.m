//
//  RZMessageDetails_NewViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-21.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZMessageDetails_NewViewController.h"
#import "RZActivity_FiveTableViewCell.h"
@interface RZMessageDetails_NewViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIButton *btnleft;
    UIButton *btnright;
    UITableView *_tableView;
    UITextField * textField;
    UIView *commentView;
    //评论 重用cell的数据
    NSMutableArray *arrOfimage_comment;
    NSMutableArray *arrOfName_comment;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfSex;
}
@end

@implementation RZMessageDetails_NewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 7, 210, 35);
        UIView *topview=[[UIView alloc] initWithFrame:rect];
        btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnleft setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
        [btnleft setBackgroundColor:[UIColor clearColor]];
        [btnleft setTitle:@"  公告详情" forState:UIControlStateNormal];
        [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边未选中.png"] forState:UIControlStateNormal];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边选中.png"] forState:UIControlStateSelected];
        [btnleft setTag:101];
        btnleft.selected = YES;
        [btnleft addTarget:self action:@selector(SelectTop_left:) forControlEvents:UIControlEventTouchUpInside];
        
        btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright setTitle:@"讨论区  " forState:UIControlStateNormal];
        [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnright.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边未选中.png"] forState:UIControlStateNormal];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边选中.png"] forState:UIControlStateSelected];
        [btnright setTag:102];
        [btnright addTarget:self action:@selector(SelectTop_right:) forControlEvents:UIControlEventTouchUpInside];
        
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Variableinitialization];
    [self setTabar];
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
    arrOfSex = [[NSMutableArray alloc] initWithObjects:@"男",@"男",@"女",@"男",@"男",@"女",nil];
    arrOfimage_comment = [[NSMutableArray alloc] initWithObjects:@"个人中心_03",@"110.jpg",@"个人中心_03",@"个人中心_03",@"110.jpg",@"个人中心_03",nil];
    arrOfDate = [[NSMutableArray alloc] initWithObjects:@"05-12 20:04:24",@"06-12 20:04:24",@"06-13 17:30:23",@"05-12 20:04:24",@"06-12 20:04:24",@"06-13 17:30:23",nil];
    arrOfName_comment = [[NSMutableArray alloc] initWithObjects:@"飞翔的小鸡",@"小小爱 回复 飞翔的小鸡",@"大大爱",@"小小爱 回复 飞翔的小鸡",@"小小爱",@"小小爱 回复 飞翔的小鸡",nil];
    arrOfcontent = [[NSMutableArray alloc] initWithObjects:@"测试文字:哦也！！！！！！！",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 ",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快速的回复过",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快放",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 ",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快速的回复过",nil];
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
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 66-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.hidden = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return arrOfName_comment.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [self caculateTheTextHeight:arrOfcontent[indexPath.row] andFontSize:14 andWith:70]+60+15;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_name = @"cell_other";
    RZActivity_FiveTableViewCell * cell_comment = (RZActivity_FiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_name];
    if (cell_comment == nil) {
        cell_comment = [[RZActivity_FiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_name];
    }
    cell_comment.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_comment.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row]];
    cell_comment.labelOfName.text = arrOfName_comment[indexPath.row];
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
#pragma  mark - textField的代理
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

//点击表情
-(void)didbiaoqing
{
    
}
//点击发送
-(void)didSendOut
{
    [textField resignFirstResponder];
}

-(void)didComment
{
    [textField becomeFirstResponder];
}
-(void)SelectTop_left:(UIButton *)sender
{
    btnright.selected = NO;
    btnleft.selected = YES;
    _tableView.hidden = YES;
    commentView.hidden = YES;
}
-(void)SelectTop_right:(UIButton *)sender
{
    btnright.selected = YES;
    btnleft.selected = NO;
    _tableView.hidden = NO;
    commentView.hidden = NO;
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

@end
