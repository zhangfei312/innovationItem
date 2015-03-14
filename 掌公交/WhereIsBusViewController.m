//
//  WhereIsBusViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "WhereIsBusViewController.h"
#import "ZFAnation.h"
#import "WXAnation.h"

#define keyValueString @"24de84ea5b588fcdfc82b996c04f13c3"

@interface WhereIsBusViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate>{
    float x,y;
    ZFAnation *anation;
    UITextField *searchFiled;
}

@end

@implementation WhereIsBusViewController

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
    
    /*
     
     在进行界面设计时候注释的地图功能
    
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    //    locationManager.distanceFilter = 1000.0f;
    //    locationManager.desiredAccuracy  = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    
    [self creatAnnotation];
    
    [self.view addSubview:_mapView];
    
    [self startPating];
     
     */
    
    [self initSearch];
    
}

//获取实时公交数据的方法
-(void) fecthInformation{
    NSError *error;
    NSString *requestString = [NSString stringWithFormat:@"http://apis.juhe.cn/szbusline/bus?key=%@&stationCode=EFP&dtype=json",keyValueString];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *resultData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *result = [resultData valueForKey:@"result"];
    NSLog(@"%@",result);
    NSLog(@"%@",[result[0] valueForKey:@"FromTo"]);
}

//初始化搜索框
-(void)initSearch{
    searchFiled = [[UITextField alloc]initWithFrame:CGRectMake(2, 68, 316, 40)];
    searchFiled.borderStyle = UITextBorderStyleRoundedRect;
    searchFiled.clearButtonMode = UITextFieldViewModeAlways;
    searchFiled.clearsOnBeginEditing = YES;
    searchFiled.alpha = 0.7;
    searchFiled.text = @"请输入站台名称或者线路名";
    searchFiled.delegate = self;
    [searchFiled addTarget:self action:@selector(exitKeyBoard:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
    [self.view addSubview:searchFiled];
    
    //用于点击空白处退出键盘的button
    UIButton *exitKeyboard = [[UIButton alloc]initWithFrame:CGRectMake(0, 108, self.view.bounds.size.width, self.view.bounds.size.height-108)];
    [exitKeyboard addTarget:self action:@selector(exitBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitKeyboard];
    
}
//点击空白背景时会退出键盘
-(void)exitBtnMethod:(id)sender{
    [searchFiled resignFirstResponder];
}
//点击return时候会退出键盘
- (void)exitKeyBoard:(id)sender {
    [sender resignFirstResponder];
}

- (void)creatAnnotation{
    x = 43.860657;
    y = 125.295838;
    CLLocationCoordinate2D showCoord = {x,y};
    anation = [[ZFAnation alloc]initWithCoordinate2D:showCoord];
    anation.title = @"自定义大头针";
    anation.subtitle  =@"小标题";
    
    [_mapView addAnnotation:anation];
}
-(void)paint:(NSTimer *)paraTimer{
    x = x +1;
    NSLog(@"%f",x);
    
    [self creatAnnotation];
    //[self mapView:_mapView viewForAnnotation:anation];
    NSLog(@"kaishi!");
    
}
- (void)startPating{
    self.paintingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(paint:) userInfo:nil repeats:YES];
}

- (void)stopPainting{
    if (self.paintingTimer != nil) {
        [self.paintingTimer invalidate];
    }
}

#pragma mark - MKAnnotationView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //判断是否为当前设备位置的annotation
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //返回nil，就使用默认的标注视图
        return nil;
    }
    
    //-------------------创建大头针视图---------------------
    
    static NSString *identifier = @"Annotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        //        annotationView = [[MKAnnotationView alloc] initWithAnnotation:<#(id<MKAnnotation>)#> reuseIdentifier:<#(NSString *)#>];
        
        //MKPinAnnotationView 是大头针视图
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        //设置是否显示标题视图
        annotationView.canShowCallout = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //[button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        //标题右边视图
        annotationView.rightCalloutAccessoryView = button;
        //标题左边视图
        //        annotationView.leftCalloutAccessoryView
    }
    
    annotationView.annotation = annotation;
    
    //设置大头针的颜色
    annotationView.pinColor = MKPinAnnotationColorRed;
    //从天上落下的动画
    annotationView.animatesDrop = YES;
    
    return annotationView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_mapView setRegion:region animated:YES];
    //mapView.centerCoordinate = loca.coordinate;
    [locationManager stopUpdatingLocation];
    NSLog(@"%@",loca);
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    _mapView.delegate = nil;
    locationManager.delegate = nil;
    [locationManager stopUpdatingLocation];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self stopPainting];
}
@end
