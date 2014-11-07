//
//  IIILocalizedIndex.m
//  IIILocalizedIndexDemo
//
//  Created by sehone on 1/23/13.
//  Copyright (c) 2013 sehone <sehone@gmail.com>. All rights reserved.
//

#import "IIILocalizedIndex.h"
#import "pinyin.h"
@implementation IIILocalizedIndex

int const III_NOT_FOUND = -1;
NSString * const III_COMMON_INDEX = @"#";
NSString * const III_LANG_EN = @"en";


// NSMutableDictionary *delimiters = nil;
// NSMutableDictionary *indexes = nil;

// Note:
// This method sends 'description' message to items in data array. So if items
// are objects of custom classes, remember to implement your own 'description'
// method for getting index.


-(void)dealloc
{
    [delimiters release];
    [indexes release];
    
    [super dealloc];
}


- (NSDictionary *)indexed:(NSArray *)data {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *desc = nil;
    NSString *index = nil;
    NSMutableArray *arr = nil;
    for (NSObject *item in data) {
        // Make sure that 'description' returns a correct NSString.
        desc = item.description;
        //NSLog(@"desc=%@",desc);
        index = (NSString *)[self getIndex:desc];
        
        arr = [dict objectForKey:[NSString stringWithFormat:@"%@",index]];
        if (arr.count == 0) {
            // No password with this index key exists yet.
            NSMutableArray *arr = [NSMutableArray arrayWithObject:item];
            [dict setObject:arr forKey:index];
        } else {
            [arr addObject:item];
        }
    }
    // sort array
    NSArray *allKeys = [dict allKeys];
    for (NSString *k in allKeys) {
        
        
        NSArray *a = [[dict objectForKey:k] sortedArrayUsingSelector:@selector(compare:)];
        
        NSComparator cmptr = ^(id obj1, id obj2){
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
 
 
             //第一种排序
     a = [a sortedArrayUsingComparator:cmptr];
 
             
        [dict setObject:a forKey:k];
    }
    return dict;
}



- (NSString *)getIndex:(NSString *)str {
    
    if (str.length == 0) {
        return III_COMMON_INDEX;
    }
    
    NSString *fc = [str substringToIndex:1];
    /*
    if([UtilCheck isHaveNum:str]){
        if([UtilCheck IsAllNum:fc]){
            if([str rangeOfString:@"栋"].location!= NSNotFound){

                fc=[str substringToIndex:[str rangeOfString:@"栋"].location];
            }
        }
    }*/
    NSString *lang;
    if ([fc canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        // If first char is an ascii char
        if([UtilCheck IsAllNum:fc]){
          lang=@"alb";
        }
        else{
        lang = III_LANG_EN;
        }
       // NSLog(@"English=%@",lang);
    } else {
        
        lang =@"zh-Hans";
        //NSLog(@"China=%@",lang);
    }
    //NSLog(@"fc=%@",fc);
    return [self getIndexWithFirstChar:fc language:lang];
}



- (NSString *)getIndexWithFirstChar:(NSString *)fc language:(NSString *)lang {
    NSString *index = III_COMMON_INDEX;
    // delimiters for this language
    NSArray *d = [[self getLangDelimiters] objectForKey:lang];
    int i = III_NOT_FOUND;
    int c = d.count;
    
    NSString *first = [d objectAtIndex:0];
 
    NSString *last = [d objectAtIndex:c-1];
   if(![lang isEqualToString:@"zh-Hans"])
   {
       if ([fc localizedCaseInsensitiveCompare:first] != NSOrderedAscending &&
           [fc localizedCaseInsensitiveCompare:last] != NSOrderedDescending) {
           // first <= firstChar <= last. i.e. A <= firstChar <= Z
           
           for (int j=0; j<c-2; j++) {
               //NSLog(@"============================");
               if ([fc localizedCaseInsensitiveCompare:[d objectAtIndex:j]] != NSOrderedAscending &&
                   [fc localizedCaseInsensitiveCompare:[d objectAtIndex:(j+1)]] == NSOrderedAscending) {
                   // d[j] <= firstChar < d[j+1]. i.e. C <= firstChar < D
                   i = j;
                   break;
               }
           }
           if (i == III_NOT_FOUND) {
               //NSLog(@"---------------------------------1");
               if ([fc localizedCaseInsensitiveCompare:[d objectAtIndex:c-2]] != NSOrderedAscending &&
                   [fc localizedCaseInsensitiveCompare:[d objectAtIndex:c-1]] != NSOrderedDescending) {
                   // d[c-2] <= firstChar <= d[c-1]. i.e. Z <= firstChar <= Z
                   i = c-2;
               }
           }
       }
   }else
    {
        if ([fc isEqualToString:@"长"]) {
            return @"C";
        }
        NSString *b = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([fc characterAtIndex:0])] uppercaseString];
        return  b;
    }
    if (i != III_NOT_FOUND) {
        // If found in current language.
        //NSLog(@"--------------------------------2");
        index = [[indexes objectForKey:lang] objectAtIndex:i];
        if([fc isEqualToString:@"9"])
        {
            index=@"9";
        }
    }
   // NSLog(@"indexstr=%@",index);
    return index;
}




// For each language, delimiters are group of characters which partition all
// characters in that language into correct sections.
//
// Theoretically, if a language supports 'localizedCaseInsensitiveCompare', then
// there is a certain order for all characters in that language. If this order
// makes sense to users(i.e. alphabetic order), then it's easy to find those
// delimiters.
// 
// This is the precondition for 'IIILocalizedIndex' to work.
// 
- (NSDictionary *)getLangDelimiters {
    if (delimiters.count == 0) {
        if(delimiters != nil || indexes != nil)
        {
            [delimiters release];
            delimiters = nil;
            
            [indexes release];
            indexes = nil;
        }
        delimiters = [[NSMutableDictionary alloc] initWithCapacity:0];
        indexes = [[NSMutableDictionary alloc] initWithCapacity:0];
        // Delimiters, use them to partition all characters
        NSArray *dlm;
        // Indexes, use them as section titles, i.e. [A-Z]
        NSArray *idx;  
        NSString *lang;
        
        // English en
        lang = III_LANG_EN;
        dlm = [NSArray arrayWithObjects:
               @"A", @"B", @"C", @"D", @"E",
               @"F", @"G", @"H", @"I", @"J",
               @"K", @"L", @"M", @"N", @"O",
               @"P", @"Q", @"R", @"S", @"T",
               @"U", @"V", @"W", @"X", @"Y",
               @"Z", nil];
        //     Standard indexes, 26 letters.
        idx = [NSArray arrayWithObjects:
               @"A", @"B", @"C", @"D", @"E",
               @"F", @"G", @"H", @"I", @"J",
               @"K", @"L", @"M", @"N", @"O",
               @"P", @"Q", @"R", @"S", @"T",
               @"U", @"V", @"W", @"X", @"Y",
               @"Z", nil];
        [delimiters setObject:dlm forKey:lang];
        [indexes setObject:idx forKey:lang];
        
        // 简体中文 zh-Hans
        lang = @"zh-Hans";
        dlm = [NSArray arrayWithObjects:
               @"啊", @"芭", @"重", @"搭", @"峨",
               @"发", @"噶", @"哈", @"击", @"喀",
               @"垃", @"妈", @"拿", @"哦", @"啪",
               @"七", @"然", @"撒", @"塌", @"挖",
               @"昔", @"压", @"匝", @"做", nil];
        //     23 indexes, without 'I', 'U', 'V' in Simplified Chinese.
        idx = [NSArray arrayWithObjects:
               @"A", @"B", @"C", @"D", @"E",
               @"F", @"G", @"H", @"J", @"K",
               @"L", @"M", @"N", @"O", @"P",
               @"Q", @"R", @"S", @"T", @"W",
               @"X", @"Y", @"Z", nil];
        [delimiters setObject:dlm forKey:lang];
        [indexes setObject:idx forKey:lang];
        
        // 繁體中文 zh-Hant
        // TODO
        
        // 阿拉伯狮子 alb
        lang = @"alb";
        dlm = [NSArray arrayWithObjects:@"0",@"1", @"2", @"3", @"4",
               @"5", @"6", @"7", @"8", @"9",nil];
        //     23 indexes, without 'I', 'U', 'V' in Simplified Chinese.
        idx = [NSArray arrayWithObjects:@"0",@"1", @"2", @"3", @"4",
               @"5", @"6", @"7", @"8", @"9", nil];
 /*    [NSArray arrayWithObjects:@"0",@"1", @"2", @"3", @"4",
         @"5", @"6", @"7", @"8", @"9",@"10",@"11", @"12", @"13", @"14",
         @"15", @"16", @"17", @"18", @"19",@"20",@"21", @"22", @"23", @"24",
         @"25", @"26", @"27", @"28", @"29",@"30",@"31", @"32", @"33", @"34",
         @"35", nil];*/
        [delimiters setObject:dlm forKey:lang];
        [indexes setObject:idx forKey:lang];

        
    }
    return delimiters;
}


@end
