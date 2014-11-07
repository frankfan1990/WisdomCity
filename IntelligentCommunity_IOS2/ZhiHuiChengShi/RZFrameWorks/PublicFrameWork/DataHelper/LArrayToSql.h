//
//  ArrayInsertToSqlite.h
//  DT_nearevent
//
//  Created by li on 13-2-20.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface LArrayToSql : NSObject {
    
}
+(NSArray*) getInsertSqlWithArray:(NSArray*)array tableName:(NSString*)tableName ;

+(NSString*) getInsertSqlWithDict:(NSDictionary*)dic tableName:(NSString*)tableName;

+(NSArray*) getUpdateSqlWithArray:(NSArray*)array tableName:(NSString*)tableName primaryKey:(NSString*)primaryKey;

+(NSString*) getUpdateSqlWithDict:(NSDictionary*)dic tableName:(NSString*)tableName primaryKey:(NSString*)primaryKey;


@end
