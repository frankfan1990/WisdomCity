//
//  RZFoodDetailsMessageViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-9.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZFoodDetailsMessageViewController.h"
#import "RZDetailsTakeoutViewController.h"
#import "RZShoppingCartViewController.h"
#import "RZFoodCommentTableViewCell.h"
#import "RZAllFoodCommentViewController.h"
#import "MarkupParser.h"
#import "CustomLabel.h"
@interface RZFoodDetailsMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSString* numberOfcomment;
    
    NSString *numberstr;
    //评论 重用cell的数据
    NSMutableArray *arrOfimage_comment;
    NSMutableArray *arrOfName_comment;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfSex;
    NSMutableArray *arrOfStar;
}
@end

@implementation RZFoodDetailsMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
    [self Variableinitialization];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-62) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
-(void)Variableinitialization
{
    //取得前面的电话号码
    RZDetailsTakeoutViewController *takeout = (RZDetailsTakeoutViewController *)self.navigationController.viewControllers[2];
    numberstr = takeout.numberStr;
    numberOfcomment = @"351";
    arrOfSex = [[NSMutableArray alloc] initWithObjects:@"男",@"女",nil];
    arrOfimage_comment = [[NSMutableArray alloc] initWithObjects:@"个人中心_03",@"110.jpg",nil];
    arrOfDate = [[NSMutableArray alloc] initWithObjects:@"05-12 20:04:24",@"06-12 20:04:24",nil];
    arrOfName_comment = [[NSMutableArray alloc] initWithObjects:@"飞翔的小鸡",@"小小爱",nil];
    arrOfcontent = [[NSMutableArray alloc] initWithObjects:@"味道还可以，就是不蛮辣 希望味道可以放重点",@"尼玛 太辣了 都快辣成狗了 你是不是和隔壁买水的是一家的呢？ ",nil];
    arrOfStar = [NSMutableArray arrayWithObjects:@"1.0",@"2.5", nil];
}
#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfName_comment.count+3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            return 220;
            break;
        case 1:
            return [self caculateTheTextHeight:_contentStr andFontSize:14 andDistance:80] + 50;
            break;
        case 2:
            return 30;
            break;
        default:
            return [self caculateTheTextHeight:arrOfcontent[indexPath.row-3] andFontSize:14 andDistance:70]+60+15;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = UIColorFromRGB(0x5695e2);
    [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.row == 0) {
        UITableViewCell *cell0 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:_image];
        imageV.frame = CGRectMake(0, 0, Mywidth, 220);
        [cell0.contentView addSubview:imageV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 220-60, Mywidth, 60)];
        label.font = [UIFont systemFontOfSize:25];
        label.backgroundColor = UIColorFromRGB(0x343434);
        label.text = [NSString stringWithFormat:@"   %@",_priceStr];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.userInteractionEnabled = YES;
        
        [cell0.contentView addSubview:label];
        
        CGFloat width = [self caculateTheTextWidth:_nameStr andFontSize:16 andDistance:25];
        
        UILabel *labelOfName = [[UILabel alloc] initWithFrame:CGRectMake(10, 220- 60 -35, width+30, 23)];
        labelOfName.textColor = [UIColor whiteColor];
        labelOfName.layer.masksToBounds = YES;
        labelOfName.layer.cornerRadius = 11;
        labelOfName.textAlignment = NSTextAlignmentCenter;
        labelOfName.text = _nameStr;
        labelOfName.font = [UIFont systemFontOfSize:16];
        labelOfName.backgroundColor = [UIColor blackColor];
        labelOfName.alpha = 0.6;
        
        [cell0.contentView addSubview:labelOfName];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"电话订餐" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(Mywidth - 120,175, 110, 30);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 15;
        btn.backgroundColor = [UIColor colorWithRed:1 green:86/255.0 blue:24/255.0 alpha:1];
        [btn addTarget:self action:@selector(didNumber) forControlEvents:UIControlEventTouchUpInside];
        [cell0.contentView addSubview:btn];
        return cell0;
        
    }
    else if (indexPath.row == 1){
        UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, Mywidth-20, 20)];
        labeltitle.text = @"菜品介绍";
        labeltitle.font = [UIFont systemFontOfSize:14];
        labeltitle.textColor = UIColorFromRGB(0x5695e2);
        [cell1.contentView addSubview:labeltitle];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 32+5, 15, 15)];
        image.image = [UIImage imageNamed:@"左边叹号"];
        [cell1.contentView addSubview:image];
        
        CGFloat height = [self caculateTheTextHeight:_contentStr andFontSize:14 andDistance:80];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 35+5, Mywidth - 78, height)];
        contentLabel.text = _contentStr;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.numberOfLines = 100;
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [cell1.contentView addSubview:contentLabel];
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(Mywidth - 33,height+25, 15, 15)];
        image2.image = [UIImage imageNamed:@"右边叹号"];
        [cell1.contentView addSubview:image2];
        
        return cell1;
    }
    else if (indexPath.row == 2){
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 20)];
        labeltitle.text = @"菜品介绍";
        labeltitle.font = [UIFont systemFontOfSize:14];
        labeltitle.textColor = UIColorFromRGB(0x5695e2);
        [cell2.contentView addSubview:labeltitle];
        
        CustomLabel *cusLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(Mywidth-110, 8.5, 100, 20)];
        NSString *text = [NSString stringWithFormat:@"<font color=\"gray\">共有<font color=\"orange\">%@<font color=\"gray\">位邻居点评",numberOfcomment];
        MarkupParser *parser = [[MarkupParser alloc] init];
        parser.fontSize = 12;
        [cusLabel setAttString:[parser attrStringFromMarkup:text]];
        cusLabel.textAlignment = NSTextAlignmentRight;
        
        [cell2.contentView addSubview:cusLabel];
        return cell2;
    }
    
    static NSString * cell_name = @"cell_other";
    RZFoodCommentTableViewCell * cell_comment = (RZFoodCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_name];
    if (cell_comment == nil) {
        cell_comment = [[RZFoodCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_name];
    }
    cell_comment.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_comment.labelOfContent.frame = CGRectMake(65, 60, self.view.frame.size.width-75, [self caculateTheTextHeight:arrOfcontent[indexPath.row-3] andFontSize:14 andDistance:70]);
    cell_comment.imageV1.image = [UIImage imageNamed:arrOfimage_comment[indexPath.row-3]];
    cell_comment.labelOfName.text = arrOfName_comment[indexPath.row-3];
    cell_comment.labelOfDate.text = arrOfDate[indexPath.row-3];
    cell_comment.star.rating = [arrOfStar[indexPath.row-3] floatValue];
    cell_comment.labelOfContent.text = arrOfcontent[indexPath.row-3];
    if ([arrOfSex[indexPath.row-3] isEqualToString:@"男"]) {
        cell_comment.imageV2.image = [UIImage imageNamed:@"男.png"];
    }else if ([arrOfSex[indexPath.row-3] isEqualToString:@"女"])
    {
        cell_comment.imageV2.image = [UIImage imageNamed:@"女1.png"];
    }
    return cell_comment;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 2) {
        RZAllFoodCommentViewController *allCtrl = [[RZAllFoodCommentViewController alloc] init];
        allCtrl.numberOfcomment = numberOfcomment;
        [self.navigationController pushViewController:allCtrl animated:YES];
    }
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
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"购物车"]  forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 5, 25, 25)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 addTarget:self action:@selector(didExit:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"菜品详情";
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didExit:(UIButton *)sender
{
    RZShoppingCartViewController *shoppingCtrl = [[RZShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCtrl animated:YES];
}


#pragma mark - 拨号按钮
-(void)didNumber
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",numberstr]]];
    NSLog(@"%@",numberstr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
