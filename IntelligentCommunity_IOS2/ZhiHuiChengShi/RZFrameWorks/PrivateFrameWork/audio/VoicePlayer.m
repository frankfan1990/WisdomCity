//
//  VoicePlayer.m
//  RcChat
//
//  Created by rching on 13-10-16.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import "VoicePlayer.h"

@implementation VoicePlayer

@synthesize indexPathrow;
@synthesize delegate;

-(void)playerAudioPath:(NSString *)audioPath  //播放语音文件
{
    [self init:-1 audioPath:audioPath];
}

-(void)playerAudioPath:(NSString *)audioPath indexRow:(int)indexRow
{
    [self init:indexRow audioPath:audioPath];
}

-(void)init:(int)index audioPath:(NSString *)audioPath
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    // [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    indexPathrow = index;
    
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:audioPath];
    
    if(audioPlayer)
    {
        audioPlayer.delegate = nil;
        [audioPlayer release];
        audioPlayer = nil;
    }
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
     NSLog(@"----------------------%f",audioPlayer.duration);
    
    audioPlayer.delegate = self;
    [audioPlayer prepareToPlay];
    [soundUrl release];
    
   
    
    [audioPlayer play];
}

-(BOOL) isPlay
{
    return [audioPlayer isPlaying];
}
-(void) audioStop
{
    if([delegate respondsToSelector:@selector(audioPlayerEndinteruption:)])
    {
        [delegate audioPlayerEndinteruption:indexPathrow];
        indexPathrow = -1;
    }
    [audioPlayer stop];

}

-(double)getDurationinPath:(NSString *)audioPath
{
    double duration=0.0f;
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:audioPath];
    AVAudioPlayer *play = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    duration = play.duration;
    
    [play release];
    [soundUrl release];
    return duration;
}


#pragma AVAudioPlayerDelegate

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放结束时执行的动作
    if([delegate respondsToSelector:@selector(audioPlayerFinish:)])
    {
        [delegate audioPlayerFinish:indexPathrow];
        indexPathrow = -1;
    }
}

- (void)audioPlayerEndInteruption:(AVAudioPlayer*)player
{
    //处理中断结束的代码
    if([delegate respondsToSelector:@selector(audioPlayerEndinteruption:)])
    {
        [delegate audioPlayerEndinteruption:indexPathrow];
        indexPathrow = -1;
    }
}


@end
