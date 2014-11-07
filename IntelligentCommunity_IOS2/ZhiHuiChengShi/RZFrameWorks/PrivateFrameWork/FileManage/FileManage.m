//
//  FileManage.m
//  Vehicle
//
//  Created by rching on 13-10-24.
//  Copyright (c) 2013年 rching. All rights reserved.
//

#import "FileManage.h"
#import "VoiceRecorderBaseVC.h"
//#import "RcStatics.h"
#import "VoiceConverter.h"
#import "NSData+Base64.h"

@implementation FileManage

/**
 生成当前时间字符串
 @returns 当前时间字符串
 */
+ (NSString*)getCurrentTimeString
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [dateformat stringFromDate:[NSDate date]];
}


/**
 获取图片缓存路径
 @returns 缓存路径
 */
+ (NSString*)getCacheImageDirectory
{
    //    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"RZCommentImage"];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path]) {
        NSError *error ;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            //            NSLog(@"creat error : %@",error.description);
        }
    }
    return path;
}

/**
 判断文件是否存在
 @param _path 文件路径
 @returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:_path];
}

/**
 删除文件
 @param _path 文件路径
 @returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] removeItemAtPath:_path error:nil];
}

/**
 生成文件路径
 @param _fileName 文件名
 @param _type 文件类型
 @returns 文件路径
 */

+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString* fileDirectory = [[[VoiceRecorderBaseVC getCacheDirectory] stringByAppendingPathComponent:_fileName]stringByAppendingPathExtension:_type];
    return fileDirectory;
}

/**
 生成文件路径
 @param _fileName 文件名
 @returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName{
    NSString* fileDirectory = [[VoiceRecorderBaseVC getCacheDirectory] stringByAppendingPathComponent:_fileName];
    return fileDirectory;
}


/**
 返回文件路径
 @param _fileName 文件名
 @param filebase64Data base64语音内容
 @returns 文件路径
 */
+(NSString *)saveAudiotoLocalname:(NSString *)filename filebase64Data:(NSString *)filebase64Data
{
    
    NSData *datastr = [NSData dataWithBase64EncodedString:filebase64Data]; //64转后的正常data 再写入文件
    
    NSString * path = [NSString stringWithFormat:@"%@/%@.amr",[VoiceRecorderBaseVC getCacheDirectory],filename];
    NSLog(@"即将存入的path＝%@",path);
    
    [datastr writeToFile:path atomically:YES];  //写入文件
    
    //  NSLog(@"AMR-接受语音文件大小:%lld",[self getFileSize:path]);
    
    //amr文件转化成wav文件
    [VoiceConverter amrToWav:path wavSavePath:[NSString stringWithFormat:@"%@/%@.wav",[VoiceRecorderBaseVC getCacheDirectory],filename]];
    
//    NSLog(@"AMR-接受语音文件大小=%lld",[RcStatics getFileSize:[NSString stringWithFormat:@"%@/%@.amr",[VoiceRecorderBaseVC getCacheDirectory],filename]]);
//    NSLog(@"WAV-接受语音文件大小=%lld",[RcStatics getFileSize:[NSString stringWithFormat:@"%@/%@.wav",[VoiceRecorderBaseVC getCacheDirectory],filename]]);
    
    NSString * voiceReciveCurrentPath= [NSString stringWithFormat:@"%@/%@.wav",[VoiceRecorderBaseVC getCacheDirectory],filename];
    
    
    NSLog(@"arm=%@",[NSString stringWithFormat:@"%@/%@.amr",[VoiceRecorderBaseVC getCacheDirectory],filename]);
    NSLog(@"wav=%@",[NSString stringWithFormat:@"%@/%@.wav",[VoiceRecorderBaseVC getCacheDirectory],filename]);
    
    return voiceReciveCurrentPath;
}

/**
 返回图片文件路径
 @param _fileName 文件名
 @param filebase64Data base64语音内容
 @returns 文件路径
 */
+(NSString *)saveImagetoLocalname:(NSString *)filename filebase64Data:(NSString *)filebase64Data
{
    NSData *datastr = [NSData dataWithBase64EncodedString:filebase64Data]; //64转后的正常data 再写入文件
    
    UIImage *imgThum = [[UIImage alloc] initWithData:datastr];
    //生成文件名
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@.jpg",[FileManage getCacheImageDirectory],filename];
    [datastr writeToFile:imagePath atomically:YES];
//    [imgThum release];
    
    return imagePath;
}

@end
