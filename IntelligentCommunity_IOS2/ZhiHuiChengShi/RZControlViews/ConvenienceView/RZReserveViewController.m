//
//  RZReserveViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-5.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZReserveViewController.h"
#import "ContentViewController.h"
#import "RZShoppingCartViewController.h"
@interface RZReserveViewController ()<ViewPagerDataSource, ViewPagerDelegate>
{
    NSArray *arrOfName;
    ContentViewController *cvc;
}
@property (nonatomic) NSUInteger numberOfTabs;
@end
@implementation RZReserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
 
    arrOfName = @[@"热菜",@"凉菜",@"小吃",@"酒水"];
    self.dataSource = self;
    self.delegate = self;
    [self loadContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setTabar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
   
    [btn2 setBackgroundImage:[UIImage imageNamed:@"购物车"]  forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 5, 25, 25)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 addTarget:self action:@selector(didExit:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"菜品列单";
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
    
}

-(void)didExit:(UIButton *)sender
{
    RZShoppingCartViewController *shoppingCtrl = [[RZShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCtrl animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Setters
- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    
    // Reload data
    [self reloadData];
    
}

#pragma mark - Helpers
- (void)selectTabWithNumberFive {
    [self selectTabAtIndex:0];
}
- (void)loadContent {
    self.numberOfTabs = arrOfName.count;
}



#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {

    return self.numberOfTabs;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    if (arrOfName.count<5) {
        UIScrollView *srollView = [[viewPager.view subviews] objectAtIndex:0];
        srollView.scrollEnabled = NO;
    }else{
        UIScrollView *srollView = [[viewPager.view subviews] objectAtIndex:0];
        srollView.scrollEnabled = YES;
    }
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = arrOfName[index];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    if (index == 0) {
        label.textColor = UIColorFromRGB(0x5496DF);
    }
    label.tag = 10000 + index;
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {

    cvc = [[ContentViewController alloc] init];
    return cvc;
}
-(void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    
    for (int i=0; i<_numberOfTabs; i++) {
        UILabel *label = (UILabel *)[[[viewPager.view subviews] objectAtIndex:1] viewWithTag:10000+i];
        label.textColor = [UIColor blackColor];
    }
    UILabel *label = (UILabel *)[[[viewPager.view subviews] objectAtIndex:1] viewWithTag:10000+index];
    label.textColor = UIColorFromRGB(0x5496DF);
    
}
#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 44.0;
        case ViewPagerOptionTabOffset:
            return 0.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 80.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 0.0;
        case ViewPagerOptionFixLatterTabsPositions://自动修正在后
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return UIColorFromRGB(0x5496DF);
        case ViewPagerTabsView:
            return [UIColor whiteColor];
        case ViewPagerContent:
            return [UIColor whiteColor];
        default:
            return color;
    }

}

@end
