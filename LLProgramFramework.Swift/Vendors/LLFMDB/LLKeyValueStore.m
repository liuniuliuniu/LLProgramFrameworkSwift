//
//  LLKeyValueStore.m
//  LLFMDB
//
//  Created by liushaohua on 2017/8/10.
//  Copyright © 2017年 liushaohua. All rights reserved.
//  Git地址 : https://github.com/liuniuliuniu/LLFMDB.git

#import "LLKeyValueStore.h"
#import "YTKKeyValueStore.h"

static NSString *dbPath = @"dyxdb";
static NSString *dbName = @"dyx.db";

@implementation LLKeyValueStore

+ (instancetype)shareStore{
    
    static LLKeyValueStore *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LLKeyValueStore new];
    });
    
    return instance;
}

- (void)createDBWithTableName:(NSString *)tableName{
    
    if (tableName.length == 0) return;
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    [store createTableWithName:tableName];
    [store close];
    
}

+(NSString *)dbPath
{
    NSString *documentsPath = [LLKeyValueStore pathWithDocuments];
    documentsPath = [documentsPath stringByAppendingPathComponent:dbPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:documentsPath]){
        [LLKeyValueStore createDirectoriesAtPath:documentsPath attributes:nil];
    }
    documentsPath = [documentsPath stringByAppendingPathComponent:dbName];
    return documentsPath;
}

// 创建多级目录
+ (BOOL)createDirectoriesAtPath:(NSString *)inPath
                     attributes:(NSDictionary *)inAttributes
{
    NSArray *components = [inPath pathComponents];
    int i;
    BOOL result = YES;
    
    for (i = 1 ; i <= [components count] ; i++ ) {
        NSArray *subComponents = [components subarrayWithRange:
                                  NSMakeRange(0,i)];
        NSString *subPath = [NSString pathWithComponents:subComponents];
        BOOL isDir;
        BOOL exists = [[NSFileManager defaultManager]
                       fileExistsAtPath:subPath isDirectory:&isDir];
        
        if (!exists) {
            result = [[NSFileManager defaultManager]
                      createDirectoryAtPath:subPath
                      withIntermediateDirectories:YES
                      attributes:inAttributes
                      error:nil];
            if (!result)
                return result;
        }
    }
    return result;
}

+ (NSString *)pathWithDocuments
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


#pragma mark - 写入数据
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName
{
    if (!string || !stringId || !tableName) return;
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    if(store)
        [store putString:string withId:stringId intoTable:tableName];
    [store close];
}

- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName
{
    if (number == nil || !numberId || !tableName) return;
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    if(store)
        [store putNumber:number withId:numberId intoTable:tableName];
    [store close];
}


- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName
{
    if (!object || !objectId || !tableName) return;
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    if(store)
        [store putObject:object withId:objectId intoTable:tableName];
    [store class];
}


#pragma mark - 读取数据
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    NSString *value = nil;
    if(store)
        value = [store getStringById:stringId fromTable:tableName];
    [store close];
    return value;
}

- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    NSNumber *value = nil;
    if(store)
        value = [store getNumberById:numberId fromTable:tableName];
    [store close];
    return value;
}


- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    id value = nil;
    if(store)
        value = [store getObjectById:objectId fromTable:tableName];
    [store close];
    return value;
}

#pragma mark - 删除数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    if(store)
        [store deleteObjectById:objectId fromTable:tableName];
    [store close];
}

- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    if(store)
        [store deleteObjectsByIdArray:objectIdArray fromTable:tableName];
    [store close];
}

- (NSArray *)getAllItemsFromTable:(NSString *)tableName{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[LLKeyValueStore dbPath]];
    NSArray *allItem;
    if(store)
        allItem = [store getAllItemsFromTable:tableName];
    [store close];
    return allItem;
}




@end
