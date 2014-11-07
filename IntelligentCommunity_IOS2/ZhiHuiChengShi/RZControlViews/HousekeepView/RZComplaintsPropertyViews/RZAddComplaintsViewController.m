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
@interface RZAddComplaintsViewController ()
{
    IBOutlet UIView *viewHead;
   IBOutlet UIView *viewInfo;
    
   IBOutlet UIView *viewImage;
    IBOutlet UILabel *lbwordcount;
        IBOutlet UILabel *lbShare;
            IBOutlet UILabel *lbImage;
    IBOutlet UITextField *txtName;
    IBOutlet  UITextField *txtAddress;
     IBOutlet  UITextView *txtInfo;
    IBOutlet UIButton *btnImgAdd;
    IBOutlet UIButton *btnShare;
    NSMutableDictionary *addDic;
    NSMutableArray *ImageArray;
    
    IBOutlet UIScrollView *_scrollview;
 
    CGSize size;
    
}
-(IBAction)btnAddImage:(id)sender;
-(IBAction)btnShare:(id)sender;

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
-(void)addDate{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];

    
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
        //        [btnRight setBackgroundImage:[UIImage imageNamed:@"Rzback.png"] forState:UIControlStateNormal];
        //        [btnRight setBackgroundImage:[UIImage imageNamed:@"Rzback.png"] forState:UIControlStateHighlighted];
        btnRight.titleLabel.font = [UIFont systemFontOfSize:17];
        [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnRight addTarget:self action:@selector(addDate) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *btnRightitem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
        
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -10;
            self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnRightitem];
        }else{
            self.navigationItem.rightBarButtonItem = btnRightitem;
        }

        
    }
    
    {
        txtName.placeholder=@"投诉什么？";
        txtAddress.placeholder=@"投诉地点";
        txtInfo.text=@"输入投诉详情";
        txtInfo.textColor=UIColorFromRGB(0xcbcbcb);
        lbwordcount.textColor=UIColorFromRGB(0xcbcbcb);
        lbwordcount.text=[NSString stringWithFormat:@"%d字",WORDCOUNT];
        lbImage.text=@"上传照片吧!";
        lbShare.text=@"分享到交流区";
        [btnShare setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [btnShare setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateSelected];
        
        viewInfo.layer.masksToBounds=YES;
        viewInfo.layer.cornerRadius=5;
    
        
        viewImage.layer.masksToBounds=YES;
        viewImage.layer.cornerRadius=5;
        ImageArray=[[NSMutableArray alloc] initWithCapacity:0];
        
    }
    
    UITapGestureRecognizer *single=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKey:)];
 
    [viewHead addGestureRecognizer:single];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//缩短uitableview 滑动
-(void) keyBoardWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
   [_scrollview setContentSize:CGSizeMake(320, viewHead.frame.size.height)];
    
    size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [_scrollview   setFrame:CGRectMake(_scrollview.frame.origin.x, _scrollview.frame.origin.y, _scrollview.frame.size.width, self.view.frame.size.height - size.height)];
    //    [_tableview setContentOffset:CGPointMake(0, size.height)];
}
//还原
-(void) keyBoardWillHide:(NSNotification *)note{
        [_scrollview setContentSize:CGSizeMake(320, viewHead.frame.size.height)];
    [_scrollview setFrame:CGRectMake(_scrollview.frame.origin.x, _scrollview.frame.origin.y, _scrollview.frame.size.width, _scrollview.frame.size.height+size.height)];
    //    [_tableview setContentOffset:CGPointMake(0, 0)];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text rangeOfString:@"输入投诉"].location!=NSNotFound){
        textView.text=@"";
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (toBeString.length > 20) {
        
        textField.text =[NSString stringWithFormat:@"%@%@", [toBeString substringToIndex:19],string];
        
        return NO;
        
    }

    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([txtInfo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<1||[txtInfo.text  rangeOfString:@"输入投诉"].location!= NSNotFound){
        txtInfo.textColor=UIColorFromRGB(0xcbcbcb);
        txtInfo.text=@"输入投诉详情";
        lbwordcount.text=[NSString stringWithFormat:@"%d字",WORDCOUNT];
        lbwordcount.textColor=UIColorFromRGB(0xcbcbcb);
    }

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@""]&&[txtInfo.text  rangeOfString:@"输入投诉"].location!= NSNotFound){
        return YES;
    }
        txtInfo.textColor=UIColorFromRGB(0x000000);
        txtInfo.text=[txtInfo.text stringByAppendingFormat:@"%@",text];
        lbwordcount.text=[NSString stringWithFormat:@"%d字",WORDCOUNT-txtInfo.text.length];
       lbwordcount.textColor=UIColorFromRGB(0xcbcbcb);
  
   
    if((NSInteger)(WORDCOUNT-txtInfo.text.length)<0){
        lbwordcount.textColor=UIColorFromRGB(0xff0000);
    }
    
    if([txtInfo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<1){
        [txtInfo resignFirstResponder];
        txtInfo.textColor=UIColorFromRGB(0xcbcbcb);
        txtInfo.text=@"输入投诉详情";
         lbwordcount.text=[NSString stringWithFormat:@"%d字",WORDCOUNT];
        lbwordcount.textColor=UIColorFromRGB(0xcbcbcb);
    }
    return YES;
}
-(void)hideKey:(UITapGestureRecognizer*)sender{
    [self ExitKey];
}
-(void)ExitKey{
    [txtName resignFirstResponder];
    [txtInfo resignFirstResponder];
    [txtAddress resignFirstResponder];
}

-(IBAction)btnAddImage:(id)sender{
    [self ExitKey];
    UIActionSheet *seet=[[UIActionSheet alloc] initWithTitle:@"图片选取" delegate:self cancelButtonTitle:@"相册" destructiveButtonTitle:@"照相机" otherButtonTitles: nil];
    [seet showInView:self.view];
}
-(IBAction)btnShare:(id)sender{
       [self ExitKey];
    btnShare.selected=!btnShare.selected;
}
#pragma mark Image delate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if(1 == buttonIndex)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *Imagepicker = [[UIImagePickerController alloc] init];
            Imagepicker.delegate =self;
            Imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:Imagepicker animated:YES completion:nil];
            
        }
        else{
            UIAlertView *alert =[[UIAlertView alloc]
                                 initWithTitle:@"未知错误" message:@"设备未发现相册"
                                 delegate:nil cancelButtonTitle:@"确认!" otherButtonTitles: nil];
            [alert show];
        }
    }else if(0 == buttonIndex) //照相机
    {
        UIImagePickerController *picker =[[UIImagePickerController alloc] init];
        picker.delegate =self;
        // picker.allowsEditing = YES;
        picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
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

#pragma mark 绘制
-(void)DreWImageview
{
    for(UIView *view in [viewImage subviews]){
        if([view isKindOfClass:[UIImageView class]]){
            [view removeFromSuperview];
        }
        if([view isKindOfClass:[ UIButton class]]){
            if(view.tag!=101){
                [view removeFromSuperview];
            }
        }
    }
     lbImage.hidden=NO;
    for(int i=0;i<[ImageArray count] ;i++)
    {
        
        lbImage.hidden=YES;
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(8+72*(i%4),5+69*(i/4), btnImgAdd.frame.size.width,  btnImgAdd.frame.size.height)];
        [img setImage:[UIImage imageWithContentsOfFile:[ImageArray objectAtIndex:i] ]];
        [img setTag:(int)(1000+i)];
        [img setBackgroundColor:[UIColor clearColor]];
        [img setUserInteractionEnabled:YES];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        img.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.view.tag=(int)(1000+i);
        [img addGestureRecognizer:singleTap];
        //实例化长按手势监听
        UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleTableviewCellLongPressed:)];
        //代理
        longPress.delegate = self;
        longPress.minimumPressDuration = 1.0;
        longPress.view.tag=(int)(1000+i);
        [img addGestureRecognizer:longPress];
        
        
        [viewImage addSubview:img];
        
        
        if(i%4==3) {
            CGRect rect=btnImgAdd.frame;
            rect.origin.x=8;
            rect.origin.y=5+69*((i+1)/4);
            [btnImgAdd setFrame:rect];
        }
        else{
            CGRect rect=btnImgAdd.frame;
            rect.origin.x=8+72*((i+1)%4);
            rect.origin.y=5+69*(i/4);
            [btnImgAdd setFrame:rect];
            
        }

    }
    CGRect rect=viewImage.frame;
    rect.origin.x=10;
    rect.size.height=btnImgAdd.frame.origin.y+btnImgAdd.frame.size.height+5;
    [viewImage setFrame:rect];
    rect=viewHead.frame;
 
    rect.size.height=viewImage.frame.origin.y+viewImage.frame.size.height+65;
    [viewHead setFrame:rect];
    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, rect.size.height)];
 
}

//长按事件的实现方法
- (void) handleSingleTap:(UITapGestureRecognizer *)singleTap {
    NSLog(@"%ld",(long)singleTap.view.tag);
    
    if(ImageArray.count<1)
    {
        return;
    }
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    for (int i=0;i<ImageArray.count;i++) {
        //             NSString *url = [NSString stringWithFormat:@"%@",@"http://s1.hao123img.com/res/images/search_logo/web.png"];
        //
        //               MWPhoto* photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]]; // 设置w网络图片地址
        
        
        MWPhoto *photo=[MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[ImageArray objectAtIndex:i]]];//本地图集
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
    browser.wantsFullScreenLayout = NO; //  iOS 5和6只：决定你想要的图片浏览器的全屏，即状态栏是否影响（缺省值为“是”）
    
    [browser setCurrentPhotoIndex:singleTap.view.tag-1000];
    
    
    [self.navigationController pushViewController:browser animated:YES];
    
    
}
//长按事件的实现方法
- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateBegan) {
        NSString *str=[NSString stringWithFormat:@"删除 第%ld张",(long)gestureRecognizer.view.tag-1000+1];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"艺人堂" message:str  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        NSLog(@"%ld",(long)gestureRecognizer.view.tag);
        alert.tag=20000+gestureRecognizer.view.tag;
        [alert show];
        NSLog(@"长安开始 UIGestureRecognizerStateBegan");
    }
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"长安结束UIGestureRecognizerStateEnded");
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1&&alertView.tag>20000){
        NSLog(@" 图片操作 删除第%ld张",(long)alertView.tag-21000+1);
        [ImageArray removeObjectAtIndex:alertView.tag-21000];
        [self DreWImageview];
    }
}

#pragma 照相机委托
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //    Imagecount++;
    
    NSData *data = UIImagePNGRepresentation(image); //把image转化成dada写入文件
    
    UIImage *imgThum = [[UIImage alloc] initWithData:data];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //判断MyImageFolder文件夹是否存在
    BOOL fileExists = [fileManager fileExistsAtPath:AppImage];
    if(!fileExists)
    {
        [fileManager createDirectoryAtPath:AppImage withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSString *myFolder = [AppImage stringByExpandingTildeInPath];
    NSDirectoryEnumerator *enumer = [fileManager enumeratorAtPath:myFolder];
    NSString *FileName;
    NSString *ImageFile;
    NSInteger ImageNumber=0;
    
    
    while (FileName = [enumer nextObject])
    {
        if([[FileName pathExtension] isEqualToString:@"jpg"])
        {
            // NSLog(@"FileName=%@",FileName);
            if(!([FileName isEqualToString:@".DS_Store"]))
            {
                
                FileName = [FileName substringWithRange:NSMakeRange(5, [FileName length] - 9)]; //取的名字的数字
                ImageNumber = [FileName integerValue];
                //NSLog(@"ImageNumber=%d",ImageNumber);
                if(ImageNumber < 9)
                    ImageFile = [[NSString alloc] initWithFormat:@"Image000%ld.jpg",(long)++ImageNumber];
                else if(ImageNumber >=9 && ImageNumber <99)
                    ImageFile = [[NSString alloc] initWithFormat:@"Image00%ld.jpg",(long)++ImageNumber];
                else if(ImageNumber >=99 && ImageNumber <999)
                    ImageFile = [[NSString alloc] initWithFormat:@"Image0%ld.jpg",(long)++ImageNumber];
                else
                    ImageFile = [[NSString alloc] initWithFormat:@"Image%ld.jpg",(long)++ImageNumber];
                //NSLog(@"ImageFile=%@",ImageFile);
            }
        }
    }
    if(ImageNumber == 0)
    {
        ImageFile = [[NSString alloc] initWithFormat:@"Image000%ld.jpg",(long)++ImageNumber];
    }
    NSLog(@"imagenumber=%ld",(long)ImageNumber);
    
    NSString *UploadImageFilePath = [AppImage stringByAppendingPathComponent:ImageFile];  //整张图片路径
    
    //1.
    //把图片数据写入沙盒目录
    NSData *ImageData = UIImageJPEGRepresentation(imgThum, 1.0);  //jpg 压缩读取
    //    CGSize size = CGSizeMake(60, 60);
    //    NSData * ThumaImageData = UIImageJPEGRepresentation([self imageWithImageSimple:ImageTemp scaledToSize:size], 1.0);  //压缩图片
    
    
    [ImageData writeToFile:UploadImageFilePath atomically:NO]; //写入文件
    //    [ThumaImageData writeToFile:UploadThumaImageFilePath atomically:NO];
    
     [ImageArray addObject:UploadImageFilePath ];
    //    [  setImage:imgThum];
    [self DreWImageview];
    
    [picker dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication ] setStatusBarHidden:NO];
    [[UIApplication sharedApplication ] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication ] setStatusBarHidden:NO];
    [[UIApplication sharedApplication ] setStatusBarStyle:UIStatusBarStyleLightContent];
    //  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
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

@end
