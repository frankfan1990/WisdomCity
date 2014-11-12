//
//  RZPeopleViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZPeopleViewController.h"
@interface RZPeopleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    NSArray *arrOfImages;
    NSArray *arrOfName;
}
@end

@implementation RZPeopleViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, -15, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"报名人员";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Variableinitialization];
    [self createTabBar];
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
    layoutView.itemSize = CGSizeMake(70, 90);
    //水平
//    [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 15, self.view.frame.size.width-10, self.view.frame.size.height-77) collectionViewLayout:layoutView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
    [self.view addSubview:_collectionView];
    
    
  
}
-(void)Variableinitialization
{
    
    arrOfName = [[NSArray alloc] initWithObjects:@"长江一号",@"长江二号",@"长江三号",@"长江四号",@"长江五号",@"长江六号",@"长江七号", @"长江一号",@"长江二号",@"长江三号",@"长江四号",@"长江五号",@"长江六号",@"长江七号",@"长江一号",@"长江二号",@"长江三号",@"长江四号",@"长江五号",@"长江六号",@"长江七号",nil];
    arrOfImages = [[NSArray alloc] initWithObjects:@"头像.png",@"头像.png",@"个人中心_03",@"头像.png",@"头像.png",@"头像.png",@"个人中心_03",@"头像.png",@"头像.png",@"个人中心_03",@"头像.png",@"头像.png",@"头像.png",@"个人中心_03",@"头像.png",@"头像.png",@"个人中心_03",@"头像.png",@"头像.png",@"头像.png",@"个人中心_03", nil];
}
#pragma mark - TabBar的设置
-(void)createTabBar{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    //    [self.view setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return  arrOfName.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_cell" forIndexPath:indexPath];
    UIImageView *_image1;
    UILabel *_label;
    _image1 = [[UIImageView alloc] init];
    _label = [[UILabel alloc] init];
    _label.adjustsFontSizeToFitWidth = YES;
    _label.font = [UIFont systemFontOfSize:15];
    _label.textAlignment = NSTextAlignmentCenter;
    _image1.layer.masksToBounds = YES;
    _image1.layer.cornerRadius = 35;
    _label.text = arrOfName[indexPath.row];
    _image1.image = [UIImage imageNamed:arrOfImages[indexPath.row]];
    _image1.frame = CGRectMake(0, 0, 70, 70);
    _label.frame =CGRectMake(0, 75, 70, 15);
    [cell addSubview:_image1];
    [cell addSubview:_label];
    return cell;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
