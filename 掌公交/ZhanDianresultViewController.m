//
//  ZhanDianresultViewController.m
//  掌公交
//
//  Created by 张飞 on 14-9-2.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "ZhanDianresultViewController.h"
#import "ZFLineDeatialViewController.h"
@interface ZhanDianresultViewController ()

@end

@implementation ZhanDianresultViewController{
    NSMutableArray *array;
    NSString *lineDtaName;
}
@synthesize resultValue;
@synthesize zhanDianString;
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
    NSLog(@"线路详情----------------------------------%@",resultValue);
	// Do any additional setup after loading the view.
    array = [NSMutableArray array];
    NSArray *array1 = [resultValue componentsSeparatedByString:@";"];
    for (int i = 0; i < [array1 count]; i+=2) {
        
        [array addObject:array1[i]];
    }
    
    for (int i = 0; i < array.count; i++){
        NSLog(@"***********:%@",array[i]);
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatResultTable];
    [self creatResultFrame];
}

//用于隐藏没有用的横线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)creatResultFrame{
    UILabel *dataLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, 20)];
    dataLable.textAlignment = NSTextAlignmentCenter;
    dataLable.text = [NSString stringWithFormat:@"%@站点附近的公交车",zhanDianString];
    [self.view addSubview:dataLable];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width, 1)];
    view1.backgroundColor = [UIColor grayColor];
    view1.alpha = 0.2;
    [self.view addSubview:view1];
    
}

- (void)creatResultTable{
    UITableView *resultView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, 320, 800) style:UITableViewStylePlain];
    resultView.delegate = self;
    resultView.dataSource = self;
    
    [resultView setScrollEnabled:NO];
    [self setExtraCellLineHidden:resultView];
    
    [self.view addSubview:resultView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    NSLog(@"%i",array.count);
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    myCell.textLabel.text  = array[indexPath.row];
    
    
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    myCell.backgroundColor = [UIColor clearColor];
    return myCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFLineDeatialViewController *ld = [[ZFLineDeatialViewController alloc]init];
    ld.receive = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSLog(@"传入的线路是：%@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text);
    [self.navigationController pushViewController:ld animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
