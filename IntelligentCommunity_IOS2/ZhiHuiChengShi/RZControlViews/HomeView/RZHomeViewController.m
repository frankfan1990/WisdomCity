//
//  RZHomeViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-18.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//



#pragma mark 进来的界面  主界面
#import "RZHomeViewController.h"

#import "MJRefresh.h"


#import "CustomPageControl.h"
#import "RESideMenu.h"
//#import "RZAppDelegate.h"
#import "RZActivityListViewController.h"
#import "RZHotChamberListViewController.h"
 

#import "RZCollectionViewTwoFallsCell.h"
#import "RZCollectionViewWaterfallHeader.h"
#import "RZCollectionViewWaterfallFooter.h"

#import "RZMyCommentViewController.h"

#define CELL_IDENTIFIER @"RZCollectionViewTwoFallsCell"
#define HEADER_IDENTIFIER @"RZCollectionViewWaterfallHeader"
#define FOOTER_IDENTIFIER @"RZCollectionViewWaterfallFooter"

@interface RZHomeViewController ()
{
    
    
      UIView *_headveiw;
      UIScrollView *_scrollview;
      UIView *_headveiwsubview;
    CustomPageControl *pagecontrol;
    
    NSTimer *timer;
    NSMutableArray *ImgpathDate;
    
    
    /*刷新 加载*/
    UILabel *lbload;//提示标签
    BOOL IsSvPOPen;//是否允许刷新 加载  yes允许
    int Postpage;//分页 默认需设置0
   
    
    
    //UICollectionView 定义 相关
   UICollectionView *_collectionView;
    
    
    NSMutableArray *arr;
    
    NSMutableArray *collectionDate;
  NSInteger collectionItemwith;
 
  CGFloat collectionFooterheight;
    
}
@end

@implementation RZHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    label.text = @"首页";
     [label setFont:[UIFont systemFontOfSize:20]];
//    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;

   #pragma warning  自动刷新(一进入程序就下拉刷新)
   [self.collectionView headerBeginRefreshing];
 
}
////取得当前程序的委托
//-(RZAppDelegate *)appDelegate{
//    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
//}

//展示侧边栏
-(void)showMeun{
        [self.sideMenuViewController presentLeftMenuViewController];
}

//转所有评论
-(void)goAllComment{
    RZMyCommentViewController *view=[[RZMyCommentViewController alloc] initWithNibName:@"RZMyCommentViewController" bundle:nil];
    view.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:view  animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    //顶部按钮
    {
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setFrame:CGRectMake(5, 5, 30, 30)];
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     
    [btnRight setBackgroundImage:[UIImage imageNamed:@"消息.png"] forState:UIControlStateNormal];
//    [btnRight setBackgroundImage:[UIImage imageNamed:@"RZIcon1.png"] forState:UIControlStateHighlighted];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnRight addTarget:self action:@selector(goAllComment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnRightitem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnRightitem];
    }else{
        self.navigationItem.rightBarButtonItem = btnRightitem;
    }
    }
    
//    UIImageView *imag=[[UIImageView alloc] initWithFrame:self.view.bounds];
//    [imag setImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    
    
//    [self.view  insertSubview:imag atIndex:0];
    
 
    collectionDate=[[NSMutableArray alloc] initWithCapacity:0];
    
    collectionDate=[NSMutableArray arrayWithObjects:
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://img0.bdstatic.com/img/image/shouye/leimu/mingxing.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil],
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://img.baidu.com/img/image/3bf33a87e950352a5947ae485143fbf2b2.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://img1.bdstatic.com/img/image/8662934349b033b5bb5c55e5d9834d3d539b700bcce.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/7af40ad162d9f2d3cdc19be8abec8a136227cce1.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/weimeiyijing0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys: @"http://e.hiphotos.baidu.com/image/w%3D400/sign=2e56c8010ed79123e0e095749d355917/ae51f3deb48f8c5470385d2638292df5e1fe7fd4.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=e37cc47c6509c93d07f20ff7af3cf8bb/7a899e510fb30f2468cc6271ca95d143ad4b0369.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys: @"http://b.hiphotos.baidu.com/image/w%3D400/sign=ac0b8e2b92ef76c6d0d2fa2bad17fdf6/a71ea8d3fd1f4134dedc5974271f95cad0c85ed4.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/huacaozhiwu0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://d.hiphotos.baidu.com/image/w%3D400/sign=7d27c75af4246b607b0eb374dbf81a35/5882b2b7d0a20cf4f28367d674094b36acaf99ac.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://f.hiphotos.baidu.com/image/w%3D400/sign=657110132ff5e0feee1888016c6134e5/c83d70cf3bc79f3d6db2fb3ab8a1cd11728b296c.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://g.hiphotos.baidu.com/image/w%3D400/sign=4be7f3c141166d223877149476230945/e850352ac65c10384d5fbac8b0119313b07e8992.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/meinvbizhi0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://a.hiphotos.baidu.com/image/w%3D400/sign=55af4af479899e51788e3b1472a7d990/f9198618367adab42ab8824a89d4b31c8701e44b.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/a50f4bfbfbedab64947d23a7f536afc379311e4d.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                    [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/6a.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
    
    arr=[[NSMutableArray alloc] initWithCapacity:0];
    arr=[NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"http://g.hiphotos.baidu.com/image/w%3D400/sign=4be7f3c141166d223877149476230945/e850352ac65c10384d5fbac8b0119313b07e8992.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                         [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/meinvbizhi0207.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                         [NSDictionary dictionaryWithObjectsAndKeys:@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                         [NSDictionary dictionaryWithObjectsAndKeys:@"http://a.hiphotos.baidu.com/image/w%3D400/sign=55af4af479899e51788e3b1472a7d990/f9198618367adab42ab8824a89d4b31c8701e44b.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                         [NSDictionary dictionaryWithObjectsAndKeys: @"http://imgstatic.baidu.com/img/image/a50f4bfbfbedab64947d23a7f536afc379311e4d.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                         [NSDictionary dictionaryWithObjectsAndKeys:@"http://img2.bdstatic.com/img/image/5086f061d950a7b0208c22b6db060d9f2d3562cc885.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,
                         [NSDictionary dictionaryWithObjectsAndKeys:@"http://imgstatic.baidu.com/img/image/6a.jpg",@"image0", [NSString stringWithFormat:@"%d",arc4random()%50+90],@"width", [NSString stringWithFormat:@"%d",arc4random()%50+60],@"height",@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋",@"text", nil] ,nil];
    
    ImgpathDate=[[NSMutableArray alloc] initWithCapacity:0];
    ImgpathDate=[arr copy];

    
    collectionItemwith= 156;
    collectionFooterheight = 82;
    [self.view addSubview:self.collectionView];
    
    if(IOS7){
//        if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
//            [_tableview setSeparatorInset:UIEdgeInsetsZero];
//        }
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
        
    }
    
    lbload=[[UILabel alloc] initWithFrame:CGRectMake(0, _collectionView.frame.origin.y, 320, 25)];
    lbload.text=@"休息会儿,没有更多内容了!!!";
    lbload.font=[UIFont systemFontOfSize:13.0f];
    lbload.textAlignment=NSTextAlignmentCenter;
    lbload.backgroundColor=  [UIColor colorWithRed:62/255.0f green:180/255.0f blue:180/255.0f alpha:0.8];
    lbload.textColor=[UIColor whiteColor];
    lbload.hidden=YES;
    [self.view addSubview:lbload];
        Postpage=0;
    IsSvPOPen=YES;
    
    // 2.集成刷新控件
    [self addHeader];
    [self addFooter];
    
 

    // Do any additional setup after loading the view from its nib.
}

#pragma mark 刷新
- (void)addHeader
{
    
    if(IsSvPOPen){
        // 添加上拉刷新尾部控件
        [self.collectionView addHeaderWithCallback:^{
            IsSvPOPen=NO;
            Postpage=0;
            NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithCapacity:0];
            [temp setObject:[NSString stringWithFormat:@"%d",Postpage] forKey:@"page"];
            [temp setObject:@"0" forKey:@"type"];
            [self postResultDate:nil request:nil];
        }];
        
    }


}

- (void)addFooter
{
    if(IsSvPOPen){
        // 添加上拉刷新尾部控件
        [self.collectionView addFooterWithCallback:^{
            
        //        dispatch_async(dispatch_queue_create("loadTableViewDataToInfinite", NULL), ^(void) {
        IsSvPOPen=NO;
        Postpage++;
        [self postResultDateAdd:nil request:nil];
        //        });
        }];
    }
 
}


//下拉
-(void) loadTableViewDataToPull{
    if(IsSvPOPen){
        IsSvPOPen=NO;
        Postpage=0;
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithCapacity:0];
        [temp setObject:[NSString stringWithFormat:@"%d",Postpage] forKey:@"page"];
        [temp setObject:@"0" forKey:@"type"];
        [self postResultDate:nil request:nil];
    }
}
//上啦
-(void) loadTableViewDataToInfinite{
    if(IsSvPOPen){
//        dispatch_async(dispatch_queue_create("loadTableViewDataToInfinite", NULL), ^(void) {
            IsSvPOPen=NO;
            Postpage++;
            [self postResultDateAdd:nil request:nil];
//        });
    }
    
}


#pragma mark 请求回调


//刷新
-(void)postResultDate:(NSArray *)array request:(id)requset {
    
    [collectionDate removeAllObjects];
    collectionDate=[NSMutableArray arrayWithArray:arr];
 
    
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [_collectionView reloadData];
          [_collectionView headerEndRefreshing];
          IsSvPOPen=YES;
          
      });
 
    
}
//加载
-(void)postResultDateAdd:(NSArray *)array request:(id)requset {
 
    [collectionDate addObjectsFromArray:arr];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    

        IsSvPOPen=YES;
        [_collectionView reloadData];
            [_collectionView footerEndRefreshing];
          [_collectionView setContentOffset:CGPointMake(0, _collectionView.contentOffset.y-30) animated:YES];
 
//    });

   
    
}

-(void)hidelbload{
    [lbload setHidden:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UICollectionView  Accessors
//初始化 UICollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        RZCollectionViewWaterfallLayout *layout = [[RZCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(0,0,0, 0); //每个setion 的间距  上 右 下 左
        layout.headerHeight = 171;//section 头部距离
        layout.footerHeight = 00;//section 底部距离
        layout.minimumColumnSpacing = 0;//Item 间距
        
        layout.minimumInteritemSpacing =7;//Item 上下间距
        
        layout.columnCount = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
 
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColorFromRGB(0xF0F0F0);
        [_collectionView registerClass:[RZCollectionViewTwoFallsCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        [_collectionView registerClass:[RZCollectionViewWaterfallHeader class]
            forSupplementaryViewOfKind:RZCollectionElementKindSectionHeader
                   withReuseIdentifier:HEADER_IDENTIFIER];
        [_collectionView registerClass:[RZCollectionViewWaterfallFooter class]
            forSupplementaryViewOfKind:RZCollectionElementKindSectionFooter
                   withReuseIdentifier:FOOTER_IDENTIFIER];
 
    }
               _collectionView.alwaysBounceVertical = YES;
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
  RZCollectionViewWaterfallLayout *layout =
    (RZCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = 2;//UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [collectionDate count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
  RZCollectionViewTwoFallsCell *cell =
    (RZCollectionViewTwoFallsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
 
    if (!cell) {
        cell = [[RZCollectionViewTwoFallsCell alloc] initWithFrame:CGRectZero];
    }
    cell.backgroundColor=[UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1];
    
    CGRect rect=cell.viewContent.frame;
    rect.size.width=collectionItemwith*0.95;
        rect.origin.x=collectionItemwith*0.05;
    [cell.viewContent setFrame:rect];
 
    NSDictionary *temp=[collectionDate objectAtIndex:indexPath.item];
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [temp objectForKey:@"image0"]]];
    
//    if ([[temp objectForKey:@"is_gif"] isEqualToString:@"1"]) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:URL];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [cell.imageTopView setImage:image];
//            });
//        });
//    }
//    else {
        [cell.imageTopView setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"thumb_pic.png"]];
//    }

    
    [cell.lbleftTitle setHidden:YES];
    CGFloat aFloat = 0;
    aFloat =collectionItemwith*0.95/[[temp objectForKey:@"width"] floatValue];
      rect=cell.imageTopView.frame;
    rect.size.height=[[temp objectForKey:@"height"] floatValue]*aFloat;
    rect.size.width=collectionItemwith*0.95;
    rect.origin.x=0;
    [cell.imageTopView setFrame:rect];
    
    rect=cell.imageTopView.frame;
    rect.origin.x=0;
    rect.origin.y=[[temp objectForKey:@"height"] floatValue]*aFloat;
    rect.size.height=collectionFooterheight;
    rect.size.width=collectionItemwith*0.95;
    [cell.viewFooter setFrame:rect];
    
    //    [self getTextViewHeight:indexPath];
    
 
    cell.lbContent.text =@"素材虽过都不喜欢吃 喜欢吃西红柿操蛋";
 
    
    CGSize size=[cell.lbContent.text sizeWithFont:cell.lbContent.font constrainedToSize:CGSizeMake(cell.lbContent.frame.size.width,40.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    if(size.height>28){
        size.height=40.0f;
    }
    else{
        size.height=28.0f;
    }
    rect= cell.lbContent.frame;
    rect.size.height=size.height;
    [cell.lbContent setFrame:rect];
    cell.lbIconNo1Title.text=@"123";
    cell.lbIconNo1Title.textColor=UIColorFromRGB(0xb8b8b8);;
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init] ;
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr=[NSString stringWithFormat:@"2014-08-%d 12:12:12",indexPath.row+1];
    NSDate *tempd=[format dateFromString:timeStr];
    double diff=[[NSDate dateWithTimeIntervalSinceNow:8*60*60] timeIntervalSinceDate:tempd];
    int result= diff/(60*60);
    NSString *lblTimeText=@"";
    if (result>=24||result<0) {
        int time=result/24;
        if (time>7||time<0) {
            [format setDateFormat:@"MM-dd"];
            lblTimeText=[format stringFromDate:tempd]; 
        }else{
            lblTimeText=[NSString stringWithFormat: @"%d天前",time];
        }
    }else if(result<24&&result>=1){
        lblTimeText=[NSString stringWithFormat: @"%d小时前",result];
    }else {
        result=diff/60;
        lblTimeText=[NSString stringWithFormat: @"%d分钟前",result];
    }
 
    cell.lbDate.text=lblTimeText;//174  126
    
    rect=cell.viewContent.frame;
    rect.size.height=cell.viewFooter.frame.origin.y+cell.viewFooter.frame.size.height ;
    if(arc4random()%2==0){
        [cell.leftBackImageView setImage:[UIImage imageNamed:@"RZsqshareIconGreen.png"]];
    }
    else {
        [cell.leftBackImageView setImage:[UIImage imageNamed:@"RZsqshareIcon.png"]];
    }
    cell.lbleftTitle.textColor=[UIColor redColor];
    
    [cell.viewContent setFrame:rect];
    
    cell.viewContent.layer.masksToBounds=YES;
    cell.viewContent.layer.cornerRadius=5;
    cell.viewContent.layer.borderWidth=1;
    cell.viewContent.layer.borderColor=UIColorFromRGB(0xcbcbcb).CGColor;
    
 
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:RZCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
 

 
        _headveiw=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 171)];
        [_headveiw setBackgroundColor:[UIColor clearColor]];
        
        _scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 125)];
 
        [_scrollview setBackgroundColor:[UIColor clearColor]];
        [_headveiw addSubview:_scrollview];
 
        _headveiwsubview=[[UIView alloc] initWithFrame:CGRectMake(0, _scrollview.frame.size.height+_scrollview.frame.origin.y, 320, _headveiw.frame.size.height- _scrollview.frame.size.height-_scrollview.frame.origin.y)];
        [_headveiwsubview setBackgroundColor:[UIColor whiteColor]];
        UILabel *lblineup=[[UILabel alloc] initWithFrame:CGRectMake(0, 1, 320, 1)];
        lblineup.backgroundColor=UIColorFromRGB(0xcbcbcb);
        [_headveiwsubview addSubview:lblineup];
        UILabel *lblinedown=[[UILabel alloc] initWithFrame:CGRectMake(0, 45, 320, 1)];
        lblinedown.backgroundColor=UIColorFromRGB(0xcbcbcb);
        [_headveiwsubview addSubview:lblinedown];
        
        
        [_headveiw addSubview:_headveiwsubview];
        
        UIButton *btnleft=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnleft setFrame:CGRectMake(0, 0, _headveiwsubview.frame.size.width/2, _headveiwsubview.frame.size.height)];
        [btnleft setBackgroundColor:[UIColor clearColor]];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [btnleft setTitleColor:[UIColor colorWithRed:169/255.0f green:169/255.0f blue:169/255.0f alpha:1] forState:UIControlStateNormal];
        [btnleft setTitle:@"活动召集令" forState:UIControlStateNormal];
        [btnleft setTag:101];

        btnleft.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [btnleft  addTarget:self action:@selector(btnselect:) forControlEvents:UIControlEventTouchUpInside];
 
        [_headveiwsubview addSubview:btnleft];
        UIImageView *imgleft=[[UIImageView alloc] initWithFrame:CGRectMake(25,9, 28, 28)];
        [imgleft setBackgroundColor:[UIColor clearColor]];
        [imgleft setImage:[UIImage imageNamed:@"令.png"]];
        [btnleft addSubview:imgleft];
        
        
 
        UIButton *btnright=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake( _headveiwsubview.frame.size.width/2, 0, _headveiwsubview.frame.size.width/2, _headveiwsubview.frame.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [btnright setTitleColor:[UIColor colorWithRed:169/255.0f green:169/255.0f blue:169/255.0f alpha:1] forState:UIControlStateNormal];
        [btnright setTitle:@"热点议事厅" forState:UIControlStateNormal];
        [btnright setTag:102];
        btnright.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
        [btnright  addTarget:self action:@selector(btnselect:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imgright=[[UIImageView alloc] initWithFrame:CGRectMake(25,9, 28, 28)];
        [imgright setBackgroundColor:[UIColor clearColor]];
        [imgright setImage:[UIImage imageNamed:@"火.png"]];
        [btnright addSubview:imgright];
        
        [_headveiwsubview addSubview:btnright];
 
        [reusableView addSubview:_headveiw];
        
            [self ShowCarousel];
        
 
        
    } else if ([kind isEqualToString:RZCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}
-(void)btnselect:(UIButton*)sender{
    if(sender.tag==101){
        RZActivityListViewController *view=[[RZActivityListViewController alloc] initWithNibName:@"RZActivityListViewController" bundle:nil];
        view.hidesBottomBarWhenPushed = YES;
        [ self.navigationController pushViewController:view animated:YES ];
    }
    else{
        RZHotChamberListViewController *view=[[RZHotChamberListViewController alloc] initWithNibName:@"RZHotChamberListViewController" bundle:nil];
        view.hidesBottomBarWhenPushed = YES;
        [ self.navigationController pushViewController:view animated:YES ];
    }
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat aFloat = 0;
    
 
     NSDictionary *temp=[collectionDate objectAtIndex:indexPath.item];
    
 
    aFloat = collectionItemwith*0.95/[[temp objectForKey:@"width"] floatValue];
    CGSize size = CGSizeMake(0,0);
    //    [self getTextViewHeight:indexPath];
    size = CGSizeMake(collectionItemwith, [[temp objectForKey:@"height"] floatValue]*aFloat+collectionFooterheight);
    return size;
    
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
/*
//上一个cell
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    RZCollectionViewTwoFallsCell * cell = (RZCollectionViewTwoFallsCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.imageTopView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[collectionDate objectAtIndex:arc4random()%indexPath.item] objectForKey:@"image0"]]] placeholderImage:nil];
    cell.backgroundColor = [UIColor whiteColor];
}



//返回上一个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}*/


-(void)ShowCarousel{
   {
        _scrollview.delegate=self;
        [_scrollview setContentOffset:CGPointMake(0, 0)];
        [[_scrollview subviews]
         makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for(UIView *view in[_headveiw subviews]){
            if([view isKindOfClass:[CustomPageControl class]])
            {
                [view removeFromSuperview];
            }
        }
        if([ImgpathDate count]==0){
            return;
        }
//        if (timer) {
//            [timer invalidate];
//        }
//        timer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollAdlist) userInfo:nil repeats:YES];
        NSInteger count=0;
       
        //    int labHeight=27;
        {
            NSDictionary *ad=[ImgpathDate objectAtIndex:[ImgpathDate count]-1];//[ImgpathDate :[_dataStoreTime count]];
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(-320, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)] ;
            //广告图片
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:_scrollview.frame];
            
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            
            UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [activity setFrame:CGRectMake(_scrollview.frame.size.width/2-10, _scrollview.frame.size.height/2-10, 20, 20)];
            [activity startAnimating];
            UIImageView *backimageView=[[UIImageView alloc] initWithFrame:_scrollview.frame];
            [backimageView setImage:[UIImage imageNamed:@"Default@2x"]];
            [backimageView addSubview:activity];
            [view addSubview:backimageView];
            
            [imageView setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",[ad objectForKey:@"image0"]]] placeholderImage:[UIImage imageNamed:@"Default@2x"] ];
            
            UIButton *btnCheck=[UIButton buttonWithType:UIButtonTypeCustom];
            [btnCheck setFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//            [btnCheck addTarget:self action:@selector(adImageOnTouchInSide:) forControlEvents:UIControlEventTouchUpInside];
            [btnCheck setTag:count];
            
            //        //广告内容
            //        UILabel *adContent=[[UILabel alloc] initWithFrame:CGRectMake(0, _scrollview.frame.size.height-labHeight, _scrollview.frame.size.width, labHeight)] ;
            //        [adContent setTextAlignment:NSTextAlignmentLeft];
            //        [adContent setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f ]];
            //        [adContent setText:[NSString stringWithFormat:@"    %@",@"asdfasdf"]];
            //        [adContent setFont:[UIFont fontWithName:@"Helvetica 粗体" size:14.f]];
            //        [adContent setTextColor:[UIColor whiteColor]];
            [view addSubview:imageView];
            //        [view addSubview:adContent];
            [view addSubview:btnCheck];
            [_scrollview addSubview:view];
        }
        for (NSDictionary *ad in ImgpathDate)
            
        {
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(count*_scrollview.frame.size.width, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)] ;
            //广告图片
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:_scrollview.frame] ;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [activity setFrame:CGRectMake(_scrollview.frame.size.width/2-10, _scrollview.frame.size.height/2-10, 20, 20)];
            [activity startAnimating];
            
            UIImageView *backimageView=[[UIImageView alloc] initWithFrame:_scrollview.frame];
            [backimageView setImage:[UIImage imageNamed:@"Default@2x"]];
            [backimageView addSubview:activity];
            [view addSubview:backimageView];
            [imageView setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",[ad objectForKey:@"image0"]]] placeholderImage:[UIImage imageNamed:@"Default@2x"] ];
            UIButton *btnCheck=[UIButton buttonWithType:UIButtonTypeCustom];
            [btnCheck setFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//            [btnCheck addTarget:self action:@selector(adImageOnTouchInSide:) forControlEvents:UIControlEventTouchUpInside];
            [btnCheck setTag:count];
            
            //        //广告内容
            //        UILabel *adContent=[[UILabel alloc] initWithFrame:CGRectMake(0, _scrollview.frame.size.height-labHeight, _scrollview.frame.size.width, labHeight)] ;
            //
            //        [adContent setTextAlignment:NSTextAlignmentLeft];
            //        [adContent setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f ]];
            //        [adContent setText:[NSString stringWithFormat:@"    %@",@"asdf"]];
            //        [adContent setFont:[UIFont fontWithName:@"Helvetica 粗体" size:14.f]];
            //        [adContent setTextColor:[UIColor whiteColor]];
            [view addSubview:imageView];
            //        [view addSubview:adContent];
            [view addSubview:btnCheck];
            [_scrollview addSubview:view];
            count++;
            
        }
        {
            NSDictionary *ad=[ImgpathDate objectAtIndex:0];
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(count*_scrollview.frame.size.width, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
            //广告图片
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:_scrollview.frame] ;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [activity setFrame:CGRectMake(_scrollview.frame.size.width/2-10, _scrollview.frame.size.height/2-10, 20, 20)];
            [activity startAnimating];
            UIImageView *backimageView=[[UIImageView alloc] initWithFrame:_scrollview.frame];
            [backimageView setImage:[UIImage imageNamed:@"Default@2x"]];
            [backimageView addSubview:activity];
            [view addSubview:backimageView];
            [imageView setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",[ad objectForKey:@"image0"]]] placeholderImage:[UIImage imageNamed:@"Default@2x"] ];
            UIButton *btnCheck=[UIButton buttonWithType:UIButtonTypeCustom];
            [btnCheck setFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//            [btnCheck addTarget:self action:@selector(adImageOnTouchInSide:) forControlEvents:UIControlEventTouchUpInside];
            [btnCheck setTag:count];
            
            //        //广告内容
            //        UILabel *adContent=[[UILabel alloc] initWithFrame:CGRectMake(0, _scrollview.frame.size.height-labHeight, _scrollview.frame.size.width, labHeight)];
            //        [adContent setTextAlignment:NSTextAlignmentLeft];
            //        [adContent setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f ]];
            //        [adContent setText:[NSString stringWithFormat:@"    %@",@"asdfasdf"]];
            //        [adContent setFont:[UIFont fontWithName:@"Helvetica 粗体" size:14.f]];
            //        [adContent setTextColor:[UIColor whiteColor]];
            [view addSubview:imageView];
            //        [view addSubview:adContent];
            [view addSubview:btnCheck];
            [_scrollview addSubview:view];
        }
        
        //增加pagecontrol
//        pagecontrol = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, (_scrollview.frame.size.height+_scrollview.frame.origin.y)-20, 320, 15) currentImageName:@"" commonImageName:@"" spacing:0.0f marginLeft:-60.0f];
    pagecontrol = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, (_scrollview.frame.size.height+_scrollview.frame.origin.y)-20, 320, 15) ];
        pagecontrol.tag =2;
        [pagecontrol setBackgroundColor:[UIColor clearColor]];
        [pagecontrol setEnabled:NO];
        pagecontrol.userInteractionEnabled = NO;
        pagecontrol.numberOfPages = [ImgpathDate count];//
        [pagecontrol setNeedsDisplay];
        [pagecontrol.layer setCornerRadius:8];
        [pagecontrol setCurrentPage:0];
        [_headveiw addSubview:pagecontrol];
        [_scrollview setContentSize:CGSizeMake([ImgpathDate count]*320, 125)];
        [_scrollview setPagingEnabled:YES];
        [_scrollview setShowsHorizontalScrollIndicator:NO];
        [_scrollview setShowsVerticalScrollIndicator:NO];
    }
}

/*
-(void)adImageOnTouchInSide:(UIButton*)sender{
    
    
    NSMutableDictionary *tempdate=[ImgpathDate objectAtIndex:sender.tag];
    
    if([[NSString stringWithFormat:@"%@",[tempdate objectForKey:@"articleType"] ]isEqualToString:@"0"])
    {
        YrtShowMallInfoViewController *view=[[YrtShowMallInfoViewController alloc] initWithNibName:@"YrtShowMallInfoViewController" bundle:nil];
        view.temp=tempdate;
        view.NewId=[tempdate objectForKey:@"articleId"];
        if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=6.0))
        {
            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        }
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"hdbg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController pushViewController:view animated:YES];
    }
    else{
        YrtTHInfoViewController *view=[[YrtTHInfoViewController alloc] initWithNibName:@"YrtTHInfoViewController" bundle:nil];
        
        view.NewId=[tempdate objectForKey:@"articleId"];
        view.temp=tempdate;
        
        if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=6.0))
        {
            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        }
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"hdbg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController pushViewController:view animated:YES];
        
    }
    
}
 */
-(void)scrollAdlist{
    
    if (_scrollview){
        if (_scrollview.contentOffset.x>=_scrollview.contentSize.width- _scrollview.frame.size.width) {
            //        NSLog(@"scroll begin,%f",imagesScroll.contentOffset.x);
            [UIView animateWithDuration:0.4 animations:^{
                if ((int)_scrollview.contentOffset.x%(int)_scrollview.frame.size.width==0) {
                    [_scrollview setContentOffset:CGPointMake(_scrollview.contentOffset.x+320, 0) animated:NO];
                }else{
                    int c=_scrollview.contentOffset.x/_scrollview.frame.size.width;
                    [_scrollview setContentOffset:CGPointMake(c*_scrollview.frame.size.width+320, 0) animated:NO];
                }
            } completion:^(BOOL finished) {
                [_scrollview setContentOffset:CGPointMake(0, 0) animated:NO];
            }];
        }else{
            int c=_scrollview.contentOffset.x/_scrollview.frame.size.width;
            [_scrollview setContentOffset:CGPointMake(c*_scrollview.frame.size.width+320, 0) animated:YES];
        }
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_scrollview) {
        
        if ((int)_scrollview.contentOffset.x%(int)_scrollview.frame.size.width==0) {
            
            int c=_scrollview.contentOffset.x/_scrollview.frame.size.width;
            [pagecontrol setCurrentPage:c];
        }
        return;
    }
}



/*
//设置cell 背景色 文字字体 文字颜色
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   //记录上一个Cell
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RZActivityListViewController *view=[[RZActivityListViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:view animated:YES ];
    
}*/
@end
