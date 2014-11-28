//
//  RZLaunchViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-10.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZLaunchViewController.h"
#import "RZLaunchTableViewCell.h"
#import "RZLaunchOtherTableViewCell.h"
#import "RZTimeSelectedViewController.h"
#import "RZRule.h"
@interface RZLaunchViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *arrOfname;
    UITableView *tableView;
    UITapGestureRecognizer *tapGesture2;
    UICollectionView *_collectionView;
    UIImagePickerController *imagePicker;
     NSMutableArray *activityImages_my;
     int cell_indexPath_row;
    int numberOfint;
    UILabel *label00;
    BOOL isHave;
    UIView *oneView;
    UITextField *field0;
    UITextField *field1;
    UITextField *field2;
    UITextField *field6;
    UITextView *textViewone;
}

@end

@implementation RZLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtapGesture)];
    self.navigationItem.titleView.userInteractionEnabled = YES;
    [self.navigationItem.titleView addGestureRecognizer:tapGesture2];
    numberOfint = 500;
    arrOfname = [NSMutableArray arrayWithObjects:@"主题",@"地点",@"联系人手机",@"开始时间",@"结束时间",@"报名截止时间",@"报名限制人数", nil];
    imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //系统照片
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{
        //手机相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    activityImages_my = [NSMutableArray array];
    imagePicker.delegate = self;

    [self setTabBar];
    [self createTableView];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, -15, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"发起活动";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"提交" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 10, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didBtn2) forControlEvents:UIControlEventTouchUpInside];
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
-(void)createTableView
{
    oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    oneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oneView];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46) style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.userInteractionEnabled = YES;
    [oneView addSubview:tableView];
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
        view.alpha = 0.3;
        view1.alpha = 0.3;
        btnshoot.alpha = 1;
        btnpicture.alpha = 1;
        lineView.alpha = 1;
    }];
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //    NSLog(@"%@",info);
}
#pragma -mark -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (tableView.contentOffset.y < -40) {
        [self didtapGesture];
        NSLog(@"asdasd");
    }
}
#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfname.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < arrOfname.count) {
        return 45;
    }else{
        return 340;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString * cellname = @"cell";
    RZLaunchTableViewCell *cell = (RZLaunchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    RZLaunchOtherTableViewCell *cell_other = [[RZLaunchOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (cell == nil) {
        cell = [[RZLaunchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_other.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        field0 = cell.textField;
        field0.returnKeyType = UIReturnKeyDone;
    }else if (indexPath.row == 1){
        field1 = cell.textField;
        field1.returnKeyType = UIReturnKeyDone;
    }else if (indexPath.row == 2){
        field2 = cell.textField;
        field2.keyboardType = UIKeyboardTypeNumberPad;
        field2.returnKeyType = UIReturnKeyDone;
    }else if (indexPath.row == 3){
        _field3 = cell.textField;
    }else if (indexPath.row == 4){
        _field4 = cell.textField;
    }else if (indexPath.row == 5){
        _field5 = cell.textField;
    }else if (indexPath.row == arrOfname.count-1){
        field6 = cell.textField;
        field6.returnKeyType = UIReturnKeyDone;
        field6.keyboardType = UIKeyboardTypeNumberPad;
        field6.tag = 666;
        field6.delegate = self;
    }
    
    if (indexPath.row == arrOfname.count) {
        
        cell_other.label.frame = CGRectMake(10, 25, self.view.frame.size.width-20, 75);
        cell_other.textView.frame = CGRectMake( 10, 25+75+20, self.view.frame.size.width-20, 180);
        cell_other.label2.frame = CGRectMake(self.view.frame.size.width-100, 25+75+20+155, 80, 20);
        
        cell_other.userInteractionEnabled = YES;
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(65, 63);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-30, 80) collectionViewLayout:layoutView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.userInteractionEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
        [cell_other.label addSubview:_collectionView];
        cell_other.textView.delegate = self;
        label00 = cell_other.label2;
        textViewone = cell_other.textView;
        cell_other.label2.text  = [NSString stringWithFormat:@"%d字",numberOfint];
        return cell_other;
    }
    
    
     if (indexPath.row < arrOfname.count)
     {
         CGFloat width = [self caculateTheTextHeight:arrOfname[indexPath.row] andFontSize:16];
         cell.label1.frame = CGRectMake(15, 0, width, 50);
         cell.label2.frame = CGRectMake(20+width, 10, 15, 15);
         cell.label1.text = arrOfname[indexPath.row];
     }

    if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
        cell.image1.hidden = NO;
        cell.textField.enabled = NO;
    }else{
        cell.image1.hidden = YES;
        cell.textField.enabled = YES;
    }
    
   
    if (indexPath.row == 6) {
      RZLaunchTableViewCell *cell1 = [[RZLaunchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
  
        UISwitch * switchV = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 10, 40, 40)];
        [switchV addTarget:self action:@selector(didChange:) forControlEvents:UIControlEventValueChanged];
        switchV.on = isHave;
        switchV.onTintColor = UIColorFromRGB(0x5496DF);
        [cell1 addSubview:switchV];
        
        CGFloat width = [self caculateTheTextHeight:arrOfname[indexPath.row] andFontSize:16];
        cell1.label1.frame = CGRectMake(15, 0, width, 50);
        cell1.label2.frame = CGRectMake(20+width, 10, 15, 15);
        cell1.label1.text = arrOfname[indexPath.row];
        cell1.label2.hidden = YES;
        cell1.label1.text = @"限制报名人数";
        cell1.textField.enabled = NO;
        return cell1;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
         NSString *msg = @"";
        if (indexPath.row == 4 && ![_field3.text length]) {
            
            msg = @"\n请先设置开始时间";
        }
        if (indexPath.row == 5 && ![_field4.text length])
        {
             msg = @"\n请先设置结束时间";
        }
        if([msg length]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        
        
        RZTimeSelectedViewController *timeCtrl = [[RZTimeSelectedViewController alloc] init];
        timeCtrl.type = indexPath.row;
        if (indexPath.row == 3) {
            if(![_field3.text isEqualToString:@""]){
                NSString *date = [_field3.text substringToIndex: 10];
                NSString *time = [_field3.text substringFromIndex:11];
                [timeCtrl getDate:date Time:time];
            }
        }else if (indexPath.row == 4) {
            if(![_field3.text isEqualToString:@""]){
                NSString *date = [_field3.text substringToIndex: 10];
                NSString *time = [_field3.text substringFromIndex:11];
                [timeCtrl getDate:date Time:time];
            }
        }else if (indexPath.row == 5) {
            if(![_field4.text isEqualToString:@""]){
                NSString *date = [_field4.text substringToIndex: 10];
                NSString *time = [_field4.text substringFromIndex:11];
                [timeCtrl getDate:date Time:time];
            }
        }
        
       
        [self.navigationController pushViewController:timeCtrl animated:YES];
        [self didtapGesture];
    }
}

#pragma mark -  UICollectionView的代理
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
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
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell_my = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_cell" forIndexPath:indexPath];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didlong:)];
    [cell_my addGestureRecognizer:longPress];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];

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
    cell_my.backgroundView = image1;
    
    return cell_my;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell_indexPath_row = indexPath.row;
    [self createPicture];
    
}
#pragma mark - UITextView的代理
-(void)textViewDidBeginEditing:(UITextView *)textView
{

    [UIView animateWithDuration:0.3 animations:^{
        [tableView  setContentOffset:CGPointMake(0, 130) animated:YES];
    oneView.frame = CGRectMake(0, -200, self.view.frame.size.width, self.view.frame.size.height);
    }];

    if ([textView.text isEqualToString:@"  输入活动详情"]) {
        textView.text = @"  ";
        textView.textColor = [UIColor blackColor];
    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
       oneView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    if ([textView.text isEqualToString:@"  "] || [textView.text isEqualToString:@" "] || [textView.text isEqualToString:@""]) {
        textView.text = @"  输入活动详情";
        textView.textColor = UIColorFromRGB(0xc5c5c5);
    }
}
//字数限制
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (toBeString.length >500) {
        
        textView.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:499],text];
        
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    numberOfint = 500 -[textView.text length];
    label00.text = [NSString stringWithFormat:@"%d字",numberOfint];
}
#pragma mark - textField的代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 666) {
        [tableView setContentOffset:CGPointMake(0, 130) animated:YES]; 
    }
  
}



- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, 50);
    
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
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didBtn2
{
    [self didtapGesture];
    NSString *msg = @"";
    if ([field0.text isEqualToString:@""]) {
        msg = @"\n主题不能为空";
    } else if ([field1.text isEqualToString:@""]) {
        msg = @"\n地点不能为空";
    }else if ([field2.text isEqualToString:@""]) {
        msg = @"\n联系人手机不能为空";
    }else if ([_field3.text isEqualToString:@""]) {
        msg = @"\n开始时间不能为空";
    }else if ([_field4.text isEqualToString:@""]) {
        msg = @"\n结束时间不能为空";
    }else if ([_field5.text isEqualToString:@""]) {
        msg = @"\n报名截止时间不能为空";
    }else if ([field6.text isEqualToString:@""] && isHave) {
        msg = @"\n限制人数不能为空";
    }else if ([textViewone.text isEqualToString:@"  输入活动详情"] || [textViewone.text isEqualToString:@" "] || [textViewone.text isEqualToString:@""] || [textViewone.text isEqualToString:@"  "]) {
        msg = @"\n活动详情不能为空";
    }else if (!isValidatePhone(field2.text))
    {
        msg = @"\n请填写正确的手机号码";
    }
    if([msg isEqualToString:@""])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
-(void)didChange:(UISwitch *)sw
{
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:7 inSection:0];
   
    
    if (sw.on) {
        isHave = YES;
        [arrOfname addObject:@"人数"];
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];

    }else{
        isHave = NO;
        [arrOfname removeLastObject];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    }
}
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
-(void)didtapGesture
{
    if ([field0 isFirstResponder]) {
        [field0 resignFirstResponder];
    }
    else if ([field1 isFirstResponder]) {
        [field1 resignFirstResponder];
    }
    else if ([field2 isFirstResponder]) {
        [field2 resignFirstResponder];
    }
    else if ([_field3 isFirstResponder]) {
        [_field3 resignFirstResponder];
    }
    else if ([_field4 isFirstResponder]) {
        [_field4 resignFirstResponder];
    }
    else if ([_field5 isFirstResponder]) {
    [_field5 resignFirstResponder];
    }
    else if ([field6 isFirstResponder]) {
        [field6 resignFirstResponder];
    }else if ([textViewone isFirstResponder]) {
        [textViewone resignFirstResponder];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



-(void)viewWillDisappear:(BOOL)animated
{
    [self didTap];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self didtapGesture];
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
