//
//  AppDelegate.m
//  BMK_XKMap
//
//  Created by 董向坤 on 2018/11/5.
//  Copyright © 2018 晓坤. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate ()<BMKLocationAuthDelegate, BMKGeneralDelegate>
@property (nonatomic, strong) BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    
    ViewController *vc = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    [self initBMKMap];
    
    return YES;
}

//百度地图
- (void)initBMKMap{
    
        [[BMKLocationAuth sharedInstance] checkPermisionWithKey:XKBMK_Key authDelegate:self];
        _mapManager = [[BMKMapManager alloc] init];
        if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
            NSLog(@"经纬度类型设置成功");
        } else {
            NSLog(@"经纬度类型设置失败");
        }
    
        //启动引擎并设置AK并设置delegate
        BOOL result = [_mapManager start:XKBMK_Key generalDelegate:self];
        if (!result) {
            NSLog(@"启动引擎失败");
        }
}

/**
 鉴权结果回调
 
 @param iError 鉴权结果错误码信息，0代表鉴权成功
 */
- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        NSLog(@"授权成功");
    } else {
        NSLog(@"授权失败：%d", iError);
    }
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
