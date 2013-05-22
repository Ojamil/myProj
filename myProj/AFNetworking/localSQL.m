

#import "localSQL.h"

#define database_name       @"Activity_Info.sqlite3"      //数据库名称
#define ACTIVITY            @"ACTIVITY"                   //Activity表名
#define plist_name          @"User_Info.plist"            //用户信息plist文件名

@interface localSQL ()

@end

@implementation localSQL


//初始化数据库
-(localSQL *)init
{
    self.database_path = [self getPaths];

    return self;
}

+(BOOL)checkIfExists
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFile = [documentsDirectory stringByAppendingPathComponent:plist_name];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFile])
    {
        NSString *check = [NSString stringWithFormat:@"%d",0];
        NSDictionary *dict = [localSQL getLocalUserInfo];
        if (![[dict objectForKey:@"uid"]isEqual:check])
            return true;
    }
    return false;
}

#pragma mark - ActivityInfo
//删除当前activity表格
- (void)deleteTable
{
    if (sqlite3_open([self.database_path UTF8String], &self->database)==SQLITE_OK)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM '%@' ",ACTIVITY];
        [self execSql:sql];
    }
    else
    {
        NSLog(@"数据库打开失败！");
    }
    sqlite3_close(self->database);
    
}

//创建Activity数据库表格
- (void)createActivityTable
{
    if (sqlite3_open([self.database_path UTF8String], &self->database)==SQLITE_OK)
    {
        NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (AID INTEGER PRIMARY KEY, ANAME CHAR(2000), MAXNUM CHAR(2000), AABS CHAR(3000), AJOINED CHAR(2000), ACLICK CHAR(2000))",ACTIVITY];
        [self execSql:sqlCreateTable];
    }
    else
    {
        NSLog(@"数据库打开失败！");
    }
    sqlite3_close(self->database);
    
}

//添加活动信息
- (void)insertActID:(int)aid ForName:(NSString *)aname ForMaxnum:(NSString *)maxnum ForAbs:(NSString *)aabs ForJoined:(NSString *)ajoined ForClick:(NSString *)click
{
    if (sqlite3_open([self.database_path UTF8String], &self->database)==SQLITE_OK)
    {
        NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO '%@' (AID, ANAME, MAXNUM,AABS,AJOINED,ACLICK) VALUES (%d, '%@', '%@','%@','%@','%@')",ACTIVITY,aid,aname,maxnum,aabs,ajoined,click ];
        [self execSql:sql];
    }
    else
    {
        NSLog(@"数据库打开失败！");
    }
    sqlite3_close(self->database);
}

//删除本地某活动
- (void)deleteActID:(int)aid
{
    if (sqlite3_open([self.database_path UTF8String], &self->database)==SQLITE_OK)
    {
        NSString *sql = [NSString stringWithFormat:
                         @"DELETE FROM '%@' WHERE AID='%D'",ACTIVITY,aid];
        [self execSql:sql];
    }
    else
    {
        NSLog(@"数据库打开失败！");
    }
    sqlite3_close(self->database);
}

//更新活动
- (void)updateActID:(int)aid ForName:(NSString *)aname ForMaxnum:(NSString *)maxnum ForAbs:(NSString *)aabs ForJoined:(NSString *)ajoined ForClick:(NSString *)click
{
    [self deleteActID:aid];
    [self insertActID:aid ForName:aname ForMaxnum:maxnum ForAbs:aabs ForJoined:ajoined ForClick:click];
}

//获取活动信息
- (NSMutableArray *)getAct
{
    NSMutableArray *res = [[NSMutableArray alloc]init];
    
    if (sqlite3_open([self.database_path UTF8String], &self->database)==SQLITE_OK)
    {
        sqlite3_stmt *statement;
        NSString *sql = [NSString stringWithFormat:@"SELECT* FROM '%@'",ACTIVITY];
    
        if (sqlite3_prepare_v2(self->database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //获取aid
               int raw_aid = sqlite3_column_int(statement, 0);
                NSString *aid = [NSString stringWithFormat:@"%d",raw_aid];
                //获取aname
                char *info1 = (char *)sqlite3_column_text(statement, 1);
                NSString *aname = [[NSString alloc] initWithUTF8String:info1];
                //获取maxNum
                char *info2 = (char *)sqlite3_column_text(statement, 2);
                NSString *maxnum = [[NSString alloc] initWithUTF8String:info2];
                //获取aabs
                char *info3 = (char *)sqlite3_column_text(statement, 3);
                NSString *aabs = [[NSString alloc] initWithUTF8String:info3];
                //获取ajoined
                char *info4 = (char *)sqlite3_column_text(statement, 4);
                NSString *ajoined = [[NSString alloc] initWithUTF8String:info4];
                //获取aclick
                char *info5 = (char *)sqlite3_column_text(statement, 5);
                NSString *aclick = [[NSString alloc] initWithUTF8String:info5];
                
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aid,@"aid",
                                                 aname,@"aname",
                                                 maxnum,@"maxNum",
                                                 aabs,@"aabs",
                                                 ajoined,@"ajoined",
                                                 aclick,@"aclick", nil];
                [res addObject:dict];
            }
        sqlite3_finalize(statement);
        }
    }
    else
    {
        NSLog(@"数据库打开失败！");
    }
    sqlite3_close(self->database);
    
    return res;
}

#pragma mark - UserInfo
//储存用户信息
+ (void)creatLocalUserInfo:(NSDictionary *)dict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFile = [documentsDirectory stringByAppendingPathComponent:plist_name];
    [dict writeToFile:plistFile atomically:YES];
}

//获取用户信息
+ (NSDictionary *)getLocalUserInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFile = [documentsDirectory stringByAppendingPathComponent:plist_name];
    NSDictionary *dict;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFile])
    {
        dict = [[NSDictionary alloc]initWithContentsOfFile:plistFile];
    }
    return dict;
}

+ (void)deleteLocalUserInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFile = [documentsDirectory stringByAppendingPathComponent:plist_name];

    NSString *defaultAid = [NSString stringWithFormat:@"%d",0];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFile])
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:defaultAid,@"uid", nil];
        [dict writeToFile:plistFile atomically:YES];
    }
}


#pragma mark - private
//返回数据库地址   private:
- (NSString *)getPaths
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:database_name];
    return database_path;
}

//执行不返回数据的sql语句     private:
- (void)execSql:(NSString *)sql
{
        char *err;
        if (sqlite3_exec(self->database, [sql UTF8String], NULL, NULL, &err) !=     SQLITE_OK)
        {
            sqlite3_close(self->database);
            NSLog(@"数据库操作数据失败!");
        }
        NSLog(@"数据库操作成功！");
}



@end
