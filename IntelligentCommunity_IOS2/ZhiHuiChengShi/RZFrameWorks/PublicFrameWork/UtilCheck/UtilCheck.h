//
//  UtilCheck.h
//  ydcb
//
//  Created by HDX on 13-5-6.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PI 3.1415926

//使用十六进制 计算像素
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 

@interface UtilCheck : NSObject {
    
}

//判断是否官方数据返回
+(NSArray*)dataCheck:(NSArray*)arr;

//加密参数 保证信息请求有效 算法
+(NSString*)getUrlToken:(NSString *)url Parameters:(NSMutableDictionary*)paraDic;

+(UIColor*)getRZColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(BOOL)IstimeOver:(NSString*)Id;

+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

+(NSString*)dictionaryToJson:(NSMutableDictionary *)dic;

//判断是否有值
+(BOOL)DataIsNuLL:(NSString *)string;

//判断是否都是数字
+(BOOL)IsAllNum:(NSString *)string;

//判断是否式合法email
+(BOOL) IsvalidateEmail: (NSString *) candidate;

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile;

//判断是否事中文字符
+(BOOL) IsExistsChinese:(NSString *)CheckStr;

//农历转换函数
+(NSString *)LunarForSolar:(NSDate *)solarDate;

//计算距离
+(double)LantitudeLongitudeDist:(double )lon1 lat1:(double)lat1 lon2:(double)lon2 lat2:(double) lat2;
+(double)distanceBetweenOrderBy:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2;

//获取mac地址
+(NSString *) macaddress;

//生成随机数
+ (NSString *)getVerificationCode:(NSInteger)count;

//比较时间
/*
 return  1: //date02比date01大
 return  0: //date02=date01
 return  -1: //date02比date01小
 */
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02 dataFormat:(NSString *)dataFormat;

//全角转半角
+(NSString *)convertedAllTohalf:(NSString *)str;

//有空格
+ (BOOL)isHaveSpace:(NSString *)tmpString;

//有中文
+ (BOOL)isHaveChinese:(NSString *)tmpString;

//有数字
+ (BOOL)isHaveNum:(NSString *)tmpString;

//判断字符串首首字符是否为字母
+ (BOOL)isFistletter:(NSString *)tempString;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

#pragma mark 日期转换

+(NSDictionary*)dateAMorPM;
/*
 
 eg:[UtilCheck returnStringFromString:@"2014年12月14日 12:12:12" originaldataFormat:@"yyyy年MM月dd日 HH:mm:ss" dataFormat:@"MM-dd HH:mm"]
 
 */
+(NSString*)returnStringFromString:(NSString *)stringdate originaldataFormat:(NSString*)originalstring dataFormat:(NSString *)dataFormatstring;
/*
 
 eg:[UtilCheck returnStringFromDate:[NSDate date] dataFormat:@"yyyy-MM-dd HH:mm"]
 
 */
+(NSString*)returnStringFromDate:(NSDate *)date dataFormat:(NSString *)dataFormat;
 

/*
+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

//NSString to NSDate
+(NSDate *)stringToDate:(NSString *)strdate;
//NSDate to NSString
+(NSString *)dateToString:(NSDate *)date;
//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+(NSString *)getUTCFormateLocalDate:(NSString *)localDate;

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getUTCFormatDate:(NSDate *)localDate;

+(NSDate *)getLocalFromUTC:(NSString *)utc;
*/

@end
