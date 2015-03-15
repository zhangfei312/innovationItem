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
#import "BusRealTimeResultViewController.h"
#define keyValueString @"24de84ea5b588fcdfc82b996c04f13c3"

@interface WhereIsBusViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate>{
    float x,y;
    ZFAnation *anation;
    UITextField *searchFiled;
    NSDictionary *resultData;//用于储存返回来的数据
    NSArray *recommendedData;//用于储存推荐的数据
    NSUserDefaults *busRoadLineInform;//公交线路详情数据
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
    
    self.view.backgroundColor = [UIColor orangeColor];
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
    [self initRecommendedData];
    [self setButton];
    
}

//获取实时公交数据的方法
-(id) getInformation:(NSString *)requestString{
    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return result;
}

//获取公交车的详细路线的方法，对于网络数据只获取一次
-(id) getBusLineInformation{
    busRoadLineInform = [NSUserDefaults standardUserDefaults];
    if ([busRoadLineInform objectForKey:@"busRoadLineInform"]) {
        resultData = [busRoadLineInform objectForKey:@"busRoadLineInform"];
    }else{
        NSLog(@"这是第一次获取数据！");
        NSError *error;
        NSString *requestString = [NSString stringWithFormat:@"http://apis.juhe.cn/szbusline/info?key=%@&dtype=json",keyValueString];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        [busRoadLineInform setObject:result forKey:@"busRoadLineInform"];
        [busRoadLineInform synchronize];
    }
    NSDictionary *result = [busRoadLineInform objectForKey:@"busRoadLineInform"];
    return result;
}

//初始化搜索框
-(void)initSearch{
    searchFiled = [[UITextField alloc]initWithFrame:CGRectMake(2, 68, 316, 40)];
    searchFiled.borderStyle = UITextBorderStyleRoundedRect;
    searchFiled.clearButtonMode = UITextFieldViewModeAlways;
    searchFiled.clearsOnBeginEditing = YES;
    searchFiled.alpha = 0.7;
    searchFiled.placeholder = @"请输入站台名称或者线路名";
    searchFiled.delegate = self;
    searchFiled.clearButtonMode = UITextFieldViewModeAlways;
    searchFiled.clearsOnBeginEditing = YES;
    [searchFiled addTarget:self action:@selector(exitKeyBoard:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
    [self.view addSubview:searchFiled];
    
    //用于点击空白处退出键盘的button
    UIButton *exitKeyboard = [[UIButton alloc]initWithFrame:CGRectMake(0, 108, self.view.bounds.size.width, self.view.bounds.size.height-108)];
    [exitKeyboard addTarget:self action:@selector(exitBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitKeyboard];
    
    
    
}
//6个Button的设计
-(void)setButton{
    int width = 100;
    int height = 30;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 135, width, height)];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10+width, 135, width, height)];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(15+width*2, 135, width, height)];
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(5, 185, width, height)];
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(10+width, 185, width, height)];
    UIButton *btn6 = [[UIButton alloc]initWithFrame:CGRectMake(15+width*2, 185, width, height)];
    
    //NSArray *button = [[NSArray alloc]initWithObjects:btn1,btn2,btn3,btn4,btn5,btn6,nil];
    
    [btn1 setTitle:recommendedData[0] forState:UIControlStateNormal];
    [btn2 setTitle:recommendedData[1] forState:UIControlStateNormal];
    [btn3 setTitle:recommendedData[2] forState:UIControlStateNormal];
    [btn4 setTitle:recommendedData[3] forState:UIControlStateNormal];
    [btn5 setTitle:recommendedData[4] forState:UIControlStateNormal];
    [btn6 setTitle:recommendedData[5] forState:UIControlStateNormal];
    
    btn1.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3];
    btn2.backgroundColor = [UIColor colorWithRed:0.3 green:0.1 blue:0.4 alpha:0.8];
    btn3.backgroundColor = [UIColor colorWithRed:0.9 green:0.5 blue:0.9 alpha:0.8];
    btn4.backgroundColor = [UIColor colorWithRed:0.4 green:0.5 blue:0.1 alpha:0.8];
    btn5.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.1 alpha:0.8];
    btn6.backgroundColor = [UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:0.5];
    
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn1.tag = 1;
    btn2.tag = 2;
    btn3.tag = 3;
    btn4.tag = 4;
    btn5.tag = 5;
    btn6.tag = 6;
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    [self.view addSubview:btn5];
    [self.view addSubview:btn6];
    
}

//推荐按钮响应方法
- (void)btnClick:(UIButton *)sender{
    long tag = sender.tag;
    switch (tag) {
        case 1:{
            BusRealTimeResultViewController *realTimeView = [[BusRealTimeResultViewController alloc]init];
            realTimeView.btnString = sender.titleLabel.text;
            [self.navigationController pushViewController:realTimeView animated:YES];
        }
            break;
        case 2:{
            BusRealTimeResultViewController *realTimeView = [[BusRealTimeResultViewController alloc]init];
            realTimeView.btnString = sender.titleLabel.text;
            [self.navigationController pushViewController:realTimeView animated:YES];        }
            break;
        case 3:{
            BusRealTimeResultViewController *realTimeView = [[BusRealTimeResultViewController alloc]init];
            realTimeView.btnString = sender.titleLabel.text;
            [self.navigationController pushViewController:realTimeView animated:YES];
        }
            break;
        case 4:{
            BusRealTimeResultViewController *realTimeView = [[BusRealTimeResultViewController alloc]init];
            realTimeView.btnString = sender.titleLabel.text;
            [self.navigationController pushViewController:realTimeView animated:YES];
        }
            break;
        case 5:{
            BusRealTimeResultViewController *realTimeView = [[BusRealTimeResultViewController alloc]init];
            realTimeView.btnString = sender.titleLabel.text;
            [self.navigationController pushViewController:realTimeView animated:YES];
        }
            break;
        case 6:{
            BusRealTimeResultViewController *realTimeView = [[BusRealTimeResultViewController alloc]init];
            realTimeView.btnString = sender.titleLabel.text;
            [self.navigationController pushViewController:realTimeView animated:YES];
        }
            break;
        default:
            break;
    }
    
}

//搜索框编辑调用
- (void)searchResult:(NSString *)editContent{
    BusRealTimeResultViewController *realTimeView = [[BusRealTimeResultViewController alloc]init];
    [self.navigationController popToViewController:realTimeView animated:YES];
}

//初始或推荐数据
-(void)initRecommendedData{
    recommendedData = [NSArray arrayWithObjects:@"13路",@"人民广场",@"239路",@"南湖广场",@"朝阳桥",@"80路",nil];
}
//根据线路名称查询
-(void)searchByRoute{
    
}
//根据站台查询方法
-(void)searchByStation{
    
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
