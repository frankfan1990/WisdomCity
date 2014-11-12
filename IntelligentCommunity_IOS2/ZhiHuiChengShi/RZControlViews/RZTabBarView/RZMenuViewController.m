//
//  RZMenuViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-19.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZMenuViewController.h"
#import "RZinformationViewController.h"
#import "RZIntegralViewController.h"
#import "RZMyorderListViewController.h"
#import "RZSystemInfoListViewController.h"
#import "RZInviteFamilyViewController.h"
#import "RZeelViewController.h"
#import "RZuserConfigViewController.h"
#import "RZUserInfoData.h"
#import "MTLJSONAdapter.h"
@interface RZMenuViewController ()
//@property (strong, readwrite, nonatomic) UITableView *tableView;
@property(nonatomic,retain)UITableView *tableView;

@end

@implementation RZMenuViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"]];
    
    RZUserInfoData *infoData = [RZUserInfoData modelWithDictionary:dict error:nil];

    if (infoData.nickname == nil) {
        infoData.nickname = @"昵称";
    }
    self.viewConttrollersTitle =[NSMutableArray arrayWithArray: @[infoData.nickname,@"我的订单",@"我的积分",@"系统通知",@"邀请家人",@"用后感",@"设置"] ];
    self.viewConttrollersIcon= [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%@%@",hostIP,infoData.headUrl],@"订单未选中2", @"积分选中",@"通知选中",@"邀请选中", @"后感选中",@"设置选中"]];

    
    self.tableView = ({
        NSLog(@"%f %f",self.view.bounds.size.width,self.sideMenuViewController.contentViewInPortraitOffsetCenterX);
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,0,(self.view.bounds.size.width-self.sideMenuViewController.contentViewInPortraitOffsetCenterX*3) , self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    
    if(IOS7){
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
        self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        [view setBackgroundColor:[UIColor clearColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        //            NSDictionary *temp=[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
        
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.viewConttrollersIcon objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@""]];
//        imageView.image = [UIImage imageNamed:self.viewConttrollersIcon[0]];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 1.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor=[ UIColor clearColor];
        UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goInformationView:)];
        imgtap.delegate=self;
        [imageView setUserInteractionEnabled:YES];
        [imageView addGestureRecognizer:imgtap];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = [self.viewConttrollersTitle objectAtIndex:0];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        UITapGestureRecognizer *lbtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goInformationView:)];
        lbtap.delegate=self;
        [label setUserInteractionEnabled:YES];
        [label addGestureRecognizer:lbtap];
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    
//    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage  imageNamed:@"101"]]];
    [self setExtraCellLineHidden:    self.tableView];
    
    [self.view addSubview:self.tableView];
    NSLog(@"Open");
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSString stringWithFormat:@"%d",[[userDefault objectForKey:SYSTEMMESSAGECOUNT]integerValue]+arc4random()%5-1] forKey:SYSTEMMESSAGECOUNT];
    [userDefault synchronize];
    
}


#pragma mark UIGestureRecognizerDelegate
-(void)updateUserImage:(UITapGestureRecognizer*)recognizer{
 
            [self.sideMenuViewController hideMenuViewController];
}

-(void)goInformationView:(UITapGestureRecognizer*)recognizer{
    
    
    if ( [self.sideMenuViewController.contentViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *) self.sideMenuViewController.contentViewController;
        RZinformationViewController *view=[[RZinformationViewController alloc] init];
        view.hidesBottomBarWhenPushed=YES;
        [navigationController pushViewController:view  animated:YES];
    }
    
    else if ([self.sideMenuViewController.contentViewController isKindOfClass:[UITabBarController class]]) {
        __weak UITabBarController *tabBarViewCOntroller = (UITabBarController *)self.sideMenuViewController.contentViewController;
        
        if ([tabBarViewCOntroller.selectedViewController isKindOfClass:[UINavigationController class]]) {
            __weak UINavigationController *navigationController = (UINavigationController *)tabBarViewCOntroller.selectedViewController;
            
                    RZinformationViewController *view=[[RZinformationViewController alloc] init];
            view.hidesBottomBarWhenPushed=YES;
                    [navigationController pushViewController:view  animated:YES];
        }
    }


//
//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[RZinformationViewController alloc] init] ] animated:YES];


    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    cell.textLabel.textAlignment=NSTextAlignmentLeft;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (tableView.frame.size.height-184)/self.viewConttrollersTitle.count-1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.viewConttrollersTitle.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *titles =self.viewConttrollersTitle;
    NSArray *images =self.viewConttrollersIcon;
    cell.textLabel.text = titles[indexPath.row+1];
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",images[indexPath.row+1]]];
//    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
//    if([[userDefault objectForKey:SYSTEMMESSAGECOUNT]integerValue]>0&&indexPath.row==2){
//        UILabel *lbright=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//        lbright.text=[NSString stringWithFormat:@"%@",[userDefault objectForKey:SYSTEMMESSAGECOUNT]];
//        lbright.layer.masksToBounds=YES;
//        lbright.layer.cornerRadius=lbright.frame.size.width/2;
//        lbright.backgroundColor=[UtilCheck getRZColor:255 green:0 blue:0 alpha:1];
//        lbright.textAlignment=NSTextAlignmentCenter;
//        lbright.textColor=[UtilCheck getRZColor:255 green:255 blue:255 alpha:1];
//        cell.accessoryView=lbright;
//    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row+1) {
        case 1:
        {
            if ( [self.sideMenuViewController.contentViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = (UINavigationController *) self.sideMenuViewController.contentViewController;
                RZMyorderListViewController *view=[[RZMyorderListViewController alloc] init];
                view.hidesBottomBarWhenPushed=YES;
                [navigationController pushViewController:view  animated:YES];
            }
            
            else if ([self.sideMenuViewController.contentViewController isKindOfClass:[UITabBarController class]]) {
                __weak UITabBarController *tabBarViewCOntroller = (UITabBarController *)self.sideMenuViewController.contentViewController;
                
                if ([tabBarViewCOntroller.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    __weak UINavigationController *navigationController = (UINavigationController *)tabBarViewCOntroller.selectedViewController;
                    
                    RZMyorderListViewController *view=[[RZMyorderListViewController alloc] init];
                    view.hidesBottomBarWhenPushed=YES;
                    [navigationController pushViewController:view  animated:YES];
                }
            }
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 2:
 
        {
            if ( [self.sideMenuViewController.contentViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = (UINavigationController *) self.sideMenuViewController.contentViewController;
                RZIntegralViewController *view=[[RZIntegralViewController alloc] init];
                view.hidesBottomBarWhenPushed=YES;
                [navigationController pushViewController:view  animated:YES];
            }
            
            else if ([self.sideMenuViewController.contentViewController isKindOfClass:[UITabBarController class]]) {
                __weak UITabBarController *tabBarViewCOntroller = (UITabBarController *)self.sideMenuViewController.contentViewController;
                
                if ([tabBarViewCOntroller.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    __weak UINavigationController *navigationController = (UINavigationController *)tabBarViewCOntroller.selectedViewController;
                    
                    RZIntegralViewController *view=[[RZIntegralViewController alloc] init];
                    view.hidesBottomBarWhenPushed=YES;
                    [navigationController pushViewController:view  animated:YES];
                }
            }
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 3:
            
        {
            if ( [self.sideMenuViewController.contentViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = (UINavigationController *) self.sideMenuViewController.contentViewController;
                RZSystemInfoListViewController *view=[[RZSystemInfoListViewController alloc] init];
                view.hidesBottomBarWhenPushed=YES;
                [navigationController pushViewController:view  animated:YES];
            }
            
            else if ([self.sideMenuViewController.contentViewController isKindOfClass:[UITabBarController class]]) {
                __weak UITabBarController *tabBarViewCOntroller = (UITabBarController *)self.sideMenuViewController.contentViewController;
                
                if ([tabBarViewCOntroller.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    __weak UINavigationController *navigationController = (UINavigationController *)tabBarViewCOntroller.selectedViewController;
                    
                    RZSystemInfoListViewController *view=[[RZSystemInfoListViewController alloc] init];
                    view.hidesBottomBarWhenPushed=YES;
                    [navigationController pushViewController:view  animated:YES];
                }
            }
            [self.sideMenuViewController hideMenuViewController];
        }
           break;
        case 4:
        {
            if ( [self.sideMenuViewController.contentViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = (UINavigationController *) self.sideMenuViewController.contentViewController;
                RZInviteFamilyViewController *view=[[RZInviteFamilyViewController alloc] init];
                view.hidesBottomBarWhenPushed=YES;
                [navigationController pushViewController:view  animated:YES];
            }
            
            else if ([self.sideMenuViewController.contentViewController isKindOfClass:[UITabBarController class]]) {
                __weak UITabBarController *tabBarViewCOntroller = (UITabBarController *)self.sideMenuViewController.contentViewController;
                
                if ([tabBarViewCOntroller.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    __weak UINavigationController *navigationController = (UINavigationController *)tabBarViewCOntroller.selectedViewController;
                    
                    RZInviteFamilyViewController *view=[[RZInviteFamilyViewController alloc] init];
                    view.hidesBottomBarWhenPushed=YES;
                    [navigationController pushViewController:view  animated:YES];
                }
            }
            [self.sideMenuViewController hideMenuViewController];
        }
 
            break;
        case 5:
           
        {
            if ( [self.sideMenuViewController.contentViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = (UINavigationController *) self.sideMenuViewController.contentViewController;
                RZeelViewController *view=[[RZeelViewController alloc] init];
                view.hidesBottomBarWhenPushed=YES;
                [navigationController pushViewController:view  animated:YES];
            }
            
            else if ([self.sideMenuViewController.contentViewController isKindOfClass:[UITabBarController class]]) {
                __weak UITabBarController *tabBarViewCOntroller = (UITabBarController *)self.sideMenuViewController.contentViewController;
                
                if ([tabBarViewCOntroller.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    __weak UINavigationController *navigationController = (UINavigationController *)tabBarViewCOntroller.selectedViewController;
                    
                    RZeelViewController *view=[[RZeelViewController alloc] init];
                    view.hidesBottomBarWhenPushed=YES;
                    [navigationController pushViewController:view  animated:YES];
                }
            }
            [self.sideMenuViewController hideMenuViewController];
        }
            
            
            break;
        case 6:
        {
            if ( [self.sideMenuViewController.contentViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = (UINavigationController *) self.sideMenuViewController.contentViewController;
                RZuserConfigViewController *view=[[RZuserConfigViewController alloc] init];
                view.hidesBottomBarWhenPushed=YES;
                [navigationController pushViewController:view  animated:YES];
            }
            
            else if ([self.sideMenuViewController.contentViewController isKindOfClass:[UITabBarController class]]) {
                __weak UITabBarController *tabBarViewCOntroller = (UITabBarController *)self.sideMenuViewController.contentViewController;
                
                if ([tabBarViewCOntroller.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    __weak UINavigationController *navigationController = (UINavigationController *)tabBarViewCOntroller.selectedViewController;
                    
                    RZuserConfigViewController *view=[[RZuserConfigViewController alloc] init];
                    view.hidesBottomBarWhenPushed=YES;
                    [navigationController pushViewController:view  animated:YES];
                }
            }
            [self.sideMenuViewController hideMenuViewController];
        }
            
           
            break;
       default:
            break;
    }

}



@end
