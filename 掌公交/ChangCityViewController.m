//
//  ChangCityViewController.m
//  掌公交
//
//  Created by froda on 15/4/6.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import "ChangCityViewController.h"

@interface ChangCityViewController ()

@end

@implementation ChangCityViewController{
    NSArray *provinceData;
    NSDictionary *cityData;
    NSArray *cityData2;
}
@synthesize cityTableView = _cityTableView;
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
    
    _provinceTabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, 480)];
    _provinceTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _provinceTabview.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    
    _provinceTabview.delegate = self;
    _provinceTabview.dataSource = self;
    _provinceTabview.tag = 2;
    [self.view addSubview:_provinceTabview];
    [self initData];
   
}
//去掉tabview中多余的横线,在调用的时候要把setScrollEnabled:设置为YES
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark 初始化数据
- (void)initData{
    provinceData =[NSArray arrayWithObjects:@"山东",
                     @"江苏",
                     @"安徽",
                     @"浙江",
                     @"福建",
                     @"广东",
                     @"广西",
                     @"海南",
                     @"湖北",
                     @"湖南",
                     @"河南",
                     @"江西",
                     @"河北",
                     @"山西",
                     @"内蒙古",
                     @"宁夏",
                     @"新疆",
                     @"青海",
                     @"陕西",
                     @"甘肃",
                     @"四川",
                     @"云南",
                     @"贵州",
                     @"西藏",
                     @"辽宁",
                     @"吉林",
                     @"黑龙江",@"上海",@"北京", @"天津",@"重庆",nil];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    cityData = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
}
#pragma mark 初始化city的数据
- (void)initCityData:(NSString *)str{
    cityData2 = [cityData valueForKey:str];
}
#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 2) {
        return 1;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 2) {
        return 31;
    }else{
        return [cityData2 count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (tableView.tag == 2) {
        myCell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, indexPath.row*44, 100, 44)];
        view.backgroundColor = [UIColor whiteColor];
        myCell.selectedBackgroundView = view;
        myCell.textLabel.text =provinceData[indexPath.row];
    }else{
        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        myCell.alpha = 0.5;
        myCell.textLabel.text = cityData2[indexPath.row];
    }
    return myCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2) {
        NSLog(@"section:%i,row:%i",indexPath.section,indexPath.row);
        NSLog(@"select:%@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text);
        NSString *str = provinceData[indexPath.row];
        NSLog(@"%@",str);
        [self initCityData:str];
        _cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 60, 220, 420)];
        if ([cityData2 count] <= 9) {
            _cityTableView.scrollEnabled = NO;
            [self setExtraCellLineHidden:_cityTableView];
        }
        _cityTableView.delegate = self;
        _cityTableView.dataSource =self;
        _cityTableView.tag = 1;
        [self.view addSubview:_cityTableView];
    }
}
@end
