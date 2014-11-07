//
//  UtilCheck.m
//  ydcb
//
//  Created by HDX on 13-5-6.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import "UtilCheck.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "FMDatabase.h"

#define HttpKey @"Rz"
@implementation UtilCheck

//判断是否官方数据返回
+(NSArray*)dataCheck:(NSArray*)arr{
    NSMutableArray *array=[[NSMutableArray alloc] initWithArray:arr];
    
    NSDictionary *temp=[array lastObject];
    BOOL IsCheck=NO;
    
    for (NSString* key in [temp keyEnumerator]) {
        if([key isEqualToString:HttpKey]){
            IsCheck=YES;
            break;
        }
    }
    if(IsCheck){
        return array;
    }
    else{
        return [NSArray arrayWithObjects:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"error",@"1",@"dataCheck",@"",@"data",@"解析异常或者请求失效",@"message",nil], nil];//本地验证
    }

}

//数据请求加密
+(NSString*)getUrlToken:(NSString *)url Parameters:(NSMutableDictionary*)paraDi{
    NSString *Result=nil;
    NSString *strKey=@"";
    for (NSString* key in [paraDi keyEnumerator]) {
        if(key.length>0){
           strKey=[NSString stringWithFormat:@"%@%@",strKey,[key substringToIndex:1]];
        }
    }
     Result=[NSString stringWithFormat:@"%@%@",url,strKey];
    return Result;
}
+(UIColor*)getRZColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    if(alpha==0){
        return [UIColor clearColor];
    }
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha] ;
//    float 0x5496DF;
//    return UIColorFromRGB(0x5496DF);
//    return [UIColor redColor];
}
//是否可以继续执行操作
+(BOOL)IstimeOver:(NSString*)Id{
    
        NSDate *NewDate=[NSDate date];
    
    FMDatabase *db=[FMDatabase getDBConnection];
    
    if(![db open]){
        [db open];
    }
    NSDateFormatter * formatter = [[NSDateFormatter  alloc ]  init ];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    
    FMResultSet *fs= [db executeQuery:@"SELECT  * FROM  OperationTimeControl where OperationId=? ",Id];
    while ([fs next]) {
        NSString *olddate=[[NSString stringWithFormat:@"%@",[[fs resultDict] objectForKey:@"createdate" ]] substringWithRange:NSMakeRange(0, 19)];
        
        
       NSDate *OldDate=[formatter dateFromString:olddate];
        
        NSCalendar *calendars = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        comps=[calendars components:unitFlags fromDate:OldDate toDate:NewDate options:0];
        if(comps.hour>=OPEN_TIME){
            //时间操作1小时
 
            BOOL resouct=[db executeUpdate:@"update  OperationTimeControl set createdate=? where OperationId=? ",[NSString stringWithFormat:@"%@",[formatter stringFromDate:NewDate]],Id];
            if(resouct){
                
            }
            
            return NO;
        }
        else{
            //时间不到1小时
            return YES;
        }
  
    }
    if(![fs next]){
        
        BOOL  result = [db executeUpdate:@"insert into OperationTimeControl(OperationId,createdate) values(?,?)",Id ,[formatter stringFromDate:[NSDate date]]];
        if(result){
            NSLog(@"OK");
            [db close];
            return NO;
        }

    }
    [formatter release];
    [db close];
    return NO;
}

//清理html 标签
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    // trim off whitespace
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

//数据字典转化盛json  保存json 可能会用到
+(NSString*)dictionaryToJson:(NSMutableDictionary *)dic;
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//判断是否有值
+(BOOL)DataIsNuLL:(NSString *)string{
    if(![string isEqualToString:nil]&&string.length>0){
        return NO;
    }
    
    return YES;
}
//判断是否都是数字
+(BOOL)IsAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
//判断是否式合法email
+(BOOL) IsvalidateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((1[2-9][0-9])|(1[2-9][^4,\\D])|(1[2-9][0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//判断是否有中文字符
+(BOOL) IsExistsChinese:(NSString *)CheckStr
{
    int length = [CheckStr length];
    // int temp=0;
    for(int i = 0; i < length ; i++)
    {
        NSRange range = NSMakeRange(i,1);
        NSString *subString = [CheckStr substringWithRange:range];
        const char *CString =[subString UTF8String];
        if(strlen(CString) == 3)
            return   YES;   //有中文
        // temp = [CheckStr characterAtIndex:i];
        //if(temp > 0x4e00 && temp < 0x9ff)
        //  return YES;
    }
    return NO;
}

//农历转换函数
+(NSString *)LunarForSolar:(NSDate *)solarDate{
    //天干名称
  //  NSArray *cTianGan = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
    
    //地支名称
  //  NSArray *cDiZhi = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    
    //属相名称
  //  NSArray *cShuXiang = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    
    //农历日期名
    NSArray *cDayName = [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                         @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                         @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int wCurYear,wCurMonth,wCurDay;
    static int nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:solarDate];
    wCurYear = [components year];
    wCurMonth = [components month];
    wCurDay = [components day];
    
    NSLog(@"year=%d,month=%d,day=%d",wCurYear,wCurMonth,wCurDay);
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历天干、地支、属相
   // NSString *szShuXiang = (NSString *)[cShuXiang objectAtIndex:((wCurYear - 4) % 60) % 12];
   // NSString *szNongli = [NSString stringWithFormat:@"%@(%@%@)年",szShuXiang, (NSString *)[cTianGan objectAtIndex:((wCurYear - 4) % 60) % 10],(NSString *)[cDiZhi objectAtIndex:((wCurYear - 4) % 60) % 12]];
    
    //生成农历月、日
    NSString *szNongliDay;
    if (wCurMonth < 1){
        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }
    else{
        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
  //  NSString *lunarDate = [NSString stringWithFormat:@"%@ %@月 %@",szNongli,szNongliDay,(NSString *)[cDayName objectAtIndex:wCurDay]];
    NSString *lunarDate = [NSString stringWithFormat:@"%@月 %@",szNongliDay,(NSString *)[cDayName objectAtIndex:wCurDay]];    
    return lunarDate;
}


+(double)LantitudeLongitudeDist:(double )lon1 lat1:(double)lat1 lon2:(double)lon2 lat2:(double) lat2
{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}

//任意两点之间的距离 经纬度
+(double)distanceBetweenOrderBy:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //返回公里数
    //return  distance*1000;
    //返回距离多少米
    return   distance;
}

#pragma mark MAC
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+(NSString *) macaddress
{
	int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
	
}

//生成6位随机数
+ (NSString *)getVerificationCode:(NSInteger)count
{
    if(count<0){
        count=4;
    }
    NSArray *strArr = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil] ;
    NSMutableString *getStr = [[NSMutableString alloc]initWithCapacity:5];
    for(int i = 0; i < count; i++) //得到六位随机字符,可自己设长度
    {
        int index = arc4random() % ([strArr count]);  //得到数组中随机数的下标
        [getStr appendString:[strArr objectAtIndex:index]];
        
    }
    NSLog(@"验证码:%@",getStr);
    [strArr release];
    return getStr;
}

//比较时间
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02 dataFormat:(NSString *)dataFormat
{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:dataFormat];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}

//全角转半角
+(NSString *)convertedAllTohalf:(NSString *)str
{
    NSMutableString *convertedstr = [str mutableCopy];
    CFStringTransform((CFMutableStringRef)convertedstr, NULL, kCFStringTransformFullwidthHalfwidth, false);
    
    return convertedstr;
}


//有空格
+ (BOOL)isHaveSpace:(NSString *)tmpString
{
    NSString *emailRegex = @"[\\s]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:tmpString];
    
}

//有中文
+ (BOOL)isHaveChinese:(NSString *)tmpString
{

    NSString *emailRegex = @"[\u2E80-\u9FFF]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:tmpString];
}
//判断是不是纯数字
+ (BOOL)isHaveNum:(NSString *)tmpString
{

    //判断是不是纯数字
    [NSCharacterSet decimalDigitCharacterSet];
if ([[tmpString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length >0) {
    return YES;
    }else{
         return NO;
    }
//    
//    NSString *emailRegex = @"[\\d]+";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:tmpString];
}

//判断字符串首首字符是否为字母
+ (BOOL)isFistletter:(NSString *)tempString
{
    NSString *regex= @"[A-Za-z]+";
    NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:tempString];
}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+(NSDictionary*)dateAMorPM{


    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"HH:mm:a"];
    NSString *ampm = [[[formatter stringFromDate:[NSDate date]] componentsSeparatedByString:@":"] objectAtIndex:2];
    int HH = [[[[formatter stringFromDate:[NSDate date]] componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
    int mm = [[[[formatter stringFromDate:[NSDate date]] componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
    [formatter release];

    return [NSDictionary dictionaryWithObjectsAndKeys:ampm,@"ampm",HH,@"HH",mm,@"mm", nil];
 
    
}


/*
 
 eg:[UtilCheck returnStringFromString:@"2014年12月14日 12:12:12" originaldataFormat:@"yyyy年MM月dd日 HH:mm:ss" dataFormat:@"MM-dd HH:mm"]
 
 */
+(NSString*)returnStringFromString:(NSString *)stringdate originaldataFormat:(NSString*)originalstring dataFormat:(NSString *)dataFormatstring{
    NSString *resust=@"";
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init] ;
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    resust=[NSString stringWithFormat:@"%@",stringdate];
    [format setDateFormat:originalstring];
    NSDate* inputDate = [format dateFromString:resust];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    resust = [format stringFromDate:inputDate];
    inputDate = [format dateFromString:resust];
    
    [format setDateFormat:dataFormatstring];
    resust = [format stringFromDate:inputDate];
    [format release];
    
    return resust;
}
/*
 
 eg:[UtilCheck returnStringFromDate:[NSDate date] dataFormat:@"yyyy-MM-dd HH:mm"]
 
 */
+(NSString*)returnStringFromDate:(NSDate *)date dataFormat:(NSString *)dataFormat{
    NSString *resust=@"";
    NSDateFormatter *format=[[NSDateFormatter alloc] init] ;
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    resust = [format stringFromDate:date];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*  inputDate = [format dateFromString:resust];
    [format setDateFormat:dataFormat];
    resust = [format stringFromDate:inputDate];
    [format release];
    return resust;
}


/*
+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate] autorelease];
    return destinationDateNow;
}

//NSString to NSDate
+(NSDate *)stringToDate:(NSString *)strdate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    [dateFormatter release];
    return retdate;
}
//NSDate to NSString
+(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    return strDate;
}

//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+(NSString *)getUTCFormateLocalDate:(NSString *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    [dateFormatter release];
    return dateString;
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    [dateFormatter release];
    return dateString;
}
+ (NSString *)getUTCFormatDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    [dateFormatter release];
    return dateString;
}

+(NSDate *)getLocalFromUTC:(NSString *)utc
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *ldate = [dateFormatter dateFromString:utc];
    [dateFormatter release];
    return ldate;
}
*/

@end
