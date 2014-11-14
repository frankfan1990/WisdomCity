//
//  RZHousekeepViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark 我的  管家
#import "RZHousekeepViewController.h"
#import "RESideMenu.h"
#import "RZTagViewController.h"
#import "RZComplaintsListViewController.h"
#import "RZRepairListViewController.h"

#import "RZKeepMessageListViewController.h"
#import "RZRecognitionViewController.h"

@interface RZHousekeepViewController ()
{
 
}
@end

@implementation RZHousekeepViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            self.title = NSLocalizedString(@"", @"");
 
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"管家";
     [label setFont:[UIFont systemFontOfSize:20]];
//    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    if(arc4random()%2==1){
        [self onlyHouseKeep];
    }
    else{
         [self noOnlyHouseKeep];
    }
 
}
-(void)showMeun{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTagCtrl:) name:@"tagCtrl1" object:nil];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    {
        [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
        [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];;
        [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 
        [btnLeft setBackgroundImage:[UIImage imageNamed:@"面包按钮.png"] forState:UIControlStateNormal];
       [btnLeft setBackgroundImage:[UIImage imageNamed:@"面包按钮.png"] forState:UIControlStateHighlighted];
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
        
        
    }
 
 
 
    // Do any additional setup after loading the view from its nib.
}


-(void)push:(UIButton *)sender{

    if(sender.tag==101)
    {
         RZComplaintsListViewController *view=[[RZComplaintsListViewController alloc] initWithNibName:@"RZComplaintsListViewController" bundle:nil];
        view.hidesBottomBarWhenPushed = YES;
        [ self.navigationController pushViewController:view animated:YES ];
        
    }
    else if(sender.tag==102){
        RZRecognitionViewController *view=[[RZRecognitionViewController alloc] initWithNibName:@"RZRecognitionViewController" bundle:nil];
        view.hidesBottomBarWhenPushed = YES;
        [ self.navigationController pushViewController:view animated:YES ];
        
    }
    else if(sender.tag==103){
        RZRepairListViewController *view=[[RZRepairListViewController alloc] initWithNibName:@"RZRepairListViewController" bundle:nil];
        view.hidesBottomBarWhenPushed = YES;
        [ self.navigationController pushViewController:view animated:YES ];
   
    }
    else if(sender.tag==104){
        RZRepairListViewController *view=[[RZRepairListViewController alloc] initWithNibName:@"RZRepairListViewController" bundle:nil];
        view.hidesBottomBarWhenPushed = YES;
        [ self.navigationController pushViewController:view animated:YES ];
        
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)claneer{
    [[self.view subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
-(void)onlyHouseKeep{
    [self claneer];
     [self drawView:100.0f];
 
}

-(void) noOnlyHouseKeep{
      [self claneer];
    
    [self drawView:100.0f];
    
}
-(void)drawView:(CGFloat)height{
    if(height>10.0f){
        UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
        [topview setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *btntop=[UIButton buttonWithType:UIButtonTypeCustom];
        [btntop setFrame:CGRectMake(0, 0, 320, 90)];
            [btntop setBackgroundColor:[UIColor clearColor]];
        [btntop addTarget:self action:@selector(goMessageList:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(19, 21, 28, 28)];
        [img setImage:[UIImage imageNamed:@"喇叭.png"]];
        [topview addSubview:img];
        
        UILabel *lbTitle=[[UILabel alloc] initWithFrame:CGRectMake(2, 43, 60, 30)];
        lbTitle.font=[UIFont systemFontOfSize:15.0f];
        lbTitle.text=@"公告";
        lbTitle.textAlignment=NSTextAlignmentCenter;
        lbTitle.textColor=[UIColor colorWithRed:83/255.0f green:83/255.0f blue:83/255.0f alpha:1];
        [lbTitle setBackgroundColor:[UIColor clearColor]];
        [topview addSubview:lbTitle];
        
        UILabel *lbSubitle=[[UILabel alloc] initWithFrame:CGRectMake(65, 18, 120, 12)];
        lbSubitle.font=[UIFont systemFontOfSize:12.0f];
        lbSubitle.text=@"2014-05-11 125:30";
        lbSubitle.textAlignment=NSTextAlignmentLeft;
        lbSubitle.textColor=[UIColor colorWithRed:148/255.0f green:148/255.0f blue:148/255.0f alpha:1];
        [lbSubitle setBackgroundColor:[UIColor clearColor]];
        [topview addSubview:lbSubitle];
        
        
        UILabel *lbcontent=[[UILabel alloc] initWithFrame:CGRectMake(65, 24, 242, 60)];
        lbcontent.font=[UIFont systemFontOfSize:14.0f];
        lbcontent.text=@"碧桂园小区12栋、13栋、14栋定于5月18日召开发布会，请广大业主积极参与";
        lbcontent.textAlignment=NSTextAlignmentLeft;
        lbcontent.numberOfLines=2;
        lbcontent.textColor=[UIColor colorWithRed:83/255.0f green:83/255.0f blue:83/255.0f alpha:1];
        [lbcontent setBackgroundColor:[UIColor clearColor]];
        [topview addSubview:lbcontent];
        [topview addSubview:btntop];
        [self.view addSubview:topview];
        
    }
    UIButton *btnComplaints=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnComplaints setFrame:CGRectMake(0, height, 159.5, 115)];
    [btnComplaints setBackgroundColor:[UIColor whiteColor]];
    [btnComplaints setTitle:@"投诉物业" forState:UIControlStateNormal];
    [btnComplaints setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btnComplaints.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnComplaints setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnComplaints setTag:101];
    [btnComplaints addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(54, 22, 45, 45)];
    [img setImage:[UIImage imageNamed:@"投诉物业.png"]];
    [btnComplaints addSubview:img];
    [self.view addSubview:btnComplaints];
    
    UIButton *btnRecognition=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRecognition setFrame:CGRectMake(160.5, height, 159.5, 115)];
    [btnRecognition setBackgroundColor:[UIColor whiteColor]];
    [btnRecognition setTitle:@"表扬物业" forState:UIControlStateNormal];
    [btnRecognition setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btnRecognition.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnRecognition setTag:102];
    [btnRecognition setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnRecognition addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(54, 22, 45, 45)];
    [img setImage:[UIImage imageNamed:@"表扬物业.png"]];
    [btnRecognition addSubview:img];
    [self.view addSubview:btnRecognition];
    height=btnRecognition.frame.size.height+btnRecognition.frame.origin.y+2;
    
    
    UIButton *btnHousingRepair=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnHousingRepair setFrame:CGRectMake(0, height, 159.5, 115)];
    [btnHousingRepair setBackgroundColor:[UIColor whiteColor]];
    [btnHousingRepair setTitle:@"房屋报修" forState:UIControlStateNormal];
    [btnHousingRepair setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnHousingRepair setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btnHousingRepair.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnHousingRepair setTag:103];
    [btnHousingRepair addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(54, 22, 45, 45)];
    [img setImage:[UIImage imageNamed:@"房屋报修.png"]];
    [btnHousingRepair addSubview:img];
    [self.view addSubview:btnHousingRepair];
    
    UIButton *btnIntelligentHomeFurnishing=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnIntelligentHomeFurnishing setFrame:CGRectMake(160.5, height, 159.5, 115)];
    [btnIntelligentHomeFurnishing setBackgroundColor:[UIColor whiteColor]];
    [btnIntelligentHomeFurnishing setTitle:@"智能家居" forState:UIControlStateNormal];
    [btnIntelligentHomeFurnishing setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnIntelligentHomeFurnishing setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    [btnIntelligentHomeFurnishing.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [btnIntelligentHomeFurnishing setTag:104];
    [btnIntelligentHomeFurnishing addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    img=[[UIImageView alloc] init];
    [img setFrame:CGRectMake(54, 22, 45, 45)];
    [img setImage:[UIImage imageNamed:@"智能家居.png"]];
    [btnIntelligentHomeFurnishing addSubview:img];
    [self.view addSubview:btnIntelligentHomeFurnishing];
}


-(void)goMessageList:(UIButton*)sender{
    RZKeepMessageListViewController *view=[[RZKeepMessageListViewController alloc] initWithNibName:@"RZKeepMessageListViewController" bundle:nil];
    view.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:view animated:YES];
}
-(void)selectButton:(UIButton*)sender{
    [self push:sender];
    NSLog(@"s");
}
-(void)pushTagCtrl:(NSNotification *)note
{
    RZTagViewController *tagCtrl = [[RZTagViewController alloc] init];
    tagCtrl.labelName = note.userInfo[@"nameStr"];
    tagCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagCtrl animated:YES];
}

@end
