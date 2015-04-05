//
//  GoHomeViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "GoHomeViewController.h"

@interface GoHomeViewController ()

@end

@implementation GoHomeViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initGoHomeData];
	
    
}
-(void)initGoHomeData{
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, 40)];
    lable1.text = @"您回家的公交车正在：";
    lable1.textAlignment = NSTextAlignmentLeft;
    lable1.textColor = [UIColor orangeColor];
    [self.view addSubview:lable1];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, 40)];
    lable2.text = @"延安大街站";
    lable2.font = [UIFont systemFontOfSize:25];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.textColor = [UIColor redColor];
    [self.view addSubview:lable2];
    
    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [imageButton setImage:[UIImage imageNamed:@"bus.png"] forState:UIControlStateNormal];
    imageButton.alpha = 0.3;
    [self.view addSubview:imageButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
