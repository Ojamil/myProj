//
//  Networking.m
//  iVolunteer
//
//  Created by Bryan on 13-5-20.
//
//

#import "Networking.h"

@implementation Networking

//初始化
- (Networking *)initWithPhp:(NSString *)php method:(NSString *)method parameters:(NSDictionary *)dict
{
    self.url = [NSURL URLWithString:@"http://103.31.20.55"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:self.url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    self.request = [httpClient requestWithMethod:method path:php parameters:dict];
    
    [self.request addValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-type"];
    
    return self;
}

//发送AFN请求，调入success和failire函数
-(void)setJsonRequestForObject:(NSObject *)obj ifSuccess:(SEL)success ifFailure:(SEL)failure
{
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:self.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([obj respondsToSelector:success])
                [obj performSelector:success withObject:JSON];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if ([obj respondsToSelector:failure])
            [obj performSelector:failure withObject:JSON];
        
    }];
    [operation start];
}

//获取云端所有活动数据并储存在本地数据库中
- (void)getCloudActInfoWithSelector:(SEL)selector by:(NSObject *)obj
{
    [self selfSetMethod:@"GET" Php:@"return_activity.php" parameters:nil];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:self.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [self connectionSuccess:JSON];
        
        if ([obj respondsToSelector:selector])
            [obj performSelector:selector];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [self connectionFailure:nil];
    }];
    [operation start];//一定有
}

//默认成功返回函数
- (void)connectionSuccess:(id)JSON
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    
    NSString *name = [NSString stringWithFormat:@"Record"];
    
    NSDictionary *dict;
    for(int i = 0;i<[JSON count];i++)
    {
        dict = [JSON objectForKey:[name stringByAppendingFormat:@"%d",i]];
        
        [data addObject:dict];
        
    }
    
    localSQL *sql = [[localSQL alloc]init];
    
    [sql createActivityTable];
    [sql deleteTable];
    
    for(int i=0;i<[data count];i++)
    {
        NSDictionary *dict = [data objectAtIndex:i];
        
        [sql insertActID:[[dict objectForKey:@"aid"]intValue] ForName:[dict objectForKey:@"aname"] ForMaxnum:[dict objectForKey:@"maxNum"] ForAbs:[dict objectForKey:@"aabs"] ForJoined:[dict objectForKey:@"ajoined"] ForClick:[dict objectForKey:@"aclick"]];
    }
}

- (void)connectionFailure:(id)JSON
{
    XYShowAlert(@"网络连接失败！");
}



//设置成员变量request
- (void)selfSetMethod:(NSString *)method Php:(NSString *)php parameters:(NSDictionary *)dict
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:self.url];
    self.request = [client requestWithMethod:method path:php parameters:dict];
}
@end
