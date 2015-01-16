//
//  ZFAppDelegate.h
//  掌公交
//
//  Created by froda on 15/1/15.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusViewController.h"
#import "SearchViewController.h"
#import "MapViewController.h"
#import "MoreViewController.h"
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>

@interface ZFAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
