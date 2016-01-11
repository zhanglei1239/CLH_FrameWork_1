//
//  NetServiceManager.h
//  NetWorkingDemo
//
//  Created by Mac on 15/12/17.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface NetServiceManager : NSObject
{
    AFHTTPSessionManager * _httpSessionManager;
}
+ (instancetype)sharedNetServiceManager;

/**
 *  Post方式请求数据
 *
 *  @param path       请求路径
 *  @param parameters 传递的参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;


/**
 *  Get方式请求数据
 *
 *  @param path       请求路径
 *  @param parameters 传递的参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;
/**
 *  网络状态变化监听回调方法
 *  
 *  @param success 状态变化之后 需要返回成功的回调
 *  @param fail    状态变化之后 需要返回失败的回调
 */
- (void)reachablityStatus:(void (^)())success fail:(void (^) ())fail;
@end
