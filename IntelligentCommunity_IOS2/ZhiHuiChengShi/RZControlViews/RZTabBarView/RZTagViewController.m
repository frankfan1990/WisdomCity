//
//  RZTagViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-13.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZTagViewController.h"
#import "RZLaunchOtherTableViewCell.h"
#import "AFNetworking.h"
@interface RZTagViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    NSDictionary *userDiction;
    UITableView *_tableView;
    UITextView *textViewone;
    UICollectionView *_collectionView;
    UIImagePickerController *imagePicker;
    UILabel *label00;
    UIView *oneView;
    NSMutableArray *activityImages_my;
    NSMutableArray *strOfImageUrl;
    int number;
    NSString * tagId;
    int cell_indexPath_row;
    NSTimer *timer;
}
@end

@implementation RZTagViewController

-(void)viewWillAppear:(BOOL)animated
{
    
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = _labelName;
        [label setFont:[UIFont systemFontOfSize:20]];
        //    label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment =NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
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
    
    [self.navigationController.navigationBar setBackgroundColor: UIColorFromRGB(0x5496DF)];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x5496DF)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    number = 500;
    activityImages_my = [NSMutableArray array];
    strOfImageUrl = [NSMutableArray array];
    imagePicker = [[UIImagePickerController alloc] init];
    tagId = [[NSUserDefaults standardUserDefaults] objectForKey:@"TagAndId"][_labelName];
    userDiction = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"]];
    [self setTabBar];
    [self createTableView];
    
    
       if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //系统照片
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{
        //手机相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    imagePicker.delegate = self;

}
-(void)createTableView
{
    oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    oneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oneView];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.userInteractionEnabled = YES;
    [oneView addSubview:_tableView];
    
}


#pragma mark - tableView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y < - 40) {
        [textViewone resignFirstResponder];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 305;
    }else{
        return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RZLaunchOtherTableViewCell *cell_other = [[RZLaunchOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UITableViewCell *cell_two = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell_other.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_two.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell_other.label.frame = CGRectMake(10, 10+180+20, self.view.frame.size.width-20, 75);
        cell_other.textView.frame = CGRectMake( 10, 15, self.view.frame.size.width-20, 180);
        cell_other.label2.frame = CGRectMake(self.view.frame.size.width-100, 20+155, 80, 20);
        cell_other.userInteractionEnabled = YES;
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(65, 63);
        cell_other.userInteractionEnabled = YES;
        cell_other.textView.text = @"  说点啥";
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
        cell_other.label2.text  = [NSString stringWithFormat:@"%d字",number];
        return cell_other;
    }else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 50)];
        label.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        label.layer.cornerRadius = 8;
        label.layer.masksToBounds = YES;
        label.text = @"   分享至:";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:18];
        label.userInteractionEnabled = YES;
        [cell_two addSubview:label];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(100, 10, 30, 30);
        [btn1 setBackgroundImage:[UIImage imageNamed:@"微博未选中"] forState:UIControlStateNormal];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(didWeiBo:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(140, 10, 30, 30);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"微信未点亮"] forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"微信1"] forState:UIControlStateSelected];
        [btn2 addTarget:self action:@selector(didWeiXin:) forControlEvents:UIControlEventTouchUpInside];
        [cell_two addSubview:btn1];
        [cell_two addSubview:btn2];
        
        return cell_two;
    }

    
}

#pragma mark - UIImagePickerController代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    imagev.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self didTap];
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
    
    if ([textView.text isEqualToString:@"  说点啥"]) {
        textView.text = @"  ";
        textView.textColor = [UIColor blackColor];
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
    number = 500 -[textView.text length];
    label00.text = [NSString stringWithFormat:@"%d字",number];
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

-(void)didWeiBo:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(void)didWeiXin:(UIButton *)sender
{
    sender.selected = !sender.selected;
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
-(void)didTap
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    [view removeFromSuperview];
    
    UIView *view1 = (UIView *)[self.view viewWithTag:10004];
    [view1 removeFromSuperview];
    
     UIView *view3 = (UIView *)[self.navigationController.navigationBar viewWithTag:10001];
    [view3 removeFromSuperview];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:10002];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:10003];
    [btn1 removeFromSuperview];
    [btn2 removeFromSuperview];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)viewWillDisappear:(BOOL)animated
{
    [self didTap];
}
-(void)didBtn2
{
    if ([textViewone.text isEqualToString:@"  说点啥"] || [textViewone.text isEqualToString:@""] || [textViewone.text isEqualToString:@" "] || [textViewone.text isEqualToString:@"  "] || activityImages_my.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n不能提交空的标签" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        
        [SVProgressHUD showWithStatus:@"正在提交" maskType:SVProgressHUDMaskTypeGradient];
        
        
        //用来保证所有图片上传完了在上传其他内容
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
        int ii=0;
        [strOfImageUrl removeAllObjects];
        for (UIImage *image in activityImages_my) {
            
            NSData * data = UIImageJPEGRepresentation(image, 0.8);
            
            NSString * _urlStr = [NSString stringWithFormat:@"%@/upload_img/addUpload",hostIPTwo];
            
            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

            [manager POST:_urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileData:data name:@"pic" fileName:[NSString stringWithFormat:@"image_%d.jpg",ii] mimeType:@"image/jpeg"];
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict = responseObject;
                if([dict[@"success"] intValue]== 1){
                    [strOfImageUrl addObject:dict];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"上传失败" message:@"\n请检查网络设置" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [aler show];
            }];
        
    
        }
        ii++;
    }
}
-(void)timer
{
    if (activityImages_my.count == strOfImageUrl.count) {
        [timer invalidate];
        NSString * str = @"";
        for (NSDictionary *dic in strOfImageUrl) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@_%@*%@;",hostIPTwo,dic[@"data"],dic[@"width"],dic[@"height"]]];
        }
        NSLog(@"%@",str);
        
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        NSString *urlStr = [NSString stringWithFormat:@"%@/home/addArticle",hostIPTwo];
        NSDictionary * paraDict = @{@"content":textViewone.text,@"picUrls":str,@"type":@"1003",@"tags":tagId,@"userId":userDiction[@"id"]};
        
        [manager POST:urlStr parameters:paraDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"上传失败" message:@"\n请检查网络设置" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [aler show];
            [SVProgressHUD dismiss];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
