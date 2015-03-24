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
    NSError *error;
    //首先加载一个NSURL对象
    NSString *requestString = [NSString stringWithFormat:@"http://api.36wu.com/Bus/GetStationInfo?city=%@&station=%@",[@"长春" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[zhandianValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
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
}

- (void)creatResultFrame{
    UILabel *dataLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, 20)];
    dataLable.textAlignment = NSTextAlignmentCenter;
    //dataLable.backgroundColor = [UIColor redColor];
    dataLable.text = [NSString stringWithFormat:@"含有%@的公交站点，共有%i个",dataSource1[0],[dataSource1 count]];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
