//
//  ZFLineDeatialViewController.m
//  掌公交
//
//  Created by froda-pc on 15/3/20.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import "ZFLineDeatialViewController.h"

@interface ZFLineDeatialViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *line;
    NSMutableArray *lineInformation;
}

@end

@implementation ZFLineDeatialViewController
@synthesize receive = _receive;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"print _receive :%@",_receive);
    
    [self creatResultTable];
    
    [self creatResultFrame];
    
    [self getLineInformation];
    
    
}
//生成一个说明框框
- (void)creatResultFrame{
    UILabel *dataLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 20)];
    dataLable.textAlignment = NSTextAlignmentCenter;
    dataLable.text = [NSString stringWithFormat:@"%@线路详情",[self getOnlyNum:_receive][0]];
    dataLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dataLable];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(20, 110, self.view.frame.size.width, 1)];
    view1.backgroundColor = [UIColor grayColor];
    view1.alpha = 0.2;
    [self.view addSubview:view1];
}
//生成点点点
-(UIView *)creatAView:(CGFloat)rx andY:(CGFloat)ry{
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x/2-1, self.view.bounds.origin.y/2-1, 2, 2)];
    btn1.backgroundColor = [UIColor blueColor];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x/2-1, self.view.bounds.origin.y/2+3, 2, 2)];
    btn2.backgroundColor = [UIColor blueColor];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x/2-1, self.view.bounds.origin.y/2+7 ,2, 2)];
    btn3.backgroundColor = [UIColor blueColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(rx, ry, 4, 12)];
    [view addSubview:btn1];
    [view addSubview:btn2];
    [view addSubview:btn3];
    return view;
}

//从字符串中取出数字
- (NSArray *)getOnlyNum:(NSString *)str
{
    NSString *onlyNumStr = [str stringByReplacingOccurrencesOfString:@"[^0-9,]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [str length])];
    NSArray *numArr = [onlyNumStr componentsSeparatedByString:@","];
    NSLog(@"从字符串中取出来的数字是：%@",numArr);
    return numArr;
}

//获取数据
-(NSArray *)getLineInformation{
    NSError *error;
    //首先加载一个NSURL对象
    
    NSArray *lin = [self getOnlyNum:_receive];
    NSLog(@"%@",lin);
    int busLine = [lin[0] intValue];
    
    NSLog(@"busline:%i",busLine);
    NSString *requestString = [NSString stringWithFormat:@"http://api.36wu.com/Bus/GetLineInfo?city%@=&line=%i&format=json",[@"长春" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],busLine];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    //弄一个NSData对象，用来装返回的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //弄一个字典，用NSJSONSerialization把data数据解析出来。
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *busline = [dic valueForKey:@"data"];
    lineInformation = [[NSMutableArray alloc]init];
    for (int i = 0; i < busline.count; i++) {
        NSString *s = [busline[i] valueForKey:@"name"];
        int t = (int)[self getOnlyNum:s][0];
        
        if (t == busLine) {
            [lineInformation addObject:s];
        }
        NSLog(@"解析的数据：%@",lineInformation);
    }
    return lineInformation;
}

- (void)creatResultTable{
    UITableView *resultView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, 320, 800) style:UITableViewStylePlain];
    resultView.delegate = self;
    resultView.dataSource = self;
    
    [resultView setScrollEnabled:NO];
    [self setExtraCellLineHidden:resultView];
    
    [self.view addSubview:resultView];
//去掉tabview中多余的横线
}- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    if (indexPath.row % 2 == 0) {
        myCell.textLabel.text  =@"nihao";
        myCell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        [myCell addSubview:[self creatAView:myCell.bounds.size.width/2 andY:myCell.bounds.origin.y+20]];
    }
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    myCell.backgroundColor = [UIColor clearColor];
    return myCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
