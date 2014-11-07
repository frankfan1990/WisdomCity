//
//  VoiceRecorder.m
//  RcChat
//
//  Created by rching on 13-10-16.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import "VoiceRecorder.h"
#import "VoiceRecorderBaseVC.h"


@interface VoiceRecorder() <AVAudioRecorderDelegate>
{
    CGFloat                 curCount;           //当前计数,初始为0
    BOOL                    canNotSend;         //不能发送
    NSTimer                 *timer;
}

@end


@implementation VoiceRecorder
@synthesize recorder;


- (void)dealloc{
    [recorder release];
    [super dealloc];
}

#pragma mark - 开始录音

- (void)beginRecordByFileName:(NSString*)_fileName
{
    //设置文件名和录音路径
    self.recordFileName = _fileName;
    self.recordFilePath = [VoiceRecorderBaseVC getPathByFileName:recordFileName ofType:@"wav"];
    NSLog(@"HDX-appdirect=%@",self.recordFilePath);
    
    //初始化录音
    NSError *error ;
    NSDictionary *dic = [VoiceRecorderBaseVC getAudioRecorderSettingDict];
    self.recorder = [[[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:recordFilePath]
                                                settings:dic
                                                   error:&error]autorelease];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    
    [recorder prepareToRecord];
    
    //还原计数
    curCount = 0;
    //还原发送
    canNotSend = NO;
    
    //开始录音
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [recorder record];
    
    //启动计时器
    [self startTimer];
}

#pragma mark - 启动定时器
- (void)startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
}

#pragma mark - 停止定时器
- (void)stopTimer{
    if (timer && timer.isValid){
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark - 更新音频峰值
- (void)updateMeters{
    if (recorder.isRecording){
        NSLog(@"录音时间=%f",curCount);
        //更新峰值
        [recorder updateMeters];

        NSLog(@"峰值:%f",[recorder averagePowerForChannel:0]);
        
        //回调录音峰值
        if([self.vrbDelegate respondsToSelector:@selector(VoiceRecorderBaseVCRecordAveragePower:)])
        {
            [self.vrbDelegate VoiceRecorderBaseVCRecordAveragePower:[recorder averagePowerForChannel:0]];
        }
        
        //倒计时
        if (curCount >= maxRecordTime - 10 && curCount < maxRecordTime) {
            //剩下10秒
            NSLog(@"剩余时间:%@",[NSString stringWithFormat:@"录音剩下:%d秒",(int)(maxRecordTime-curCount)]) ;
        }else if (curCount >= maxRecordTime){
            //时间到
            [self recorderEnd];
        }
        curCount += 0.1f;
    }
}

#pragma mark - 录音结束
-(void)recorderEnd
{
    //停止录音
    if (recorder.isRecording)
        [recorder stop];
    
    //时间小于0.5秒则取消录音
    if(curCount <0.500000f)
    {
        canNotSend = YES;
    }
    
    if (canNotSend) {
        //取消发送，删除文件
        [VoiceRecorderBaseVC deleteFileAtPath:recordFilePath];
        
        //回调录音取消
        if([self.vrbDelegate respondsToSelector:@selector(VoiceRecorderBaseVCRecordCancel:)])
        {
            [self.vrbDelegate VoiceRecorderBaseVCRecordCancel:curCount];
        }
        
    }else{
        //回调录音文件路径
        if ([self.vrbDelegate respondsToSelector:@selector(VoiceRecorderBaseVCRecordFinish:fileName:)])
        {
            [self.vrbDelegate VoiceRecorderBaseVCRecordFinish:recordFilePath fileName:recordFileName];
        }

    }
}

//取消录音
-(void)cancelRecorder
{
    //停止录音
    if (recorder.isRecording)
    {
        [recorder stop];
    }
    
    //取消发送，删除文件
    [VoiceRecorderBaseVC deleteFileAtPath:recordFilePath];
}

#pragma mark - AVAudioRecorder Delegate Methods
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    //    NSLog(@"录音停止");
    
    [self stopTimer];
    curCount = 0;
}
- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder{
    NSLog(@"录音开始");
    [self stopTimer];
    curCount = 0;
}
- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags{
    NSLog(@"录音中断");
    [self stopTimer];
    curCount = 0;
}


@end
