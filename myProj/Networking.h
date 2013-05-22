//
//  Networking.h
//  iVolunteer
//
//  Created by Bryan on 13-5-20.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "XYAlertViewHeader.h"
#import "localSQL.h"

@interface Networking : NSObject 

@property (strong,nonatomic) NSURL *url;
@property (strong,nonatomic) NSMutableURLRequest *request;

//设置网络请求参数
- (Networking *)initWithPhp:(NSString *)php method:(NSString *)method parameters:(NSDictionary *)obj;

//从云端获取活动数据并存储在本地数据库中，loadingView为传递参数,selector为函数指针 
- (void)getCloudActInfoWithSelector:(SEL)selector by:(NSObject *)obj;

//发送json请求
-(void)setJsonRequestForObject:(NSObject *)obj ifSuccess:(SEL)success ifFailure:(SEL)failure;
@end

