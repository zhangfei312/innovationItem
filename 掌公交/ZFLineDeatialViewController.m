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
    NSArray *lineInformation;
}

@end

@implementation ZFLineDeatialViewController
@synthesize receive = _receive;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLineInformation];
    
    NSLog(@"_receive :%@",_receive);
    
    [self creatResultTable];
    
    [self creatResultFrame];
    
    NSLog(@"lineInformation:%@,lineInformation'count:%i",lineInformation,[lineInformation count]);
    
    
}
//生成一个说明框框
- (void)creatResultFrame{
    UILabel *dataLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 50)];
    dataLable.backgroundColor = [UIColor whiteColor];
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
-(void)getLineInformation{
    NSError *error;
    //首先加载一个NSURL对象
    
    NSArray *lin = [self getOnlyNum:_receive];
    NSLog(@"lin:%@",lin);
    //int busLine = [lin[0] intValue];
    NSString *busLine =lin[0];
    NSLog(@"busline:%@",busLine);
    NSString *requestString = [NSString stringWithFormat:@"http://api.36wu.com/Bus/GetLineInfo?city=%@&line=%@&format=json",[@"长春" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],busLine];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    //弄一个NSData对象，用来装返回的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //弄一个字典，用NSJSONSerialization把data数据解析出来。
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *busline = [dic valueForKey:@"data"];
    
    for (int i = 0; i < busline.count; i++) {
        
        NSString *busName = [busline[i] valueForKey:@"name"];
        NSLog(@"busName:%@",busName);
        NSLog(@"receive:%@",_receive);
        if ([busName isEqualToString:_receive]) {
            NSLog(@"i:----------------%i",i);
            NSArray *busLineInform = [busline valueForKey:@"stats"];
            lineInformation = [busLineInform[0] componentsSeparatedByString:@";"];
            
        }
        NSLog(@"解析的数据：%@",lineInformation);
    }
}

- (void)creatResultTable{
    UITableView *resultView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, 320, 480) style:UITableViewStylePlain];
    resultView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    resultView.separatorStyle = UITableViewCellSeparatorStyleNone;
    resultView.delegate = self;
    resultView.dataSource = self;
    
    [resultView setScrollEnabled:YES];
    //[self setExtraCellLineHidden:resultView];
    
    [self.view addSubview:resultView];
//去掉tabview中多余的横线
}- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return [lineInformation count];
    return [lineInformation count]*2-1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (indexPath.row == 0) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(110, myCell.bounds.origin.y/2, 100, 44)];
        lable.backgroundColor = [UIColor clearColor];
        [myCell addSubview:lable];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = lineInformation[indexPath.row];
    }
    if (indexPath.row % 2 == 0) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(110, myCell.bounds.origin.y/2, 100, 44)];
        lable.backgroundColor = [UIColor clearColor];
        [myCell addSubview:lable];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = lineInformation[indexPath.row/2];
    }else{
        if (indexPath.row != ([lineInformation count])) {
            [myCell addSubview:[self creatAView:myCell.bounds.size.width/2 andY:myCell.bounds.origin.y+20]];
        }
        
    }
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0,  myCell.bounds.origin.y/2, 320, 44)];
    myView.backgroundColor = [UIColor whiteColor];
    myCell.selectedBackgroundView = myView;

    return myCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
