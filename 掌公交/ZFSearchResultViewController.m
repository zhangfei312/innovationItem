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
    NSMutableData *responseData;
    UIView *backview;
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

//此方法用于请求查询公交信息
- (void)requestBusInformation{
    
     //加载用于请求是出现的菊花
    
    backview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    backview.backgroundColor = [UIColor clearColor];
    
    UIView *activityIndicatorView = [[UIView alloc]initWithFrame:CGRectMake(((self.view.frame.size.width-100)/2), ((self.view.frame.size.height-100)/2), 100, 100)];
    activityIndicatorView.backgroundColor = [UIColor grayColor];
    [backview addSubview:activityIndicatorView];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.frame = CGRectMake(0,0,30,30);
    [indicatorView setCenter:CGPointMake(50, 50)];
    [indicatorView startAnimating];
    [activityIndicatorView addSubview:indicatorView];
    
    [self.view addSubview:backview];
    
    
    //NSError *error;
    //首先加载一个NSURL对象
    NSUserDefaults *gohomeSetting = [NSUserDefaults standardUserDefaults];
    NSString *city = [gohomeSetting objectForKey:@"city"];
    NSLog(@"设置的城市是：%@",city);
    //http://api.36wu.com/Bus/GetTransferInfo?city=%@&start=%@&end=%@&format=json
    //http://op.juhe.cn/189/bus/station?key=%@&city=%@station=%@
    NSString *requestString = [NSString stringWithFormat:@"http://api.36wu.com/Bus/GetTransferInfo?city=%@&start=%@&end=%@&format=json",[city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_startValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_endValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    request.timeoutInterval = 15.0;
    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    NSLog(@"请求已经发出！");
    
 /*
    //    NSLog(@"终点：%@",[detail valueForKey:@"end_stat"]);
    //    NSLog(@"需步行到起点的距离：%@",[detail valueForKey:@"foot_dist"]);
    //    NSLog(@"线路总长:%@",[detail valueForKey:@"line_dist"]);
    //    NSLog(@"途径站点:%@",[detail valueForKey:@"stats"]);
    //    NSLog(@"线路名称:%@",[detail valueForKey:@"line_name"]);
    //    NSLog(@"需要花费时间:%@",[bus_array1 valueForKey:@"time"]);
    //    busString = [detail valueForKey:@"line_name"];
    */
}

#pragma mark- NSURLConnectionDataDelegate代理方法

//当接收到服务器的响应（连通了服务器）时会调用

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"接收到服务器的响应");
    responseData = [NSMutableData data];
}

//当接收到服务器的数据时会调用（可能会被调用多次，每次只传递部分数据）

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"接收到服务器的数据");
    [responseData appendData:data];
    NSLog(@"%d---%@--",responseData.length,[NSThread currentThread]);
}

//当服务器的数据加载完毕时就会调用

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"服务器的数据加载完毕");
    
    //处理服务器返回的所有数据
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *resultData = [dict valueForKey:@"data"];
    NSDictionary *result_buses = [resultData valueForKey:@"buses"];
    NSArray *bus_array = [result_buses valueForKey:@"bus"];//返回的公交车的信息
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
    [backview removeFromSuperview];
    
}

//请求错误（失败）的时候调用（请求超时\断网\没有网\，一般指客户端错误）

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"请求错误");
    [backview removeFromSuperview];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark UIalterViewDelegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"数据加载失败了!-----");
    }
}
@end
