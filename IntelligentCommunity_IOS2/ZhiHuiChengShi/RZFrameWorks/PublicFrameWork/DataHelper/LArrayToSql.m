//
//  ArrayInsertToSqlite.m
//  DT_nearevent
//
//  Created by li on 13-2-20.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import "LArrayToSql.h"


@implementation LArrayToSql
+(NSArray *)getInsertSqlWithArray:(NSArray *)array tableName:(NSString*)tableName{
    NSMutableArray *sqls=[[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        [sqls addObject:[self getInsertSqlWithDict:dict tableName:tableName]];
    }
    return [sqls autorelease];
}
+(NSString *)getInsertSqlWithDict:(NSDictionary *)dict tableName:(NSString*)tableName{
    
    // insert into tablename(a,b,c) values(?,?)
    static NSString *oldTableName=nil;
    static NSMutableArray *cols=nil;
    if ([oldTableName isEqualToString:tableName]) {
        
    }else{//生成插入语句时，根据当前数据表已有的字段成  insert
        NSLog(@"new table name %@",tableName);
        oldTableName=tableName;
        [cols release];
        cols=nil;
        FMDatabase *db=[FMDatabase getDBConnection];
        [db open];
        FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from %@",oldTableName]];
        cols=[[NSMutableArray alloc] initWithCapacity:[result columnCount]];
        for (int i=0; i<[result columnCount]; i++) {
            NSString *colName=[[[result columnNameForIndex:i] lowercaseString] copy];
            [cols addObject:colName];
            [colName release];
        }
        [db close];
    }
    
    NSMutableString *sql=[[NSMutableString alloc] init];
    [sql appendFormat:@"insert into %@(",tableName];
    for (NSString *colName in [dict keyEnumerator]) {
        if (![cols containsObject:[colName lowercaseString]]) {
            continue;
        }        
        [sql appendFormat:@"%@,", colName];
    }
    [sql deleteCharactersInRange:NSMakeRange([sql length]-1, 1)];
    [sql appendString:@") values ("];
    for (NSString *colName in [dict keyEnumerator]) {        
        if (![cols containsObject:[colName lowercaseString]]) {
            continue;
        }
        NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
        NSMutableString *value=[NSMutableString stringWithFormat:@"%@", [dict objectForKey:colName]];
        [value stringByReplacingOccurrencesOfString:@"'" withString:@"''" ];
        [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [sql appendFormat:@"'%@',", value];
        [pool release];
    }
    
    [sql deleteCharactersInRange:NSMakeRange([sql length]-1, 1)];
    [sql appendString:@");"];
    return [sql autorelease];
}

+(NSArray *)getUpdateSqlWithArray:(NSArray *)array tableName:(NSString*)tableName primaryKey:(NSString*)primaryKey{
    NSMutableArray *sqls=[[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        [sqls addObject:[self getUpdateSqlWithDict:dict tableName:tableName primaryKey:primaryKey]];
    }
    return [sqls autorelease];
}
+(NSString *)getUpdateSqlWithDict:(NSDictionary *)dict tableName:(NSString*)tableName primaryKey:(NSString*)primaryKey{
    
    // insert into tablename(a,b,c) values(?,?)
    static NSString *oldTableName=nil;
    static NSMutableArray *cols=nil;
    if ([oldTableName isEqualToString:tableName]) {
        
    }else{//生成插入语句时，根据当前数据表已有的字段成  insert
        NSLog(@"new table name %@",tableName);
        oldTableName=tableName;
        [cols release];
        cols=nil;
        FMDatabase *db=[FMDatabase getDBConnection];
        [db open];
        FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from %@",oldTableName]];
        cols=[[NSMutableArray alloc] initWithCapacity:[result columnCount]];
        for (int i=0; i<[result columnCount]; i++) {
            NSString *colName=[[[result columnNameForIndex:i] lowercaseString] copy];
            [cols addObject:colName];
            [colName release];
        }
        [db close];
    }
    
    NSMutableString *sql=[[NSMutableString alloc] init];
    //update table set col=val
    [sql appendFormat:@"update %@ set ",tableName];
    for (NSString *colName in [dict keyEnumerator]) {
        if (![cols containsObject:[colName lowercaseString]]) {
            continue;
        }
        NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
        NSMutableString *value=[NSMutableString stringWithFormat:@"%@", [dict objectForKey:colName]];
        [value stringByReplacingOccurrencesOfString:@"'" withString:@"''" ];
        [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [sql appendFormat:@"%@='%@',", colName,value];
        [pool release];
    }
    
    [sql deleteCharactersInRange:NSMakeRange([sql length]-1, 1)];
    [sql appendString:[NSString stringWithFormat:@" where %@='%@';",primaryKey,[dict objectForKey:primaryKey]]];
    return [sql autorelease];
}
@end
