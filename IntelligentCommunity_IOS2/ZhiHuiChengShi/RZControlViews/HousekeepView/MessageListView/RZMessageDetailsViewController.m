//
//  RZMessageDetailsViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-11.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZMessageDetailsViewController.h"
#import "RZHomeCommentTableViewCell.h"

#define TranspondMsgUpdateChatContentNotifi @"TranspondMsgUpdateChatContentNotifi"   //转发消息给好友并更新聊天室的用户

@interface RZMessageDetailsViewController ()
{
    UIButton *btnleft;
    UIButton *btnright;
    BOOL isStartOnclick;
    
    
    IBOutlet UIWebView *_webview;
    IBOutlet UIView *_contentView;
   IBOutlet UIView *_commentView;//评论view
    IBOutlet UITableView *_tableview;
    NSMutableArray *_tableDate;
    NSMutableDictionary *DetailsDic;
    
    RcFaceView * faceview;
    
    BOOL isShowinputed;
    BOOL isRecording;
    UIButton *btnsay;
    //底部按钮
    UIView *bottomview;
    //底部按钮
    UIView *viewMoreBottom;
    HPGrowingTextView *messageTextView;  //消息输入框对象
    int touchBeginY;
    NSDateFormatter *formatter;
    
    
 
}
@end

@implementation RZMessageDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0, 7, 200, 35);
        UIView *topview=[[UIView alloc] initWithFrame:rect];
        btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnleft setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
        [btnleft setBackgroundColor:[UIColor clearColor]];
        [btnleft setTitle:@"公告详情" forState:UIControlStateNormal];
        [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnleft.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边未选中.png"] forState:UIControlStateNormal];
        [btnleft setBackgroundImage:[UIImage imageNamed:@"右边选中.png"] forState:UIControlStateSelected];
        [btnleft setTag:101];
        btnleft.selected = YES;
        [btnleft addTarget:self action:@selector(SelectTop:) forControlEvents:UIControlEventTouchUpInside];
        
        btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnright setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height)];
        [btnright setBackgroundColor:[UIColor clearColor]];
        [btnright setTitle:@"讨论区" forState:UIControlStateNormal];
        [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnright.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边未选中.png"] forState:UIControlStateNormal];
        [btnright setBackgroundImage:[UIImage imageNamed:@"左边选中.png"] forState:UIControlStateSelected];
        [btnright setTag:102];
        [btnright addTarget:self action:@selector(SelectTop:) forControlEvents:UIControlEventTouchUpInside];
        
        [topview addSubview:btnleft];
        [topview addSubview:btnright];
        topview.layer.masksToBounds=YES;
        topview.layer.cornerRadius=15;
        self.navigationItem.titleView = topview;
        
    }
    return self;
}
//点击切换显示内容 首次点击 或者加载无数据重新请求 否则取旧数据
-(void)SelectTop:(UIButton*)sender{
    if(sender.tag==101){
        
        btnleft.selected=YES;
        btnright.selected=NO;
        _webview.hidden=NO;
        _contentView.hidden=YES;
        
        
    }
    else if(sender.tag==102){
        
        btnright.selected=YES;
        btnleft.selected=NO;
        _webview.hidden=YES;
        _contentView.hidden=NO;
        
        if([_tableDate count]<1){
            [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeNone];
            NSLog(@"http:2");
 
            [SVProgressHUD dismiss];
 
        }
    }
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    //顶部按钮
    {
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
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_tableview setBackgroundColor:[UIColor whiteColor]];
    _webview.hidden=NO;
    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeNone];
    [self initWebViewContent:1.0f];
    
    /*========
     此部分属于评论内容
     ==========
     */
    bottomview =[[UIView alloc] initWithFrame:CGRectMake(0, _contentView.bounds.size.height-50,_contentView.bounds.size.width, 50)];
    bottomview .autoresizingMask=UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin ;
    bottomview.autoresizesSubviews=YES;
    [bottomview setBackgroundColor:UIColorFromRGB(0xcbcbcb)];
//    bottomview.layer.masksToBounds=YES;
//    bottomview.layer.cornerRadius=7;
    //语音
    /*
    UIButton *btnyy=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnyy setFrame:CGRectMake(8, 6, 40, 40)];
    btnyy.tag=0;
    [btnyy setTitle:@"Y" forState:UIControlStateNormal];
    btnyy .autoresizingMask=UIViewAutoresizingNone |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin ;
    [btnyy setBackgroundColor:[UIColor clearColor]];
    [btnyy addTarget:self action:@selector(actionChangeinput:) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:btnyy];
     */
    
    //表情
    UIButton *btnJ=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnJ setFrame:CGRectMake(5, 6, 40, 40)];
    btnJ .autoresizingMask=UIViewAutoresizingNone |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin ;
    [btnJ setBackgroundColor:[UIColor clearColor]];
//    [btnJ setTitle:@"+" forState:UIControlStateNormal];
    [btnJ setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    
    [btnJ addTarget:self action:@selector(actionFace:) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:btnJ];//actionAddmore:
    
    //发送
    UIButton *btnGO=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnGO setFrame:CGRectMake(255, 6, 40, 40)];
    btnGO .autoresizingMask=UIViewAutoresizingNone |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin ;
    [btnGO setBackgroundColor:[UIColor clearColor]];
    [btnGO addTarget:self action:@selector(actionSendmsg:) forControlEvents:UIControlEventTouchUpInside];
    [btnGO setTitle:@"发送" forState:UIControlStateNormal];
    [bottomview addSubview:btnGO];
    
    //按住说话
    /*
    btnPressSay=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnPressSay setFrame:CGRectMake(106, 6, 142, 40)];
    btnPressSay .autoresizingMask=UIViewAutoresizingNone |UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth ;
    [btnPressSay setBackgroundColor:[UIColor clearColor]];
    [btnPressSay setTitle:@"按住说话" forState:UIControlStateNormal];
    [btnPressSay setTitle:@"松开保存语音" forState:UIControlStateSelected];
    //长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLong:)];
    longPress.minimumPressDuration = 0.3;
    [btnPressSay addGestureRecognizer:longPress];
    
    
    imgInputbg=[[UIImageView alloc] initWithFrame:CGRectMake(106 , 6, 142, 40)];
    imgInputbg.autoresizingMask=UIViewAutoresizingNone |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    imgInputbg.contentMode = UIViewContentModeScaleAspectFill;
    imgInputbg.clipsToBounds = YES;
    imgInputbg.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [imgInputbg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", arc4random()%7 ]] ];
    
    
    [bottomview addSubview:btnPressSay];
    [bottomview addSubview:imgInputbg];
    */
    
    
    
    
    
    
    //输入框
    messageTextView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(50, 10, 180, 25)];
    messageTextView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	messageTextView.minNumberOfLines = 1;
	messageTextView.maxNumberOfLines = 3;
	//messageTextView.returnKeyType = UIReturnKeyGo; //just as an example
	messageTextView.font = [UIFont systemFontOfSize:15.0f];
	messageTextView.delegate = self;
    messageTextView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    messageTextView.backgroundColor = [UIColor whiteColor];
    messageTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [bottomview addSubview:messageTextView];
    
    [_contentView addSubview:bottomview];
    
    
    
    //更多内容
    /*底部*/
    viewMoreBottom =[[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 150)];
    viewMoreBottom .autoresizingMask=UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin ;
    viewMoreBottom.autoresizesSubviews=YES;
    [viewMoreBottom setBackgroundColor:[UIColor whiteColor]];
    viewMoreBottom.layer.masksToBounds=YES;
    viewMoreBottom.layer.cornerRadius=7;
    
    //发送表情
    UIButton *btnBQ=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnBQ setFrame:CGRectMake(80, 36, 53, 53)];
    btnBQ .autoresizingMask=UIViewAutoresizingNone |UIViewAutoresizingFlexibleLeftMargin  |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    [btnBQ setBackgroundColor:[UIColor orangeColor]];
    [btnBQ setTitle:@"表情" forState:UIControlStateNormal];
    [btnBQ addTarget:self action:@selector(actionFace:) forControlEvents:UIControlEventTouchUpInside];
    [viewMoreBottom addSubview:btnBQ];
    
    //发送图片
    UIButton *btnImage=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnImage setFrame:CGRectMake(187, 36, 53,53)];
    btnImage .autoresizingMask=UIViewAutoresizingNone |UIViewAutoresizingFlexibleLeftMargin  |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    
    [btnImage setBackgroundColor:[UIColor redColor]];
    [btnImage setTitle:@"图片" forState:UIControlStateNormal];
    [btnImage addTarget:self action:@selector(actionImage:) forControlEvents:UIControlEventTouchUpInside];
    [viewMoreBottom addSubview:btnImage];
    [_contentView addSubview:viewMoreBottom];
    
    
    
    
    /*语音*/
    /*
    contentYY =[[UIView alloc] initWithFrame:CGRectMake(80, (self.view.bounds.size.height-160)/2, 160, 160)];
    [contentYY setHidden:YES];
    contentYY .autoresizingMask=UIViewAutoresizingNone   ;
    contentYY.autoresizesSubviews=YES;
    [contentYY setBackgroundColor:[UIColor greenColor]];
    
    imgRecorderPower=[[UIImageView alloc] initWithFrame:CGRectMake(35 , 22, 90, 75)];
    imgRecorderPower.autoresizingMask=UIViewAutoresizingNone |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    imgRecorderPower.contentMode = UIViewContentModeScaleAspectFill;
    imgRecorderPower.clipsToBounds = YES;
    imgRecorderPower.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [imgRecorderPower setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", arc4random()%7 ]] ];
    [contentYY addSubview:imgRecorderPower];
    
    lbRecorderPrompt=[[UILabel alloc] initWithFrame:CGRectMake(20, 113, 120, 21)];
    [lbRecorderPrompt setBackgroundColor:[UIColor clearColor]];
    [lbRecorderPrompt setFont:[UIFont systemFontOfSize:14.0f]];
    [contentYY addSubview:lbRecorderPrompt];
    
    [self.view addSubview:contentYY];
    
    */
    
    
    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //监听转发消息后对聊天室的用户更新
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(referenshChatUser:) name:TranspondMsgUpdateChatContentNotifi object:nil];
    
    
    //初始化录音类
    /*
    voiceRecorder = [[VoiceRecorder alloc] init];
    voiceRecorder.vrbDelegate = self;
    
    //初始化播放语音类
    voicePlayer = [[VoicePlayer alloc] init];
    voicePlayer.delegate = self;
    voicePlayer.indexPathrow = -1;
    
    _tabledate = [[NSMutableArray alloc] init];
   
    //    //录音对话框提示
    //    viewRecorderDialog.layer.masksToBounds = YES;
    //    viewRecorderDialog.layer.cornerRadius = 80;
    //
    //    lbRecorderPrompt.layer.masksToBounds = YES;
    //    lbRecorderPrompt.layer.cornerRadius = 8;
     
     */
    
    touchBeginY = 0;
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    oneTap.delegate = self;
    oneTap.numberOfTouchesRequired = 1;
    [_tableview addGestureRecognizer:oneTap];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!faceview)
    {
        faceview = [[RcFaceView alloc] init];
        faceview.delegate = self;
        faceview.view.hidden = YES;
        faceview.FaceView.hidden = NO;
        faceview.FaceView.layer.masksToBounds=YES;
        faceview.FaceView.layer.cornerRadius=0;
        [faceview.FaceView setBackgroundColor:UIColorFromRGB(0xbdbdbd)];
        faceview.FaceView.autoresizingMask=UIViewAutoresizingNone |UIViewAutoresizingFlexibleLeftMargin  |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        [faceview.view setBackgroundColor:[UIColor clearColor]];
        [faceview.FaceView setFrame:CGRectMake((self.view.frame.size.width-faceview.FaceView.frame.size.width)/2, viewMoreBottom.frame.size.height, faceview.FaceView.frame.size.width, faceview.FaceView.frame.size.height)];
        
        [viewMoreBottom addSubview:faceview.FaceView];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Webdelete
-(void)initWebViewContent :(CGFloat)scale{
    NSString *content=[NSString stringWithFormat:@"%@",@"惊天大秘密，你想<p>不想知道，知道请访问www.baidu.com惊天大秘密，你想不想知道，知道请访问www.baidu.com惊天大秘密，你想不想知道，</p><p>知道请访问www.baidu.com惊天大秘密，你想不想知道，知道请访问www.baidu.com惊天大秘密，你想不想知道，知道请访问w</p>ww.baidu.com"];
    NSRange bodyStart=[content rangeOfString:@"<body>"];
    NSRange bodyEnd=[content rangeOfString:@"</body>"];
    if (bodyStart.location!=NSNotFound && bodyEnd.location!=NSNotFound) {
        content=[content substringWithRange:NSMakeRange(bodyStart.location+bodyStart.length, bodyEnd.location-bodyStart.location-bodyStart.length)];
    }
    
    NSString  *string=@"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml'><head runat='server'><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'> <title>测试</title><meta http-equiv='Cache-Control' content='must-revalidate,no-cache'><meta id='viewport'	 name='viewport' content='width=device-width, maximum-scale=2,minimum-scale=1,initial-scale=1.000000'><meta name='MobileOptimized' content='240'></head><style> body{margin:0px;padding:0px;font-size:14px;text-align:left;}p{line-height:25px; text-indent: 0em;} img{width:90%%;text-align:center;display: block;margin: 0px auto;}font{font-size:14px;}#head{text-align:center}  </style>\
    <body style='width:320px; background-color:#ffffff; margin:0px auto;font-family: system;'>\
      <div id='head'><h2>%@</h2><span style='text-align:center'>发布时间:%@  评论数:%@ </span></div><br>\
    <div id='container' style='width:300px;margin:2px auto; font-size:14px;'>%@</div> \
    </body></html>";
    
    content=[NSString stringWithFormat:string  ,@"小区宠物管理规定",@"2014-09-11 11:20",@"3",content];
    _webview.delegate=self;
    [_webview setBackgroundColor:[UIColor clearColor]];
    [_webview loadHTMLString:content baseURL:nil];
    [_webview setUserInteractionEnabled:NO];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self performSelector:@selector(hideSVPHUD) withObject:self afterDelay:1.5];
}
-(void)hideSVPHUD{
    [SVProgressHUD dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    //    return [_tableData count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"RZHomeCommentTableViewCell";
    
    RZHomeCommentTableViewCell * cell=  (RZHomeCommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        
        cell= [[[NSBundle mainBundle] loadNibNamed:@"RZHomeCommentTableViewCell" owner:self options:nil] objectAtIndex:0] ;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.btncomment.tag=1001;
    [cell.btncomment addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.lbTitle.text=[NSString stringWithFormat:@"%@",@""];
    cell.lbTime.text=@"06-14 20:15:04";
    cell.lbSubTitle.text=@"只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有只是应为在人群种多看了你一眼，那夜风雨会不会再有";
    
    CGSize size=[cell.lbSubTitle.text sizeWithFont:cell.lbSubTitle.font constrainedToSize:CGSizeMake(cell.lbSubTitle.frame.size.width, 90000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.lbSubTitle.numberOfLines=size.height/14+2;
    
    [cell.lbSubTitle setFrame:CGRectMake(cell.lbSubTitle.frame.origin.x, cell.lbSubTitle.frame.origin.y, cell.lbSubTitle.frame.size.width,(NSInteger)size.height+14)];
    
    [cell.imageHead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
    
    [cell.imagesex setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://h.hiphotos.baidu.com/image/w%3D400/sign=880260efb68f8c54e3d3c42f0a292dee/d0c8a786c9177f3e405a5a0c72cf3bc79f3d5640.jpg"]] placeholderImage:nil];
    
    [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, cell.lbSubTitle.frame.origin.y+cell.lbSubTitle.frame.size.height+20)];
    
    return cell;

    
}
-(void)comment:(UIButton*)sender{
    NSLog(@"comment");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 
}

#pragma mark Comment
-(void) keyBoardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    // NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSLog(@"duration=%f",[duration floatValue]);
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = bottomview.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    
    [UIView animateWithDuration:[duration doubleValue] animations:^(void){
        isShowinputed = NO;
        bottomview.frame = containerFrame;
    }completion:^(BOOL finished){
        NSLog(@"---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
        isShowinputed = YES;
    }];
    
	
    
	//[UIView commitAnimations];
    
    
    [_tableview setFrame:CGRectMake(_tableview.frame.origin.x, _tableview.frame.origin.y, _tableview.frame.size.width, bottomview.frame.origin.y)];
    //让tableview在最下面
    if([_tableDate count] > 0)
    {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[_tableDate count]-1 inSection:0];
        [_tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

-(void) keyBoardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    // NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
	
    NSLog(@"duration=%f",[duration floatValue]);
	// get a rect for the textView frame
	CGRect containerFrame = bottomview.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
	
    [UIView animateWithDuration:[duration doubleValue] animations:^(void){
        isShowinputed = NO;
        bottomview.frame = containerFrame;
    }completion:^(BOOL finished){
        NSLog(@"---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
        isShowinputed = YES;
    }];
    
    
    [viewMoreBottom setFrame:CGRectMake(viewMoreBottom.frame.origin.x, self.view.frame.size.height, viewMoreBottom.frame.size.width, viewMoreBottom.frame.size.height)];
    
    [_tableview setFrame:CGRectMake(_tableview.frame.origin.x, _tableview.frame.origin.y, _tableview.frame.size.width, self.view.frame.size.height-bottomview.frame.size.height)];
    
}

//发送消息
-(void)sendMessage:(NSString *)sendStr MediaUrl:(NSString *)MediaUrl
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *msgtype=[sendStr substringToIndex:1];
    
    if([msgtype isEqualToString:@"T"])  //文本
    {
        
        
        [dict setObject:[sendStr substringFromIndex:1] forKey:@"msg"];
        
    }else if([msgtype isEqualToString:@"V"])  //语音
    {
//        NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
//        [dateformat setDateFormat:@"yyyyMMddHHmmssSSS"];
//        NSString *audioUrl = [FileManage saveAudiotoLocalname: [dateformat stringFromDate:[NSDate date]] filebase64Data:[sendStr substringFromIndex:1]];
//        
//        [dict setObject:audioUrl forKey:@"msg"];
    }else if([msgtype isEqualToString:@"P"])   //图片
    {
        NSLog(@"mediaurl=%@",MediaUrl);
        [dict setObject:MediaUrl forKey:@"msg"];
        
    }
    
    
    
    [dict setObject:msgtype forKey:@"msgtype"];  //消息类型  //T:文本   V:语音   P:图片
    [dict setObject:@"15581557239" forKey:@"fphone"];  //发送者手机号
    [dict setObject:@"2012-12-12 12:12:12.562" forKey:@"msgtime"];  //接受消息时间
    [dict setObject:[NSString stringWithFormat:@"%d",arc4random()%2] forKey:@"sendflag"];
    [dict setObject:[NSString stringWithFormat:@"%d",arc4random()%7] forKey:@"headimg"];
    
//    [_tableDate addObject:dict];
    
    isShowinputed = NO;
    //重新刷新tableView
    [_tableview reloadData];
    //让tableview在最下面
    if([_tableDate count] > 0)
    {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[_tableDate count]-1 inSection:0];
        [_tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
//发送按钮
-(void)actionSendmsg:(UIButton *)sender
{
    [messageTextView resignFirstResponder];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [viewMoreBottom setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 150)];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [bottomview setFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [_tableview setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50)];
    }];
    
    if(![messageTextView.text isEqualToString:@""])
    {
        [self sendMessage:[NSString stringWithFormat:@"T%@",messageTextView.text] MediaUrl:@""];  //T表示文本信息
        // [messageTextView resignFirstResponder];
        messageTextView.text =@"";
    }
}
//发表更多
-(void)actionAddmore:(UIButton *)sender
{
    [messageTextView resignFirstResponder];
    
    if([messageTextView isHidden])
    {
//        imgInputbg.hidden = NO;
        messageTextView.hidden = NO;
    }
    
    if(faceview.FaceView.frame.origin.y == 2)
    {
        [UIView animateWithDuration:0.25f animations:^(void){
            
            [faceview.FaceView setFrame:CGRectMake((self.view.frame.size.width-faceview.FaceView.frame.size.width)/2 , viewMoreBottom.frame.size.height, faceview.FaceView.frame.size.width, faceview.FaceView.frame.size.height)];
            //            faceview.FaceView.frame.origin.x
        }];
    }
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    
    if(viewMoreBottom.frame.origin.y  == self.view.bounds.size.height)
    {
        [UIView animateWithDuration:0.25f animations:^(void){
            
            isShowinputed = NO;
            [bottomview setFrame:CGRectMake(bottomview.frame.origin.x, bottomview.frame.origin.y-viewMoreBottom.frame.size.height, bottomview.frame.size.width, bottomview.frame.size.height)];
            [viewMoreBottom setFrame:CGRectMake(viewMoreBottom.frame.origin.x, viewMoreBottom.frame.origin.y-viewMoreBottom.frame.size.height, viewMoreBottom.frame.size.width, viewMoreBottom.frame.size.height)];
        } completion:^(BOOL finished){
            isShowinputed = YES;
        }];
        
        
        //
        [_tableview setFrame:CGRectMake(_tableview.frame.origin.x, _tableview.frame.origin.y, _tableview.frame.size.width, bottomview.frame.origin.y)];
        //让tableview在最下面
        if([_tableDate count] > 0)
        {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[_tableDate count]-1 inSection:0];
            [_tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
    
}

//表情
-(void)actionFace:(UIButton *)sender
{
    
    [messageTextView resignFirstResponder];
    
    if([messageTextView isHidden])
    {
        //        imgInputbg.hidden = NO;
        messageTextView.hidden = NO;
    }
    
    if(faceview.FaceView.frame.origin.y == 2)
    {
        [UIView animateWithDuration:0.25f animations:^(void){
            
            [faceview.FaceView setFrame:CGRectMake((self.view.frame.size.width-faceview.FaceView.frame.size.width)/2 , viewMoreBottom.frame.size.height, faceview.FaceView.frame.size.width, faceview.FaceView.frame.size.height)];
            //            faceview.FaceView.frame.origin.x
        }];
    }
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    
    if(viewMoreBottom.frame.origin.y  == self.view.bounds.size.height)
    {
 
        [UIView animateWithDuration:0.25f animations:^(void){
            
            isShowinputed = NO;
            [bottomview setFrame:CGRectMake(bottomview.frame.origin.x, bottomview.frame.origin.y-viewMoreBottom.frame.size.height, bottomview.frame.size.width, bottomview.frame.size.height)];
            [viewMoreBottom setFrame:CGRectMake(viewMoreBottom.frame.origin.x, viewMoreBottom.frame.origin.y-viewMoreBottom.frame.size.height, viewMoreBottom.frame.size.width, viewMoreBottom.frame.size.height)];
        } completion:^(BOOL finished){
            isShowinputed = YES;
        }];

        
        [_tableview setFrame:CGRectMake(_tableview.frame.origin.x, _tableview.frame.origin.y, _tableview.frame.size.width, bottomview.frame.origin.y)];
        
        
        //让tableview在最下面
        if([_tableDate count] > 0)
        {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[_tableDate count]-1 inSection:0];
            [_tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
    
    
    [UIView animateWithDuration:0.25f animations:^(void){
        
        [faceview.FaceView setFrame:CGRectMake((self.view.frame.size.width-faceview.FaceView.frame.size.width)/2 , 0, faceview.FaceView.frame.size.width, faceview.FaceView.frame.size.height)];
        
        //        faceview.FaceView.frame.origin.x
    }];
    
}

//图片
-(void)actionImage:(UIButton *)sender
{
    UIActionSheet *ActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"照相机", nil];
    [ActionSheet showInView:self.view];
    
}
//输入框向下移动
-(void)responsBottommoveDown
{
    int viewMorebottomY = self.view.frame.size.height-viewMoreBottom.frame.size.height;
    
    if(viewMoreBottom.frame.origin.y  == viewMorebottomY)
    {
        [UIView animateWithDuration:0.25 animations:^(void){
            isShowinputed = NO;
            [bottomview setFrame:CGRectMake(bottomview.frame.origin.x, self.view.frame.size.height-bottomview.frame.size.height, bottomview.frame.size.width, bottomview.frame.size.height)];
            
            [viewMoreBottom setFrame:CGRectMake(viewMoreBottom.frame.origin.x, self.view.frame.size.height, viewMoreBottom.frame.size.width, viewMoreBottom.frame.size.height)];
            
        }completion:^(BOOL finished){
            isShowinputed = YES;
        }];
        
        [_tableview setFrame:CGRectMake(_tableview.frame.origin.x, _tableview.frame.origin.y, _tableview.frame.size.width, self.view.frame.size.height-bottomview.frame.size.height)];
    }
}
//长按事件
- (void) pressedLong:(UILongPressGestureRecognizer *) gestureRecognizer
{
    [messageTextView resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        [viewMoreBottom setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 150)];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [bottomview setFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [_tableview setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50)];
    }];
}
-(void)hideKeyBoard
{
    
    [self responsBottommoveDown];
    [messageTextView resignFirstResponder];
}
#pragma mark 图片选取操作
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if(0 == buttonIndex)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            
            ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
            picker.maximumNumberOfSelection = 3;
            picker.assetsFilter = [ALAssetsFilter allPhotos];
            picker.showEmptyGroups=NO;
            picker.delegate=self;
            picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                    NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                    return duration >= 5;
                } else {
                    return YES;
                }
            }];
            [self presentViewController:picker animated:YES completion:NULL];
            
            
        }
        else{
            UIAlertView *alert =[[UIAlertView alloc]
                                 initWithTitle:@"Error accessing photo library" message:@"Device does not support a photo library" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles: nil];
            [alert show];
            
        }
        
    }else if(1 == buttonIndex)
    {
#if !(TARGET_IPHONE_SIMULATOR)
        {
            UIImagePickerController *picker =[[UIImagePickerController alloc] init];
            picker.delegate =self;
            picker.allowsEditing = YES;  //可选择图片区域
            picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
#endif
#if (TARGET_IPHONE_SIMULATOR)
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"模拟器上无法调用摄像功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
#endif
        
    }else if(2 == buttonIndex)
    {
        
    }
}
#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    NSLog(@"－－－－－－调用ZYQAssetPickerController的委托拉");
    [messageTextView resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        [viewMoreBottom setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 150)];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [bottomview setFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [_tableview setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50)];
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i=0; i<assets.count; i++) {
            NSLog(@"-----count=%d",i);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ALAsset *asset=assets[i];
                UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                
                float tempwidth=0.0f;
                float tempheight=0.0f;
                
                tempwidth = tempImg.size.width*0.5;
                tempheight = tempImg.size.height*0.5;
                
                //大图就压缩更小
                if(tempImg.size.width > 1280)
                {
                    tempwidth = tempImg.size.width*0.3;
                    tempheight = tempImg.size.height*0.3;
                    
                }
                
                //小图就原图发送
                if(tempImg.size.width <=320)
                {
                    tempwidth = tempImg.size.width;
                    tempheight = tempImg.size.height;
                    
                }
                
                //图片压缩转换成data
                NSData *data = UIImageJPEGRepresentation([self imageWithImageSimple:tempImg scaledToSize:CGSizeMake(tempwidth, tempheight)], 0.5);
                
                UIImage *imgThum = [[UIImage alloc] initWithData:data];
                
                //生成文件名
                NSString *imagePath = [NSString stringWithFormat:@"%@/%@.jpg",[FileManage getCacheImageDirectory],[FileManage getCurrentTimeString]];
                [data writeToFile:imagePath atomically:YES];
                
                
                //发送图片
                NSMutableString *imgString = [[NSMutableString alloc]initWithString:@"P"]; //V表示是语音信息
                [imgString appendString:[data base64EncodedString]];  //转成base64
                [self sendMessage:imgString MediaUrl:imagePath];
                //
                
                
            });
        }
        
        
    });
}


-(void)assetPickerController:(ZYQAssetPickerController *)picker didSelectAsset:(ALAsset*)asset
{
    NSLog(@"didSelectAsset======");
    if([picker.indexPathsForSelectedItems count] == picker.maximumNumberOfSelection)
    {
        NSString *str = [NSString stringWithFormat:@"最多支持%d张照片发送",picker.maximumNumberOfSelection];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
}

#pragma 照相机委托
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"－－－－－－调用照相机的委托拉");
    
    NSLog(@"照片大小width=%f,height=%f",image.size.width,image.size.height);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSData *data = UIImageJPEGRepresentation([self imageWithImageSimple:image scaledToSize:CGSizeMake(320, 320)], 0.5);
        
        UIImage *imgThum = [[UIImage alloc] initWithData:data];
        
        //生成文件名
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@.jpg",[FileManage getCacheImageDirectory],[FileManage getCurrentTimeString]];
        [data writeToFile:imagePath atomically:YES];
        
        
        //发送图片
        NSMutableString *imgString = [[NSMutableString alloc]initWithString:@"P"]; //V表示是语音信息
        [imgString appendString:[data base64EncodedString]];  //转成base64
        [self sendMessage:imgString MediaUrl:imagePath];
        
        //
        
    });
    
    
    [picker dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"=========================%f",bottomview.frame.origin.y);
    isShowinputed = YES;
}


#pragma RcFaceViewDelegate
-(void)didselectFace:(NSString *)faceCode
{
    NSMutableString *text = [[NSMutableString alloc] initWithString:messageTextView.text];
    [text appendString:faceCode];
    messageTextView.text = text;
    
}



#pragma HPGrowingTextViewDelegate
// 自定义textview委托方法
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = bottomview.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	bottomview.frame = r;
}

@end
