//
//  AppDelegate.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingPageViewController.h"
#import "MainViewController.h"
#import <BaiduMapAPI/BMKMapManager.h>
#import "CustomURLCache.h"
@interface AppDelegate ()

@end
BMKMapManager* _mapManager;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    self.window.frame =[[UIScreen mainScreen] bounds];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    BOOL ret = [_mapManager start:@"9BV9EM4zYsn99xTTuC45LGfM" generalDelegate:self];
    if (!ret) {
        NSLog(@"shit");
    }
    
    MainViewController *_mainViewController = [[MainViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:_mainViewController];
    self.window.rootViewController = nav;
    
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                 diskCapacity:200 * 1024 * 1024
                                                                     diskPath:nil
                                                                    cacheTime:0];
    [CustomURLCache setSharedURLCache:urlCache];
    
    [NSURLCache setSharedURLCache:urlCache];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
