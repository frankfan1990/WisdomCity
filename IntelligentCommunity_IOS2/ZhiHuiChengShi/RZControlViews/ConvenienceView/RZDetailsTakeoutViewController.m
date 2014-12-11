//
//  RZDetailsTakeoutViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-2.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZDetailsTakeoutViewController.h"
#import "RZCommonlyListTableViewCell.h"
#import "RZDetailTakeoutTableViewCell.h"
#import "RZTakeoutMessageCommentViewController.h"
#import "RZReserveViewController.h"
#import "MWPhotoBrowser.h"

@interface RZDetailsTakeoutViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate>
{
    UITableView *_tableView;
    UICollectionView *_collectionView;
    
    NSMutableArray *activityImages_my;
    int cell_indexPath_row;
   
    NSArray *_photos;
    NSString *introduceStr;
    NSMutableArray *arrOfContent;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfnumber;
    
    NSMutableArray *arrOfimages;
}
@end

@implementation RZDetailsTakeoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
    [self Variableinitialization];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64-48) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view  addSubview:_tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, Myheight - 45 - 64, Mywidth, 45);
    [btn setTitle:@"在线预订" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didReserve) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor =UIColorFromRGB(0x5496DF);
    [self.view addSubview:btn];
}
-(void)Variableinitialization
{
    arrOfimages = [NSMutableArray array];
    activityImages_my = [NSMutableArray arrayWithObjects:@"http://pic17.nipic.com/20111102/7015943_083452063000_2.jpg",@"http://pic24.nipic.com/20121015/9095554_134755084000_2.jpg",@"http://pic.nipic.com/2007-12-20/200712206539308_2.jpg",@"http://pic1.nipic.com/2008-10-13/2008101312210298_2.jpg",@"http://pic24.nipic.com/20121014/9095554_130006147000_2.jpg",@"http://pic1a.nipic.com/2008-10-27/2008102793623630_2.jpg",@"http://pic17.nipic.com/20111102/7015943_083452063000_2.jpg",nil];;
    introduceStr = @"打包形式是最早出现的外卖形式，虽然古老，却延续至今。随着电话、手机、网络的普及，使外卖行业得到迅速发展。我店准时送到外卖  好吃 实惠 你值得拥有！";
    _numberStr = @"071-88668866";
    
    arrOfContent = [NSMutableArray arrayWithObjects:@"超值优惠 满就送",@"夏季饮品 买二送一",@"超值优惠 满就送",@"夏季饮品 买二送一",@"超值优惠 满就送 买一送三  送到你满意 送到你开心 送到你拿不动 开业打放送 走过路过 千万不要错 过了今天就没有这个优惠了 大家快来啦啦啦啦啦 ",@"超值优惠 满就送",nil];
    arrOfDate = [NSMutableArray arrayWithObjects:@"2014-05-08 15:52",@"2014-05-09 15:52",@"2014-05-10 15:52",@"2014-05-11 15:52",@"2014-05-12 15:52", @"2014-05-13 15:52",nil];
    arrOfnumber = [NSMutableArray arrayWithObjects:@"99",@"10576099",@"9",@"23", @"99",@"10576099", nil];
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
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"商户详情";
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6 +arrOfContent.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 || indexPath.row == 3)
    {
        return 90;
    }else if(indexPath.row == 1){
        return 45;
    }else if(indexPath.row == 2)
    {
        return 40;
    }else if(indexPath.row == 5)
    {
        return 30;
    }else if(indexPath.row == 4)
    {
        return 40+[self caculateTheTextHeight:introduceStr andFontSize:13 andDistance:40]+13;
    }else{
         return [self caculateTheTextHeight:arrOfContent[indexPath.row-6] andFontSize:13 andDistance:105]+10+38;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    if (indexPath.row == 0) {
        RZCommonlyListTableViewCell *cell = [[RZCommonlyListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageV.image = _image;
        cell.labelOfTitle.text = _nameStr;
        cell.labelOfAddress.text = _addressStr;
         cell.labelOfDistance.frame = CGRectMake(Mywidth-100, 15, 90, 20);
        cell.labelOfDistance.text = [NSString stringWithFormat:@"距离：%@m",_distanceStr];
        cell.labelOfAddress.frame = CGRectMake(80+8, 42, Mywidth-98, [self caculateTheTextHeight:_addressStr andFontSize:13 andDistance:100]);
        return cell;
        
    }
    else if(indexPath.row == 1){
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 25)];
        label1.textColor = MyTitleBlueColr;
        label1.text = @"服务热线";
        label1.font = [UIFont systemFontOfSize:14];
        
        UILabel *numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, Mywidth-50-120, 25)];
        numberlabel.text = _numberStr;;
        numberlabel.textAlignment = NSTextAlignmentRight;
        numberlabel.font = [UIFont systemFontOfSize:14];
        
        UIButton *numberbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        numberbtn.frame =CGRectMake(Mywidth-40, 8, 30, 30);
        [numberbtn setBackgroundImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
        [numberbtn addTarget:self action:@selector(didNumber:) forControlEvents:UIControlEventTouchUpInside];
        [cell2 addSubview:numberlabel];
        [cell2 addSubview:label1];
        [cell2 addSubview:numberbtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45-0.5, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell2 addSubview:lineView];
        return cell2;
    }
    else if(indexPath.row == 2){
        
        UITableViewCell *cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 25)];
        label1.textColor = MyTitleBlueColr;
        label1.text = @"查看图片";
        label1.font = [UIFont systemFontOfSize:14];
        [cell3 addSubview:label1];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40-0.5, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell3 addSubview:lineView];
        return cell3;
    }
    else if(indexPath.row == 3){
        UITableViewCell *cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 4, Mywidth-20, 70)];
        scrollView.contentSize = CGSizeMake(72*activityImages_my.count, 70);
        scrollView.showsHorizontalScrollIndicator = NO;
        [cell4 addSubview:scrollView];
        
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(63, 60);
        //水平
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 8, 70*activityImages_my.count, 70) collectionViewLayout:layoutView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
        [scrollView addSubview:_collectionView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 90-0.5, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell4 addSubview:lineView];
        return cell4;
    }
    else if(indexPath.row == 4){
        UITableViewCell *cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 25)];
        label1.textColor = MyTitleBlueColr;
        label1.text = @"商户介绍";
        label1.font = [UIFont systemFontOfSize:14];
        [cell5 addSubview:label1];
        CGFloat height = [self caculateTheTextHeight:introduceStr andFontSize:13 andDistance:40];
        UILabel *labelcontent = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, Mywidth-30, height)];
        labelcontent.text = introduceStr;
        labelcontent.font = [UIFont systemFontOfSize:13];
        labelcontent.textAlignment = NSTextAlignmentLeft;
        labelcontent.numberOfLines = 1000;
        [cell5 addSubview:labelcontent];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40+height+13-0.5, cell5.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell5 addSubview:lineView];
        
        return cell5;
    }
    else if(indexPath.row == 5){
        UITableViewCell *cell6 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell6.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        label1.textColor = MyTitleBlueColr;
        label1.text = @"最新发布";
        label1.font = [UIFont systemFontOfSize:14];
        [cell6 addSubview:label1];
        return cell6;
    }
    else{
        static NSString *cellStr = @"cell";

        RZDetailTakeoutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[RZDetailTakeoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            
        }
        CGFloat height = [self caculateTheTextHeight:arrOfContent[indexPath.row-6] andFontSize:13 andDistance:105];
        CGFloat width = [self caculateTheTextWidth:arrOfnumber[indexPath.row-6] andFontSize:12 andDistance:20];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label1.frame = CGRectMake(15, 10, 40, 15);
        cell.label2.frame = CGRectMake(65, 9, Mywidth-40-65, height);
        cell.label3.frame = CGRectMake(15, 10+height + 8 , 120, 20);
        cell.label4.frame = CGRectMake(115+10+width+5, 10+height + 8, 40, 20);
        cell.imageV2.frame = CGRectMake(Mywidth-40, (height+10+38)/2-15,30, 30);
        cell. imageV1.frame = CGRectMake(8, height+10+38-3, Mywidth-16, 0.4);
        cell. numberlabel.frame = CGRectMake(115+10,10+height + 8 , width, 20);
        
        cell.label2.text = arrOfContent[indexPath.row-6];
        cell.label3.text = arrOfDate[indexPath.row-6];
        cell.numberlabel.text = arrOfnumber[indexPath.row -6];
        return cell;
    }

 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >5) {
        RZDetailTakeoutTableViewCell *cell = (RZDetailTakeoutTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        RZTakeoutMessageCommentViewController *commentCtr = [[RZTakeoutMessageCommentViewController alloc] init];
        commentCtr.nameStr = _nameStr;
        commentCtr.dateStr = cell.label3.text;
        commentCtr.numberStr = cell.numberlabel.text;
        commentCtr.image = _image;
        commentCtr.titleStr = cell.label2.text;
        [self.navigationController pushViewController:commentCtr animated:YES];
        
    }
}


#pragma mark -  UICollectionView的代理
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return activityImages_my.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell_my = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_cell" forIndexPath:indexPath];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 60)];
    [image1 setImageWithURL:[NSURL URLWithString:activityImages_my[indexPath.row]] placeholderImage:[UIImage imageNamed:@"煲仔饭"]];
    
    [arrOfimages addObject:image1];
    cell_my.backgroundView = image1;
    return cell_my;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell_indexPath_row = indexPath.row;
    [self handleSingleTap];
}


#pragma mark 图集
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}
- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

#pragma mark - 根据字长算 高度或宽度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(self.view.bounds.size.width-distance, CGFLOAT_MAX);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.height;
}

- (CGFloat)caculateTheTextWidth:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake( CGFLOAT_MAX,distance);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.width;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//注意这里的图片是本地的
- (void) handleSingleTap {
    
    if(activityImages_my.count<1)
    {
        return;
    }
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    for (int i=0;i<activityImages_my.count;i++) {
        //             NSString *url = [NSString stringWithFormat:@"%@",@"http://s1.hao123img.com/res/images/search_logo/web.png"];
        //
        //               MWPhoto* photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]]; // 设置w网络图片地址
        MWPhoto *photo;
       
        photo=[MWPhoto photoWithImage:[arrOfimages[i] image]];
        //本地图集
        //photo.caption = [NSString stringWithFormat:@"%d我忍有的和",i];
        // 设置描述
        [photos addObject:photo];
    }
    _photos = photos;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    
    // Set options
    browser.displayActionButton = YES; // 显示动作按钮允许共享，复制，等等（缺省值为“是”）
    browser.displayNavArrows = YES; // 是否显示导航工具栏上的左、右箭头（缺省为不）
    browser.displaySelectionButtons = NO; // 是否选择按钮上显示图像（缺省为不）
    browser.zoomPhotosToFill = YES; // 图像，几乎填满屏幕将初步放大到填充（缺省为的是的）
    browser.alwaysShowControls = NO; // 允许控制是否条和控件总是可见的或他们是否褪色显示照片完整（缺省为不）
    browser.enableGrid = YES; // 是否允许在网格中的所有照片的缩略图查看（缺省值为“是”）
    browser.startOnGrid = NO; // 是否开始在缩略图网格而不是第一张照片（缺省为不）
//    browser.wantsFullScreenLayout = NO; //  iOS 5和6只：决定你想要的图片浏览器的全屏，即状态栏是否影响（缺省值为“是”）
    
    [browser setCurrentPhotoIndex:cell_indexPath_row];
    
    
    [self.navigationController pushViewController:browser animated:YES];
    
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didReserve
{
    RZReserveViewController *reserveCtrl = [[RZReserveViewController alloc] init];
    [self.navigationController pushViewController:reserveCtrl animated:YES];
}
-(void)didNumber:(UIButton *)sender
{
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",_numberStr]]];
}

@end
