//
//  RZTakeoutMessageCommentViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-5.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZTakeoutMessageCommentViewController.h"
#import "RZActivity_FiveTableViewCell.h"
#import "RZCommonlyListTableViewCell.h"
@interface RZTakeoutMessageCommentViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UITextField * textField;
    UIView *commentView;
    //评论 重用cell的数据
    NSMutableArray *arrOfimage_comment;
    NSMutableArray *arrOfName_comment;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfSex;
    
    NSString *contentStr;
}


@end

@implementation RZTakeoutMessageCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Variableinitialization];
    [self setTabar];
    [self createTableView];
    [self createCommentView];
    
}
-(void)setTabar
{
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
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"消息评论";
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
    contentStr = @"    凡是在辣翻天消费，满二十送送五元  满100送30  送到你满意 送到你开心  啤酒畅饮！满200元 送价值70元的大礼包。";
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 66-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(void)createCommentView
{
    commentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40-66, self.view.frame.size.width, 40)];
    commentView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(8, 5, 30, 30);
    [btn setImage:[UIImage imageNamed:@"表情蓝色.png"] forState:UIControlStateNormal];
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
    [sendbtn setTitleColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1] forState:UIControlStateNormal];
    [sendbtn addTarget:self action:@selector(didSendOut) forControlEvents:UIControlEventTouchUpInside];
    sendbtn.frame = CGRectMake(self.view.frame.size.width - 43, 5, 40, 30);
    [commentView addSubview:sendbtn];
    [self.view addSubview:commentView];
}
#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrOfName_comment.count+2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return  90;
    }
    else if (indexPath.row == 1) {
        return 55+[self caculateTheTextHeight:contentStr andFontSize:14 andWith:40];
    }
    else{
         return [self caculateTheTextHeight:arrOfcontent[indexPath.row-2] andFontSize:14 andWith:70]+60+15;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RZCommonlyListTableViewCell *cell = [[RZCommonlyListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageV.image = _image;
        cell.labelOfTitle.text = _nameStr;
        cell.labelOfAddress.text = [NSString stringWithFormat:@"发表于：%@",_dateStr];
        cell.labelOfDistance.text = [NSString stringWithFormat:@"回复：%@",_numberStr];
        cell.labelOfDistance.frame = CGRectMake(Mywidth-200, 60, 190, 20);
        cell.labelOfDistance.textAlignment = NSTextAlignmentRight;
        cell.labelOfAddress.frame = CGRectMake(80+25, 42, Mywidth-98, 20);
        return cell;
        
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 40, 17)];
        label1.textColor = [UIColor whiteColor];
        label1.text = @"优惠";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:12];
        label1.backgroundColor = [UIColor orangeColor];
        [cell.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 9, Mywidth-75, 20)];
        label2.text = _titleStr;
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(15,40, Mywidth-30, [self caculateTheTextHeight:contentStr andFontSize:14 andWith:40])];
        label3.text = contentStr;
        label3.textAlignment = NSTextAlignmentLeft;
        label3.numberOfLines = 100;
        label3.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label3];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 55+[self caculateTheTextHeight:contentStr andFontSize:14 andWith:40]-0.5, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell.contentView addSubview:lineView];
        return cell;
    }
    static NSString * cell_name = @"cell_other";
    RZActivity_FiveTableViewCell * cell_comment = (RZActivity_FiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_name];
    if (cell_comment == nil) {
        cell_comment = [[RZActivity_FiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_name];
    }

    cell_comment.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell_comment.labelOfContent.frame = CGRectMake(65, 60, self.view.frame.size.width-75, [self caculateTheTextHeight:arrOfcontent[indexPath.row-2] andFontSize:14 andWith:70]);
    cell_comment.btn1.frame = CGRectMake(self.view.frame.size.width-50, 15, 33, 25);
    cell_comment.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row-2]];
    cell_comment.labelOfName.text = arrOfName_comment[indexPath.row-2];
    cell_comment.labelOfDate.text = arrOfDate[indexPath.row-2];
    cell_comment.labelOfContent.text = arrOfcontent[indexPath.row-2];
    
    [cell_comment.btn1 setBackgroundImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [cell_comment.btn1 addTarget:self action:@selector(didComment) forControlEvents:UIControlEventTouchUpInside];
    if ([arrOfSex[indexPath.row-2] isEqualToString:@"男"]) {
        cell_comment.imageV2.image = [UIImage imageNamed:@"男.png"];
    }else if ([arrOfSex[indexPath.row-2] isEqualToString:@"女"])
    {
        cell_comment.imageV2.image = [UIImage imageNamed:@"女1.png"];
    }
    return cell_comment;
}
#pragma  mark - textField的代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField1
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
