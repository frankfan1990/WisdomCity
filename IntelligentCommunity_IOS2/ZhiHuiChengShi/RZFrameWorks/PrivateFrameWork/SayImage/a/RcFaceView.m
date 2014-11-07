//
//  RcFaceView.m
//  Rching
//
//  Created by rching on 13-9-13.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import "RcFaceView.h"
#import <QuartzCore/QuartzCore.h>

#define columns 7  //列数
#define rows 3    //行数
#define itemsPerPage 21     //一页能放多少个item
#define space 10
#define gridHight 32     //view的高度
#define gridWith 32      //view 的宽度
#define unValidIndex  -1  //item
#define threshold 30
#define Myx 12    //贴item之间的x坐标
#define Myy 10    //贴item之间的y坐标



@interface RcFaceView ()

@end

@implementation RcFaceView

@synthesize delegate;
@synthesize FaceView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [FaceView release];
    [lbTitle release];
    [phraseArray release];
    [faceScrollView release];
    [super dealloc];
}

-(IBAction)back:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
}

//-(id)init
//{
//    [super init];
//    if(self)
//    {
//
//    }
//    return  self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[lbTitle setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bg.png"]]];
    
    phraseArray = [[NSMutableArray alloc] init];
    faceScrollView.bounces = NO;  //设置滑到最后不可滑动
    
    //增加表情到面板上
    for (int i = 0; i<105; i++)
    {
        UIImage *face  = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        NSMutableDictionary *dicFace = [NSMutableDictionary dictionary];
        [dicFace setObject:face forKey:[NSString stringWithFormat:@"[#%d]",i]];
        [phraseArray addObject:dicFace];
    }
    //增加表情到scrollview上
    [self showEmojiView];
    
    [PageControl setBackgroundColor:[UIColor clearColor]];
    [PageControl setEnabled:NO];
    PageControl.userInteractionEnabled = NO;
    PageControl.numberOfPages = 5;
    PageControl.currentPage = 0;

}

- (void)showEmojiView
{

    
    for (int i = 0 ; i < 105 ; i++ )
    {
        CGRect frame = CGRectMake(Myx, Myy, gridWith, gridHight);
        int n = i;
        int row = (n) / columns;
        int col = (n) % columns;
        int curpage = (n) / itemsPerPage;
        row = row % rows;
        if (n / itemsPerPage + 1 > itemsPerPage) {  //12 为item树木
            NSLog(@"不能创建更多页面");
        }
        
        frame.origin.x = frame.origin.x + frame.size.width * col + Myx * col + faceScrollView.frame.size.width * curpage;
        frame.origin.y = frame.origin.y + frame.size.height * row + Myy * row;
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = frame;
       // button.frame = CGRectMake(10 + xIndex*32, 10 + yIndex*32, 32.0f, 32.0f);
        NSMutableDictionary *tempdic = [phraseArray objectAtIndex:i];

        UIImage *tempImage = [tempdic valueForKey:[NSString stringWithFormat:@"[#%d]",i]];
        [button setBackgroundImage:tempImage forState:UIControlStateNormal];
                [button setBackgroundImage:tempImage forState:UIControlStateHighlighted];
        button.tag = i;
        
        [button addTarget:self action:@selector(didSelectAFace:)forControlEvents:UIControlEventTouchUpInside];
        
        [faceScrollView addSubview:button];
        
        [faceScrollView setContentSize:CGSizeMake(faceScrollView.frame.size.width * (curpage + 1), faceScrollView.frame.size.height)];
    }
    


    
    //[faceScrollView setContentSize:CGSizeMake(300.0f, 12 + (yIndex+1)*32)];
    
}

-(void)didSelectAFace:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    
    NSDictionary *tempDic = [phraseArray objectAtIndex:sender.tag];
    NSArray *tempArray = [tempDic allKeys];
    
    NSString *faceCode = [NSString stringWithFormat:@"%@",[tempArray objectAtIndex:0]];
    NSLog(@"facecode=%@",faceCode);
    
    //调用委托传递点击表情代码
    [delegate didselectFace:faceCode];
   // [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;//+2*PADDING;
    int count = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(count < 0 && count > 5)
        return;
    [PageControl setCurrentPage:count];
}

-(IBAction)exitEidt:(id)sender
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.4;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    
    self.view.hidden = YES;
}




@end
