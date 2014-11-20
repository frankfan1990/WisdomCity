//
//  RZNewActivityViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-4.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZNewActivityViewController.h"
#import "RZRegistrationActivityViewController.h"
#import "RZPeopleViewController.h"
#import "RZActivity_oneTableViewCell.h"
#import "RZActivity_TwoTableViewCell.h"
#import "RZActivity_ThereTableViewCell.h"
#import "RZActivity_zeroTableViewCell.h"
#import "RZActivity_FourTableViewCell.h"
#import "RZActivity_FiveTableViewCell.h"
@interface RZNewActivityViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    
    NSString *activityStr;
    UITextField *textField;
    
    NSString *addressStr;
    NSString *endtimeStr;
    NSString *stratTimeStr;
    NSString *nameOfactivityStr;
    
    //评论 重用cell的数据
    NSMutableArray *arrOfimage;
    NSMutableArray *arrOfName;
    NSMutableArray *arrOfDate;
    NSMutableArray *arrOfcontent;
    NSMutableArray *arrOfSex;
    UICollectionView *_collectionView;
   
    //活动展示的图片
    NSArray *activityImages;
    NSArray *imageWithUrl;
    
    NSMutableArray *activityImages_my;
    int cell_indexPath_row;
    
    UIImagePickerController *imagePicker;
    UIView *commentView;
    
//    UICollectionView
}
@end
#warning 分享 评论  拨号 UICollectionView
@implementation RZNewActivityViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, -15, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"活动详情";
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self Variableinitialization];
    [self createTabBar];
    [self createTableView];
    [self createCommentView];
    
    
}
-(void)Variableinitialization
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    stratTimeStr = @"06月13日11:30";
    endtimeStr = @"06月13日23:15";
    addressStr = @"长沙开福区湘江世纪城";
    nameOfactivityStr = @"天空小区之天空杯 程序员 --- 之 ---- LOL大赛";
    
    activityImages_my = [NSMutableArray array];
    
    [activityImages_my addObject:@"110.jpg"];
    
    
    activityImages = @[@"110.jpg",@"110.jpg"];
    activityStr = @"  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的减肥哈快速的回复过 阿飞s哥快速拉升如果Flash发过来 测试文字：深刻的减肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来4测试文字：深刻的减肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的减肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的减肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 深刻的减肥哈快速的回复过 阿飞哥快拉升如果Flash发过来 测试文字：深刻的减肥哈快速的回复过 阿飞哥快速拉升如果";
    arrOfSex = [[NSMutableArray alloc] initWithObjects:@"男",@"女",nil];
    arrOfimage = [[NSMutableArray alloc] initWithObjects:@"110.jpg",@"110.jpg",nil];
    arrOfDate = [[NSMutableArray alloc] initWithObjects:@"06-12 20:04:24",@"06-13 17:30:23",nil];
    arrOfName = [[NSMutableArray alloc] initWithObjects:@"小小爱",@"大大爱 回复 小小爱",nil];
    arrOfcontent = [[NSMutableArray alloc] initWithObjects:@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 ",@"测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来  测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 测试文字：深刻的6肥哈快速的回复过 阿飞哥快速拉升如果Flash发过来 ",nil];
    
    imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //系统照片
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{
        //手机相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    imagePicker.delegate = self;
    

}

#pragma mark - TabBar的设置
-(void)createTabBar{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
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
    if (_type == 1 || _type == 2) {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"更多"]  forState:UIControlStateNormal];
    }else{
        [btn2 setTitle:@"管理" forState:UIControlStateNormal];
    }
    
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 addTarget:self action:@selector(didExit:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
    
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
#pragma mark - TableView的创建
-(void)createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-66) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource =self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView reloadData];
    [self.view addSubview:tableView];
    
}

-(void)createCommentView
{
    commentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 40)];
    commentView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(8, 5, 30, 30);
    [btn setImage:[UIImage imageNamed:@"表情.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didbiaoqing) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:btn];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(46, 3, self.view.frame.size.width - 46 -46, 34)];
    textField.placeholder = @"说点什么";
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    [commentView addSubview:textField];

    UIButton *sendbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendbtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendbtn addTarget:self action:@selector(didSendOut) forControlEvents:UIControlEventTouchUpInside];
    sendbtn.frame = CGRectMake(self.view.frame.size.width - 43, 5, 40, 30);
    [commentView addSubview:sendbtn];
    
    [self.view addSubview:commentView];
}
-(void)keyboardWillShow:(NSNotification *)note
{
    [UIView animateWithDuration:0.35 animations:^{
       commentView.frame = CGRectMake(0, self.view.frame.size.height-293, self.view.frame.size.width, 40);
    }];
    NSLog(@"%@",note.userInfo);
}
-(void)keyboardWillHide:(NSNotification *)note
{
    [UIView animateWithDuration:0.35 animations:^{
       commentView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 40);
    }];
}
-(void)didbiaoqing
{
    
}
-(void)didSendOut
{
    [textField resignFirstResponder];
}
-(UIView *)createCellView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, -10, self.view.frame.size.width, 145)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 18, 80, 80)];
    imageV1.image = [UIImage imageNamed:@"110.jpg"];
    [headView addSubview:imageV1];
    
    UILabel *labe1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 50, 20)];
    labe1.text = @"进行中";
    labe1.font = [UIFont systemFontOfSize:14];
    labe1.textColor = [UIColor whiteColor];
    labe1.textAlignment = NSTextAlignmentCenter;
    if ([labe1.text isEqualToString: @"进行中"])
    {
        labe1.backgroundColor = UIColorFromRGB(0x5496DF);
    }else
    {
        labe1.backgroundColor = [UIColor grayColor];
    }
    [imageV1 addSubview:labe1];
    
    
    UILabel *labelofName = [[UILabel alloc] initWithFrame:CGRectMake(100, 13, self.view.frame.size.width-110, 40)];
    labelofName.numberOfLines = 2;
    labelofName.adjustsFontSizeToFitWidth = YES;
    labelofName.text = nameOfactivityStr;
    labelofName.font = [UIFont systemFontOfSize:14];
    labelofName.adjustsFontSizeToFitWidth = YES;
    [headView addSubview:labelofName];
    
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(97, 63, 17, 17)];
    imageV2.image = [UIImage imageNamed:@"时间.png"];
    [headView addSubview:imageV2];
    
    UIImageView *imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(97, 83, 17, 17)];
    imageV3.image = [UIImage imageNamed:@"地标2.png"];
    [headView addSubview:imageV3];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 60,self.view.frame.size.width-120, 20)];
    label2.text = [NSString stringWithFormat:@"%@-%@",stratTimeStr,endtimeStr];
    label2.adjustsFontSizeToFitWidth = YES;
    label2.textColor = UIColorFromRGB(0x8b8b8b);
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(120, 80,self.view.frame.size.width-120, 20)];
    label3.text = addressStr;
    label3.adjustsFontSizeToFitWidth = YES;
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor = UIColorFromRGB(0x8b8b8b);
    label3.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:label3];
    
    UIImageView *imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 108, 30, 30)];
    imageV4.image = [UIImage imageNamed:@"小头像.png"];
    [headView addSubview:imageV4];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(45, 112,self.view.frame.size.width-50, 20)];
    label4.text = @"发起人:小宝";
    label4.adjustsFontSizeToFitWidth = YES;
    label4.font = [UIFont systemFontOfSize:15];
    label4.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:label4];
    
    UIButton * _btn1 = [[UIButton alloc] init] ;
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
    _btn1.frame = CGRectMake(self.view.frame.size.width-50, 105, 35, 35);
    [headView addSubview:_btn1];
    
    return headView;
}
#pragma mark - textField的代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [textField resignFirstResponder];
    return YES;
}
#pragma mark - TableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5+arrOfName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 140;
    }
    else if (indexPath.row == 1) {
        return 121;
    }
    else if (indexPath.row == 2) {
        return 45+ [self caculateTheTextHeight:activityStr andFontSize:15 andDistance:20];
    }
    else  if (indexPath.row == 3) {
        return 110;
    }
    else  if (indexPath.row == 4) {
        return 45;
    }
    return 60+[self caculateTheTextHeight:arrOfcontent[indexPath.row-5] andFontSize:14 andDistance:75]+10;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellname = @"cell";
    RZActivity_FiveTableViewCell * cell = (RZActivity_FiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    RZActivity_zeroTableViewCell *cell_zero = [[RZActivity_zeroTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    RZActivity_oneTableViewCell *cell_one = [[RZActivity_oneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    RZActivity_TwoTableViewCell *cell_two = [[RZActivity_TwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    RZActivity_ThereTableViewCell *cell_there = [[RZActivity_ThereTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    RZActivity_FourTableViewCell *cell_four = [[RZActivity_FourTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
   
    cell_one.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_two.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_there.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_four.selectionStyle = UITableViewCellSelectionStyleNone;
     cell_zero.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[RZActivity_FiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    
    
    
    if (indexPath.row == 0) {
        [cell_zero.cellView addSubview:[self createCellView]];
        return cell_zero;
    }
    if(indexPath.row == 1)
    {
        cell_one.label.text = @"活动晒图！！";
        cell_one.backgroundColor = UIColorFromRGB(0xf0f0f0);
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(66, 65);
        //水平
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 35, self.view.frame.size.width-20, 70) collectionViewLayout:layoutView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
        [cell_one addSubview:_collectionView];
        
        return cell_one;
    }else if (indexPath.row == 2)
    {
       cell_two.label1.text = @"活动详情";
       cell_two.label2.text = activityStr;
        return cell_two;
    }else if (indexPath.row == 3)
    {
        cell_there.label1.text = @"报名截止: 06年13日23:15";
        if (_type == 1 || _type == 2) {
            [cell_there.btn setTitle:@"立即报名" forState:UIControlStateNormal];
        }else if (_type == 3)
        {
            [cell_there.btn setTitle:@"查看报名人员" forState:UIControlStateNormal];
        }
        [cell_there.btn addTarget:self action:@selector(didBtnThere:) forControlEvents:UIControlEventTouchUpInside];
        cell_there.label2.text = @"限制人数: 40人";
        cell_there.label3.text = @"已报名:";
        cell_there.label4.text = @"3";
        cell_there.label5.text = @"人";
        return cell_there;
    }else if(indexPath.row == 4)
    {
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 50, 45)];
        label2.text = @"2 评论";
        label2.font =[UIFont systemFontOfSize:15];
        [cell_four.btnone addTarget:self action:@selector(didBtnComment) forControlEvents:UIControlEventTouchUpInside];
        [cell_four.btn2 addTarget:self action:@selector(sharePage) forControlEvents:UIControlEventTouchUpInside];
        [cell_four.btnone addSubview:label2];
        
        return cell_four;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageV1.image = [UIImage imageNamed:arrOfimage[indexPath.row-5]];
    cell.labelOfName.text = arrOfName[indexPath.row-5];
    cell.labelOfDate.text = arrOfDate[indexPath.row-5];
    cell.labelOfContent.text = arrOfcontent[indexPath.row-5];
    cell.labelOfContent.frame = CGRectMake(60, 55, self.view.frame.size.width-75, 60+[self caculateTheTextHeight:arrOfcontent[indexPath.row-5] andFontSize:14 andDistance:75]-56);
    cell.btn1.frame = CGRectMake(self.view.frame.size.width-50, 15, 33, 25);
    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    
    if ([arrOfSex[indexPath.row-5] isEqualToString:@"男"]) {
        cell.imageV2.image = [UIImage imageNamed:@"男.png"];
    }else if ([arrOfSex[indexPath.row-5] isEqualToString:@"女"])
    {
        cell.imageV2.image = [UIImage imageNamed:@"女1.png"];
    }
    
    return cell;
}

#pragma mark -  UICollectionView的代理
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_type == 1 || _type == 2)
    {
     return  activityImages.count;
    }else
    {
        if (activityImages_my.count < 4)
        {
            return activityImages_my.count + 1;
        }
        else
        {
            return 4;
        }
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell_my = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_cell" forIndexPath:indexPath];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didlong:)];
    [cell_my addGestureRecognizer:longPress];
    
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    if (_type == 1 || _type == 2) {
       image1.image = [UIImage imageNamed:activityImages[indexPath.row]];
    }else if (_type == 3){
        if (activityImages_my.count < 4)
        {
            
            if (indexPath.row == activityImages_my.count)
            {
                cell_my.tag = 555;
            image1.image = [UIImage imageNamed:@"添加照片"];
            }
            else
            {
                if ([activityImages_my[indexPath.row] isKindOfClass:[UIImage class]]) {
                    image1.image = activityImages_my[indexPath.row];
                }
                else{
                    image1.image = [UIImage imageNamed:activityImages_my[indexPath.row]];
                }
            }
        }
        else
        {
            if ([activityImages_my[indexPath.row] isKindOfClass:[UIImage class]]) {
                image1.image = activityImages_my[indexPath.row];
            }
            else{
                image1.image = [UIImage imageNamed:activityImages_my[indexPath.row]];
            }

        }
    }
    
    
    
    cell_my.backgroundView = image1;
    
    return cell_my;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_type == 3)
    {
         cell_indexPath_row = indexPath.row;
        [self createPicture];
    }
    NSLog(@"_type = %d  indexpath.row = %d",_type,indexPath.row);

}
#pragma mark - UIImagePickerController代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    imagev.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    if (cell_indexPath_row == activityImages_my.count) {
        [activityImages_my addObject:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [_collectionView reloadData];
    }else
    {
        [activityImages_my removeObjectAtIndex:cell_indexPath_row];
        [activityImages_my insertObject:[info objectForKey:UIImagePickerControllerOriginalImage] atIndex:cell_indexPath_row];
        [_collectionView reloadData];
    }
    
    
    

    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    //    NSLog(@"%@",info);
}
-(void)didlong:(UILongPressGestureRecognizer *)longpress
{
    if(longpress.state == UIGestureRecognizerStateBegan)
    {
        UICollectionViewCell *cell = (UICollectionViewCell *)longpress.view
        ;
        NSIndexPath * indexpath = [_collectionView indexPathForCell:cell];
        if (indexpath.row < activityImages_my.count) {
            [activityImages_my removeObjectAtIndex:indexpath.row];
            [_collectionView reloadData];
        }
    }

}
-(void)createPicture
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0;
    view.tag = 10000;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 44)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha  = 0;
    view1.tag = 10001;
    [self.navigationController.navigationBar addSubview:view1];
    
    
    
    
    UIButton *btnshoot = [UIButton buttonWithType:UIButtonTypeSystem];
    btnshoot.frame = CGRectMake(8, 150, self.view.frame.size.width-16, 55);
    btnshoot.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"拍照.png"]];
    imageView1.frame = CGRectMake(8, 5, 45, 45);
    [btnshoot addSubview:imageView1];
    [btnshoot addTarget:self action:@selector(didBtnShoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnshoot];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 150+54, self.view.frame.size.width-16, 2)];
    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:lineView];
    
    
    
    UIButton *btnpicture = [UIButton buttonWithType:UIButtonTypeSystem];
    btnpicture.frame = CGRectMake(8, 150+55, self.view.frame.size.width-16, 55);
    [btnpicture addTarget:self action:@selector(didBtnPicture) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"相册拿.png"]];
    imageView2.frame = CGRectMake(8, 5, 45, 45);
    [btnpicture addSubview:imageView2];
    [self.view addSubview:btnpicture];
    btnpicture.backgroundColor = [UIColor whiteColor];
    
    btnshoot.tag = 10002;
    btnpicture.tag = 10003;
    lineView.tag = 10004;
    
    btnshoot.alpha = 0;
    btnpicture.alpha = 0;
    lineView.alpha = 0;
    
    [btnpicture setTitle:@"相册选取                           " forState:UIControlStateNormal];
    [btnshoot setTitle:@"拍照                                " forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.6;
        view1.alpha = 0.6;
        btnshoot.alpha = 1;
        btnpicture.alpha = 1;
        lineView.alpha = 1;
    }];
}
-(void)didBtnPicture
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)didBtnShoot
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.showsCameraControls = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}



#pragma mark - 一系列点击 手势 的响应时间

-(void)didBtnThere:(UIButton *)sender
{
    if (_type == 1)
    {
        RZRegistrationActivityViewController *resgistCtrl = [[RZRegistrationActivityViewController alloc] init];
        resgistCtrl.startTimeStr = stratTimeStr;
        resgistCtrl.endTimeStr = endtimeStr;
        resgistCtrl.addressStr = addressStr;
        resgistCtrl.nameOfactivityStr = nameOfactivityStr;
        [self.navigationController pushViewController:resgistCtrl animated:YES];
        
        
    }else if (_type == 2)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n你已经报名了该活动！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if(_type == 3){
        RZPeopleViewController *peopleCtrl = [[RZPeopleViewController alloc] init];
        [self.navigationController pushViewController:peopleCtrl animated:YES];
    }
}

#pragma mark - 创建举报页面
//点击 ...
-(void)didExit:(UIButton *)sender
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0;
    view.tag = 10000;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 44)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha  = 0;
    view1.tag = 10001;
    [self.navigationController.navigationBar addSubview:view1];
    
    UIButton *btnJuBao = [UIButton buttonWithType:UIButtonTypeSystem];
    btnJuBao.frame = CGRectMake(15, 140, self.view.frame.size.width-30, 45);
    btnJuBao.backgroundColor = [UIColor whiteColor];
    [btnJuBao addTarget:self action:@selector(didBtnJuBao) forControlEvents:UIControlEventTouchUpInside];
    btnJuBao.layer.cornerRadius = 8;
    btnJuBao.layer.masksToBounds = YES;
    [self.view addSubview:btnJuBao];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    btnCancel.frame = CGRectMake(15, 150+45, self.view.frame.size.width-30, 45);
    [btnCancel addTarget:self action:@selector(didTap) forControlEvents:UIControlEventTouchUpInside];
    btnCancel.backgroundColor = [UIColor whiteColor];
    btnCancel.layer.cornerRadius = 8;
    btnCancel.layer.masksToBounds = YES;
    [self.view addSubview:btnCancel];
    
    btnJuBao.tag = 10002;
    btnCancel.tag = 10003;
    btnJuBao.alpha = 0;
    btnCancel.alpha = 0;
    if(_type == 1 || _type == 2)
    {
        [btnJuBao setTitle:@"举报" forState:UIControlStateNormal];
    }else
    {
      [btnJuBao setTitle:@"取消活动" forState:UIControlStateNormal];
    }
    
    btnJuBao.titleLabel.font = [UIFont systemFontOfSize:18];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
     btnCancel.titleLabel.font = [UIFont systemFontOfSize:18];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.6;
        view1.alpha = 0.6;
        btnJuBao.alpha = 1;
        btnCancel.alpha = 1;
    }];

}

//点击举报
-(void)didBtnJuBao
{
    NSLog(@"举报");
    [self didTap];
    if (_type == 3) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 评论
-(void)didBtnComment
{
    [textField becomeFirstResponder];
     NSLog(@"评论");
}
#pragma mark - 创建分享页面
-(void)sharePage
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0;
    view.tag = 10000;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 44)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha  = 0;
    view1.tag = 10001;
    [self.navigationController.navigationBar addSubview:view1];
    
    
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(8, 130, self.view.frame.size.width-16, 45);
    btn1.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"微博.png"]];
    imageView1.frame = CGRectMake(8, 5, 35, 35);
    [btn1 addSubview:imageView1];
    [btn1 addTarget:self action:@selector(didBtnWeiBo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 150+40, self.view.frame.size.width-16, 2)];
//    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//    [self.view addSubview:lineView];
    
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(8, 130+45, self.view.frame.size.width-16, 45);
    [btn2 addTarget:self action:@selector(didBtnWeiXin) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"活动召集令-详情-分享_06.png"]];
    imageView2.frame = CGRectMake(8, 5, 35, 35);
    [btn2 addSubview:imageView2];
    [self.view addSubview:btn2];
    btn2.layer.borderWidth = 1;
    btn2.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1].CGColor;
    btn2.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(8, 130+45+45, self.view.frame.size.width-16, 45);
    [btn3 addTarget:self action:@selector(didBtnWeiXin) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"活动召集令-详情-分享_06.png"]];
    imageView3.frame = CGRectMake(8, 5, 35, 35);
    [btn3 addSubview:imageView3];
    [self.view addSubview:btn3];
    btn3.backgroundColor = [UIColor whiteColor];
    
    
    btn1.tag = 10002;
    btn2.tag = 10003;
    btn3.tag = 10004;
//    lineView.tag = 9999;
    
    btn1.alpha = 0;
    btn2.alpha = 0;
    btn3.alpha = 0;
//    lineView.alpha = 0;
    

    [btn1 setTitle:@"分享到新浪微博                     " forState:UIControlStateNormal];
    [btn2 setTitle:@"分享到微信朋友圈                   " forState:UIControlStateNormal];
    [btn3 setTitle:@"分享到微信朋友                     " forState:UIControlStateNormal];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.6;
        view1.alpha = 0.6;
        btn1.alpha = 1;
        btn2.alpha = 1;
        btn3.alpha = 1;
//        lineView.alpha = 1;
    }];

}

-(void)didBtnWeiBo
{
    
}
-(void)didBtnWeiXin
{
    
}
-(void)didBtnWeiXinFriends
{
    
}
#pragma mark - 手势  取消举报页面
-(void)didTap
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    UIView *view2 = (UIView *)[self.view viewWithTag:9999];
    UIView *view3 = (UIView *)[self.navigationController.navigationBar viewWithTag:10001];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:10002];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:10003];
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
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self didTap];
}


@end
