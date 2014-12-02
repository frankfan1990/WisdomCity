//
//  RZNumberPassViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-11-25.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//
//!!!:拨号功能没做
#import "RZNumberPassViewController.h"
#import "RZMyNumberPassViewController.h"
#import "RZCommonlyUseViewController.h"
#import "RZOtherNumberViewController.h"
#import "AFNetworking.h"
#define Mywith (self.view.frame.size.width)
@interface RZNumberPassViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *arrOfCategory;
    NSMutableArray *arrOfContent;
    UITableView *_tableView;
    NSMutableArray *arrOfcount;
    
}
@end

@implementation RZNumberPassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"号码通";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arrOfCategory = [NSMutableArray arrayWithObjects:@"我的号码通",@"小区必备", nil];
    arrOfContent = [NSMutableArray array];
    arrOfcount = [NSMutableArray array];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NumberPass.plist"]];
    if (dict != nil) {
        for (NSDictionary *dd1 in dict[@"items"]) {
            
            [arrOfCategory addObject:dd1[@"category"]];
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dd2 in dd1[@"commentcontent"][@"items"]) {
                [arr addObject:dd2[@"category"]];
            }
            [arrOfContent addObject:arr];
            //用来管理cell的 局部刷新用的
            NSMutableArray *arr_other = [NSMutableArray arrayWithObjects:@"one", nil];
            [arrOfcount addObject:arr_other];
        }
    }
    [self getData];
    [self setTabBar];
    [self createTableView];

    
    
}
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(-10, 0, 30, 30)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"搜索白色"]  forState:UIControlStateNormal];
    
    
    [btn2 setFrame:CGRectMake(0, 5, 28, 28)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 addTarget:self action:@selector(didExit:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywith, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}
-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:[NSString stringWithFormat:@"%@/convenience/getNumberBookMenu",hostIPTwo] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        arrOfCategory = [NSMutableArray arrayWithObjects:@"我的号码通",@"小区必备", nil];
        arrOfContent = [NSMutableArray array];
         [arrOfcount removeAllObjects];
        NSDictionary *dic = responseObject;
        if([dic[@"success"] intValue] == 1)
        {
        
            [NSKeyedArchiver archiveRootObject:dic[@"data"] toFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NumberPass.plist"]];
            
            for (NSDictionary *dd1 in dic[@"data"][@"items"]) {
               
                [arrOfCategory addObject:dd1[@"category"]];
                
                NSMutableArray *arr = [NSMutableArray array];
                for (NSDictionary *dd2 in dd1[@"commentcontent"][@"items"]) {
                    [arr addObject:dd2[@"category"]];
                }
                [arrOfContent addObject:arr];
                
                //用来管理cell的
                NSMutableArray *arr_other = [NSMutableArray arrayWithObjects:@"one", nil];
                [arrOfcount addObject:arr_other];
            }
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NumberPass.plist"]];
        if (dict == nil) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n网络异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    
    }];
    
    
}

#pragma mark - tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrOfCategory.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0;
    }else{
        return [arrOfcount[section-2] count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        
    if([arrOfContent[indexPath.section-2] count]%3){
        return 44*([arrOfContent[indexPath.section-2] count]/3+1);
    }else{
        return 44*[arrOfContent[indexPath.section-2] count]/3;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *headView =[[UIButton alloc] initWithFrame:CGRectMake(-1, 0, Mywith+2, 45)];
    if (section%2) {
        
         headView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    }else{
        headView.backgroundColor = [UIColor colorWithRed:237/255.0 green:246/255.0 blue:255/255.0 alpha:1];
    }

    headView.tag = section+2222;
    headView.selected = NO;
    if (section != 1) {
        headView.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1].CGColor;
        headView.layer.borderWidth = 0.5;
    }
    
    [headView addTarget:self action:@selector(didHeadView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 250, 45)];
    namelabel.text = arrOfCategory[section];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.font = [UIFont systemFontOfSize:16];
    [headView addSubview:namelabel];
    
   UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(Mywith - 35, 10, 30, 30)];
    if (section > 1) {
        headImage.transform =  CGAffineTransformMakeRotation(M_PI_2);
    }
    headImage.image = [UIImage imageNamed:@"向右灰"];
    headImage.tag = headView.tag+100;
    [headView addSubview:headImage];
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellname = @"cell";
    UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
    layoutView.itemSize = CGSizeMake((Mywith-20)/3, 35);
    float height;
    if([arrOfContent[indexPath.section-2] count]%3){
       height = 44*([arrOfContent[indexPath.section-2] count]/3+1);
    }else{
       height = 44*[arrOfContent[indexPath.section-2] count]/3;
    }
   UICollectionView * _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Mywith, height) collectionViewLayout:layoutView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.tag = 1101+indexPath.section;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
    [cell addSubview:_collectionView];
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, height-0.5, Mywith, 0.5)];
    footView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [cell addSubview:footView];
    if(indexPath.section == arrOfCategory.count-1)
    {
        footView.hidden = NO;
    }else{
        footView.hidden = YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//点击头部
-(void)didHeadView:(UIButton *)sender
{
    
    if (sender.tag-2222 == 0) {
        RZMyNumberPassViewController *Mynumber = [[RZMyNumberPassViewController alloc] init];
        [self.navigationController pushViewController:Mynumber animated:YES];
    }else if (sender.tag- 2222 == 1){
        RZCommonlyUseViewController *CommonlyCtrl = [[RZCommonlyUseViewController alloc] init];
        [self.navigationController pushViewController:CommonlyCtrl animated:YES];
    }
    
    
    if (sender.tag > 2222+1) {
        
        UIImageView *image = (UIImageView *)[sender viewWithTag:sender.tag+100];
        if (!sender.selected) {
            [UIView animateWithDuration:0.35 animations:^{
                image.transform =  CGAffineTransformMakeRotation(0);
            }];
            
        }else{
            [UIView animateWithDuration:0.35 animations:^{
                image.transform =  CGAffineTransformMakeRotation(M_PI_2);
            }];
            
        }
        //cell的局部刷新
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:sender.tag-2222];
        if (sender.selected) {
            [arrOfcount[sender.tag-2222-2] addObject:@"one"];
            [_tableView beginUpdates];
            [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [_tableView endUpdates];
            
        }else{
            [arrOfcount[sender.tag-2222-2] removeAllObjects];
            [_tableView beginUpdates];
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [_tableView endUpdates];
        }
        sender.selected = !sender.selected;
        
    }
   
    
}
#pragma mark - collectionView的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrOfContent[collectionView.tag-1101-2] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell_my = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_cell" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Mywith/3+4, 45)];
    label.text = arrOfContent[collectionView.tag-1101-2][indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.layer.borderColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1].CGColor;
    label.layer.borderWidth = 0.5;
    [cell_my.contentView addSubview:label];
    return cell_my;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RZOtherNumberViewController  *OtherCtrl = [[RZOtherNumberViewController alloc] init];
    OtherCtrl.titleStr = arrOfContent[collectionView.tag-1101-2][indexPath.row];
    [self.navigationController pushViewController:OtherCtrl animated:YES];
    NSLog(@"%@",indexPath);
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didExit:(UIButton *)sender
{
    NSLog(@"搜索");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
