//
//  RZTabBarController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZTabBarController.h"
#import "RZTagViewController.h"
#import "RZHomeViewController.h"
#import "RZHousekeepViewController.h"
#import "RZPhotographViewController.h"
#import "RZConvenienceViewController.h"
#import "RZTheNeighborsViewController.h"
#import "AFNetworking.h"

@interface RZTabBarController()<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrOfName;
    RZHomeViewController * oneViewController_ ;
    NSString *noteNameStr;
    UITableView *tabView ;
}

@end

@implementation RZTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    if (![item.title isEqualToString:@"随手拍"]) {
        
        UIView *view = (UIView *)[self.view viewWithTag:10000];
        [view removeFromSuperview];
       
    }
    if (item.tag == 99990) {
        noteNameStr = @"tagCtrl0";
    }else if (item.tag == 99991){
        noteNameStr = @"tagCtrl1";
    }else if (item.tag == 99992){
        noteNameStr = @"tagCtrl2";
    }else if (item.tag == 99993){
        noteNameStr = @"tagCtrl3";
    }
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    noteNameStr = @"tagCtrl0";

   
    arrOfName = [NSMutableArray array];
    [self getAllTag];
    
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom-bg"]];
    img.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    img.contentMode = UIViewContentModeScaleToFill;
//    [[self tabBar] insertSubview:img atIndex:0];//底部tabbar 背景图
    [[self tabBar] setBackgroundImage:img.image];
    self.tabBar.autoresizingMask=UIViewAutoresizingNone;
    /*
     ------------
     清除iOS7线底部阴影
     ------------
     
     */
    //高度＝＝49
    //    [self.tabBar setClipsToBounds:YES];
    //    //高度>49
    if (IOS6)
    {
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
    
    /*---------首页-----------*/
    UITabBarItem *MytabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"首页未选中.png"] selectedImage:[UIImage imageNamed:@"首页选中.png"]];
    //MytabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);//不出头使用
    
    MytabBarItem.tag = 99990;
    //设置选中时的图标
    UIImage *selectedImage=[UIImage imageNamed:@"首页选中.png"];
//    if (IOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }

    MytabBarItem.selectedImage =selectedImage;
    
    oneViewController_ = [[RZHomeViewController alloc] initWithNibName:@"RZHomeViewController" bundle:nil];
	oneViewController_.tabBarItem=MytabBarItem;
    
    UINavigationController *oneNav_=[[UINavigationController alloc] initWithRootViewController:oneViewController_];
    oneViewController_=nil;
    
 
    if(IOS7){
        oneNav_.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
       oneNav_.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    
    /*--------管家------------*/
    MytabBarItem =[[UITabBarItem alloc] initWithTitle:@"管家" image:[UIImage imageNamed:@"管家未选中.png"] selectedImage:[UIImage imageNamed:@"管家选中.png"]];
    //MytabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    selectedImage=[UIImage imageNamed:@"管家选中.png"];
//    if (IOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
      MytabBarItem.title = @"管家";
    MytabBarItem.selectedImage =selectedImage;
    
    MytabBarItem.tag = 99991;
	RZHousekeepViewController * Housekeep = [[RZHousekeepViewController alloc] initWithNibName:@"RZHousekeepViewController" bundle:nil];
   	Housekeep.tabBarItem=MytabBarItem;
    
    
    UINavigationController *twoNav_=[[UINavigationController alloc] initWithRootViewController:Housekeep];
 
    if(IOS7){
        twoNav_.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
        twoNav_.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    Housekeep=nil;
    
    
    /*------随手拍----------*/
    selectedImage=[UIImage imageNamed:@"随手拍.png"];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MytabBarItem =[[UITabBarItem alloc] initWithTitle:@"随手拍" image:selectedImage selectedImage:selectedImage];
    MytabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
//    [MytabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"随手拍.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"随手拍.png"]];

//    MytabBarItem.selectedImage =selectedImage;
    [MytabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];


    
    
    
    RZHomeViewController * Photograph = [[RZHomeViewController alloc] initWithNibName:@"RZHomeViewController" bundle:nil];
	Photograph.tabBarItem=MytabBarItem;
    
    
    UINavigationController *sanNav_=[[UINavigationController alloc] initWithRootViewController:Photograph];
    if(IOS7){
        sanNav_.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
        sanNav_.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }

    Photograph=nil;
    /*-------便民---------*/
    MytabBarItem =[[UITabBarItem alloc] initWithTitle:@"便民" image:[UIImage imageNamed:@"便民未选中.png"] selectedImage:[UIImage imageNamed:@"便民选中.png"]];
    //MytabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    selectedImage=[UIImage imageNamed:@"便民选中.png"];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MytabBarItem.selectedImage =selectedImage;
	RZConvenienceViewController * Convenience = [[RZConvenienceViewController alloc] initWithNibName:@"RZConvenienceViewController" bundle:nil];
   	Convenience.tabBarItem=MytabBarItem;
    
    
    UINavigationController *navConvenience=[[UINavigationController alloc] initWithRootViewController:Convenience];
    if(IOS7){
        navConvenience.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
        navConvenience.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    Convenience=nil;
    MytabBarItem.tag = 99992;
    
    /*-------邻居---------*/
    
    MytabBarItem =[[UITabBarItem alloc] initWithTitle:@"邻居" image:[UIImage imageNamed:@"邻居未选中.png"] selectedImage:[UIImage imageNamed:@"邻居选中.png"]];
    //MytabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
     MytabBarItem.tag = 99993;
//    [MytabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"邻居选中.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"邻居未选中.png"]];
    selectedImage=[UIImage imageNamed:@"邻居选中.png"];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MytabBarItem.selectedImage =selectedImage;
    
	RZTheNeighborsViewController * Neighbors = [[RZTheNeighborsViewController alloc] initWithNibName:@"RZTheNeighborsViewController" bundle:nil];
    Neighbors.tabBarItem=MytabBarItem;
    
    UINavigationController *navNeighbors=[[UINavigationController alloc] initWithRootViewController:Neighbors];
    if(IOS7){
        navNeighbors.navigationBar.barTintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    else{
        navNeighbors.navigationBar.tintColor=[UtilCheck getRZColor:77 green:154 blue:240 alpha:1];
    }
    Neighbors=nil;
 
    
    self.viewControllers=@[oneNav_, twoNav_,sanNav_,navConvenience,navNeighbors];
 
    
    oneNav_=nil;
    twoNav_=nil;
    sanNav_=nil;
    navConvenience=nil;
    navNeighbors=nil;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(self.view.frame.size.width/2-29, 0, 58, 51);
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(didbtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.tabBar addSubview:btn];
      
//    LeftView *leftView_=[[LeftView alloc] initWithArray:self.viewControllers];
//    leftView_.delegate=self;
//    [self.view insertSubview:leftView_ atIndex:0];
//    leftView_=nil;
 
}
-(void)getAllTag
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manger POST:[NSString stringWithFormat:@"%@/home/getAllTag",hostIPTwo] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *ditc = responseObject;
        [arrOfName removeAllObjects];
        
        NSMutableDictionary *dddict = [NSMutableDictionary dictionary];
        for (NSDictionary *dictionary in ditc[@"data"][@"items"]) {
            
            [dddict setObject:dictionary[@"id"] forKey:dictionary[@"category"]];
            [arrOfName addObject:dictionary[@"category"]];
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:arrOfName forKey:TAGALLCONTENT];
        [[NSUserDefaults standardUserDefaults] setObject:dddict forKey:@"TagAndId"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        arrOfName = [NSMutableArray array];
        arrOfName = [[NSUserDefaults standardUserDefaults] objectForKey:TAGALLCONTENT];
    }];
    
    
}
-(void)didbtn
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0;
    view.tag = 10000;
    [self.view addSubview:view];
    
    if(arrOfName.count > 5)
    {
        tabView = [[UITableView alloc] initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 5*50+40) style:UITableViewStylePlain];
    }else{
        tabView = [[UITableView alloc] initWithFrame:CGRectMake(10, 110+20*(5-arrOfName.count), self.view.frame.size.width-20, arrOfName.count*50+40) style:UITableViewStylePlain];
    }

    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.alpha = 0;
    tabView.tag = 999;
    
    [self.view addSubview:tabView];
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.3;
        tabView.alpha = 0.9;
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width-20, 45)];
    label.backgroundColor = UIColorFromRGB(0x5496DF);
    label.text = @"  选择标签";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString * cellname = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    cell.textLabel.text = arrOfName[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = @{@"nameStr":arrOfName[indexPath.row]};
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:noteNameStr object:self userInfo:dict];
    [self didTap];
    
////    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tagCtrl];
//      [self presentViewController:nav animated:YES completion:nil];
}



-(void)didTap
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    UIView *view2 = (UIView *)[self.view viewWithTag:999];
    UIView *view3 = (UIView *)[self.navigationController.navigationBar viewWithTag:10001];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:110];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:111];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:10004];
    [UIView animateWithDuration:0.8 animations:^{
        
        [view2 removeFromSuperview];
        [view removeFromSuperview];
        [view3 removeFromSuperview];
        [btn1 removeFromSuperview];
        [btn2 removeFromSuperview];
        [btn3 removeFromSuperview];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self didTap];
}

/*
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)showRootControllOne
{
    [self setSelectedIndex:0];
    
}
-(void)accountForcequit
{
    // [self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    //xmpp登录
    // [[self appDelegate] xmppLogin];
    self.navigationController.navigationBarHidden = YES;
    
    [super viewWillAppear:animated];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
            [self setNoHighlightTabBar:tabBarController];

    }
    else{
            [self setSelectedIndex:0];
        UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"s" message:@"sf" delegate:self cancelButtonTitle:@"S" otherButtonTitles:@"B", nil];
        [al show];

    }

 
}



- (void)setNoHighlightTabBar:(UITabBarController *)tabBarController

{
    NSArray * tabBarSubviews = [tabBarController.tabBar subviews];
    int index4SelView;
    if(tabBarController.selectedIndex+1 > 4)
    {//selected the last tab.
        index4SelView = [tabBarSubviews count]-1;
    }
    else if([tabBarController.viewControllers count] > 5)
    {//have "more" tab. and havn't selected the last tab:"more" tab.
        index4SelView = [tabBarSubviews count] - 5 + tabBarController.selectedIndex;
    }
    else
    {//have no "more" tab.
        index4SelView = [tabBarSubviews count] -
        [tabBarController.viewControllers count] + tabBarController.selectedIndex;
    }
    if([tabBarSubviews count] < index4SelView+1)
    {
        assert(false);
        return;
    }
    UIView * selView = [tabBarSubviews objectAtIndex:index4SelView];
    NSArray * selViewSubviews = [selView subviews];
    for(UIView * v in selViewSubviews)
    {
        if(v && [NSStringFromClass([v class]) isEqualToString:@"RZPhotographViewController"])
            
        {//the v is the highlight view.
            [v removeFromSuperview];
            break;
        }
    }
}

*/



@end
