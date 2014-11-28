//
//  RZHot_PrepareViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-19.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZHot_PrepareViewController.h"

@interface RZHot_PrepareViewController ()
{
    NSString *imageUrl;
    NSString *nameStr;
    NSString *timeStr;
    NSString *contentStr;
    NSString *numberOfhead;
    NSString *numberofneed;
    BOOL isAttention;
}
@end
@implementation RZHot_PrepareViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, -15, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"议题详情";
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
    [self Variableinitialization];
    [self createTabBar];
    [self createHeadView];
    
}
-(void)Variableinitialization
{
    isAttention = NO;
    imageUrl = @"头像_4";
    nameStr = @"JM_思密达";
    numberOfhead = @"9999";
    numberofneed = @"10";
    timeStr = @"2014-07-02 11:30";
    contentStr = @"测就是的测试文字阿双方嘎哈健康是一个个按设计开发嘎哈就是的测试文字阿双方嘎哈健康是一个个按设计开发嘎哈就是的的再重新注册的的";
}
-(void)createHeadView
{
     CGFloat height =  [self caculateTheTextHeight:contentStr andFontSize:18];
    
    UIScrollView *scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 68, Mywidth, 200)];
    
    scroView.scrollEnabled = NO;
    [self.view addSubview:scroView];
    
    if (height > 200) {
        scroView.scrollEnabled = YES;
        scroView.contentSize = CGSizeMake(Mywidth, height);
    }
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 45, 45)];
    imageV.image = [UIImage imageNamed:@"头像_4"];
    [self.view addSubview:imageV];
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, Mywidth-70, 20)];
    namelabel.text = nameStr;
    namelabel.textColor = [UIColor blackColor];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:namelabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 38, Mywidth-70, 20)];
    timeLabel.text = timeStr;
    timeLabel.textColor = UIColorFromRGB(0xaeaeae);
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:timeLabel];
    

    
    UILabel *_labelOfnumber_head = [[UILabel alloc] init];
    _labelOfnumber_head.frame = CGRectMake(10, 0,50, 20);
    _labelOfnumber_head.textColor = [UIColor whiteColor];
    _labelOfnumber_head.textAlignment = NSTextAlignmentCenter;
    _labelOfnumber_head.layer.masksToBounds = YES;
    _labelOfnumber_head.layer.cornerRadius = 10;
    _labelOfnumber_head.adjustsFontSizeToFitWidth = YES;
    _labelOfnumber_head.backgroundColor = UIColorFromRGB(0x5496DF);
    _labelOfnumber_head.font = [UIFont systemFontOfSize:15];
    _labelOfnumber_head.text = numberOfhead;
    [scroView addSubview:_labelOfnumber_head];
    
    UILabel *contentLbael = [[UILabel alloc] initWithFrame:CGRectMake(10,0, Mywidth-20,height)];
    contentLbael.numberOfLines = 1000;
    contentLbael.font = [UIFont systemFontOfSize:18];
    contentLbael.text = [NSString stringWithFormat:@"            %@",contentStr];
    contentLbael.textAlignment = NSTextAlignmentLeft;
    contentLbael.textColor = [UIColor blackColor];
    [scroView addSubview:contentLbael];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 288, 40, 20)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(25+40+2, 288, 20, 20)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(25+40+2+20, 288, Mywidth-50+40+2+30, 20)];
    
    label1.text = @"还需";
    label2.text = numberofneed;
    label3.text = @"位邻居关注即可成为正式议题";
    
    label1.font = [UIFont systemFontOfSize:15];
    label2.font = [UIFont systemFontOfSize:15];
    label3.font = [UIFont systemFontOfSize:15];
    
    label1.textAlignment = NSTextAlignmentRight;
    label2.textAlignment = NSTextAlignmentCenter;
    label3.textAlignment = NSTextAlignmentLeft;
    
    label1.textColor = UIColorFromRGB(0x868686);
    label2.textColor = UIColorFromRGB(0x5695e2);
    label3.textColor = UIColorFromRGB(0x868686);
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.userInteractionEnabled = YES;
    btn.frame = CGRectMake(15, 288 + 60, Mywidth - 30, 45);
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    if (isAttention) {
        [btn setTitle:@"   已关注" forState:UIControlStateNormal];
        btn.backgroundColor = UIColorFromRGB(0x888888);
    }else{
        [btn setTitle:@"  关注" forState:UIControlStateNormal];
        btn.backgroundColor = UIColorFromRGB(0x5496DF);
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"白眼睛"]];
    image1.frame = CGRectMake(Mywidth/2-60, 14, 25, 17);
    [btn addSubview:image1];
}

-(void)createTabBar{
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
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"更多"]  forState:UIControlStateNormal];
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
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didExit:(UIButton *)sender
{
    
}
-(void)didBtn:(UIButton *)sender{
    if (!isAttention) {
        [sender setTitle:@"    已关注" forState:UIControlStateNormal];
        sender.backgroundColor = UIColorFromRGB(0x888888);
    }
    
}
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(Mywidth-40, CGFLOAT_MAX);
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
