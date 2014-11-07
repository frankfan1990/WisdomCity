//
//  RZAppDelegate.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-6-17.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZAppDelegate.h"
#import "RZViewController.h"
#import "RZTabBarController.h"
#import "RZMenuViewController.h"
#import "RZRegistrationViewController.h"
#import "RZForgetThePasswordViewController.h"
#import "RZCustomTextField.h"
#import "MMLocationManager.h"
#import "RZRule.h"
#import "UserSignLn.h"
#import "RZDengLuViewController.h"
#define VERSIONID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define SYSTEM_VERSION  [[UIDevice currentDevice] systemVersion]


@implementation RZAppDelegate
{
    UIView *loginView;//登录界面
    UILabel *lb;
    UserSignLn *signLn;
    NSString *str;
}

- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *name   = [NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__];
        NSString *reason = [NSString stringWithFormat:@"请首先配置APIKey.h中的APIKey, 申请APIKey参考见 http://api.amap.com"];
        
        @throw [NSException exceptionWithName:name
                                       reason:reason
                                     userInfo:nil];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}
#pragma mark - Initialization

- (void)initMapView
{
    self.mapView=[[MAMapView alloc] initWithFrame:self.window.bounds];
    
 
    
    self.mapView.delegate = self;
    
    [self.window addSubview:self.mapView];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);//可见区域
    
    self.search=[[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    
    self.search.delegate = self;
}


-(void)userLocation{

//       [self.mapView addObserver:self forKeyPath:@"showsUserLocation" options:NSKeyValueObservingOptionNew context:nil];
            self.mapView.showsUserLocation = YES; //YES 为打开定位，NO为关闭定位
     [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    
}
//#pragma mark - NSKeyValueObservering
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"showsUserLocation"])
//    {
//     
////        NSNumber *showsNum = [change objectForKey:NSKeyValueChangeNewKey];
//        
//        NSLog(@"%@",change);
//    }
//}
#pragma mark - MAMapViewDelegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
      CLLocationCoordinate2D coordinate;
 
    if(userLocation.location!=nil){
        coordinate=userLocation.location.coordinate;
    }
  
        NSLog(@"%f %f",coordinate.latitude,coordinate.longitude);
//        self.mapView.showsUserLocation=NO;
        AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
        regeoRequest.searchType = AMapSearchType_ReGeocode;
        regeoRequest.location=[AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        regeoRequest.radius = 5000;//搜索范围
        regeoRequest.requireExtension = NO;//是否返回全部
        
        [self.search AMapReGoecodeSearch: regeoRequest];
 
    
}


// 继承了 MASearchDelegate 的类里，通过实现方法来接收和处理查询结果。 request 经纬度 范围  response 详细信息
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
 
    NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
 
 
   result=[NSString stringWithFormat:@"当前经纬度：%f %f  省:%@ 市:%@ 区:%@ 街道:%@ 附近：%@ 建筑:%@ 市号:%@ 路号:%@ 路:%@ 小区号:%@ 经纬度:%@  距离:%ld 方向:%@  ",request.location.latitude,request.location.longitude,response.regeocode.addressComponent.province,
            response.regeocode.addressComponent.city,
           response.regeocode.addressComponent.district,
           response.regeocode.addressComponent.township,
           response.regeocode.addressComponent.neighborhood,
           response.regeocode.addressComponent.building,
           response.regeocode.addressComponent.citycode,
           response.regeocode.addressComponent.adcode,
           response.regeocode.addressComponent.streetNumber.street,
           response.regeocode.addressComponent.streetNumber.number,
           response.regeocode.addressComponent.streetNumber.location,
           (long)response.regeocode.addressComponent.streetNumber.distance,
           response.regeocode.addressComponent.streetNumber.direction];
//    if(lb==nil){
//     lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 410, 320, 90)];
//    }
//    lb.font=[UIFont systemFontOfSize:12.0f];
//    lb.numberOfLines=5;
//    lb.text=result;
//    lb.textColor=[UtilCheck getRZColor:arc4random()%255 green:arc4random()%255 blue:arc4random()%255 alpha:1];
//    lb.backgroundColor=[UIColor grayColor];
//    [self.window insertSubview:lb atIndex:99999];
//            self.mapView.showsUserLocation=YES;
}

//定位获取失败时的回调函数
-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
{
        self.mapView.showsUserLocation = YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[MMLocationManager shareLocation] getCity:^(NSString *addressString) {
        str = [addressString description];
    }];
    /*
     =================
     高德定位服务
     =================
     [self configureAPIKey];
     [self initMapView];
     [self userLocation];
     */
 
    
    /*
     ================
     启动隐藏状态栏  首先要在plist 中设置key Status bar is initially hidden    设置YES
     ================
     */
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    /*
     ================
     修改状态栏色彩  首先要在plist 中添加key View controller-based status bar appearance   设置NO
     ================
     */
    [[UIApplication sharedApplication ] setStatusBarHidden:NO];
    [[UIApplication sharedApplication ] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    signLn = [[UserSignLn alloc] init];
    
    
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor grayColor]];
    
    UIImageView *image=[[UIImageView alloc] init];
    if([UIScreen mainScreen].bounds.size.height==480){
        [image setImage:[UIImage imageNamed:@"Default@2x"]];
    }
    else
    {
        [image setImage:[UIImage imageNamed:@"Default-568h@2x"]];
    }
    [image setBackgroundColor:[UIColor clearColor]];
    [image setFrame:[UIScreen mainScreen].bounds];
 
    [self.window addSubview:image];//底图

    
    
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc] init];
    NSUserDefaults *UserDefault = [NSUserDefaults standardUserDefaults];
    
    
    //第一次进入应用   保存应用版本
    if([UserDefault objectForKey:VERSIONIDSERVER]==nil||[[[UserDefault objectForKey:VERSIONIDSERVER] objectForKey:@"SYSTEM_VERSIONID"] isEqualToString:@""]||[[[UserDefault objectForKey:VERSIONIDSERVER] objectForKey:@"VERSIONID"] isEqualToString:@"VERSIONID"]){
        [userDictionary setObject:[NSString stringWithFormat:@"%@",VERSIONID] forKey:@"VERSIONID"];
        [userDictionary setObject:[NSString stringWithFormat:@"%@",SYSTEM_VERSION] forKey:@"SYSTEM_VERSIONID"];
        [UserDefault setObject:userDictionary  forKey:VERSIONIDSERVER];
        [UserDefault setObject:[NSString stringWithFormat:@"%d",0] forKey:SYSTEMMESSAGECOUNT];//第一次使用应用 初始化系统消息为0
        [UserDefault synchronize];
       //第一次使用 从未加载引导页
        if([UserDefault objectForKey:START]==nil||[[UserDefault objectForKey:START] isEqualToString:@"YES"]){
 
            [UserDefault setObject:@"NO" forKey:START];
            [UserDefault synchronize];
            
            RZViewController *view=[[RZViewController alloc] init];
            view.IsStart=YES;//说明首次加载app
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:view];
            if(IOS7){
            nav.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
            }
            else{
             nav.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
            }
            nav.navigationBarHidden=YES;
            self.window.rootViewController=nav;
            
        }
        else
        {
            [self goInfo:NO];
        }
 
    }
    else
    {
        [self goInfo:NO];
    }
    /*  此部分用于企业版本更新判断 上架则不需要
    else{
 
        NSString * currentVersion = [NSString stringWithFormat:@"%@",VERSIONID];//系统版本
        NSString * oldVersion =[NSString stringWithFormat:@"%@",[[UserDefault objectForKey:VERSIONIDSERVER] objectForKey:@"VERSIONID"]];//存储版本
        
        if(![oldVersion isEqualToString:currentVersion])
        {
            //用户更新了版本 强制注销账户
            
            userDictionary=[NSMutableDictionary dictionaryWithDictionary:[UserDefault objectForKey:VERSIONIDSERVER]];
            [userDictionary setObject:[NSString stringWithFormat:@"%@",VERSIONID] forKey:@"VERSIONID"];
            [userDictionary setObject:[NSString stringWithFormat:@"%@",SYSTEM_VERSION] forKey:@"SYSTEM_VERSIONID"];
            [UserDefault setObject:userDictionary forKey:VERSIONIDSERVER];
            [UserDefault setObject:@"YES" forKey:START];//引导页重新启动
 
            [UserDefault synchronize]; //同步
            
            [self  clearUserInfos];
            
            
        }
        else{
            if([UserDefault objectForKey:START]==nil||[[UserDefault objectForKey:START] isEqualToString:@"YES"]){
                
                [UserDefault setObject:@"NO" forKey:START];
                [UserDefault synchronize];
                
                RZViewController *view=[[RZViewController alloc] init];
                view.IsStart=YES;//说明首次加载app
                UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:view];
                if(IOS7){
                    nav.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
                }
                else{
                    nav.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
                }
                nav.navigationBarHidden=YES;
                self.window.rootViewController=nav;
                
            }
            else
            {
                [self goInfo:NO];
            }
        }
        
    }
    */
 

 [self.window makeKeyAndVisible];
 
 
    return YES;
}
//清理临时存储信息
-(void)clearUserInfos
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFO];//清理用户信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERISLOGIN];//清理用户信息
    
 
    [SVProgressHUD showWithStatus:@"版本更新,请重启程序" maskType:SVProgressHUDMaskTypeBlack];
    [self performSelector:@selector(goNewApp) withObject:self afterDelay:2.0];
 
    
}
//重新加载应用
-(void)goNewApp{
    [SVProgressHUD dismiss];
    NSUserDefaults *UserDefault = [NSUserDefaults standardUserDefaults];   //保存用户信息
    
    if([UserDefault objectForKey:START]==nil||[[UserDefault objectForKey:START] isEqualToString:@"YES"]){
               self.window.rootViewController=nil;
        [UserDefault setObject:@"NO" forKey:START];
        [UserDefault synchronize];
        
        RZViewController *view=[[RZViewController alloc] init];
        view.IsStart=YES;//说明首次加载app
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:view];
        if(IOS7){
            nav.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
        }
        else{
            nav.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
        }
        nav.navigationBarHidden=YES;
        self.window.rootViewController=nav;
        
    }
    else
    {
        [self goInfo:NO];
    }

 
}

//删除临时文件 释放容量
-(void)DeleteCachesFile
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:AppVideo error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        //        if ([[filename pathExtension] isEqualToString:@"mov"]) {
        
        [fileManager removeItemAtPath:[AppVideo stringByAppendingPathComponent:filename] error:NULL];
        //        }
    }
    
    contents = [fileManager contentsOfDirectoryAtPath:AppImage error:NULL];
    e = [contents objectEnumerator];
    
    while ((filename = [e nextObject])) {
        
        //        if ([[filename pathExtension] isEqualToString:@"mov"]) {
        
        [fileManager removeItemAtPath:[AppImage stringByAppendingPathComponent:filename] error:NULL];
        //        }
    }
    
    contents = [fileManager contentsOfDirectoryAtPath:AppMusice error:NULL];
    e = [contents objectEnumerator];
    
    while ((filename = [e nextObject])) {
        
        //        if ([[filename pathExtension] isEqualToString:@"mov"]) {
        
        [fileManager removeItemAtPath:[AppMusice stringByAppendingPathComponent:filename] error:NULL];
        //        }
    }
    
}


//Visitor 是否游客登录 游客直接登录
-(void)goInfo:(BOOL)Visitor{
    /*
     ---------------------------
     底部选项卡
     ---------------------------
     */
    if([self IsLogin]||Visitor) {
        self.window.rootViewController = nil;
        RZTabBarController *tabBarController =[[RZTabBarController alloc]init];
 
 
        RZMenuViewController *leftMenuViewController = [[RZMenuViewController alloc] init];
//        DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:tabBarController
                    leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
        
        sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Default@2x"];//侧边背景
        sideMenuViewController.menuPreferredStatusBarStyle =1; // UIStatusBarStyleLightContent
        sideMenuViewController.delegate = self;
        sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
        sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
        sideMenuViewController.contentViewShadowOpacity = 0.9;//透明度
        sideMenuViewController.contentViewShadowRadius = 12;//阴影半径
        sideMenuViewController.contentViewShadowEnabled = YES;//是否开启阴影
        sideMenuViewController.contentViewScaleValue=1.0f;//缩小倍数 0-1   0 最小
        sideMenuViewController.scaleMenuView=NO;//消除缩放效果
        sideMenuViewController.fadeMenuView=0.0f;// 消除渐变效果
        sideMenuViewController.contentViewInPortraitOffsetCenterX=45.0f;//右边距离  有待自己去探究
        self.window.rootViewController = sideMenuViewController;
        self.window.backgroundColor = [UIColor whiteColor];

    }
    else{
        //创建 登录界面
        loginView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [loginView setBackgroundColor:[UIColor clearColor]];
        loginView.tag=9999;
        
        UIImageView *image=[[UIImageView alloc] init];
        if([UIScreen mainScreen].bounds.size.height==480){
           [image setImage:[UIImage imageNamed:@"Default@2x"]];
        }
        else
        {
            [image setImage:[UIImage imageNamed:@"Default-568h@2x"]];
        }

        [image setBackgroundColor:[UIColor clearColor]];
        [image setFrame:[UIScreen mainScreen].bounds];
        [loginView addSubview:image];
        RZDengLuViewController *v= [[RZDengLuViewController alloc] init];
        v.view=loginView;
        self.window.rootViewController=v;
 
        
        CGFloat height=218.0f;//绘制控件初始高度
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        [temp setObject:@"" forKey:@"userNumber"];
        [temp setObject:@"" forKey:@"userPassWord"];
        
 
        //注册后返回
        if([[NSUserDefaults standardUserDefaults] objectForKey:REGISTRATION]!=nil&&[[[NSUserDefaults standardUserDefaults] objectForKey:REGISTRATION] objectForKey:@"userNumber"]!=nil){
 
            NSDictionary *t=[[NSUserDefaults standardUserDefaults] objectForKey:REGISTRATION];
  
            [temp setObject:[t objectForKey:@"userNumber"]  forKey:@"userNumber"];
            [temp setObject:[t objectForKey:@"userPassWord"] forKey:@"userPassWord"];
        }
        
        RZCustomTextField * txtUserNumber = [[RZCustomTextField alloc] initWithFrame:CGRectMake(30, height, 260, 40)];
        txtUserNumber.placeholder = @"请输入手机号码";
        txtUserNumber.borderStyle = UITextBorderStyleNone;
        txtUserNumber.textAlignment = NSTextAlignmentLeft;
        txtUserNumber.delegate = self;
        txtUserNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtUserNumber.text =[temp objectForKey:@"userNumber"];
        txtUserNumber.tag=101;
        UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"手机号.png"]];
        txtUserNumber.leftView = imgv;
        txtUserNumber.returnKeyType=UIReturnKeyDone;
        txtUserNumber.leftViewMode = UITextFieldViewModeAlways;
        txtUserNumber.backgroundColor=[UtilCheck getRZColor:17 green:97 blue:175 alpha:1];
        txtUserNumber.textColor=[UIColor whiteColor];
        
        [loginView addSubview:txtUserNumber];
        height=txtUserNumber.frame.size.height+txtUserNumber.frame.origin.y+8;
        
        RZCustomTextField * txtUserPWD = [[RZCustomTextField alloc] initWithFrame:CGRectMake(30, height, 260, 40)];
        txtUserPWD.placeholder = @"密码";
        txtUserPWD.borderStyle = UITextBorderStyleNone;
        txtUserPWD.textAlignment = NSTextAlignmentLeft;
        txtUserPWD.delegate = self;
        txtUserPWD.secureTextEntry=YES;
        txtUserPWD.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtUserPWD.text =[temp objectForKey:@"userPassWord"];
        txtUserPWD.tag=102;
        UIImageView *imgP = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码.png"]];
        txtUserPWD.leftView = imgP;
        txtUserPWD.returnKeyType=UIReturnKeyDone;
        txtUserPWD.leftViewMode = UITextFieldViewModeAlways;
        txtUserPWD.backgroundColor=[UtilCheck getRZColor:17 green:97 blue:175 alpha:1];
        txtUserPWD.textColor=[UIColor whiteColor];
        
        [loginView addSubview:txtUserPWD];
        height=txtUserPWD.frame.size.height+txtUserPWD.frame.origin.y+28;
        
        
        UIButton *btnLogin=[UIButton buttonWithType:UIButtonTypeCustom];
        btnLogin.tag = 123456;
        [btnLogin setFrame:CGRectMake(30, height, 260, 40)];
        [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [btnLogin setBackgroundColor:[UtilCheck getRZColor:75 green:198 blue:31 alpha:1]];
        [btnLogin.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
        [btnLogin setTitleColor:[UtilCheck getRZColor:255 green:255 blue:255 alpha:1] forState:UIControlStateNormal];
        
        [btnLogin addTarget:self action:@selector(logoinDate:) forControlEvents:UIControlEventTouchUpInside];
        btnLogin.layer.masksToBounds=YES;
        btnLogin.layer.cornerRadius=10;
        [loginView addSubview:btnLogin];
        
        if(IOS7)
        {
             height=[UIScreen mainScreen].bounds.size.height-80;
        }
        else{
             height=[UIScreen mainScreen].bounds.size.height-100;
        }
        UIButton *btnRegister=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnRegister setFrame:CGRectMake(30, height, 130, 30)];
        [btnRegister setTitle:@"立即注册" forState:UIControlStateNormal];
        [btnRegister setBackgroundColor:[UtilCheck getRZColor:0 green:0 blue:0 alpha:0]];
        [btnRegister.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [btnRegister setTitleColor:[UtilCheck getRZColor:255 green:255 blue:255 alpha:1] forState:UIControlStateNormal];
        [btnRegister addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
        [loginView addSubview:btnRegister];
        
        UIButton *btnForgotPWD=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnForgotPWD setFrame:CGRectMake(160, height, 130, 30)];
        [btnForgotPWD setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [btnForgotPWD setBackgroundColor:[UtilCheck getRZColor:0 green:0 blue:0 alpha:0]];
        [btnForgotPWD.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [btnForgotPWD setTitleColor:[UtilCheck getRZColor:255 green:255 blue:255 alpha:1] forState:UIControlStateNormal];
        [btnForgotPWD addTarget:self action:@selector(userForgotPWD:) forControlEvents:UIControlEventTouchUpInside];
        [loginView addSubview:btnForgotPWD];
        
        UILabel *lbline=[[UILabel alloc] initWithFrame:CGRectMake(159.5, height+6, 1, 18)];
        [lbline setBackgroundColor:[UtilCheck getRZColor:255 green:255 blue:255 alpha:1]];
        [loginView addSubview:lbline];
        if(IOS7)
        {
        height=[UIScreen mainScreen].bounds.size.height-42;
        }
        else{
                    height=[UIScreen mainScreen].bounds.size.height-62;
        }
        UIButton *btnVisitor=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnVisitor setFrame:CGRectMake(120, height, 80, 30)];
        [btnVisitor setTitle:@"游客" forState:UIControlStateNormal];
        [btnVisitor setBackgroundColor:[UtilCheck getRZColor:0 green:0 blue:0 alpha:0]];
        [btnVisitor.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:22.0f]];
        [btnVisitor setTitleColor:[UtilCheck getRZColor:255 green:255 blue:255 alpha:1] forState:UIControlStateNormal];
        [btnVisitor addTarget:self action:@selector(userVisitorD:) forControlEvents:UIControlEventTouchUpInside];
        [loginView addSubview:btnVisitor];
        
        
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        [loginView addGestureRecognizer:singleTap];
        
            if([UIScreen mainScreen].bounds.size.height==480){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
            }
        //       [txtUserNumber setValue:[UIColor colorWithRed:118/255.0 green:188/255.0 blue:155/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        
        
    }
}


#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

#pragma mark Login
//判断用户是否登录
-(BOOL)IsLogin{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if([user objectForKey:USERISLOGIN]!=nil&&[[user objectForKey:USERISLOGIN] isEqualToString:@"YES"]){
        return YES;
    }
    else{
        [user setObject:@"NO" forKey:USERISLOGIN];
        [user synchronize];
        return NO;
    }
}
#pragma mark - 登录按钮
-(void)logoinDate:(UIButton*)sender{
    
    [self Ext];
    sender.enabled=NO;
    NSString *msg=nil;
    NSString *userNumber=nil;
    NSString *UserPassWord=nil;
    for(UITextField *txtfile in [loginView subviews]){
        if([txtfile isKindOfClass:[RZCustomTextField class]]&&txtfile.tag==101){
            userNumber=txtfile.text;
        }
        if([txtfile isKindOfClass:[RZCustomTextField class]]&&txtfile.tag==102){
            UserPassWord=txtfile.text;
        }
    }
    if([userNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet ]].length<1){
        msg=@"请您输入你的手机号";
    }
    else if (!isValidatePhone([userNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet ]])) {
        msg = @"请输入正确的手机号码";
    }
    else if([UserPassWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet ]].length<1){
        msg=@"请输入密码";
    }
    
    
    
    if(msg==nil){
 
        signLn.urlstr = [NSString stringWithFormat:@"%@signIn/userSignIn",hostIPTwo];
        signLn.paramter = @{@"phoneNumber":userNumber,@"passWord":UserPassWord};
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Success:) name:@"succ" object:signLn];
        [signLn getData];
        [SVProgressHUD showWithStatus:@"登录中" maskType:SVProgressHUDMaskTypeBlack];
        
        
        
//        [self performSelector:@selector(openBtn:) withObject:sender afterDelay:1.5];
        
    }
    else{
           sender.enabled=YES;
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [aler show];
    }
}
-(void)Success:(NSNotification *)notification
{
    UIButton *btn = (UIButton *)[loginView viewWithTag:123456];
    NSDictionary *dict = notification.userInfo;
    if ([dict[@"success"] intValue] == 1) {
        NSDictionary *dict1 = dict[@"data"][@"items"][0];
    [NSKeyedArchiver archiveRootObject:dict1 toFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"]];
        
        
        [self performSelector:@selector(openBtn:) withObject:btn afterDelay:0.5];
    }else{
    
        [SVProgressHUD dismiss];
        btn.enabled=YES;

    }

}

-(void)openBtn:(UIButton*)sender{
    [SVProgressHUD dismiss];
    sender.enabled=YES;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:@"YES" forKey:USERISLOGIN];
    [user synchronize];
    [self goInfo:NO];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.tag==101){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length >11) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:10],string];
            
            return NO;
            
        }
        return YES;
    }
    else if(textField.tag==102){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 20) {
            
            textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:19],string];
            
            return NO;
            
        }
        return YES;
    }
        return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
-(void)userRegister:(UIButton*)sender{
    
    [self Ext];
    self.window.rootViewController=nil;
    RZRegistrationViewController *view=[[RZRegistrationViewController alloc] initWithNibName:@"RZRegistrationViewController" bundle:nil];
    view.cityStr = str;
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:view];
    if(IOS7){
        nav.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        nav.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
 
     view = nil;
     self.window.rootViewController=nav;
    
    
}
-(void)userForgotPWD:(UIButton*)sender{
    
    [self Ext];
  RZForgetThePasswordViewController  *view=[[RZForgetThePasswordViewController alloc] initWithNibName:@"RZForgetThePasswordViewController" bundle:nil];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:view];
    if(IOS7){
        nav.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
    else{
        nav.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
    }
 
    view = nil;
    self.window.rootViewController=nav;
    
}
-(void)userVisitorD:(UIButton*)sender{
    
    [self Ext];
    [self goInfo:YES];
    
}
-(void)Ext{
    for(UIView *view in [loginView subviews]){
        if([view isFirstResponder]){
            [view resignFirstResponder];
        }
    }
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self Ext];
}
static float Keytopy=0.0f;
//缩短uitableview 滑动
-(void)keyBoardShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
   CGSize  size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    if(Keytopy==0)
    {
      Keytopy=[[info objectForKey:UIKeyboardCenterBeginUserInfoKey] CGPointValue].y/2;
    }

    if([UIScreen mainScreen].bounds.size.height==480){
        [UIView animateWithDuration:0.5 animations:^{
            [loginView   setFrame:CGRectMake(loginView.frame.origin.x,-(Keytopy+40+size.height-[UIScreen mainScreen].bounds.size.height), loginView.frame.size.width, loginView.frame.size.height)];
        }];
        
    }
    
    
    //    [_tableview setContentOffset:CGPointMake(0, size.height)];
}
//还原
-(void)keyBoardHide:(NSNotification *)note{
    [UIView animateWithDuration:0.5 animations:^{
        [loginView   setFrame:CGRectMake(loginView.frame.origin.x,0, loginView.frame.size.width, loginView.frame.size.height)];
    }];
 
}


#pragma mark - myself 定位

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
