//
//  ZFRealTimeViewController.m
//  掌公交
//
//  Created by froda on 15/4/9.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import "ZFRealTimeViewController.h"

@interface ZFRealTimeViewController (){
    NSMutableArray *_dataArray;
}

@end

@implementation ZFRealTimeViewController
@synthesize resultLable = _resultLable;
@synthesize resultTabView = _resultTabView;
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
    _resultTabView.delegate = self;
    _resultTabView.dataSource = self;
    _dataArray = [[NSMutableArray alloc]init];
    [self initData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = [[UITableViewCell alloc]init];
    myCell.textLabel.text = _dataArray[indexPath.row];
    if (0 <= [_dataArray[indexPath.row] intValue] <= 9) {
        myCell.image = [UIImage imageNamed:@"busLift.png"];
    }
    return myCell;
}
- (void)initData{
    NSError *error;
    NSString *inform = [NSString stringWithFormat:@"http://apis.juhe.cn/szbusline/bus?key=24de84ea5b588fcdfc82b996c04f13c3&dtype=json&busline=792365ed-82b2-423f-bbdc-5376d1507d21"];//获取110线路实时数据
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:inform]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *resultData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *dataArray = [resultData valueForKey:@"result"];
    for (int i = 0; i < [dataArray count]; i++) {
        NSString *str = [dataArray[i] valueForKey:@"ArrivalTime"];
        NSString *str2 = [dataArray[i] valueForKey:@"stationName"];
        NSString *dataStr = [NSString stringWithFormat:@"%@        %@",str,str2];
        [_dataArray addObject:dataStr];
    }
}

@end
