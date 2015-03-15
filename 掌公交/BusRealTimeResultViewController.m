//
//  BusRealTimeResultViewController.m
//  掌公交
//
//  Created by froda on 15/3/15.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import "BusRealTimeResultViewController.h"

@interface BusRealTimeResultViewController ()

@end

@implementation BusRealTimeResultViewController

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
    [self intitView];
    // Do any additional setup after loading the view.
}

- (void)intitView{

    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(40, 200, 200, 40)];
    lable.text = _btnString;
    [self.view addSubview:lable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
