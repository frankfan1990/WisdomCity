//
//  ImageSaveHelper.m
//  DT_nearevent
//
//  Created by li on 13-1-29.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import "ImageSaveHelper.h"


NSString *ImageSaveHelperNotif=@"ImageSaveHelperNotif";


@implementation ImageSaveHelper


//从网络地址保存图片
+(NSString*) saveImage:(NSURL*)url fileName:(NSString*)fileName orgImgView:(UIImageView*)imgView{
    if(url==nil){
        return fileName;
    }
    static NSFileManager *file=nil;
    NSLog(@"ImageSaveHeler:%@",url);
    //多线程存图,线程结束时设置组件的图片
    dispatch_async(dispatch_queue_create("saveImage", NULL), ^(void) {
        [imgView retain];
        NSString *tempFileName=nil;
        NSError *error=nil;
        NSData *imgData=[NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
        if (file==nil) {            
            file=[NSFileManager defaultManager];
            NSLog(@"alloc NSFileManager");
        }
        if ([imgData length]==0) {
            tempFileName=[NSString stringWithFormat:@"%@_none",fileName];
            //保存图片
            [file createFileAtPath:tempFileName contents:imgData attributes:nil]; 
            //改变将要设置的图片
//            tempFileName= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"none.gif"];
            tempFileName= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ydcbnone.png"];
        }else{
            tempFileName=fileName;
            
            [file createFileAtPath:tempFileName contents:imgData attributes:nil]; 
        }
        //改变图片
        if (imgView!=nil&&[imgView isKindOfClass:[UIImageView class]]) {
            [imgView stopAnimating];
            for (UIView *view in [imgView subviews]) {
                if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
                    UIActivityIndicatorView *acti=(UIActivityIndicatorView*)view;
                    [acti stopAnimating];
                    [acti removeFromSuperview];
                }
            }
            [imgView setImage:[UIImage imageWithContentsOfFile:tempFileName]];
            [imgView release];
        }else if (imgView!=nil&&[imgView isKindOfClass:[UIButton class]]){
            for (UIView *view in [imgView subviews]) {
                if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
                    UIActivityIndicatorView *acti=(UIActivityIndicatorView*)view;
                    [acti stopAnimating];
                    [acti removeFromSuperview];
                }
            }
 
            [imgView setImage:[UIImage imageWithContentsOfFile:tempFileName]  ];
            [imgView release];
        }
       // NSLog(@"save image is over %d url:%@",0,fileName);
    });
    if(imgView!=nil){
        imgView.animationImages=[NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"001.png"],
                                 [UIImage imageNamed:@"002.png"],
                                 [UIImage imageNamed:@"003.png"],
                                 [UIImage imageNamed:@"004.png"],
                                 [UIImage imageNamed:@"005.png"],
                                 [UIImage imageNamed:@"006.png"],
                                 [UIImage imageNamed:@"007.png"],
                                 [UIImage imageNamed:@"008.png"],
                                 [UIImage imageNamed:@"009.png"],
                                 [UIImage imageNamed:@"012.png"],
                                 [UIImage imageNamed:@"011.png"],
                                 [UIImage imageNamed:@"012.png"],
                                 nil];
        imgView.animationDuration=1.f;
        imgView.animationRepeatCount=0;
        [imgView startAnimating];
    }
    return fileName;
}
//加密字符串
+(NSString*)parserStr:(NSString*)orgStr{
 
    NSString *result=@"";
    NSRange range;
    if([orgStr hasSuffix:@".jpg"]){
    range = [orgStr rangeOfString:@".jpg"];
    if (range.location != NSNotFound) {
        result=[orgStr substringWithRange:NSMakeRange(range.location-36, 36)];
        result=[NSString stringWithFormat:@"%@.jpg",result];
    }
    }
    else if([orgStr hasSuffix:@".jpeg"])
    {
    range = [orgStr rangeOfString:@".jpeg"];
    if (range.location != NSNotFound) {
        result=[orgStr substringWithRange:NSMakeRange(range.location-36, 36)];
                result=[NSString stringWithFormat:@"%@.jpeg",result];
    }
    }
    else if([orgStr hasSuffix:@".png"])
    {

    range = [orgStr rangeOfString:@".png"];
    if (range.location != NSNotFound) {
        result=[orgStr substringWithRange:NSMakeRange(range.location-36, 36)];
                result=[NSString stringWithFormat:@"%@.png",result];
    }
    }
    else if([orgStr hasSuffix:@".JPG"])
    {

    range = [orgStr rangeOfString:@".JPG"];
    if (range.location != NSNotFound) {
        result=[orgStr substringWithRange:NSMakeRange(range.location-36, 36)];
                result=[NSString stringWithFormat:@"%@.JPG",result];
    }
    }
    else if([orgStr hasSuffix:@".JPEG"])
    {
    range = [orgStr rangeOfString:@".JPEG"];
    if (range.location != NSNotFound) {
        result=[orgStr substringWithRange:NSMakeRange(range.location-36, 36)];
                result=[NSString stringWithFormat:@"%@.JPEG",result];
    }
    }
    else if([orgStr hasSuffix:@".PNG"])
    {
    range = [orgStr rangeOfString:@".PNG"];
    if (range.location != NSNotFound) {
        result=[orgStr substringWithRange:NSMakeRange(range.location-36, 36)];
                result=[NSString stringWithFormat:@"%@.PNG",result];
    }
    }
    
    return result;
    
//    return [CommonFunc base64StringFromText:orgStr];
}
//取出是否有此图片
+(BOOL) isExistFile:(NSString*)fileName{
   NSFileManager *file=[NSFileManager defaultManager];
    BOOL isDir;
    //NSData *imgData=[NSData dataWithContentsOfMappedFile:fileName]
    BOOL isExist=[file fileExistsAtPath:fileName isDirectory:&isDir];
    if (isDir) {
        return NO;
    }
    if (!isExist) {
        isExist=[file fileExistsAtPath:[NSString stringWithFormat:@"%@_none",fileName] ];
        if (isExist) {
            //当图片的字节长度为0时.重新取图
            isExist=RELOAD_LAST_UNLOAD_IMG;
        }
    }
    return  isExist;
    
}

//保存图片并返回图片名
+(NSString *)saveImageForStr:(NSString *)url{ 
    //对连接取出加密码,以判断是否有此图片
    return [self saveImageForStr:url orgImgView:nil];
}


+(NSString *)saveImageForStr:(NSString *)url orgImgView:(UIImageView*)orgImg{
    //对连接取出加密码,以判断是否有此图片
   // NSLog(@"%@",url);
    
    NSString *result=[self parserStr:url];
    static NSString  *docPath=nil;
    if(docPath==nil){
        docPath=AppImage;
        [docPath retain];
        //[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    }
    NSString *fileName=[NSString stringWithFormat:@"%@/%@",docPath,result];
    if(![self isExistFile:fileName]){
        result= fileName;
        [self saveImage:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ] fileName:fileName orgImgView:orgImg];
    }else{
        
        result=fileName;
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:result,@"fileName", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageSaveHelperNotif object:nil userInfo:dic];  //文件已存在 发出通知
        
        
    }
    return result;
}

//保存图片并返回图片名
+(NSString *)saveImageForUrl:(NSURL *)url orgImgView:(UIImageView*)orgImg {    
    //对连接取出加密码,以判断是否有此图片
   // NSLog(@"%@",[url absoluteString]);
    NSString *result=[self parserStr:[url absoluteString]];
   static NSString *docPath= nil;
    if (docPath==nil) {
        docPath= AppImage;
        [docPath retain];
    }
    NSString *fileName=[NSString stringWithFormat:@"%@/%@",docPath,result];
    if(![self isExistFile:fileName]){      
        result= [self saveImage:url fileName:fileName orgImgView:orgImg];   
    }else{
        result=fileName;
        
    }
    return result;
}
+(NSString *)saveImageForUrl:(NSURL *)url  {   
    return [self saveImageForUrl:url orgImgView:nil];
}

+(NSString*)saveImageForNSData:(UIImage *)image maxSize:(CGSize)maxSize{
    if (image==nil) {
        NSLog(@"post image nil");
        return @"";
    }
    
    NSLog(@"post image start");
    
    NSLog(@"post image data :%@",image);
    CGSize imgSize=[image size];
    if(maxSize.height==0&&maxSize.width==0){
        maxSize=CGSizeMake(320, 480);
    }
    
    float dWidth = maxSize.width;                                  //img的宽高  
    float dHeight = maxSize.height;  
    float dAspectRatio = dWidth/dHeight;                           //纵横比  
    
    float dPictureWidth = imgSize.width;  
    float dPictureHeight = imgSize.height;                        //传图的宽高  
    float dPictureAspectRatio = dPictureWidth/dPictureHeight;      //长宽比  
    
    
    
    
    if (imgSize.height>maxSize.height||imgSize.width>maxSize.width) {
        if (dPictureAspectRatio > dAspectRatio){  
            NSLog(@"image begin draw");
            float nNewHeight = dWidth/dPictureWidth*dPictureHeight;    
            UIGraphicsBeginImageContext(CGSizeMake(dWidth,nNewHeight));
            [image drawInRect:CGRectMake(0, 0, dWidth, nNewHeight)];
            
        }else {  
            NSLog(@"image begin draw");
            float nNewWidth = dHeight/dPictureHeight*dPictureWidth;     
            UIGraphicsBeginImageContext(CGSizeMake(nNewWidth,dHeight));
            [image drawInRect:CGRectMake(0, 0, nNewWidth, dHeight)];
        }        
        
        NSLog(@"image end draw");
        image=UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"draw end image:%@",image);
        UIGraphicsEndImageContext();
    }    
    NSString *docPath= AppImage;;
    NSString *fileName=[NSString stringWithFormat:@"%@/%d.jpg",docPath,arc4random()];
    NSData *imageData=UIImageJPEGRepresentation(image, 1) ;    
    [imageData writeToFile:fileName atomically:YES];
    NSLog(@"file name :%@",fileName);
    NSFileManager *file=[NSFileManager defaultManager];
    
    NSLog(@"file size :%llu",[[file attributesOfItemAtPath:fileName error:nil] fileSize]);
    NSLog(@"file attr :%@",[file attributesOfItemAtPath:fileName error:nil]);
    return fileName;
}
@end


//
//  CommonFunc.m
//  PRJ_base64
//
//  Created by wangzhipeng on 12-11-29.
//  Copyright (c) 2012年 com.comsoft. All rights reserved.
//


//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>

//空字符串
#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-";

@implementation CommonFunc

+ (NSString *)base64StringFromText:(NSString *)text
{
    
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY
        NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
        data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY
        NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin
        data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
	if (string == nil)
		[NSException raise:NSInvalidArgumentException format:nil];
	if ([string length] == 0)
		return [NSData data];
	
	static char *decodingTable = NULL;
	if (decodingTable == NULL)
	{
		decodingTable = malloc(256);
		if (decodingTable == NULL)
			return nil;
		memset(decodingTable, CHAR_MAX, 256);
		NSUInteger i;
		for (i = 0; i < 64; i++)
			decodingTable[(short)encodingTable[i]] = i;
	}
	const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
	if (characters == NULL)     //  Not an ASCII string!
		return nil;
	char *bytes = malloc((([string length] + 3) / 4) * 3);
	if (bytes == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (YES)
	{
		char buffer[4];
		short bufferLength;
		for (bufferLength = 0; bufferLength < 4; i++)
		{
			if (characters[i] == '\0')
				break;
			if (isspace(characters[i]) || characters[i] == '=')
				continue;
			buffer[bufferLength] = decodingTable[(short)characters[i]];
			if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
			{
				free(bytes);
				return nil;
			}
		}
		
		if (bufferLength == 0)
			break;
		if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
		{
			free(bytes);
			return nil;
		}
		
		//  Decode the characters in the buffer to bytes.
		bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
		if (bufferLength > 2)
			bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
		if (bufferLength > 3)
			bytes[length++] = (buffer[2] << 6) | buffer[3];
	}
	
	bytes = realloc(bytes, length);
	return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
	if ([data length] == 0)
		return @"";
	
    char *characters = malloc((([data length] + 2) / 3) * 4);
	if (characters == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (i < [data length])
	{
		char buffer[3] = {0,0,0};
		short bufferLength = 0;
		while (bufferLength < 3 && i < [data length])
			buffer[bufferLength++] = ((char *)[data bytes])[i++];
		
		//  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
		characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
		characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
		if (bufferLength > 1)
			characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		else characters[length++] = '=';
		if (bufferLength > 2)
			characters[length++] = encodingTable[buffer[2] & 0x3F];
		else characters[length++] = '=';
	}
	
	return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
