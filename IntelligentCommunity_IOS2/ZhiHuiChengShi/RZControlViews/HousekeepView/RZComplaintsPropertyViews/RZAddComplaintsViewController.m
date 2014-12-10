//
//  RZAddComplaintsViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-15.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark 我的 -  四个VIew的第一个 - 投诉记录 - 投诉 -  我要投诉
#import "RZAddComplaintsViewController.h"

#define WORDCOUNT 500
@interface RZAddComplaintsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITextField *_textField_other;
    UITextField *_textField;
    UITextView *_textView;
    int numberOfint;
    UILabel *labelofNumber;
    UILabel *_imageLabel;
    UICollectionView *_collectionView;
    NSMutableArray *activityImages_my;
    int cell_indexPath_row;
    UIImagePickerController *imagePicker;

}

@end

@implementation RZAddComplaintsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label= [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"我要投诉";
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        self.title = NSLocalizedString(@" ", @"");
        
    }
    return self;
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTabBar];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didresignFirstResponder)];
    self.navigationItem.titleView.userInteractionEnabled = YES;
    [self.navigationItem.titleView addGestureRecognizer:tapGesture2];
    
    
    _textField_other = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, Mywidth - 20, 30)];
    _textField_other.placeholder = @"投诉类型";
    _textField_other.font = [UIFont systemFontOfSize:17];
    _textField_other.textColor = [UIColor blackColor];
    [self.view addSubview:_textField_other];
    
    UIView *line_other = [[UIView alloc] initWithFrame:CGRectMake(-2, 29, Mywidth -10, 29)];
    line_other.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    [_textField_other addSubview:line_other];
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20+40, Mywidth - 20, 30)];
    _textField.placeholder = @"地点";
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.textColor = [UIColor blackColor];
    [self.view addSubview:_textField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-2, 29, Mywidth -10, 29)];
    line.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    [_textField addSubview:line];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 70+40, Mywidth - 20, 120)];
    _textView.textColor = UIColorFromRGB(0xc5c5c5);
    _textView.text = @" 描述投诉详情";
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.layer.borderColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1].CGColor;
    _textView.layer.borderWidth = 1;
    _textView.layer.cornerRadius = 7;
    _textView.layer.masksToBounds = YES;
    [self.view addSubview:_textView];
    
    labelofNumber = [[UILabel alloc] initWithFrame:CGRectMake(Mywidth - 75, 190-25+40, 60, 20)];
    labelofNumber.textColor = UIColorFromRGB(0xc5c5c5);
    labelofNumber.text = @"500字";
    labelofNumber.font = [UIFont systemFontOfSize:15];
    labelofNumber.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:labelofNumber];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(18, 20 + 290 +40, 22, 22);
    [btn setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(didSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel * labelshare = [[UILabel alloc] initWithFrame:CGRectMake(18+33, 22+290+40, 120, 20)];
    labelshare.text = @"分享到交流区";
    labelshare.font = [UIFont systemFontOfSize:15];
    labelshare.textColor = [UIColor blackColor];
    labelshare.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:labelshare];

    
    imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //系统照片
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{
        //手机相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    imagePicker.delegate = self;
    activityImages_my = [NSMutableArray array];
    
    [self createImageView];
    
    
}
-(void)didresignFirstResponder
{
    if ([_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }else if([_textView isFirstResponder]){
        [_textView resignFirstResponder];
    }else if ([_textField_other isFirstResponder]){
        [_textField_other resignFirstResponder];
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
    
    UIView *viewOther = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 20)];
    viewOther.backgroundColor = [UIColor blackColor];
    viewOther.alpha  = 0;
    viewOther.tag = 10088;
    [[[UIApplication sharedApplication] keyWindow] addSubview:viewOther];
    
    [UIView animateWithDuration:0.8 animations:^{
        view.alpha = 0.3;
        view1.alpha = 0.3;
        viewOther.alpha = 0.3;
        btnshoot.alpha = 1;
        btnpicture.alpha = 1;
        lineView.alpha = 1;
    }];
}
-(void)createImageView
{
    _imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190+20+40, Mywidth-20, 80)];
    _imageLabel.backgroundColor = UIColorFromRGB(0xeeeeee);
    _imageLabel.textColor= UIColorFromRGB(0x969696);
    _imageLabel.text = @"上传照片吧！";
    _imageLabel.layer.masksToBounds = YES;
    _imageLabel.layer.cornerRadius = 8;
    _imageLabel.userInteractionEnabled = YES;
    _imageLabel.textAlignment = NSTextAlignmentCenter;
    _imageLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_imageLabel];
    
    
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
    layoutView.itemSize = CGSizeMake(65, 63);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 8, self.view.frame.size.width-30, 80) collectionViewLayout:layoutView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.userInteractionEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
    [_imageLabel addSubview:_collectionView];
    
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
            image1.image = activityImages_my[indexPath.row];
        }
    }
    else
    {
        image1.image = activityImages_my[indexPath.row];
        
    }
    cell_my.backgroundView = image1;
    
    return cell_my;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell_indexPath_row = indexPath.row;
    [self createPicture];
    
}

-(void)addtijiao
{
    [self didresignFirstResponder];
    NSString *message = @"";
    if (![_textField_other.text length]) {
        message = @"\n请填写要投诉的类型";
    }else if(![_textField.text length]){
        message = @"\n请填写投诉的地点";
    }else if([_textView.text isEqualToString:@" 描述内容"] ||[_textView.text isEqualToString:@""] || [_textView.text isEqualToString:@" "] ){
        message = @"\n请描述一下投诉内容";
    }
    if(![message length]){
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
-(void)didSelectBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
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
-(void)didTap
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    UIView *view2 = (UIView *)[self.view viewWithTag:9999];
    UIView *view3 = (UIView *)[self.navigationController.navigationBar viewWithTag:10001];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:10002];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:10003];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:10004];
    UIView *viewOther = (UIView *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:10088];
    [viewOther removeFromSuperview];
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
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
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
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setFrame:CGRectMake(0, 0, 40, 40)];;
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRight setTitle:@"提交" forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnRight addTarget:self action:@selector(addtijiao) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnRightitem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnRightitem];
    }else{
        self.navigationItem.rightBarButtonItem = btnRightitem;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - textField的代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text rangeOfString:@" 描述投诉详情"].location!=NSNotFound){
        textView.text=@"";
        textView.textColor = [UIColor blackColor];;
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
    labelofNumber.text = [NSString stringWithFormat:@"%d字",numberOfint];
}




#pragma 照相机委托
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
    [self didTap];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}

//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    [image drawInRect:CGRectMake(0,0, newSize.width, newSize.height)];
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self didTap];
}


@end
