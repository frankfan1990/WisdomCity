#import "FMDatabase.h"
#import "unistd.h"

@implementation FMDatabase
@synthesize inTransaction;
@synthesize cachedStatements;
@synthesize logsErrors;
@synthesize crashOnErrors;
@synthesize busyRetryTimeout;
@synthesize checkedOut;
@synthesize traceExecution;


+(void) initTable{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//
//    
//    NSString *documentDirectory = [paths objectAtIndex:0];
//    //Path： 数据库路径，在Document中。
//    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[self getDBPath]];
//    //NSLog(@"log=%@",dbPath);
    NSString *dbPath=[self getDBPath];
    NSFileManager *file=[NSFileManager defaultManager];
    if (![file fileExistsAtPath:dbPath]) {
        FMDatabase *db=[[FMDatabase alloc] initWithPath:dbPath];
        [db open];
        //eid 不能为唯一
//        [db executeUpdate:@"create table ActorDealistable (id integer primary key autoincrement,actorid varchar(10),content varchar(5000))"];
//        [db executeUpdate:@"create table ShowMallDealistable (id integer primary key autoincrement,ShowMallid varchar(10),content varchar(5000))"];
        //type 0 1 2 秀  堂汇 艺人
       [db executeUpdate:@"create table CollectionTable (id integer primary key autoincrement,NewId varchar(10),Title varchar(500),subTitle varchar(500),other varchar(500),Type integer,Img varchar(500),addtime varchar(500),Creattime varchar(500),Remark text)"];
        
        [db executeUpdate:@"create table SearchHistorytable (id integer primary key autoincrement,content varchar(500),Numcount integer,dateTime varchar(50)) "];
//        [db executeUpdate:@"create table newsnaviitem (ID integer,Name varchar(20))"];
//        [db executeUpdate:@"create table busCollect (busType varchar(10),busName varchar(100))"];
//        
//        [db executeUpdate:@"create table messagecenter (id integer primary key autoincrement ,msgcontent varchar(5000),msgtime varchar(200),msgstate integer,msgtype,newsid varchar(1000),naviid integer) "];
//        
//        [db executeUpdate:@"create table subjectcollect (id integer primary key autoincrement,subid  varchar(10) ,title varchar(500),author varchar(50),collect varchar(1000),fid integer,subtime varchar(200)) "];
        
//        NSDateFormatter *format=[[NSDateFormatter alloc] init];
//        [format setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
//        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        [db executeUpdate:[NSString stringWithFormat:@"insert into messagecenter (msgcontent,msgtime,msgstate,msgtype,newsid,naviid) values ('欢迎加入My乌鲁木齐，您可以通过本客户端看新闻、查违章、手机购物、了解各类优惠信息并参加晨报活动。','%@',0,-1,-1,-1)",[format stringFromDate:[NSDate date]]]];
//        [format release];
        
        
     //消息中心
     [db executeUpdate:@"create table MessageCenter (messageId varchar(50),producerId varchar(50),superid varchar(50),person varchar(50),phone varchar(50),title varchar(100),content varchar(5000),sendTime varchar(100),remark varchar(1000),type varchar(5),workType varchar(5),IsPay varchar(5)) "];
        
      //  insert into `tb_city` (`cityId`, `cityName`, `provinceId`, `sequence`) values('1','北京市','1','1');
         [db executeUpdate:@"create table tb_city (cityId varchar(50),cityName varchar(50),provinceId varchar(50),sequence varchar(50)) "];
        //insert into `tb_province` (`provinceId`, `provinceName`, `sequence`, `shortName`, `remark`, `countryId`) values('2','天津市','2','TJ','直辖市','1');
         [db executeUpdate:@"create table tb_province (provinceId varchar(50),provinceName varchar(50),sequence varchar(50),shortName varchar(50),remark varchar(50),countryId varchar(50)) "];
        //insert into `tb_region` (`regionId`, `regionName`, `cityId`) values('7','石景山区','1');
         [db executeUpdate:@"create table tb_region (regionId varchar(50),regionName varchar(50),cityId varchar(50)) "];
       [db executeUpdate:@"create table videoImg (videoId varchar(50),ImgPath varchar(50),createdate varchar(50),isdelete integer) "];
        
       [db executeUpdate:@"create table OperationTimeControl (OperationId varchar(50),createdate varchar(50)) "];//数据时间修改
        
        
//  //通知中心
//        [db executeUpdate:@"create table Tongzhi (Id varchar(50),urlid  varchar(50),content  varchar(50),producerId varchar(50),superid varchar(50),person varchar(50),phone varchar(50),title varchar(100),content varchar(5000),sendTime varchar(100),remark varchar(1000),type varchar(5),workType varchar(5),IsPay varchar(5)) "];
                [db close];
            dispatch_queue_t queue=dispatch_queue_create("InitCity", NULL);
            dispatch_async(queue , ^{
            
            FMDatabase *dbq=[[FMDatabase alloc] initWithPath:dbPath];
            [dbq open];
            
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"sql"];
            NSError *error;
            
            NSString *sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
            //        NSLog(@"%@",sql);
            
            NSArray *arr=[sql componentsSeparatedByString:@";"];
            
            int count=0;
            for(int i=0;i<[arr count];i++)
            {
                BOOL result = [dbq executeUpdate:[arr objectAtIndex:i]];
                if(result){
                    count++;
                }
            }
            NSLog(@"sql:%d  arr:%d",count,[arr count]);
            
            
            filePath = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"sql"];
            
            
            sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
            //        NSLog(@"%@",sql);
            
            arr=[sql componentsSeparatedByString:@";"];
            
            count=0;
            for(int i=0;i<[arr count];i++)
            {
                BOOL result = [dbq executeUpdate:[arr objectAtIndex:i]];
                if(result){
                    count++;
                }
            }
            NSLog(@"sql:%d  arr:%d",count,[arr count]);
            
            filePath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"sql"];
            
            
            sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
            //        NSLog(@"%@",sql);
            
            arr=[sql componentsSeparatedByString:@";"];
            
            count=0;
            for(int i=0;i<[arr count];i++)
            {
                BOOL result = [dbq executeUpdate:[arr objectAtIndex:i]];
                if(result){
                    count++;
                }
            }
            NSLog(@"sql:%d  arr:%d",count,[arr count]);
                   [dbq close];
            
            
              dispatch_async(dispatch_queue_create("chushihua", NULL), ^(void) {
                  /*输出话地区*/
                  {
                      NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                      NSString *Document = [Paths objectAtIndex:0];
                      
                      NSString *Name = [Document stringByAppendingPathComponent:@"RZarea.plist"];
                      NSString *Namecity = [Document stringByAppendingPathComponent:@"RZcity.plist"];
                      BOOL FileExists = [[NSFileManager defaultManager] fileExistsAtPath:Name];
                      if(!FileExists)
                      {
                          
                          NSMutableArray *ProvinceArray = [[NSMutableArray alloc] initWithCapacity:1];//省 市 区 三级联动
                          NSMutableArray *CityArray = [[NSMutableArray alloc] initWithCapacity:1];//省 市二级联动
                          NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:0];//省
         
//                          NSMutableArray *tempqu=[[NSMutableArray alloc] initWithCapacity:0];//区
                          FMDatabase *dba=[[FMDatabase alloc] initWithPath:dbPath];
                          [dba open];
                          if(![dba open]){
                              [dba open];
                          }
                          NSString *sql=@"select * from tb_province ";
                          FMResultSet *fsa= [dba executeQuery:sql];
                          //    NSMutableArray *result=[[NSMutableArray alloc] init];
                          while ([fsa next]) {
                              NSMutableArray *tempshi=[[NSMutableArray alloc] initWithCapacity:0];//市 qu
                              NSMutableArray *tempshi1=[[NSMutableArray alloc] initWithCapacity:0];//市
                              
                              dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[[fsa resultDict] objectForKey:@"provinceid"],@"provinceid",[[fsa resultDict] objectForKey:@"provincename"],@"state",[[fsa resultDict] objectForKey:@"sequence"],@"sequence",[[fsa resultDict] objectForKey:@"shortname"],@"shortname",[[fsa resultDict] objectForKey:@"remark"],@"remark",[[fsa resultDict] objectForKey:@"countryid"],@"countryid", nil];
                              
                              NSString *sql=[NSString stringWithFormat:@"SELECT  * FROM  tb_city  where provinceid='%@' ",[[fsa resultDict] objectForKey:@"provinceid"]];
                              FMResultSet *fss=[dba executeQuery:sql];
                              while ([fss next]) {
                                  
                                NSMutableDictionary *temps=[NSMutableDictionary dictionaryWithObjectsAndKeys:[[fss resultDict] objectForKey:@"cityid"],@"cityid",[[fss resultDict] objectForKey:@"cityname"],@"city",[[fss resultDict] objectForKey:@"provinceid"],@"provinceid",[[fss resultDict] objectForKey:@"sequence"],@"sequence",  nil];
                                  
                                  NSString *sql=[NSString stringWithFormat:@"SELECT  * FROM  tb_region  where cityid='%@' ",[[fss resultDict] objectForKey:@"cityid"]];
                                  NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:0];
                                  FMResultSet *fsss=[dba executeQuery:sql];
                                  while ([fsss next]) {
                                     NSDictionary * temp=[NSDictionary dictionaryWithObjectsAndKeys:[[fsss resultDict] objectForKey:@"regionid"],@"regionid",[[fsss resultDict] objectForKey:@"regionname"],@"city",[[fsss resultDict] objectForKey:@"cityid"],@"cityid",@"",@"areas", nil];
                                          [arr  addObject:temp];
 
                                  }
                                  [tempshi1 addObject:temps];//市
                                  [temps setObject:arr forKey:@"areas"];
                                  [arr release];
                                  [tempshi addObject:temps];//市区
                                  
                              }
                              
                              [dic setObject:tempshi1 forKey:@"cities"];
                              [CityArray addObject:dic];
                              
                              [dic setObject:tempshi forKey:@"cities"];
                              [ProvinceArray addObject:dic];
                              [tempshi release];
                              [tempshi1 release];
                          }
                          [dba close];
                          [[NSFileManager defaultManager] createFileAtPath:Name contents:nil attributes:nil]; //创建文件
                          [[NSFileManager defaultManager] createFileAtPath:Namecity contents:nil attributes:nil]; //创建文件
                          [ProvinceArray writeToFile:Name atomically:YES];  //写入数据到文
                          [CityArray writeToFile:Namecity atomically:YES];  //写入数据到文
                          [ProvinceArray release];
                          [CityArray release];

                      }
                  }
              });
 
        });
           dispatch_release(queue);

    }
    
}
//初始化地区数据
+(void)initTableSiteArea{
        NSString *dbPath=[self getDBPath];
                dispatch_queue_t queue=dispatch_queue_create("InitCity", NULL);
    dispatch_async(queue, ^ {
        
        FMDatabase *dbq=[[FMDatabase alloc] initWithPath:dbPath];
        [dbq open];
        
        [dbq executeUpdate:@" delete *from tb_city "];
 
        [dbq executeUpdate:@"delete  * from tb_province "];
 
        [dbq executeUpdate:@"delete * from tb_region "];
        
         
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"sql"];
        NSError *error;
        
        NSString *sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        //        NSLog(@"%@",sql);
        
        NSArray *arr=[sql componentsSeparatedByString:@";"];
        
        int count=0;
        for(int i=0;i<[arr count];i++)
        {
            BOOL result = [dbq executeUpdate:[arr objectAtIndex:i]];
            if(result){
                count++;
            }
        }
        NSLog(@"sql:%d  arr:%d",count,[arr count]);
        
        
        filePath = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"sql"];
        
        
        sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        //        NSLog(@"%@",sql);
        
        arr=[sql componentsSeparatedByString:@";"];
        
        count=0;
        for(int i=0;i<[arr count];i++)
        {
            BOOL result = [dbq executeUpdate:[arr objectAtIndex:i]];
            if(result){
                count++;
            }
        }
        NSLog(@"sql:%d  arr:%d",count,[arr count]);
        
        filePath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"sql"];
        
        
        sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        //        NSLog(@"%@",sql);
        
        arr=[sql componentsSeparatedByString:@";"];
        
        count=0;
        for(int i=0;i<[arr count];i++)
        {
            BOOL result = [dbq executeUpdate:[arr objectAtIndex:i]];
            if(result){
                count++;
            }
        }
        NSLog(@"sql:%d  arr:%d",count,[arr count]);
        [dbq close];
        
        
        dispatch_async(dispatch_queue_create("chushihua", NULL), ^(void) {
            /*输出话地区*/
            {
                NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *Document = [Paths objectAtIndex:0];
                
                NSString *Name = [Document stringByAppendingPathComponent:@"RZarea.plist"];
                NSString *Namecity = [Document stringByAppendingPathComponent:@"RZcity.plist"];
                BOOL FileExists = [[NSFileManager defaultManager] fileExistsAtPath:Name];
                if(!FileExists)
                {
                    
                    NSMutableArray *ProvinceArray = [[NSMutableArray alloc] initWithCapacity:1];//省 市 区 三级联动
                    NSMutableArray *CityArray = [[NSMutableArray alloc] initWithCapacity:1];//省 市二级联动
                    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:0];//省
                    
                    //                          NSMutableArray *tempqu=[[NSMutableArray alloc] initWithCapacity:0];//区
                    FMDatabase *dba=[[FMDatabase alloc] initWithPath:dbPath];
                    [dba open];
                    if(![dba open]){
                        [dba open];
                    }
                    NSString *sql=@"select * from tb_province ";
                    FMResultSet *fsa= [dba executeQuery:sql];
                    //    NSMutableArray *result=[[NSMutableArray alloc] init];
                    while ([fsa next]) {
                        NSMutableArray *tempshi=[[NSMutableArray alloc] initWithCapacity:0];//市 qu
                        NSMutableArray *tempshi1=[[NSMutableArray alloc] initWithCapacity:0];//市
                        
                        dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[[fsa resultDict] objectForKey:@"provinceid"],@"provinceid",[[fsa resultDict] objectForKey:@"provincename"],@"state",[[fsa resultDict] objectForKey:@"sequence"],@"sequence",[[fsa resultDict] objectForKey:@"shortname"],@"shortname",[[fsa resultDict] objectForKey:@"remark"],@"remark",[[fsa resultDict] objectForKey:@"countryid"],@"countryid", nil];
                        
                        NSString *sql=[NSString stringWithFormat:@"SELECT  * FROM  tb_city  where provinceid='%@' ",[[fsa resultDict] objectForKey:@"provinceid"]];
                        FMResultSet *fss=[dba executeQuery:sql];
                        while ([fss next]) {
                            
                            NSMutableDictionary *temps=[NSMutableDictionary dictionaryWithObjectsAndKeys:[[fss resultDict] objectForKey:@"cityid"],@"cityid",[[fss resultDict] objectForKey:@"cityname"],@"city",[[fss resultDict] objectForKey:@"provinceid"],@"provinceid",[[fss resultDict] objectForKey:@"sequence"],@"sequence",  nil];
                            
                            NSString *sql=[NSString stringWithFormat:@"SELECT  * FROM  tb_region  where cityid='%@' ",[[fss resultDict] objectForKey:@"cityid"]];
                            NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:0];
                            FMResultSet *fsss=[dba executeQuery:sql];
                            while ([fsss next]) {
                                NSDictionary * temp=[NSDictionary dictionaryWithObjectsAndKeys:[[fsss resultDict] objectForKey:@"regionid"],@"regionid",[[fsss resultDict] objectForKey:@"regionname"],@"city",[[fsss resultDict] objectForKey:@"cityid"],@"cityid",@"",@"areas", nil];
                                [arr  addObject:temp];
                                
                            }
                            [tempshi1 addObject:temps];//市
                            [temps setObject:arr forKey:@"areas"];
                            [arr release];
                            [tempshi addObject:temps];//市区
                            
                        }
                        
                        [dic setObject:tempshi1 forKey:@"cities"];
                        [CityArray addObject:dic];
                        
                        [dic setObject:tempshi forKey:@"cities"];
                        [ProvinceArray addObject:dic];
                        [tempshi release];
                        [tempshi1 release];
                    }
                    [dba close];
                    [[NSFileManager defaultManager] createFileAtPath:Name contents:nil attributes:nil]; //创建文件
                    [[NSFileManager defaultManager] createFileAtPath:Namecity contents:nil attributes:nil]; //创建文件
                    [ProvinceArray writeToFile:Name atomically:YES];  //写入数据到文
                    [CityArray writeToFile:Namecity atomically:YES];  //写入数据到文
                    [ProvinceArray release];
                    [CityArray release];
                    
                }
            }
        });
        
    });
              dispatch_release(queue);
}


+(NSString *)getDBPath
{
//    NSString *path =NSHomeDirectory();
//    path = [path stringByAppendingPathComponent:@"Documents/YRT.db"];
    
   NSString * path= [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"YRT.db"];
    
    NSLog(@"DBPath=%@",path);
    return path;
}

+ (id)databaseWithPath:(NSString*)aPath {
    return [[[self alloc] initWithPath:aPath] autorelease];
}
+(FMDatabase*)getDBConnection{
    @synchronized(self){
        if(fmDB==nil){

            fmDB=[[FMDatabase alloc] initWithPath:[self getDBPath]];
        }        
    }
    return fmDB;
}

+ (FMDatabase*)getDBconnectionInDB:(NSString *)DB
{
    return [[FMDatabase alloc] initWithPath:DB];
}

+(void)dbClose{    

    [fmDB close];
    [fmDB release];
}


- (id)initWithPath:(NSString*)aPath {
    self = [super init];
    
    if (self) {
        databasePath        = [aPath copy];
        openResultSets      = [[NSMutableSet alloc] init];
        db                  = 0x00;
        logsErrors          = 0x00;
        crashOnErrors       = 0x00;
        busyRetryTimeout    = 0x00;
    }
    
    return self;
}

- (void)finalize {
    [self close];
    [super finalize];
}

- (void)dealloc {
    [self close];
    
    [openResultSets release];
    [cachedStatements release];
    [databasePath release];
    
    [super dealloc];
}

+ (NSString*)sqliteLibVersion {
    return [NSString stringWithFormat:@"%s", sqlite3_libversion()];
}

- (NSString *)databasePath {
    return databasePath;
}

- (sqlite3*)sqliteHandle {
    return db;
}

- (BOOL)open {
    if (db) {
        return YES;
    }
    
    int err = sqlite3_open((databasePath ? [databasePath fileSystemRepresentation] : ":memory:"), &db );
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    }
    
    return YES;
}

#if SQLITE_VERSION_NUMBER >= 3005000
- (BOOL)openWithFlags:(int)flags {
    int err = sqlite3_open_v2((databasePath ? [databasePath fileSystemRepresentation] : ":memory:"), &db, flags, NULL /* Name of VFS module to use */);
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    }
    return YES;
}
#endif


- (BOOL)close {
    
    [self clearCachedStatements];
    [self closeOpenResultSets];
    
    if (!db) {
        return YES;
    }
    
    int  rc;
    BOOL retry;
    int numberOfRetries = 0;
    BOOL triedFinalizingOpenStatements = NO;
    
    do {
        retry   = NO;
        rc      = sqlite3_close(db);
        if (SQLITE_BUSY == rc || SQLITE_LOCKED == rc) {
            retry = YES;
            usleep(20);
            if (busyRetryTimeout && (numberOfRetries++ > busyRetryTimeout)) {
                NSLog(@"%s:%d", __FUNCTION__, __LINE__);
                NSLog(@"Database busy, unable to close");
                return NO;
            }
            
            if (!triedFinalizingOpenStatements) {
                triedFinalizingOpenStatements = YES;
                sqlite3_stmt *pStmt;
                while ((pStmt = sqlite3_next_stmt(db, 0x00)) !=0) {
                    NSLog(@"Closing leaked statement");
                    sqlite3_finalize(pStmt);
                }
            }
        }
        else if (SQLITE_OK != rc) {
            NSLog(@"error closing!: %d", rc);
        }
    }
    while (retry);
    
    db = nil;
    return YES;
}

- (void)clearCachedStatements {
    
    NSEnumerator *e = [cachedStatements objectEnumerator];
    FMStatement *cachedStmt;

    while ((cachedStmt = [e nextObject])) {
        [cachedStmt close];
    }
    
    [cachedStatements removeAllObjects];
}

- (void)closeOpenResultSets {
    //Copy the set so we don't get mutation errors
    NSSet *resultSets = [[openResultSets copy] autorelease];
    
    NSEnumerator *e = [resultSets objectEnumerator];
    NSValue *returnedResultSet = nil;
    
    while((returnedResultSet = [e nextObject])) {
        FMResultSet *rs = (FMResultSet *)[returnedResultSet pointerValue];
        if ([rs respondsToSelector:@selector(close)]) {
            [rs close];
        }
    }
}

- (void)resultSetDidClose:(FMResultSet *)resultSet {
    NSValue *setValue = [NSValue valueWithNonretainedObject:resultSet];
    [openResultSets removeObject:setValue];
}

- (FMStatement*)cachedStatementForQuery:(NSString*)query {
    return [cachedStatements objectForKey:query];
}

- (void)setCachedStatement:(FMStatement*)statement forQuery:(NSString*)query {
    //NSLog(@"setting query: %@", query);
    query = [query copy]; // in case we got handed in a mutable string...
    [statement setQuery:query];
    [cachedStatements setObject:statement forKey:query];
    [query release];
}


- (BOOL)rekey:(NSString*)key {
#ifdef SQLITE_HAS_CODEC
    if (!key) {
        return NO;
    }
    
    int rc = sqlite3_rekey(db, [key UTF8String], strlen([key UTF8String]));
    
    if (rc != SQLITE_OK) {
        NSLog(@"error on rekey: %d", rc);
        NSLog(@"%@", [self lastErrorMessage]);
    }
    
    return (rc == SQLITE_OK);
#else
    return NO;
#endif
}

- (BOOL)setKey:(NSString*)key {
#ifdef SQLITE_HAS_CODEC
    if (!key) {
        return NO;
    }
    
    int rc = sqlite3_key(db, [key UTF8String], strlen([key UTF8String]));
    
    return (rc == SQLITE_OK);
#else
    return NO;
#endif
}

- (BOOL)goodConnection {
    
    if (!db) {
        return NO;
    }
    
    FMResultSet *rs = [self executeQuery:@"select name from sqlite_master where type='table'"];
    
    if (rs) {
        [rs close];
        return YES;
    }
    
    return NO;
}

- (void)warnInUse {
    NSLog(@"The FMDatabase %@ is currently in use.", self);
    
#ifndef NS_BLOCK_ASSERTIONS
    if (crashOnErrors) {
        NSAssert1(false, @"The FMDatabase %@ is currently in use.", self);
    }
#endif
}

- (BOOL)databaseExists {
    
    if (!db) {
            
        NSLog(@"The FMDatabase %@ is not open.", self);
        
    #ifndef NS_BLOCK_ASSERTIONS
        if (crashOnErrors) {
            NSAssert1(false, @"The FMDatabase %@ is not open.", self);
        }
    #endif
        
        return NO;
    }
    
    return YES;
}

- (NSString*)lastErrorMessage {
    return [NSString stringWithUTF8String:sqlite3_errmsg(db)];
}

- (BOOL)hadError {
    int lastErrCode = [self lastErrorCode];
    
    return (lastErrCode > SQLITE_OK && lastErrCode < SQLITE_ROW);
}

- (int)lastErrorCode {
    return sqlite3_errcode(db);
}

- (sqlite_int64)lastInsertRowId {
    
    if (inUse) {
        [self warnInUse];
        return NO;
    }
    [self setInUse:YES];
    
    sqlite_int64 ret = sqlite3_last_insert_rowid(db);
    
    [self setInUse:NO];
    
    return ret;
}

- (int)changes {
    if (inUse) {
        [self warnInUse];
        return 0;
    }
    
    [self setInUse:YES];
    int ret = sqlite3_changes(db);
    [self setInUse:NO];
    
    return ret;
}

- (void)bindObject:(id)obj toColumn:(int)idx inStatement:(sqlite3_stmt*)pStmt {
    
    if ((!obj) || ((NSNull *)obj == [NSNull null])) {
        sqlite3_bind_null(pStmt, idx);
    }
    
    // FIXME - someday check the return codes on these binds.
    else if ([obj isKindOfClass:[NSData class]]) {
        sqlite3_bind_blob(pStmt, idx, [obj bytes], (int)[obj length], SQLITE_STATIC);
    }
    else if ([obj isKindOfClass:[NSDate class]]) {
        sqlite3_bind_double(pStmt, idx, [obj timeIntervalSince1970]);
    }
    else if ([obj isKindOfClass:[NSNumber class]]) {
        
        if (strcmp([obj objCType], @encode(BOOL)) == 0) {
            sqlite3_bind_int(pStmt, idx, ([obj boolValue] ? 1 : 0));
        }
        else if (strcmp([obj objCType], @encode(int)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longValue]);
        }
        else if (strcmp([obj objCType], @encode(long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longValue]);
        }
        else if (strcmp([obj objCType], @encode(long long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longLongValue]);
        }
        else if (strcmp([obj objCType], @encode(float)) == 0) {
            sqlite3_bind_double(pStmt, idx, [obj floatValue]);
        }
        else if (strcmp([obj objCType], @encode(double)) == 0) {
            sqlite3_bind_double(pStmt, idx, [obj doubleValue]);
        }
        else {
            sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
        }
    }
    else {
        sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
    }
}

- (void)_extractSQL:(NSString *)sql argumentsList:(va_list)args intoString:(NSMutableString *)cleanedSQL arguments:(NSMutableArray *)arguments {
    
    NSUInteger length = [sql length];
    unichar last = '\0';
    for (NSUInteger i = 0; i < length; ++i) {
        id arg = nil;
        unichar current = [sql characterAtIndex:i];
        unichar add = current;
        if (last == '%') {
            switch (current) {
                case '@':
                    arg = va_arg(args, id); break;
                case 'c':
                    arg = [NSString stringWithFormat:@"%c", va_arg(args, char)]; break;
                case 's':
                    arg = [NSString stringWithUTF8String:va_arg(args, char*)]; break;
                case 'd':
                case 'D':
                case 'i':
                    arg = [NSNumber numberWithInt:va_arg(args, int)]; break;
                case 'u':
                case 'U':
                    arg = [NSNumber numberWithUnsignedInt:va_arg(args, unsigned int)]; break;
                case 'h':
                    i++;
                    if (i < length && [sql characterAtIndex:i] == 'i') {
                        arg = [NSNumber numberWithShort:va_arg(args, short)];
                    }
                    else if (i < length && [sql characterAtIndex:i] == 'u') {
                        arg = [NSNumber numberWithUnsignedShort:va_arg(args, unsigned short)];
                    }
                    else {
                        i--;
                    }
                    break;
                case 'q':
                    i++;
                    if (i < length && [sql characterAtIndex:i] == 'i') {
                        arg = [NSNumber numberWithLongLong:va_arg(args, long long)];
                    }
                    else if (i < length && [sql characterAtIndex:i] == 'u') {
                        arg = [NSNumber numberWithUnsignedLongLong:va_arg(args, unsigned long long)];
                    }
                    else {
                        i--;
                    }
                    break;
                case 'f':
                    arg = [NSNumber numberWithDouble:va_arg(args, double)]; break;
                case 'g':
                    arg = [NSNumber numberWithFloat:va_arg(args, float)]; break;
                case 'l':
                    i++;
                    if (i < length) {
                        unichar next = [sql characterAtIndex:i];
                        if (next == 'l') {
                            i++;
                            if (i < length && [sql characterAtIndex:i] == 'd') {
                                //%lld
                                arg = [NSNumber numberWithLongLong:va_arg(args, long long)];
                            }
                            else if (i < length && [sql characterAtIndex:i] == 'u') {
                                //%llu
                                arg = [NSNumber numberWithUnsignedLongLong:va_arg(args, unsigned long long)];
                            }
                            else {
                                i--;
                            }
                        }
                        else if (next == 'd') {
                            //%ld
                            arg = [NSNumber numberWithLong:va_arg(args, long)];
                        }
                        else if (next == 'u') {
                            //%lu
                            arg = [NSNumber numberWithUnsignedLong:va_arg(args, unsigned long)];
                        }
                        else {
                            i--;
                        }
                    }
                    else {
                        i--;
                    }
                    break;
                default:
                    // something else that we can't interpret. just pass it on through like normal
                    break;
            }
        }
        else if (current == '%') {
            // percent sign; skip this character
            add = '\0';
        }
        
        if (arg != nil) {
            [cleanedSQL appendString:@"?"];
            [arguments addObject:arg];
        }
        else if (add != '\0') {
            [cleanedSQL appendFormat:@"%C", add];
        }
        last = current;
    }
    
}

- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray*)arrayArgs orVAList:(va_list)args {
    
    if (![self databaseExists]) {
        return 0x00;
    }
    
    if (inUse) {
        [self warnInUse];
        return 0x00;
    }
    
    [self setInUse:YES];
    
    FMResultSet *rs = nil;
    
    int rc                  = 0x00;
    sqlite3_stmt *pStmt     = 0x00;
    FMStatement *statement  = 0x00;
    
    if (traceExecution && sql) {
        NSLog(@"%@ executeQuery: %@", self, sql);
    }
    
    if (shouldCacheStatements) {
        statement = [self cachedStatementForQuery:sql];
        pStmt = statement ? [statement statement] : 0x00;
    }
    
    int numberOfRetries = 0;
    BOOL retry          = NO;
    
    if (!pStmt) {
        do {
            retry   = NO;
            rc      = sqlite3_prepare_v2(db, [sql UTF8String], -1, &pStmt, 0);
            
            if (SQLITE_BUSY == rc || SQLITE_LOCKED == rc) {
                retry = YES;
                usleep(20);
                
                if (busyRetryTimeout && (numberOfRetries++ > busyRetryTimeout)) {
                    NSLog(@"%s:%d Database busy (%@)", __FUNCTION__, __LINE__, [self databasePath]);
                    NSLog(@"Database busy");
                    sqlite3_finalize(pStmt);
                    [self setInUse:NO];
                    return nil;
                }
            }
            else if (SQLITE_OK != rc) {
                
                
                if (logsErrors) {
                   // NSLog(@"DB Error: %d \"%@\"", [self lastErrorCode], [self lastErrorMessage]);
                    //NSLog(@"DB Query: %@", sql);
#ifndef NS_BLOCK_ASSERTIONS
                    if (crashOnErrors) {
                        NSAssert2(false, @"DB Error: %d \"%@\"", [self lastErrorCode], [self lastErrorMessage]);
                    }
#endif
                }
                
                sqlite3_finalize(pStmt);
                
                [self setInUse:NO];
                return nil;
            }
        }
        while (retry);
    }
    
    id obj;
    int idx = 0;
    int queryCount = sqlite3_bind_parameter_count(pStmt); // pointed out by Dominic Yu (thanks!)
    
    while (idx < queryCount) {
        
        if (arrayArgs) {
            obj = [arrayArgs objectAtIndex:idx];
        }
        else {
            obj = va_arg(args, id);
        }
        
        if (traceExecution) {
            NSLog(@"obj: %@", obj);
        }
        
        idx++;
        
        [self bindObject:obj toColumn:idx inStatement:pStmt];
    }
    
    if (idx != queryCount) {
        NSLog(@"Error: the bind count is not correct for the # of variables (executeQuery)");
        sqlite3_finalize(pStmt);
        [self setInUse:NO];
        return nil;
    }
    
    [statement retain]; // to balance the release below
    
    if (!statement) {
        statement = [[FMStatement alloc] init];
        [statement setStatement:pStmt];
        
        if (shouldCacheStatements) {
            [self setCachedStatement:statement forQuery:sql];
        }
    }
    
    // the statement gets closed in rs's dealloc or [rs close];
    rs = [FMResultSet resultSetWithStatement:statement usingParentDatabase:self];
    [rs setQuery:sql];
    NSValue *openResultSet = [NSValue valueWithNonretainedObject:rs];
    [openResultSets addObject:openResultSet];
    
    statement.useCount = statement.useCount + 1;
    
    [statement release];    
    
    [self setInUse:NO];
    
    return rs;
}

- (FMResultSet *)executeQuery:(NSString*)sql, ... {
    va_list args;
    va_start(args, sql);
    
    id result = [self executeQuery:sql withArgumentsInArray:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (FMResultSet *)executeQueryWithFormat:(NSString*)format, ... {
    va_list args;
    va_start(args, format);
    
    NSMutableString *sql = [NSMutableString stringWithCapacity:[format length]];
    NSMutableArray *arguments = [NSMutableArray array];
    [self _extractSQL:format argumentsList:args intoString:sql arguments:arguments];    
    
    va_end(args);
    
    return [self executeQuery:sql withArgumentsInArray:arguments];
}

- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments {
    return [self executeQuery:sql withArgumentsInArray:arguments orVAList:nil];
}

- (BOOL)executeUpdate:(NSString*)sql error:(NSError**)outErr withArgumentsInArray:(NSArray*)arrayArgs orVAList:(va_list)args {
    
    if (![self databaseExists]) {
        return NO;
    }
    
    if (inUse) {
        [self warnInUse];
        return NO;
    }
    
    [self setInUse:YES];
    
    int rc                   = 0x00;
    sqlite3_stmt *pStmt      = 0x00;
    FMStatement *cachedStmt  = 0x00;
    
    if (traceExecution && sql) {
        NSLog(@"%@ executeUpdate: %@", self, sql);
    }
    
    if (shouldCacheStatements) {
        cachedStmt = [self cachedStatementForQuery:sql];
        pStmt = cachedStmt ? [cachedStmt statement] : 0x00;
    }
    
    int numberOfRetries = 0;
    BOOL retry          = NO;
    
    if (!pStmt) {
        
        do {
            retry   = NO;
            rc      = sqlite3_prepare_v2(db, [sql UTF8String], -1, &pStmt, 0);
            if (SQLITE_BUSY == rc || SQLITE_LOCKED == rc) {
                retry = YES;
                usleep(20);
                
                if (busyRetryTimeout && (numberOfRetries++ > busyRetryTimeout)) {
                    NSLog(@"%s:%d Database busy (%@)", __FUNCTION__, __LINE__, [self databasePath]);
                    NSLog(@"Database busy");
                    sqlite3_finalize(pStmt);
                    [self setInUse:NO];
                    return NO;
                }
            }
            else if (SQLITE_OK != rc) {
                
                
                if (logsErrors) {
                   // NSLog(@"DB Error: %d \"%@\"", [self lastErrorCode], [self lastErrorMessage]);
                   // NSLog(@"DB Query: %@", sql);
#ifndef NS_BLOCK_ASSERTIONS
                    if (crashOnErrors) {
                        NSAssert2(false, @"DB Error: %d \"%@\"", [self lastErrorCode], [self lastErrorMessage]);
                    }
#endif
                }
                
                sqlite3_finalize(pStmt);
                [self setInUse:NO];
                
                if (outErr) {
                    *outErr = [NSError errorWithDomain:[NSString stringWithUTF8String:sqlite3_errmsg(db)] code:rc userInfo:nil];
                }
                
                return NO;
            }
        }
        while (retry);
    }
    
    
    id obj;
    int idx = 0;
    int queryCount = sqlite3_bind_parameter_count(pStmt);
    
    while (idx < queryCount) {
        
        if (arrayArgs) {
            obj = [arrayArgs objectAtIndex:idx];
        }
        else {
            obj = va_arg(args, id);
        }
        
        
        if (traceExecution) {
            NSLog(@"obj: %@", obj);
        }
        
        idx++;
        
        [self bindObject:obj toColumn:idx inStatement:pStmt];
    }
    
    if (idx != queryCount) {
        NSLog(@"Error: the bind count is not correct for the # of variables (%@) (executeUpdate)", sql);
        sqlite3_finalize(pStmt);
        [self setInUse:NO];
        return NO;
    }
    
    /* Call sqlite3_step() to run the virtual machine. Since the SQL being
     ** executed is not a SELECT statement, we assume no data will be returned.
     */
    numberOfRetries = 0;
    do {
        rc      = sqlite3_step(pStmt);
        retry   = NO;
        
        if (SQLITE_BUSY == rc || SQLITE_LOCKED == rc) {
            // this will happen if the db is locked, like if we are doing an update or insert.
            // in that case, retry the step... and maybe wait just 10 milliseconds.
            retry = YES;
            if (SQLITE_LOCKED == rc) {
                rc = sqlite3_reset(pStmt);
                if (rc != SQLITE_LOCKED) {
                    NSLog(@"Unexpected result from sqlite3_reset (%d) eu", rc);
                }
            }
            usleep(20);
            
            if (busyRetryTimeout && (numberOfRetries++ > busyRetryTimeout)) {
                NSLog(@"%s:%d Database busy (%@)", __FUNCTION__, __LINE__, [self databasePath]);
                NSLog(@"Database busy");
                retry = NO;
            }
        }
        else if (SQLITE_DONE == rc || SQLITE_ROW == rc) {
            // all is well, let's return.
        }
        else if (SQLITE_ERROR == rc) {
           // NSLog(@"Error calling sqlite3_step (%d: %s) SQLITE_ERROR", rc, sqlite3_errmsg(db));
           // NSLog(@"DB Query: %@", sql);
        }
        else if (SQLITE_MISUSE == rc) {
            // uh oh.
           // NSLog(@"Error calling sqlite3_step (%d: %s) SQLITE_MISUSE", rc, sqlite3_errmsg(db));
           // NSLog(@"DB Query: %@", sql);
        }
        else {
            // wtf?
           // NSLog(@"Unknown error calling sqlite3_step (%d: %s) eu", rc, sqlite3_errmsg(db));
           // NSLog(@"DB Query: %@", sql);
        }
        
    } while (retry);
    
    assert( rc!=SQLITE_ROW );
    
    
    if (shouldCacheStatements && !cachedStmt) {
        cachedStmt = [[FMStatement alloc] init];
        
        [cachedStmt setStatement:pStmt];
        
        [self setCachedStatement:cachedStmt forQuery:sql];
        
        [cachedStmt release];
    }
    
    if (cachedStmt) {
        cachedStmt.useCount = cachedStmt.useCount + 1;
        rc = sqlite3_reset(pStmt);
    }
    else {
        /* Finalize the virtual machine. This releases all memory and other
         ** resources allocated by the sqlite3_prepare() call above.
         */
        rc = sqlite3_finalize(pStmt);
    }
    
    [self setInUse:NO];
    
    return (rc == SQLITE_OK);
}


- (BOOL)executeUpdate:(NSString*)sql, ... {
    va_list args;
    va_start(args, sql);
    
    BOOL result = [self executeUpdate:sql error:nil withArgumentsInArray:nil orVAList:args];
    
    va_end(args);
    return result;
}



- (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments {
    return [self executeUpdate:sql error:nil withArgumentsInArray:arguments orVAList:nil];
}

- (BOOL)executeUpdateWithFormat:(NSString*)format, ... {
    va_list args;
    va_start(args, format);
    
    NSMutableString *sql = [NSMutableString stringWithCapacity:[format length]];
    NSMutableArray *arguments = [NSMutableArray array];
    [self _extractSQL:format argumentsList:args intoString:sql arguments:arguments];    
    
    va_end(args);
    
    return [self executeUpdate:sql withArgumentsInArray:arguments];
}

- (BOOL)update:(NSString*)sql error:(NSError**)outErr bind:(id)bindArgs, ... {
    va_list args;
    va_start(args, bindArgs);
    
    BOOL result = [self executeUpdate:sql error:outErr withArgumentsInArray:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (BOOL)rollback {
    BOOL b = [self executeUpdate:@"ROLLBACK TRANSACTION;"];
    if (b) {
        inTransaction = NO;
    }
    return b;
}

- (BOOL)commit {
    BOOL b =  [self executeUpdate:@"COMMIT TRANSACTION;"];
    if (b) {
        inTransaction = NO;
    }
    return b;
}

- (BOOL)beginDeferredTransaction {
    BOOL b =  [self executeUpdate:@"BEGIN DEFERRED TRANSACTION;"];
    if (b) {
        inTransaction = YES;
    }
    return b;
}

- (BOOL)beginTransaction {
    BOOL b =  [self executeUpdate:@"BEGIN EXCLUSIVE TRANSACTION;"];
    if (b) {
        inTransaction = YES;
    }
    return b;
}



- (BOOL)inUse {
    return inUse || inTransaction;
}

- (void)setInUse:(BOOL)b {
    inUse = b;
}


- (BOOL)shouldCacheStatements {
    return shouldCacheStatements;
}

- (void)setShouldCacheStatements:(BOOL)value {
    
    shouldCacheStatements = value;
    
    if (shouldCacheStatements && !cachedStatements) {
        [self setCachedStatements:[NSMutableDictionary dictionary]];
    }
    
    if (!shouldCacheStatements) {
        [self setCachedStatements:nil];
    }
}

+ (BOOL)isThreadSafe {
    // make sure to read the sqlite headers on this guy!
    return sqlite3_threadsafe();
}

@end



@implementation FMStatement
@synthesize statement;
@synthesize query;
@synthesize useCount;

- (void)finalize {
    [self close];
    [super finalize];
}

- (void)dealloc {
    [self close];
    [query release];
    [super dealloc];
}

- (void)close {
    if (statement) {
        sqlite3_finalize(statement);
        statement = 0x00;
    }
}

- (void)reset {
    if (statement) {
        sqlite3_reset(statement);
    }
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ %d hit(s) for query %@", [super description], useCount, query];
}


@end

