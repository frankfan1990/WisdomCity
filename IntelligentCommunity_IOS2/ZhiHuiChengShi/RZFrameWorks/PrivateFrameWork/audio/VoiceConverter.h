//
//  VoiceConverter.h
//  RcChat
//
//  Created by rching on 13-10-16.
//  Copyright (c) 2013年 rching. All rights reserved.
//

/**********
 语音转换类
 *********/

#import <Foundation/Foundation.h>

@interface VoiceConverter : NSObject

+ (int)amrToWav:(NSString*)_amrPath wavSavePath:(NSString*)_savePath;

+ (int)wavToAmr:(NSString*)_wavPath amrSavePath:(NSString*)_savePath;

@end
