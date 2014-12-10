//
//  ContentViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "ContentViewController.h"
#import "RZFoodListTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "RZReserveViewController.h"
#import "RZFoodDetailsMessageViewController.h"
@interface ContentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *arrOfFoodImage;
    NSMutableArray *arrOfFoodName;
    NSMutableArray *arrOfFoodPrice;
    NSMutableArray *arrOfFoodState;
    NSMutableArray *arrOfFoodContent;
    RZReserveViewController *resCtrl;
}
@end

@implementation ContentViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self prefersStatusBarHidden];
     self.view.backgroundColor = [UIColor whiteColor];
    [self Variableinitialization];

   
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-110) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(void)Variableinitialization
{
    arrOfFoodImage = [NSMutableArray arrayWithObjects:@"http://pic17.nipic.com/20111102/7015943_083452063000_2.jpg",@"http://pic24.nipic.com/20121015/9095554_134755084000_2.jpg",@"http://pic.nipic.com/2007-12-20/200712206539308_2.jpg",@"http://pic1.nipic.com/2008-10-13/2008101312210298_2.jpg",@"http://pic24.nipic.com/20121014/9095554_130006147000_2.jpg",@"http://pic1a.nipic.com/2008-10-27/2008102793623630_2.jpg",@"http://pic17.nipic.com/20111102/7015943_083452063000_2.jpg",nil];
    arrOfFoodName  = [NSMutableArray arrayWithObjects:@"红烧猪脚",@"酸辣鸡杂",@"拔丝香蕉",@"东安鸡",@"松花皮蛋",@"水果菜",@"爆蒸鱿鱼" ,nil];
    arrOfFoodPrice = [NSMutableArray arrayWithObjects:@"36.00",@"28.00",@"12.00",@"24.00",@"22.00",@"8.00",@"99.00", nil];
    arrOfFoodState = [NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"1",@"0",@"0", @"0",nil];
    arrOfFoodContent = [NSMutableArray arrayWithObjects:@"红烧猪脚 肥而不腻，味道鲜美",@"红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美",@"红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美",@"红烧猪脚 肥而不腻，味道鲜美",@"红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美",@" 红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美",@" 红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美红烧猪脚 肥而不腻，味道鲜美", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfFoodName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    RZFoodListTableViewCell *cell = (RZFoodListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[RZFoodListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSURL *url = [NSURL URLWithString:arrOfFoodImage[indexPath.row]];
    [cell.btnFoodImage setImageForState:UIControlStateNormal withURL:url placeholderImage:[UIImage imageNamed:@""]];
    
    if ([arrOfFoodState[indexPath.row] intValue] ==1) {
        cell.btnFoodOrer.selected = YES;
        cell.btnFoodOrer.backgroundColor = UIColorFromRGB(0x5496DF);
        
    }else{
        cell.btnFoodOrer.backgroundColor = [UIColor whiteColor];
        cell.btnFoodOrer.selected = NO;
    }
    
    cell.labelFoodName.text = arrOfFoodName[indexPath.row];
    cell.labelFoodPirce.text = [NSString stringWithFormat:@"￥ %@",arrOfFoodPrice[indexPath.row]];
    
    cell.btnFoodImage.tag = 555555+indexPath.row;
    [cell.btnFoodImage addTarget:self action:@selector(didFoodImage:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZFoodListTableViewCell *cell = (RZFoodListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    RZFoodDetailsMessageViewController *foodCtrl = [[RZFoodDetailsMessageViewController alloc] init];
    foodCtrl.image = cell.btnFoodImage.currentImage;
    foodCtrl.priceStr = cell.labelFoodPirce.text;
    foodCtrl.nameStr = cell.labelFoodName.text;
    foodCtrl.contentStr = arrOfFoodContent[indexPath.row];
    [self.navigationController pushViewController:foodCtrl animated:YES];
}
-(void)didFoodImage:(UIButton *)sender
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -200, Mywidth, Myheight+300)];
    backView.alpha = 0;
    backView.tag = 100001;
    backView.backgroundColor = [UIColor blackColor];
    
    resCtrl = self.navigationController.viewControllers[self.navigationController.viewControllers.count-1];
    [resCtrl.view addSubview:backView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 44)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha  = 0;
    view1.tag = 100002;
    [self.navigationController.navigationBar addSubview:view1];
    
    UIView *viewOther = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 20)];
    viewOther.backgroundColor = [UIColor blackColor];
    viewOther.alpha  = 0;
    viewOther.tag = 100003;
    [[[UIApplication sharedApplication] keyWindow] addSubview:viewOther];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(18, 25, Mywidth-36, 340)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.alpha = 0;
    whiteView.tag = 100004;
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.cornerRadius = 4;
    [resCtrl.view addSubview:whiteView];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    labelname.text = @"菜品介绍";
    labelname.font = [UIFont systemFontOfSize:17];
    labelname.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:labelname];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(Mywidth-69, 8, 23, 23)];
    [cancelBtn addTarget:self action:@selector(didCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    [whiteView addSubview:cancelBtn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:sender.currentImage];
    imageView.frame = CGRectMake(18, 40, Mywidth-72, 210);
    [whiteView addSubview:imageView];
    
    CGFloat height = [self caculateTheTextHeight:arrOfFoodContent[sender.tag-555555] andFontSize:14 andDistance:60];
    if (height>55) {
        height = 55;
    }
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 260, Mywidth-66, height)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.text = arrOfFoodContent[sender.tag -555555];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 3;
    [whiteView addSubview:contentLabel];
    
    [UIView animateWithDuration:0.5 animations:^{
        backView.alpha = 0.4;
        view1.alpha = 0.4;
        viewOther.alpha = 0.4;
        whiteView.alpha = 1;
       
    }];
    
}
-(void)didCancel
{
    UIView *backView = (UIView *)[resCtrl.view viewWithTag:100001];
    [backView removeFromSuperview];
    
    UIView *view1 = (UIView *)[self.navigationController.navigationBar viewWithTag:100002];
    [view1 removeFromSuperview];
    
    UIView *view2 = (UIView *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:100003];
    [view2 removeFromSuperview];
    
    UIView *view3 = (UIView *)[resCtrl.view viewWithTag:100004];
    [view3 removeFromSuperview];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
