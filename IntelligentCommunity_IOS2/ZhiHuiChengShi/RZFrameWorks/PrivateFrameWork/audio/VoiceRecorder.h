//
//  VoiceRecorder.h
//  RcChat
//
//  Created by rching on 13-10-16.
//  Copyright (c) 2013年 rching. All rights reserved.
//
/************
 录音类
 ***********/

#import <Foundation/Foundation.h>
#import "VoiceRecorderBaseVC.h"

@interface VoiceRecorder : VoiceRecorderBaseVC


@property (retain, nonatomic)   AVAudioRecorder     *recorder;

//开始录音
- (void)beginRecordByFileName:(NSString*)_fileName;

//结束录音
-(void)recorderEnd;

//取消录音
-(void)cancelRecorder;

@end
