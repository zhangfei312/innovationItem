//
//  ZFSearchResultViewController.m
//  掌公交
//
//  Created by froda on 15/4/5.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import "ZFSearchResultViewController.h"
#import "BusViewController.h"
#import "ZFLineDeatialViewController.h"
#import "ZFRealTimeViewController.h"
@interface ZFSearchResultViewController (){
    NSString *busString;
    UILabel *lable1;
    UILabel *lable2;
    NSMutableArray *dataSource;//用于存放公交车信息
}
@end

@implementation ZFSearchResultViewController
@synthesize lable1 = _lable1;
@synthesize lable2 = _lable2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc]init];
    [self requestBusInformation];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.backgroundColor = [UIColor orangeColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"查询结果";
    [self initFrameButton];
    _lable1.text = _startValue;
    _lable2.text = _endValue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSString *dataS = dataSource[indexPath.row];
    myCell.textLabel.text = dataS;
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    myCell.backgroundColor = [UIColor clearColor];
    return  myCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int x = indexPath.row;
    NSLog(@"你点击了%i",x);
    ZFRealTimeViewController *ld = [[ZFRealTimeViewController alloc]init];
    ld.receive = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSLog(@"传入的线路是：%@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text);
    [self.navigationController pushViewController:ld animated:YES];
}
- (void)initFrameButton{
    [_frameButton.layer setCornerRadius:8.0];//设置矩圆角半径
    [_frameButton.layer setBorderWidth:2.0];//边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.807, 0.814, 0.788, 1.000 });
    [_frameButton.layer setBorderColor:colorref];
}
/*
- (void)creatResultFrame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 80, 300, 100);
    [button.layer setCornerRadius:8.0];//设置矩圆角半径
    [button.layer setBorderWidth:2.0];//边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.807, 0.814, 0.788, 1.000 });
    [button.layer setBorderColor:colorref];
    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, 299, 45)];
    lable1.text = _startValue;//@"起点：延安大街";
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(225, 110, 299, 45)];
    lable2.text  =_endValue;//@"终点：修正路";
    
    UIButton *busDirection = [[UIButton alloc]initWithFrame:CGRectMake(110, 127, 100, 10)];
    [busDirection setImage:[UIImage imageNamed:@"busDirection.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    [self.view addSubview:lable1];
    [self.view addSubview:lable2];
    [self.view addSubview:busDirection];
    
}
 */

//此方法用于请求查询公交信息
- (void)requestBusInformation{
    /*
     加载用于请求是出现的菊花
     */
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    UIActivityIndicatorView *native = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    native.frame = CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+20, 20, 20);
    native.hidesWhenStopped = YES;
    [native startAnimating];
    [view addSubview:native];
    [self.view addSubview:view];
    
    NSError *error;
    //首先加载一个NSURL对象
    NSUserDefaults *gohomeSetting = [NSUserDefaults standardUserDefaults];
    NSString *city = [gohomeSetting objectForKey:@"city"];
    NSLog(@"设置的城市是：%@",city);
    NSString *requestString = [NSString stringWithFormat:@"http://api.36wu.com/Bus/GetTransferInfo?city=%@&start=%@&end=%@&format=json",[city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_startValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_endValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    //弄一个NSData对象，用来装返回的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //弄一个字典，用NSJSONSerialization把data数据解析出来。
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *resultData = [dic valueForKey:@"data"];
    NSDictionary *result_buses = [resultData valueForKey:@"buses"];
    NSArray *bus_array = [result_buses valueForKey:@"bus"];//返回的公交车的信息
    // NSlog(@"tiaoshu:%i",[bus_array count]);
    if ([dic isEqual:NULL]) {
        NSLog(@"请求回来的数据不是空！");
        [native stopAnimating];
        [view removeFromSuperview];
    }
    for (int i = 0; i < [bus_array count]; i++) {
        
        NSDictionary *bus_array1 = bus_array[i];
        //NSLog(@"条数:%i",[bus_array count]);
        NSDictionary *bus_array1_segments = [bus_array1 valueForKey:@"segments"];
        NSArray *bus_array1_segments_segment = [bus_array1_segments valueForKey:@"segment"];
        NSDictionary *detail = bus_array1_segments_segment[0];
        NSString *bus_line_data = [detail valueForKey:@"line_name"];
        [dataSource addObject:bus_line_data];
        NSLog(@"线路名称:%@",[detail valueForKey:@"line_name"]);
    }
    //    NSLog(@"终点：%@",[detail valueForKey:@"end_stat"]);
    //    NSLog(@"需步行到起点的距离：%@",[detail valueForKey:@"foot_dist"]);
    //    NSLog(@"线路总长:%@",[detail valueForKey:@"line_dist"]);
    //    NSLog(@"途径站点:%@",[detail valueForKey:@"stats"]);
    //    NSLog(@"线路名称:%@",[detail valueForKey:@"line_name"]);
    //    NSLog(@"需要花费时间:%@",[bus_array1 valueForKey:@"time"]);
    //    busString = [detail valueForKey:@"line_name"];
}
@end
