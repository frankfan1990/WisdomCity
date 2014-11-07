//
//  RZTabBarController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZTabBarController.h"

#import "RZHomeViewController.h"
#import "RZHousekeepViewController.h"
#import "RZPhotographViewController.h"
#import "RZConvenienceViewController.h"
#import "RZTheNeighborsViewController.h"


@interface RZTabBarController()<UITabBarDelegate>
{
    
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
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    
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
    
    
    //设置选中时的图标
    UIImage *selectedImage=[UIImage imageNamed:@"首页选中.png"];
//    if (IOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }

    MytabBarItem.selectedImage =selectedImage;
    
    RZHomeViewController * oneViewController_ = [[RZHomeViewController alloc] initWithNibName:@"RZHomeViewController" bundle:nil];
	oneViewController_.tabBarItem=MytabBarItem;
    
    UINavigationController *oneNav_=[[UINavigationController alloc] initWithRootViewController:oneViewController_];
    oneViewController_=nil;
    
 
    if(IOS7){
        oneNav_.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        oneNav_.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
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
    
	RZHousekeepViewController * Housekeep = [[RZHousekeepViewController alloc] initWithNibName:@"RZHousekeepViewController" bundle:nil];
   	Housekeep.tabBarItem=MytabBarItem;
    
    
    UINavigationController *twoNav_=[[UINavigationController alloc] initWithRootViewController:Housekeep];
 
    if(IOS7){
        twoNav_.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        twoNav_.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
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
        sanNav_.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        sanNav_.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
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
        navConvenience.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        navConvenience.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    Convenience=nil;
    
    /*-------邻居---------*/
    
    MytabBarItem =[[UITabBarItem alloc] initWithTitle:@"邻居" image:[UIImage imageNamed:@"邻居未选中.png"] selectedImage:[UIImage imageNamed:@"邻居选中.png"]];
    //MytabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
//    [MytabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"邻居选中.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"邻居未选中.png"]];
    selectedImage=[UIImage imageNamed:@"邻居选中.png"];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MytabBarItem.selectedImage =selectedImage;
    
	RZTheNeighborsViewController * Neighbors = [[RZTheNeighborsViewController alloc] initWithNibName:@"RZTheNeighborsViewController" bundle:nil];
    Neighbors.tabBarItem=MytabBarItem;
    
    UINavigationController *navNeighbors=[[UINavigationController alloc] initWithRootViewController:Neighbors];
    if(IOS7){
        navNeighbors.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        navNeighbors.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
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
-(void)didbtn
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0;
    view.tag = 10000;
    [self.view addSubview:view];

    UIButton *btnshoot = [UIButton buttonWithType:UIButtonTypeSystem];
    btnshoot.frame = CGRectMake(8, 190, self.view.frame.size.width-16, 55);
    btnshoot.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"拍照.png"]];
    imageView1.frame = CGRectMake(8, 5, 45, 45);
    [btnshoot addSubview:imageView1];
    [self.view addSubview:btnshoot];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 190+54, self.view.frame.size.width-16, 2)];
    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:lineView];
    
    
    
    UIButton *btnpicture = [UIButton buttonWithType:UIButtonTypeSystem];
    btnpicture.frame = CGRectMake(8, 190+55, self.view.frame.size.width-16, 55);
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"相册拿.png"]];
    imageView2.frame = CGRectMake(8, 5, 45, 45);
    [btnpicture addSubview:imageView2];
    [self.view addSubview:btnpicture];
    btnpicture.backgroundColor = [UIColor whiteColor];
   
    btnshoot.tag = 111;
    btnpicture.tag = 110;
    lineView.tag = 999;
    
    btnshoot.alpha = 0;
    btnpicture.alpha = 0;
    lineView.alpha = 0;
    
    [btnpicture setTitle:@"相册选取                           " forState:UIControlStateNormal];
    [btnshoot setTitle:@"拍照                                " forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.8;
        btnshoot.alpha = 1;
        btnpicture.alpha = 1;
        lineView.alpha = 1;
    }];
    
}
-(void)didTap
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    [view removeFromSuperview];
    
    UIView *view1 = (UIView *)[self.view viewWithTag:999];
    [view1 removeFromSuperview];
    
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:111];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:110];
    [btn1 removeFromSuperview];
    [btn2 removeFromSuperview];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
