//
//  BusViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "BusViewController.h"
#import "SearchResultViewController.h"
#import "GoHomeViewController.h"
#import "WhereIsBusViewController.h"
#import "WhereAmIViewController.h"
@interface BusViewController ()<UIAlertViewDelegate>

@end

@implementation BusViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//起点和终点的文本输入框里面可以添加小图标
- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"gongjiao2.jpeg"];
//    [self.view addSubview:imageView];
//    [self.view sendSubviewToBack:imageView];
    // Do any additional setup after loading the view from its nib.
    [self initSomeButton];
    NSLog(@"fdgfhgyu");
}
#pragma mark 初始化查询以及下面的几个按钮
- (void)initSomeButton{
    NSLog(@"开始初始化！");
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(25, (self.view.bounds.origin.y-150), 226, 30)];
    searchButton.backgroundColor = [UIColor orangeColor];
    [searchButton setTitle:@"查询" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(changeSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    UIButton *goHome = [[UIButton alloc]initWithFrame:CGRectMake(10, self.view.bounds.origin.y-100, 73, 30)];
    goHome.backgroundColor = [UIColor redColor];
    goHome.alpha = 0.8;
    [goHome setTitle:@"我要回家" forState:UIControlStateNormal];
    [goHome addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goHome];
    
    UIButton *whereIsBus = [[UIButton alloc]initWithFrame:CGRectMake(93, self.view.bounds.origin.y-100, 73, 30)];
    whereIsBus.backgroundColor = [UIColor redColor];
    whereIsBus.alpha = 0.8;
    [whereIsBus setTitle:@"车在哪" forState:UIControlStateNormal];
    [whereIsBus addTarget:self action:@selector(whereIsBus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:whereIsBus];
    
    UIButton *whereAmI = [[UIButton alloc]initWithFrame:CGRectMake(113, self.view.bounds.origin.y-100, 73, 30)];
    whereAmI.backgroundColor = [UIColor redColor];
    whereAmI.alpha = 0.8;
    [whereAmI setTitle:@"我在哪" forState:UIControlStateNormal];
    [whereAmI addTarget:self action:@selector(whereAmI:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:whereIsBus];
    NSLog(@"gthyhg");
    
}
- (void)sendBtnValue:(NSString *)value returnTag:(int)tag{
    if (tag == 1) {
        self.startTextField.text = value;
    }else{
        self.endTextField.text = value;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeSearch:(UIButton *)sender {
    NSString *temp = nil;
    temp = self.startTextField.text;
    self.startTextField.text = self.endTextField.text;
    self.endTextField.text = temp;
    
}
#pragma mark 这里有问题没有解决
- (IBAction)search:(UIButton *)sender {
    SearchResultViewController *result = [[SearchResultViewController alloc]init];
    result.startValue = self.startTextField.text;
    result.endValue = self.endTextField.text;
    NSString *a = self.startTextField.text;
    NSString *b = self.endTextField.text;
    NSLog(@"%@,%@",a,b);
//    NSString *c = @"";
//    NSString *d = @"";
    if ([a isEqual: @""] && [b isEqual: @""] ){
        
        NSLog(@"你没有输入任何信息");
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"请输入起点和终点！" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterView show];
//        result.hidesBottomBarWhenPushed = YES;//隐藏tabBar
//        [self.navigationController pushViewController:result animated:YES];
        
    }else{
        NSLog(@"aaaaaaaaaa");
        result.hidesBottomBarWhenPushed = YES;//隐藏tabBar
        [self.navigationController pushViewController:result animated:YES];
        
        
    }
    
}

- (IBAction)goHome:(UIButton *)sender {
    GoHomeViewController *goHome = [[GoHomeViewController alloc]init];
    goHome.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goHome animated:YES];
}

- (IBAction)whereIsBus:(UIButton *)sender {
    WhereIsBusViewController *bus = [[WhereIsBusViewController alloc]init];
    bus.hidesBottomBarWhenPushed  =YES;
    [self.navigationController pushViewController:bus animated:YES];
}

- (IBAction)whereAmI:(UIButton *)sender {
    WhereAmIViewController *mylocation = [[WhereAmIViewController alloc]init];
    mylocation.hidesBottomBarWhenPushed = YES;
    mylocation.deleagate = self;
    [self.navigationController pushViewController:mylocation animated:YES];
}
//点击return时候会退出键盘，但是点击第二个UITextField时不会退出
- (IBAction)exitKeyBoard:(id)sender {
    [sender resignFirstResponder];
}
//点击背景的时候会退出键盘
- (IBAction)clickBacgroundExitKeyBoard:(id)sender {
    [_startTextField resignFirstResponder];
    [_endTextField resignFirstResponder];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"点击了取消！");
    }else{
        NSLog(@"点击了确定");
    }
}
@end

