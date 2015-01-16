//
//  SearchResultViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "SearchResultViewController.h"
#import "BusViewController.h"


@interface SearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *busString;
    UILabel *lable1;
    UILabel *lable2;
    NSMutableArray *dataSource;//用于存放公交车信息
}

@end

@implementation SearchResultViewController
@synthesize startValue;
@synthesize endValue;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"方案";
    dataSource = [[NSMutableArray alloc]init];
    [self creatResultFrame];
    [self requestBusInformation];
    [self creatResultTabview];
    
	// Do any additional setup after loading the view.
}

//此方法用于请求查询公交信息
- (void)requestBusInformation{
    NSError *error;
    //首先加载一个NSURL对象
    NSString *requestString = [NSString stringWithFormat:@"http://api.36wu.com/Bus/GetTransferInfo?city=%@&start=%@&end=%@",[@"长春" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[startValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[endValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    //弄一个NSData对象，用来装返回的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //弄一个字典，用NSJSONSerialization把data数据解析出来。
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *resultData = [dic valueForKey:@"data"];
    NSDictionary *result_buses = [resultData valueForKey:@"buses"];
    NSArray *bus_array = [result_buses valueForKey:@"bus"];//返回的公交车的信息
   // NSlog(@"tiaoshu:%i",[bus_array count]);
    for (int i = 0; i < [bus_array count]; i++) {
        
        NSDictionary *bus_array1 = bus_array[i];
        NSLog(@"条数:%i",[bus_array count]);
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

- (void)creatResultFrame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 80, 300, 100);
    [button.layer setCornerRadius:8.0];//设置矩圆角半径
    [button.layer setBorderWidth:2.0];//边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.807, 0.814, 0.788, 1.000 });
    [button.layer setBorderColor:colorref];
    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, 299, 45)];
    lable1.text = startValue;//@"起点：延安大街";
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 130, 299, 45)];
    lable2.text  =endValue;//@"终点：修正路";
    
    [self.view addSubview:button];
    [self.view addSubview:lable1];
    [self.view addSubview:lable2];
    
}
- (void)creatResultTabview{
    UITableView *resultTabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, 320, 800) style:UITableViewStylePlain];
    resultTabview.dataSource = self;
    resultTabview.delegate = self;
    [self.view addSubview:resultTabview];
}
#pragma mark deleate
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
    UITableView *secondView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    UIViewController *cot = [[UIViewController alloc] init];
    
    [cot.view addSubview:secondView];
    
    [self.navigationController pushViewController:cot animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
