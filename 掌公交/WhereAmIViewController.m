//
//  WhereAmIViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "WhereAmIViewController.h"

@interface WhereAmIViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@end

@implementation WhereAmIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
//    locationManager.distanceFilter = 1000.0f;
//    locationManager.desiredAccuracy  = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    start.frame = CGRectMake(20,self.view.frame.size.height-40,120,30);
    start.alpha = 0.9;
    [start setTitle:@"设置为起点" forState:UIControlStateNormal];
    start.backgroundColor = [UIColor orangeColor];
    start.tintColor = [UIColor redColor];
    [start addTarget:self action:@selector(StartButtnon) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *end = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    end.frame = CGRectMake(180,self.view.frame.size.height-40,120,30);
    end.alpha = 0.9;
    [end setTitle:@"设置为终点" forState:UIControlStateNormal];
    end.backgroundColor = [UIColor orangeColor];
    end.tintColor = [UIColor redColor];
    [end addTarget:self action:@selector(EndButtnon) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mapView];
    [self.view addSubview:start];
    [self.view addSubview:end];
}
- (void)StartButtnon{
    NSString *str = @"延安大街";
    if ([_deleagate respondsToSelector:@selector(sendBtnValue: returnTag:)]) {
        [_deleagate sendBtnValue:str returnTag:1];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"设置为起点方法执行");
    
}
- (void)EndButtnon{
    NSString *str = @"修正路";
    if ([_deleagate respondsToSelector:@selector(sendBtnValue: returnTag:)]) {
        [_deleagate sendBtnValue:str returnTag:2];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"设置为终点方法执行");
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    mapView.centerCoordinate
    CLLocation *loca = [locations lastObject];
    NSLog(@"%f",loca.coordinate.latitude);
//    MKCoordinateRegion theRegion = { {loca.coordinate.latitude, loca.coordinate.longitude }, { 0.1, 0.3 } };
//    theRegion.center= mapView.userLocation.location.coordinate;
//    
//    //缩放的精度。数值越小约精准
//    theRegion.span.longitudeDelta = 0.1f;
//    theRegion.span.latitudeDelta = 0.1f;
//    [mapView setRegion:theRegion animated:YES];
    //坐标
    //地图初始化显示的坐标
    CLLocationCoordinate2D coord = loca.coordinate;    //地图初始化显示的范围
    MKCoordinateSpan span = {0.1,0.1};
    
    MKCoordinateRegion region = {coord,span};
    //地图初始化显示的区域
    [mapView setRegion:region animated:YES];
    //mapView.centerCoordinate = loca.coordinate;
    [locationManager stopUpdatingLocation];
    NSLog(@"%@",loca);
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    mapView.delegate = nil;
    locationManager.delegate = nil;
    [locationManager stopUpdatingLocation];
}

@end
