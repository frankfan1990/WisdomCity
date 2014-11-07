//
//  RZServerWebViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZServerWebViewController.h"


@interface RZServerWebViewController ()

@end

@implementation RZServerWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)back{
      [webviews loadRequest:[NSURLRequest requestWithURL:nil]];
    webviews=nil;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"服务条款";
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
 
    
    [self.view setBackgroundColor:[UIColor grayColor]];
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

    if(_hideBottom){
        bottomView.hidden=YES;
        CGRect rect=webviews.frame;
        rect.size.height+=bottomView.frame.size.height;
        [webviews setFrame:rect];
    }
    else{
        bottomView.hidden=NO;
    }
    
    lblLoadstat=[[UILabel alloc] initWithFrame:CGRectMake(0, webviews.frame.size.height-25, 320, 25)];
    lblLoadstat.textColor=[UtilCheck getRZColor:255 green:255 blue:255 alpha:1];
    lblLoadstat.backgroundColor=[UtilCheck getRZColor:0 green:0 blue:0 alpha:1];
    [webviews addSubview:lblLoadstat];
    
    NSURL *urlResult=[NSURL URLWithString:[_webviewUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (urlResult==nil) {
        urlResult=[NSURL URLWithString:_webviewUrl];
    }
    [webviews loadRequest:[NSURLRequest requestWithURL:urlResult]];
    for (UIView *view in [[[webviews subviews] lastObject] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view setHidden:YES];
        }
    }

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSString * createImageJavaScript(){
    NSString *js=@"var imgs=document.getElementsByTagName('img');for(var i=0;i<imgs.length;i++){imgs[i].onclick=function(){ var url='imagePath:'+this.src;document.location=url;};}";
    return js;
}
- (void) initImageShow: (UIImage *) image webView: (UIWebView *) webView  {
    CGRect frame= [webView superview].frame;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom ];
    [btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [btn setEnabled:YES];
//    [btn addTarget:self action:@selector(releaseImageShow) forControlEvents:UIControlEventTouchUpInside];
    imageScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    imageScroll.delegate=self;
    NSInteger imgWidth=[image size].width;
    NSInteger imgHeight=[image size].height ;
    CGFloat zoomWidth=frame.size.width/imgWidth;
    CGFloat zoomHeight=frame.size.height/imgHeight;
    CGFloat zoom=zoomHeight>zoomWidth?zoomWidth:zoomHeight;
    CGFloat origin_x=(frame.size.width-imgWidth)/2.0;
    CGFloat origin_y=(frame.size.height-imgHeight)/2.0;
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(origin_x, origin_y-44, frame.size.width, frame.size.height*imgHeight/imgWidth)];
    [imageView setImage: image];
    [imageScroll setMaximumZoomScale:5.f];
    [imageScroll setMinimumZoomScale:zoom];
    [imageScroll setZoomScale:zoom];
    [imageScroll addSubview:btn];
    [imageScroll addSubview:imageView];
    
    backView=[[UIView alloc] initWithFrame:frame];
    [backView setBackgroundColor:[UIColor blackColor]];        //[backView addSubview:btn];
    [backView addSubview:imageScroll];
    [[webView superview] addSubview:backView];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    lblLoadstat.text=@"加载中......";
    [loadingActi startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:createImageJavaScript()];
    [loadingActi stopAnimating];
    lblLoadstat.text=@"加载完成!";
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [loadingActi stopAnimating];
    lblLoadstat.text=@"加载完成!";
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType==UIWebViewNavigationTypeLinkClicked) {
        NSString *link=[[request URL] absoluteString];
        if ([link hasPrefix:@"https://itunes.apple.com"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
            return NO;
        }
        if ([link hasPrefix:@"imagePath:"]) {
            
            link= [link substringFromIndex:10];
            UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:link]]];
            [self initImageShow: image webView: webView];
            return NO;
        }
        else if ([[link lowercaseString] rangeOfString:@"customsms:"].location!=NSNotFound) {
            [self performSelectorOnMainThread:@selector(sendMessage:) withObject:link waitUntilDone:NO];
            return NO;
        }
    }
    
    [loadingActi startAnimating];
    return YES;
}

-(void) sendMessage:(NSString*)urlString{
    if ([MFMessageComposeViewController canSendText]) {
        NSArray *msg=[urlString componentsSeparatedByString:@";"];
        if ([msg count]==2) {
            MFMessageComposeViewController *Controller=[[MFMessageComposeViewController alloc] init];
            [Controller setMessageComposeDelegate:self];
            NSArray *tel,*body;
            tel=[[msg objectAtIndex:0] componentsSeparatedByString:@":"];
            body=[[msg objectAtIndex:1] componentsSeparatedByString:@":"];
            if ([tel count]==2) {
                Controller.recipients=[NSArray arrayWithObject:[NSString stringWithFormat:@"%@",[tel objectAtIndex:1]]];
            }if ([body count]==2) {
                Controller.body=[[NSString stringWithFormat:@"%@",[body objectAtIndex:1]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            [self.navigationController presentViewController:Controller animated:YES completion:nil];
        }
    }else{
        [SVProgressHUD showWithStatus:@"无法举报" maskType:SVProgressHUDMaskTypeGradient];
        [self performSelector:@selector(hide) withObject:nil afterDelay:CLEAR_TIME];
    }
}
-(void)hide{
    [SVProgressHUD dismiss];
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            
            break;
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    for (id view in [scrollView subviews]) {
        if([view isKindOfClass:[UIImageView class]]){
            return imageView;
        }
    }
    return nil;
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSInteger offsety=scrollView.contentOffset.y;
    NSInteger height= [scrollView superview].frame.size.height;
    [imageView setCenter:CGPointMake(imageView.center.x, (height-offsety)*0.5)] ;
}

-(IBAction)mainPage{
    [webviews loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webviewUrl]]];
    
}
-(IBAction)backPage{
    if ([webviews canGoBack]) {
        [webviews goBack];
    }
}
-(IBAction)forward{
    if ([webviews canGoForward]) {
        [webviews goForward];
    }
}
-(IBAction)refresh{
     [webviews loadRequest:[NSURLRequest requestWithURL:nil]];
    NSString *tempUrl=_webviewUrl;
    if ([tempUrl rangeOfString:@"?"].location!=NSNotFound) {
        tempUrl=[tempUrl stringByAppendingString:[NSString stringWithFormat:@"&ttc=%d",arc4random()]];
    }else{
        tempUrl=[tempUrl stringByAppendingString:[NSString stringWithFormat:@"?ttc=%d",arc4random()]];
    }
    NSURL *urlResult=[NSURL URLWithString:[tempUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [webviews loadRequest:[NSURLRequest requestWithURL:urlResult ] ];
    [webviews reload];
}
@end
