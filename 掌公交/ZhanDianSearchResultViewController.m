//
//  ZhanDianSearchResultViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-18.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "ZhanDianSearchResultViewController.h"
#import "ZhanDianresultViewController.h"
@interface ZhanDianSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *busString;
    UILabel *lable1;
    UILabel *lable2;
    NSMutableArray *dataSource1;//用于存放公交车信息
    NSMutableArray *dataSource2;
    UITableView *resultTabview;
    NSMutableData *responseData;
    UIView *backview;
}

@end

@implementation ZhanDianSearchResultViewController
@synthesize zhandianValue;
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
    dataSource1 = [[NSMutableArray alloc]init];
    dataSource2 = [[NSMutableArray alloc]init];
    NSLog(@"zhandian:%@",zhandianValue);
    resultTabview = [[UITableView alloc]init];
    [self creatResultTabview];
    
    [resultTabview setScrollEnabled:NO];
    [self setExtraCellLineHidden:resultTabview];
    
    [self requestBusInformation];
    [self creatResultFrame];
	// Do any additional setup after loading the view.
}
//用于隐藏没有用的横线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//此方法用于请求查询公交信息
- (void)requestBusInformation{
    
    //-----------------------------------------------------------------
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
    //------------------------------------------------------------------
    
    
    //首先加载一个NSURL对象
    NSString *requestString = [NSString stringWithFormat:@"http://api.36wu.com/Bus/GetStationInfo?city=%@&station=%@&format=json",[@"长春" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[zhandianValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    request.timeoutInterval = 15.0;
    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    NSLog(@"请求已经发出！");
    
    /*
    //弄一个NSData对象，用来装返回的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //弄一个字典，用NSJSONSerialization把data数据解析出来。
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *arrayData = [dic valueForKey:@"data"];
    NSLog(@"data:%@",arrayData);
    NSLog(@"dataSource1:%i",[arrayData count]);
    for (int i = 0; i < [arrayData count]; i ++) {
        NSDictionary *dicData = arrayData[i];
        NSString *temp = [dicData valueForKey:@"name"];
        [dataSource1 addObject:temp];
        NSString *temp2 = [dicData valueForKey:@"line_names"];
        [dataSource2 addObject:temp2];
        
    }
     */
}

- (void)creatResultFrame{
    UILabel *dataLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, 20)];
    dataLable.textAlignment = NSTextAlignmentCenter;
    //dataLable.backgroundColor = [UIColor redColor];
    if (dataSource1 == nil) {
        dataLable.text = [NSString stringWithFormat:@"含有%@的公交站点，共有%i个",self.zhandianValue,0];
    }else{
        dataLable.text = [NSString stringWithFormat:@"含有%@的公交站点，共有%i个",self.zhandianValue,[dataSource1 count]];

    }
    [self.view addSubview:dataLable];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width, 1)];
    view1.backgroundColor = [UIColor grayColor];
    view1.alpha = 0.2;
    [self.view addSubview:view1];
    
}
- (void)creatResultTabview{
    resultTabview.frame = CGRectMake(0, 60, 320, 800);
    //resultTabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, 320, 800) style:UITableViewStylePlain];
    resultTabview.dataSource = self;
    resultTabview.delegate = self;
    [self.view addSubview:resultTabview];
}
#pragma mark deleate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataSource2 count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSString *dataS = dataSource1[indexPath.row];
    myCell.textLabel.text = dataS;
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    myCell.backgroundColor = [UIColor clearColor];
    return  myCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ZhanDianresultViewController *cot = [[ZhanDianresultViewController alloc]init];
    
    int i = indexPath.row;
    
    NSString *temp = dataSource2[i];
    cot.resultValue = temp;
    cot.zhanDianString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [self.navigationController pushViewController:cot animated:YES];
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
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    NSArray *arrayData = [dic valueForKey:@"data"];
    NSLog(@"data:%@",arrayData);
    NSLog(@"dataSource1:%i",[arrayData count]);
    for (int i = 0; i < [arrayData count]; i ++) {
        NSDictionary *dicData = arrayData[i];
        NSString *temp = [dicData valueForKey:@"name"];
        [dataSource1 addObject:temp];
        NSString *temp2 = [dicData valueForKey:@"line_names"];
        [dataSource2 addObject:temp2];
        
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
