//
//  ZFAppDelegate.m
//  掌公交
//
//  Created by froda on 15/1/15.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import "ZFAppDelegate.h"
#import "BusLineViewController.h"
@implementation ZFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //启动百度引擎
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [mapManager start:@"TN9CjZzsOq41lpqP1pzvGZVQ" generalDelegate:self];
    if (!ret) {
        NSLog(@"百度引擎启动失败!");
    }
    NSLog(@"百度引擎启动成功！");
    
    //高德地图SDK授权
    [MAMapServices sharedServices].apiKey =@"d194a3390fc706293b8bb612d67269cb";
    
    [self createTabBarController];//创建总的控制器
    
    return YES;
}

//此方法用于创建总的控制器，为tabBarController
- (void)createTabBarController{
    BusViewController *busView = [[BusViewController alloc]init];
    UINavigationController *zfbusNavigation = [[UINavigationController alloc]initWithRootViewController:busView];
    busView.title = @"掌公交";
    busView.tabBarItem.image = [UIImage imageNamed:@"1.png"];
    
    
    SearchViewController *searchView = [[SearchViewController alloc]init];
    UINavigationController *zfsearchNavigation = [[UINavigationController alloc]initWithRootViewController:searchView];
    searchView.title = @"查询";
    searchView.tabBarItem.image = [UIImage imageNamed:@"2.png"];
    
    BusLineViewController *mapView = [[BusLineViewController alloc]init];
    UINavigationController *zfmapNavigation = [[UINavigationController alloc]initWithRootViewController:mapView];
    mapView.title = @"地图";
    mapView.tabBarItem.image = [UIImage imageNamed:@"3.png"];
    
    MoreViewController *moreView = [[MoreViewController alloc]init];
    UINavigationController *zfmoreNavigation = [[UINavigationController alloc]initWithRootViewController:moreView];
    moreView.title = @"设置";
    moreView.tabBarItem.image = [UIImage imageNamed:@"4.png"];
    
    NSArray *tabBarControllerArray = [NSArray arrayWithObjects:zfbusNavigation,zfsearchNavigation,zfmapNavigation,zfmoreNavigation, nil];
    
    UITabBarController *zftabBarcontroller = [[UITabBarController alloc]init];
    zftabBarcontroller.viewControllers = tabBarControllerArray;
    zftabBarcontroller.delegate = self;
    
    self.window.rootViewController = zftabBarcontroller;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
