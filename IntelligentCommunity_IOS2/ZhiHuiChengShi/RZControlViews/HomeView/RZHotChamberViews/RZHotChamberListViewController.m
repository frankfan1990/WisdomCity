//
//  RZHotChamberListViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-9-4.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#pragma mark ** 找一找/首页 - 热点议事厅

#import "RZHotChamberListViewController.h"
#import "RESideMenu.h"
#import "TextStepperField.h"

@interface RZHotChamberListViewController ()
{
    IBOutlet UISegmentedControl *segment;
    
    IBOutlet UILabel *lbtishi;
    
    
   NSInteger counter;
}
@end

@implementation RZHotChamberListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect rect = CGRectMake(0, 0, 200, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"热点议事厅";
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
    [btn2 setTitle:@"发起" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 40, 45)];;
     btn2.titleLabel.font = [UIFont systemFontOfSize:17];
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

    
    

    
//    _starRatingView = [[RZStarRatingView alloc] initWithFrame:CGRectMake(30, 200, 60, 25)
//                                                numberOfStar:kNUMBER_OF_STAR];
//    _starRatingView.delegate = self;
//    [_starRatingView setScore:0.4 withAnimation:YES];
//    [self.view addSubview:_starRatingView];
//    
//    TextStepperField *stepper = [[TextStepperField alloc] initWithFrame:CGRectMake(50, 100, 100, 25)];
//    [stepper addTarget:self
//                action:@selector(programmaticallyCreatedStepperDidStep:)
//      forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:stepper];

    counter=0;
    
    segment.layer.cornerRadius = 8;
    segment.backgroundColor = [UIColor whiteColor];
    segment.tintColor = [UIColor colorWithRed:70/255.0 green:128/255.0 blue:218/255.0 alpha:1];
    segment.layer.borderColor = [UIColor colorWithRed:70/255.0 green:128/255.0 blue:218/255.0 alpha:1].CGColor;
    segment.layer.borderWidth = 1;
    segment.layer.masksToBounds = YES;
    
    
//    lbtishi.backgroundColor=[UIColor whiteColor];
//    lbtishi.layer.masksToBounds=YES;
//    lbtishi.layer.cornerRadius=5;
//    lbtishi.layer.shadowColor = [UIColor redColor].CGColor;
//    lbtishi.layer.shadowOpacity = 1.0;
//    lbtishi.layer.shadowRadius = 5.0;
//    lbtishi.layer.shadowOffset = CGSizeMake(0, 2);
//    lbtishi.clipsToBounds = YES;
    
    
}

- (void)programmaticallyCreatedStepperDidStep:(TextStepperField *)stepper {
    if (stepper.TypeChange == TextStepperFieldChangeKindNegative) {
        counter -= 1;
    }
    else {
        counter += 1;
    }
    
 lbtishi.text = [NSString stringWithFormat:@"%d PR", counter];
}


-(void)starRatingView:(RZStarRatingView *)view score:(float)score
{
    NSLog(@"%f",score/2);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
