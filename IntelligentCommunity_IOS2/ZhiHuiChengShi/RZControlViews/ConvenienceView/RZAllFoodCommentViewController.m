//
//  RZAllFoodCommentViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-9.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZAllFoodCommentViewController.h"
#import "RZFoodCommentTableViewCell.h"
#import "RZFoodCommentViewController.h"
@interface RZAllFoodCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    //评论 重用cell的数据
    NSMutableArray *arrOfimage_comment;
    NSMutableArray *arrOfName_comment;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfSex;
    NSMutableArray *arrOfStar;
}
@end

@implementation RZAllFoodCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self Variableinitialization];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-62-45) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setTabar];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, Myheight-45-64, Mywidth, 45);
    btn.backgroundColor = UIColorFromRGB(0x5695e2);
    [btn setTitle:@"发表点评" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didComment:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
-(void)Variableinitialization
{
    arrOfSex = [[NSMutableArray alloc] initWithObjects:@"男",@"女",@"男",@"女",@"男",@"女",@"男",@"女",nil];
    arrOfimage_comment = [[NSMutableArray alloc] initWithObjects:@"个人中心_03",@"110.jpg",@"个人中心_03",@"110.jpg",@"个人中心_03",@"110.jpg",@"个人中心_03",@"110.jpg",nil];
    arrOfDate = [[NSMutableArray alloc] initWithObjects:@"05-12 20:04:24",@"06-12 20:04:24",@"05-12 20:04:24",@"06-12 20:04:24",@"05-12 20:04:24",@"06-12 20:04:24",@"05-12 20:04:24",@"06-12 20:04:24",nil];
    arrOfName_comment = [[NSMutableArray alloc] initWithObjects:@"飞翔的小鸡",@"小小爱",@"飞翔的小鸡",@"小小爱",@"飞翔的小鸡",@"小小爱",@"飞翔的小鸡",@"小小爱",nil];
    arrOfcontent = [[NSMutableArray alloc] initWithObjects:@"味道还可以，就是不蛮辣 希望味道可以放重点",@"尼玛 太辣了 都快辣成狗了 你是不是和隔壁买水的是一家的呢？ ",@"味道还可以，就是不蛮辣 希望味道可以放重点",@"尼玛 太辣了 都快辣成狗了 你是不是和隔壁买水的是一家的呢？ ",@"味道还可以，就是不蛮辣 希望味道可以放重点",@"尼玛 太辣了 都快辣成狗了 你是不是和隔壁买水的是一家的呢？ ",@"味道还可以，就是不蛮辣 希望味道可以放重点",@"尼玛 太辣了 都快辣成狗了 你是不是和隔壁买水的是一家的呢？ ",nil];
    arrOfStar = [NSMutableArray arrayWithObjects:@"1.0",@"2.5",@"1.0",@"2.5", @"1.0",@"2.5",@"1.0",@"2.5", nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
    label.text = [NSString stringWithFormat:@"全部(%@)",self.numberOfcomment];
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
    
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfName_comment.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self caculateTheTextHeight:arrOfcontent[indexPath.row] andFontSize:14 andDistance:70]+60+15;
            
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_name = @"cell_other";
    RZFoodCommentTableViewCell * cell_comment = (RZFoodCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_name];
    if (cell_comment == nil) {
        cell_comment = [[RZFoodCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_name];
    }
    cell_comment.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_comment.labelOfContent.frame = CGRectMake(65, 60, self.view.frame.size.width-75, [self caculateTheTextHeight:arrOfcontent[indexPath.row] andFontSize:14 andDistance:70]);
    cell_comment.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row]];
    cell_comment.labelOfName.text = arrOfName_comment[indexPath.row];
    cell_comment.labelOfDate.text = arrOfDate[indexPath.row];
    cell_comment.star.rating = [arrOfStar[indexPath.row] floatValue];
    cell_comment.labelOfContent.text = arrOfcontent[indexPath.row];
    if ([arrOfSex[indexPath.row] isEqualToString:@"男"]) {
        cell_comment.imageV2.image = [UIImage imageNamed:@"男.png"];
    }else if ([arrOfSex[indexPath.row] isEqualToString:@"女"])
    {
        cell_comment.imageV2.image = [UIImage imageNamed:@"女1.png"];
    }
    return cell_comment;

}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
- (CGFloat)caculateTheTextWidth:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake( CGFLOAT_MAX,distance);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.width;
}

-(void)didComment:(UIButton *)sender
{
    RZFoodCommentViewController *foodcommentCtrl = [[RZFoodCommentViewController alloc] init];
    [self.navigationController pushViewController:foodcommentCtrl animated:YES];
}

@end
