
#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface localSQL : NSObject
{
    sqlite3 *database;
}
@property (strong,nonatomic) NSString *database_path;

//初始化类
-(localSQL *)init;

//查看本地是否已存有用户信息
+(BOOL)checkIfExists;

//删除当前Activity表格
- (void)deleteTable;

//创建Activity数据库表格
- (void)createActivityTable;

//添加活动信息
- (void)insertActID:(int)aid ForName:(NSString *)aname ForMaxnum:(NSString *)maxnum ForAbs:(NSString *)aabs ForJoined:(NSString *)ajoined ForClick:(NSString *)click;

//删除活动信息
- (void)deleteActID:(int)aid;

//更新某条本地活动信息
- (void)updateActID:(int)aid ForName:(NSString *)aname ForMaxnum:(NSString *)maxnum ForAbs:(NSString *)aabs ForJoined:(NSString *)ajoined ForClick:(NSString *)click;

//获取活动信息
- (NSMutableArray *)getAct;

//创建用户信息
+ (void)creatLocalUserInfo:(NSDictionary *)dict;

//返回用户信息
+ (NSDictionary *)getLocalUserInfo;

//删除用户信息
+ (void)deleteLocalUserInfo;

@end
