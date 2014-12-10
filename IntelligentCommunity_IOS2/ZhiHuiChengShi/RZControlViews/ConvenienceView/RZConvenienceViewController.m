//
//  RZConvenienceViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark  便民 搭配

#import "RZConvenienceViewController.h"
#import "RESideMenu.h"
#import "RZTagViewController.h"
#import "RZNumberPassViewController.h"
#import "RZHousingTransactionsViewController.h"
#import "RZCategoryListViewController.h"
#import "RZCommonlyListViewController.h"
@interface RZConvenienceViewController ()
{
    NSInteger typeId;
    NSArray *Title;
}
@end

@implementation RZConvenienceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"便民";
    [label setFont:[UIFont systemFontOfSize:20]];
//    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
}
-(void)showMeun{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)viewDidLoad
{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTagCtrl:) name:@"tagCtrl2" object:nil];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [btnLeft setBackgroundImage:[UIImage imageNamed:@"面包按钮.png"] forState:UIControlStateNormal];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(showMeun) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
 
       [self onlyHouseKeep];
}
/*
 号码通
 外卖
 购物
 优惠
 二手市场
 家政
 家教
 房屋交易
 违章查询
 Number
 Take away
 Shopping
 Discount
 Secondhand market
 Home Economics
 Tutor
 Housing transactions
 Violation queries
 */
#define BTNWIDTH (100.0f)

#define BTNHEIGHT (115.0f)

-(void)onlyHouseKeep{
    Title=@[@"号码通",@"外卖",@"便利店",@"二手市场",@"家政",@"家教",@"房屋交易",@"违章查询"];
    NSArray *TitleIcon=@[@"号码.png",@"外卖.png",@"便利.png",@"二手.png",@"家政.png",@"家教.png",@"交易.png",@"违章.png"];
    
    CGFloat height=0.0f;
    for (int i=0;i<[Title count]; i++ ) {
    
        UIButton *btnNumber=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnNumber setFrame:CGRectMake(0+110*(i%3), height, BTNWIDTH, BTNHEIGHT)];
        [btnNumber setBackgroundColor:[UIColor clearColor]];
        [btnNumber setTitle:[Title objectAtIndex:i] forState:UIControlStateNormal];
        [btnNumber setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
        [btnNumber.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [btnNumber setTag:101+i];
        [btnNumber setTitleColor:[UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1] forState:UIControlStateNormal];
        [btnNumber addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *img=[[UIImageView alloc] init];
        [img setFrame:CGRectMake(30, 40, 45, 45)];
        [img setImage:[UIImage imageNamed:[TitleIcon objectAtIndex:i]]];
        [btnNumber addSubview:img];
        [self.view addSubview:btnNumber];
        if(i%3==2&&i!=0){
            height=btnNumber.frame.size.height+btnNumber.frame.origin.y;
            
        }
        
    }
  
}
//类别分类：
//1001，号码通类别
//1002，二手市场类别
//1003，家政类别
//1004，家教类别
//1005，外卖菜品类别
//1006，家政人员类别
-(void)selectButton:(UIButton*)sender{
    
    if (sender.tag == 101) {
        RZNumberPassViewController *numberCtrl = [[RZNumberPassViewController alloc] init];
        numberCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:numberCtrl animated:YES];
    }else if (sender.tag == 107){
        RZHousingTransactionsViewController *houseCtrl = [[RZHousingTransactionsViewController alloc] init];
        houseCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:houseCtrl animated:YES];
    }else if (sender.tag == 105 || sender.tag == 106)
    {
        typeId = sender.tag-105+1003;//1003是家政类别
        RZCategoryListViewController *listCtrl = [[RZCategoryListViewController alloc] init];
        listCtrl.hidesBottomBarWhenPushed = YES;
        //代理传值
        self.delegate = listCtrl;
        [self.delegate sendData:@{@"key":@"value"} Type:typeId Name:Title[sender.tag-101]];
        [self.navigationController pushViewController:listCtrl animated:YES];
    }else if (sender.tag == 102){
        typeId = sender.tag - 102 + 1005;
        RZCommonlyListViewController *commonlyCtrl = [[RZCommonlyListViewController alloc] init];
        commonlyCtrl.hidesBottomBarWhenPushed = YES;
        self.delegate = commonlyCtrl;
        [self.delegate sendData:@{@"key":@"value"} Type:typeId Name:Title[sender.tag-101]];
        [self.navigationController pushViewController:commonlyCtrl animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushTagCtrl:(NSNotification *)note
{
    RZTagViewController *tagCtrl = [[RZTagViewController alloc] init];
    tagCtrl.labelName = note.userInfo[@"nameStr"];
    tagCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagCtrl animated:YES];
}
@end
