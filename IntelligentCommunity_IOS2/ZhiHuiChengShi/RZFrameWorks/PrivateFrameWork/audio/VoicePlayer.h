//
//  VoicePlayer.h
//  RcChat
//
//  Created by rching on 13-10-16.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol VoicePlayerDelegate <NSObject>

//播放结束 返回某一条cell的index.row
-(void)audioPlayerFinish:(int)indexRow;

//播放中断结束 返回某一条cell的index.row
-(void)audioPlayerEndinteruption:(int)indexRow;


@end

@interface VoicePlayer : NSObject<AVAudioPlayerDelegate>
{
    AVAudioPlayer *audioPlayer;
}

@property(nonatomic,assign) int indexPathrow;

@property(nonatomic,assign)id delegate;

-(void)playerAudioPath:(NSString *)audioPath;  //播放语音文件   
-(void)playerAudioPath:(NSString *)audioPath indexRow:(int)indexRow;  //播放语音文件   //哪一条cell的indexrow
-(BOOL) isPlay;  //是否播放中  Yes:播放中 No:播放完毕
-(void) audioStop;  //停止播放

//返回音频时间
-(double)getDurationinPath:(NSString *)audioPath;

@end
