//
//  ZhanDianresultViewController.m
//  掌公交
//
//  Created by 张飞 on 14-9-2.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "ZhanDianresultViewController.h"

@interface ZhanDianresultViewController ()

@end

@implementation ZhanDianresultViewController
@synthesize resultValue;
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
    NSArray *array = [resultValue componentsSeparatedByString:@";"];
    for (int i = 0; i < [array count]; i++) {
        NSLog(@"resultValue:%@",array[i]);
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatResultTable];
}
- (void)creatResultTable{
    UITableView *resultView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    resultView.delegate = self;
    resultView.dataSource = self;
    
    [self.view addSubview:resultView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    myCell.textLabel.text  = resultValue;
    
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    myCell.backgroundColor = [UIColor clearColor];
    return myCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
