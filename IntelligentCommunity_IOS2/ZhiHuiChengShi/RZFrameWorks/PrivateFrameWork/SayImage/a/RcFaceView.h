//
//  RcFaceView.h
//  Rching
//
//  Created by rching on 13-9-13.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RcFaceViewDelegate;

@interface RcFaceView : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UILabel *lbTitle;  //标题
    
    IBOutlet UIScrollView *faceScrollView;
    IBOutlet UIPageControl *PageControl;
    
    NSMutableArray *phraseArray;
}

@property(nonatomic,assign) id<RcFaceViewDelegate>delegate;

@property(nonatomic,retain) IBOutlet UIView *FaceView;

-(IBAction)back:(id)sender;

-(void)showEmojiView;

-(IBAction)exitEidt:(id)sender;

@end


//点击表情委托
@protocol RcFaceViewDelegate <NSObject>

@optional
-(void)didselectFace:(NSString *)faceCode;

@end

