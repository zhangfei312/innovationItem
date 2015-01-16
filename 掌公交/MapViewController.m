//
//  MapViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

//
//  MapViewController.m
//  掌公交
//
//  Created by zhangfei on 14-8-12.
//  Copyright (c) 2014年 zhangfei. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    mapView.mapType = MAMapTypeStandard;
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    mapView.zoomLevel  = 15;
    [self.view addSubview:mapView];
    
	
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 150, 50, 40);
    [button setTitle:@"定位" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)btnClick{
    mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"---------------------------");
    [super viewDidDisappear:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

