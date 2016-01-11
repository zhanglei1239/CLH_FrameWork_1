//
//  NetServiceManager.m
//  NetWorkingDemo
//
//  Created by Mac on 15/12/17.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import "NetServiceManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

NetServiceManager * _shareServiceManager;

@implementation NetServiceManager

+ (id)sharedNetServiceManager
{
    static dispatch_once_t pred = 0;
    __strong static id _shareServiceManager = nil;
    dispatch_once(&pred,^{
        _shareServiceManager = [[self alloc] init];
    });
    return _shareServiceManager;
}

-(void)dealloc{
    
}

- (id)init
{
    self = [super init];
    if (self) {
        _httpSessionManager = [AFHTTPSessionManager manager];
//        _httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (void)reachablityStatus:(void (^)())success fail:(void (^) ())fail
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //网络状态未知:
//                [[NSNotificationCenter defaultCenter] postNotificationName:kPLNetWorkingStatusChange object:@"4"];
                if (fail) {
                    fail();
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //网络不可用
//                [[NSNotificationCenter defaultCenter] postNotificationName:kPLNetWorkingStatusChange object:@"0"];
                if (fail) {
                    fail();
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //Wifi网
//                [[NSNotificationCenter defaultCenter] postNotificationName:kPLNetWorkingStatusChange object:@"2"];
                if (success) {
                    success();
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //2G 3G 4G 移动网络
//               [[NSNotificationCenter defaultCenter] postNotificationName:kPLNetWorkingStatusChange object:@"1"];
                if (success) {
                    success();
                }
            }
                break;
            default:
                break;
        }
    }];
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [_httpSessionManager POST:path parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //请求处理中回调
        NSLog(@"...");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        //请求成功回调
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       //请求失败回调
        if (success) {
            failure(error);
        }
    }];
}

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [_httpSessionManager GET:path parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //请求处理中回调
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功回调
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败回调
        if (failure) {
            failure(error);
        }
    }];
}

@end
