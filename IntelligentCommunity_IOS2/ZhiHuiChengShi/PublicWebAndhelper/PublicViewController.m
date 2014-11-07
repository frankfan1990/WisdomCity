//
//  PublicViewController.m
//  RcYiRenTang
//
//  Created by H.DX on 14-6-9.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "PublicViewController.h"
#import "RZAppDelegate.h"

@interface PublicViewController ()
{

     UIWebView *webview;
    UIButton *Post;
    UILabel *lblLoadstat;
    UIActivityIndicatorView *loadingActi;
    UILabel * label;
    
}
@end

@implementation PublicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
       label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"帮助中心";
        label.adjustsFontSizeToFitWidth=YES;
                label.textAlignment =NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        self.navigationItem.titleView = label;
    }
    return self;
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [loadingActi stopAnimating];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    [self.view setBackgroundColor:[UIColor grayColor]];

    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(5, 5, 30, 30)];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBack setTitle:@"" forState:UIControlStateNormal];
    if(_Type!=1){
    [btnBack setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    }
    btnBack.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        if(_Type!=1){
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        }
    UIBarButtonItem *btnBackitem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnBackitem];
    }else{
        self.navigationItem.leftBarButtonItem = btnBackitem;
    }
    
    
        if(_Type==0){
            NSLog(@"帮助中心");
                        label.text=@"帮助中心";
            if(_Types==1){
                            label.text=@"金币说明";
            }
            else if(_Types==2){
                            label.text=@"担保金说明";
            }

            webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320,  [UIScreen mainScreen].bounds.size.height-64)];
            webview.delegate=self;
            lblLoadstat=[[UILabel alloc] initWithFrame:CGRectMake(0,  [UIScreen mainScreen].bounds.size.height-25-64, 320, 25)];
            [lblLoadstat setBackgroundColor:[UIColor colorWithRed:62/255.0f green:180/255.0f blue:180/255.0f alpha:0.8]];
            [lblLoadstat setTextColor:[UIColor whiteColor]];
            [lblLoadstat setFont:[UIFont systemFontOfSize:12.0f]];
            [self .view addSubview:webview];
            [self .view addSubview:lblLoadstat];
        }
        else if(_Type==1){
            NSLog(@"服务条框%f %f",self.view.frame.size.height,[UIScreen mainScreen].bounds.size.height);
            label.text=@"艺人堂用户服务条款";
            webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-50-64)];
            webview.delegate=self;
            lblLoadstat=[[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-75-64, 320, 25)];
            [lblLoadstat setBackgroundColor:[UIColor colorWithRed:62/255.0f green:180/255.0f blue:180/255.0f alpha:0.8]];
            [lblLoadstat setTextColor:[UIColor whiteColor]];
            [lblLoadstat setFont:[UIFont systemFontOfSize:12.0f]];
            Post=[UIButton buttonWithType:UIButtonTypeCustom];
            [Post setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-64, 320, 50)];
            [Post setTitle:@"同意艺人堂用户服务条款" forState:UIControlStateNormal];
            [Post setBackgroundColor:Defaultcolor];
            [Post setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //        [Post setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [Post.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [Post addTarget:self action:@selector(Agree) forControlEvents:UIControlEventTouchUpInside];
            [self .view addSubview:webview];
            [self .view addSubview:lblLoadstat];
            [self .view addSubview:Post];
            
            
        }
        else if(_Type==2){
            label.text=@"支付账户信息";
            webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320,  [UIScreen mainScreen].bounds.size.height-64)];
            webview.delegate=self;
            lblLoadstat=[[UILabel alloc] initWithFrame:CGRectMake(0,  [UIScreen mainScreen].bounds.size.height-25-64, 320, 25)];
            [lblLoadstat setBackgroundColor:[UIColor colorWithRed:62/255.0f green:180/255.0f blue:180/255.0f alpha:0.8]];
            [lblLoadstat setTextColor:[UIColor whiteColor]];
            [lblLoadstat setFont:[UIFont systemFontOfSize:12.0f]];
            [self .view addSubview:webview];
            [self .view addSubview:lblLoadstat];
        }
   
    
    loadingActi=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingActi setFrame:CGRectMake(149, 219, 20, 20)];
    
    [self .view addSubview:loadingActi];
    
    NSURL *urlResult=[NSURL URLWithString:[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (urlResult==nil) {
        urlResult=[NSURL URLWithString:_url];
    }
//    [webview setFrame:CGRectMake(0, 0, 320, 22)];
    [webview loadRequest:[NSURLRequest requestWithURL:urlResult]];
    for (UIView *view in [[[webview subviews] lastObject] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view setHidden:YES];
        }
    }
    [webview setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//取得当前程序的委托
-(RZAppDelegate *)appDelegate{
    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
}
//同意后跳转首页
-(void)Agree{
//    
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    if([[NSString stringWithFormat:@"%@",[[user objectForKey:UserInfoKey] objectForKey:@"level"]] compare:@"A" options:NSCaseInsensitiveSearch | NSNumericSearch]==NSOrderedSame)
//    {
//    [user setObject:@"Y" forKey:[NSString stringWithFormat:@"%@%@",ServecsYorN,[[user objectForKey:UserInfoKey] objectForKey:@"producerId"]]];//所属用户是否同意了服务条框 而且是否是第一次登录
//    }
//    else{
////       [user setObject:@"Y" forKey:[NSString stringWithFormat:@"%@%@",ServecsYorN,[[user objectForKey:UserInfoKey] objectForKey:@"producerId"]]];//所属用户是否同意了服务条框 而且是否是第一次登录
//       [user setObject:@"Y" forKey:[NSString stringWithFormat:@"%@%@",ServecsYorN,[[user objectForKey:UserInfoKey] objectForKey:@"lowerId"]]];//所属用户是否同意了服务条框 而且是否是第一次登录
//    
//    }
//    [user synchronize];
//    [[self appDelegate] UserIsLogin];//登录成功
    
}
#pragma mark UIWebview
NSString * createImageJavaScripts(){
    NSString *js=@"var imgs=document.getElementsByTagName('img');for(var i=0;i<imgs.length;i++){imgs[i].onclick=function(){ var url='imagePath:'+this.src;document.location=url;};}";
    return js;
}

- (void) initImageShow: (UIImage *) image webView: (UIWebView *) webView  {
//    CGRect frame= [webView superview].frame;
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom ];
//    [btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    [btn setEnabled:YES];
//    [btn addTarget:self action:@selector(releaseImageShow) forControlEvents:UIControlEventTouchUpInside];
//    imageScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    imageScroll.delegate=self;
//    NSInteger imgWidth=[image size].width;
//    NSInteger imgHeight=[image size].height ;
//    CGFloat zoomWidth=frame.size.width/imgWidth;
//    CGFloat zoomHeight=frame.size.height/imgHeight;
//    CGFloat zoom=zoomHeight>zoomWidth?zoomWidth:zoomHeight;
//    CGFloat origin_x=(frame.size.width-imgWidth)/2.0;
//    CGFloat origin_y=(frame.size.height-imgHeight)/2.0;
//    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(origin_x, origin_y-44, frame.size.width, frame.size.height*imgHeight/imgWidth)];
//    [imageView setImage: image];
//    [imageScroll setMaximumZoomScale:5.f];
//    [imageScroll setMinimumZoomScale:zoom];
//    [imageScroll setZoomScale:zoom];
//    [imageScroll addSubview:btn];
//    [imageScroll addSubview:imageView];
//    
//    backView=[[UIView alloc] initWithFrame:frame];
//    [backView setBackgroundColor:[UIColor blackColor]];        //[backView addSubview:btn];
//    [backView addSubview:imageScroll];
//    [[webView superview] addSubview:backView];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    lblLoadstat.text=@"加载中......";
    [loadingActi startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:createImageJavaScripts()];
    [loadingActi stopAnimating];
    lblLoadstat.text=@"加载完成!";
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stop) userInfo:nil repeats:NO];
    
}
-(void)stop{
    [lblLoadstat setHidden:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [loadingActi stopAnimating];
    lblLoadstat.text=@"加载完成!";
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stop) userInfo:nil repeats:NO];
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
//            [self performSelectorOnMainThread:@selector(sendMessage:) withObject:link waitUntilDone:NO];
            return NO;
        }
    }
    
    [loadingActi startAnimating];
    return YES;
}

-(void)backPage{
    if ([webview canGoBack]) {
        [webview goBack];
    }
}
-(void)forward{
    if ([webview canGoForward]) {
        [webview goForward];
    }
}
-(void)refresh{
 
//    [webview.request initWithURL:nil];
     [webview loadRequest:[NSURLRequest requestWithURL:nil]];
    NSString *tempUrl=_url;
    if ([tempUrl rangeOfString:@"?"].location!=NSNotFound) {
        tempUrl=[tempUrl stringByAppendingString:[NSString stringWithFormat:@"&ttc=%d",arc4random()]];
    }else{
        tempUrl=[tempUrl stringByAppendingString:[NSString stringWithFormat:@"?ttc=%d",arc4random()]];
    }
    NSURL *urlResult=[NSURL URLWithString:[tempUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [webview loadRequest:[NSURLRequest requestWithURL:urlResult ] ];
    [webview reload];
}

@end
