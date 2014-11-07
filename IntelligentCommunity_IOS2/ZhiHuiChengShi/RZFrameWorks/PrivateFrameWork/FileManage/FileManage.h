//
//  FileManage.h
//  Vehicle
//
//  Created by rching on 13-10-24.
//  Copyright (c) 2013年 rching. All rights reserved.
//


/**
    文件操作类
 */

#import <Foundation/Foundation.h>

@interface FileManage : NSObject

/**
 生成当前时间字符串
 @returns 当前时间字符串
 */
+ (NSString*)getCurrentTimeString;

/**
 获取图片缓存路径
 @returns 缓存路径
 */
+ (NSString*)getCacheImageDirectory;

/**
 判断文件是否存在
 @param _path 文件路径
 @returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path;

/**
 删除文件
 @param _path 文件路径
 @returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path;


#pragma mark -

/**
 生成文件路径
 @param _fileName 文件名
 @param _type 文件类型
 @returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName;
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type;

/**
 返回语音文件路径
 @param _fileName 文件名
 @param filebase64Data base64语音内容
 @returns 文件路径
 */
+(NSString *)saveAudiotoLocalname:(NSString *)filename filebase64Data:(NSString *)filebase64Data;

/**
 返回图片文件路径
 @param _fileName 文件名
 @param filebase64Data base64语音内容
 @returns 文件路径
 */
+(NSString *)saveImagetoLocalname:(NSString *)filename filebase64Data:(NSString *)filebase64Data;


@end
