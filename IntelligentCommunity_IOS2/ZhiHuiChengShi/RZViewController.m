//
//  RZViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-6-17.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//
#pragma mark 首次启动
#import "RZViewController.h"
#import "RZAppDelegate.h"

@interface RZViewController ()

@end

@implementation RZViewController
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
 
    [super viewDidLoad];

        UIImageView *image=[[UIImageView alloc] init];
        if([UIScreen mainScreen].bounds.size.height==480){
            [image setImage:[UIImage imageNamed:@"960.png"]];
        }
        else
        {
            [image setImage:[UIImage imageNamed:@"1136.png"]];
        }
        [image setBackgroundColor:[UIColor clearColor]];
        [image setFrame:[UIScreen mainScreen].bounds];
        
        [self.view addSubview:image];
        
        [image setUserInteractionEnabled:YES];
        //点击返回登录
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLogin:)];
        [image addGestureRecognizer:singleTap];
        
    
    	// Do any additional setup after loading the view, typically from a nib.
}

//取得当前程序的委托
-(RZAppDelegate *)appDelegate{
    return (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(void)goLogin:(UITapGestureRecognizer*)tap{
    if(_IsStart){
        //首次启动
        [[self appDelegate] goInfo:NO];
    }
    else{
        [self back];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
