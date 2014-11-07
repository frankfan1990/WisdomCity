//
//  LeftView.m
//  SideslipTabBar
//
//  Created by zhangqingfeng on 13-7-9.
//  Copyright (c) 2013年 zhangqingfeng. All rights reserved.
//

#import "LeftView.h"
#import "SMViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RZinformationViewController.h"
#import "RZuserConfigViewController.h"


@implementation LeftView

- (id)initWithArray:(NSArray *)array Title:(NSArray*)arrayTitle Icon:(NSArray *)arrayIcon
{
    self = [super initWithFrame:self.bounds];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.75];
        self.viewConttrollers=array;
        self.viewConttrollersIcon=arrayIcon;
        self.viewConttrollersTitle=arrayTitle;
//        UILabel *titleLabel_=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, 260, 44)];
//        titleLabel_.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
//        titleLabel_.layer.shadowColor=[UIColor blackColor].CGColor;
//        titleLabel_.layer.shadowOffset=CGSizeMake(-2, -5);
//        titleLabel_.layer.shadowOpacity=0.5;
//        titleLabel_.text=@"此处可放置logo和一些按扭";
//        titleLabel_.font=[UIFont boldSystemFontOfSize:20];
////        titleLabel_.textAlignment=NSTextAlignmentCenter;
//        titleLabel_.textColor=[UIColor whiteColor];
//        [self addSubview:titleLabel_];
//
    
        
        UITableView *tableView_=[[UITableView alloc] initWithFrame:CGRectMake(20, 0, 200, [UIScreen mainScreen].bounds.size.height)];
//        tableView_.backgroundColor=[UIColor clearColor];
//        tableView_.separatorStyle=UITableViewCellSeparatorStyleNone;
//        tableView_.rowHeight=50;
//        tableView_.delegate=self;
//        tableView_.dataSource=self;
//        [self addSubview:tableView_];
//        
//        NSIndexPath *indexPath_=[NSIndexPath indexPathForRow:0 inSection:0];
//        
//        [tableView_ selectRowAtIndexPath:indexPath_ animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        tableView_.delegate = self;
        tableView_.dataSource = self;
        tableView_.opaque = NO;
        tableView_.backgroundColor = [UIColor clearColor];
//        tableView_.separatorStyle=UITableViewCellSeparatorStyleNone;
        if(IOS7){
         [tableView_ setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        tableView_.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
            [view setBackgroundColor:[UIColor clearColor]];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
 
//            NSDictionary *temp=[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
            
            [imageView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"100.png"]];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 50.0;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            imageView.layer.borderWidth = 1.0f;
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.layer.shouldRasterize = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor=[ UIColor clearColor];
            UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateUserImage:)];
            imgtap.delegate=self;
            [imageView setUserInteractionEnabled:YES];
            [imageView addGestureRecognizer:imgtap];
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
            label.text =  @"飞翔的小吉吉";
            label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            [label sizeToFit];
            label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            UITapGestureRecognizer *lbtap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goInformationView:)];
            lbtap.delegate=self;
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:lbtap];
            
            [view addSubview:imageView];
          [view addSubview:label];
            view;
        });
      [self setExtraCellLineHidden:tableView_];
     [self addSubview:tableView_];
    }
    return self;
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate
-(void)updateUserImage:(UITapGestureRecognizer*)recognizer{
    
}

-(void)goInformationView:(UITapGestureRecognizer*)recognizer{
    [SMViewController sharedSMViewController].selectedIndex=1;
 
    [[SMViewController sharedSMViewController] closeSideBar:YES];
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (tableView.frame.size.height-184)/self.viewConttrollers.count-2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.viewConttrollers.count-2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *cellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSArray *titles =self.viewConttrollersTitle;
    NSArray *images =self.viewConttrollersIcon;
    cell.textLabel.text = titles[indexPath.row+2];
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",images[indexPath.row+2]]];
    return cell;
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [SMViewController sharedSMViewController].selectedIndex = indexPath.row+2;
 
     [[SMViewController sharedSMViewController] closeSideBar:YES];
}

- (void)btnClick{
    NSLog(@"left");
}

@end
