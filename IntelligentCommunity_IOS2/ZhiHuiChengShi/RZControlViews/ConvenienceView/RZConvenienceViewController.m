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

@interface RZConvenienceViewController ()

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
//        [btnLeft setBackgroundImage:[UIImage imageNamed:@"RzMenuIcon.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(showMeun) forControlEvents:UIControlEventTouchUpInside];
    //    [btnLeft addTarget:self action:@selector(meun:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
 
       [self onlyHouseKeep];
    
    // Do any additional setup after loading the view from its nib.
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
    NSArray *Title=@[@"号码通",@"外卖",@"便利店",@"二手市场",@"家政",@"家教",@"房屋交易",@"违章查询"];
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
    /*
    UIButton *btnNumber=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnNumber setFrame:CGRectMake(0, height, BTNWIDTH, BTNHEIGHT)];
    [btnNumber setBackgroundColor:[UIColor clearColor]];
    [btnNumber setTitle:@"号码通" forState:UIControlStateNormal];
    [btnNumber setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnNumber.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnNumber setTag:101];
    [btnNumber addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"100.png"]];
    [btnNumber addSubview:img];
    [self.view addSubview:btnNumber];
    
    UIButton *btnTakeAway=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnTakeAway setFrame:CGRectMake(110, height,BTNWIDTH, BTNHEIGHT)];
    [btnTakeAway setBackgroundColor:[UIColor clearColor]];
    [btnTakeAway setTitle:@"外卖" forState:UIControlStateNormal];
    [btnTakeAway setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnTakeAway.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnTakeAway setTag:102];
    [btnTakeAway addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"101.png"]];
    [btnTakeAway addSubview:img];
    [self.view addSubview:btnTakeAway];
    
    
    UIButton *btnShopping=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnShopping setFrame:CGRectMake(220, height,BTNWIDTH, BTNHEIGHT)];
    [btnShopping setBackgroundColor:[UIColor clearColor]];
    [btnShopping setTitle:@"购物" forState:UIControlStateNormal];
    [btnShopping setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnShopping.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnShopping setTag:102];
    [btnShopping addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"101.png"]];
    [btnShopping addSubview:img];
    [self.view addSubview:btnShopping];

    height=btnNumber.frame.size.height+btnNumber.frame.origin.y;
    
    UIButton *btnDiscount=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDiscount setFrame:CGRectMake(0, height, BTNWIDTH, BTNHEIGHT)];
    [btnDiscount setBackgroundColor:[UIColor clearColor]];
    [btnDiscount setTitle:@"优惠" forState:UIControlStateNormal];
    [btnDiscount setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnDiscount.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnDiscount setTag:101];
    [btnDiscount addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"100.png"]];
    [btnDiscount addSubview:img];
    [self.view addSubview:btnDiscount];
    
    UIButton *btnSecondhandMarket=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSecondhandMarket setFrame:CGRectMake(110, height,BTNWIDTH, BTNHEIGHT)];
    [btnSecondhandMarket setBackgroundColor:[UIColor clearColor]];
    [btnSecondhandMarket setTitle:@"二手交易" forState:UIControlStateNormal];
    [btnSecondhandMarket setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnSecondhandMarket.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnSecondhandMarket setTag:102];
    [btnSecondhandMarket addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"101.png"]];
    [btnSecondhandMarket addSubview:img];
    [self.view addSubview:btnSecondhandMarket];
    
    
    UIButton *btnHomeEconomics=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnHomeEconomics setFrame:CGRectMake(220, height,BTNWIDTH, BTNHEIGHT)];
    [btnHomeEconomics setBackgroundColor:[UIColor clearColor]];
    [btnHomeEconomics setTitle:@"家政" forState:UIControlStateNormal];
    [btnHomeEconomics setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnHomeEconomics.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnHomeEconomics setTag:102];
    [btnHomeEconomics addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"101.png"]];
    [btnHomeEconomics addSubview:img];
    [self.view addSubview:btnHomeEconomics];
    
    height=btnHomeEconomics.frame.size.height+btnHomeEconomics.frame.origin.y;
    
    UIButton *btnTutor=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnTutor setFrame:CGRectMake(0, height, BTNWIDTH, BTNHEIGHT)];
    [btnTutor setBackgroundColor:[UIColor clearColor]];
    [btnTutor setTitle:@"家教" forState:UIControlStateNormal];
    [btnTutor setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnTutor.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnTutor setTag:101];
    [btnTutor addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
     img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"100.png"]];
    [btnTutor addSubview:img];
    [self.view addSubview:btnTutor];
    
    UIButton *btnHousingTransactions=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnHousingTransactions setFrame:CGRectMake(110, height,BTNWIDTH, BTNHEIGHT)];
    [btnHousingTransactions setBackgroundColor:[UIColor clearColor]];
    [btnHousingTransactions setTitle:@"房屋交易" forState:UIControlStateNormal];
    [btnHousingTransactions setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnHousingTransactions.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnHousingTransactions setTag:102];
    [btnHousingTransactions addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"101.png"]];
    [btnHousingTransactions addSubview:img];
    [self.view addSubview:btnHousingTransactions];
    
    
 
    UIButton *btnViolationQueries=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnViolationQueries setFrame:CGRectMake(220, height,BTNWIDTH, BTNHEIGHT)];
    [btnViolationQueries setBackgroundColor:[UIColor clearColor]];
    [btnViolationQueries setTitle:@"违章查询" forState:UIControlStateNormal];
    [btnViolationQueries setTitleEdgeInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    [btnViolationQueries.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnViolationQueries setTag:102];
    [btnViolationQueries addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(30, 40, 45, 45)];
    [img setImage:[UIImage imageNamed:@"101.png"]];
    [btnViolationQueries addSubview:img];
    [self.view addSubview:btnViolationQueries];
    
    height=btnNumber.frame.size.height+btnNumber.frame.origin.y;
    
*/
    
 
    
}
-(void)selectButton:(UIButton*)sender{
    NSLog(@"s");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
