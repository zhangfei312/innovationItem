//
//  SearchViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "SearchViewController.h"
#import "ZhanDianSearchResultViewController.h"
#import "ZhanDianresultViewController.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    NSArray *_Source;//cell上显示的数据
    UITableView *historyView;
    NSArray *sectionOne;
}

@end

@implementation SearchViewController

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
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"serch2.jpg"];
    [self.view addSubview:imageView];
    // 此按钮用于退出键盘
    UIButton *exitKeyBoard = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    exitKeyBoard.frame = CGRectMake(0, 0, 320, 960);
    [exitKeyBoard addTarget:self action:@selector(exitButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitKeyBoard];
    
    placeSearch = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, 280, 40)];
    placeSearch.borderStyle = UITextBorderStyleRoundedRect;
    [placeSearch addTarget:self action:@selector(exitKeyBoard) forControlEvents:UIControlEventEditingDidEndOnExit];
    placeSearch.alpha = 0.7;
    placeSearch.delegate = self;
    placeSearch.placeholder = @"请输入公交站名：如延安大街";
//    placeSearch.tintColor = [UIColor redColor];//光标颜色
//    placeSearch.textColor = [UIColor purpleColor];//输入文字的颜色
    placeSearch.clearButtonMode = UITextFieldViewModeAlways;//那个清除的叉叉
    placeSearch.clearsOnBeginEditing = YES;//再次编辑清除
    
    
    sectionOne = [NSArray arrayWithObjects:@"延安大街",@"修正路",@"人民大街",@"红旗街", nil];
    NSArray *sectionTwo = [NSArray arrayWithObjects:@"                 清空所有历史", nil];
    NSArray *shuju = [NSArray arrayWithObjects:sectionOne,sectionTwo,nil];
    _Source = shuju;
    
    

    [self creatSearchHistory];
    [self.view addSubview:placeSearch];
	// Do any additional setup after loading the view.
}
- (void)exitKeyBoard{
    [placeSearch resignFirstResponder];
}
#pragma mark 自定义navigationBar
- (void)initNavigationBar{
    [self.navigationController setNavigationBarHidden:YES];
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(10, 25, 40, 30)];
    [left setTitle:@"取消" forState:UIControlStateNormal];
    [left setTitleColor:[UIColor colorWithRed:0.242 green:0.634 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:left];
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right setFrame:CGRectMake(270, 20, 40, 30)];
    [right setTitle:@"搜索" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor colorWithRed:0.242 green:0.634 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:right];
    [self.view addSubview:bar];
}
- (void)cancle{
    NSLog(@"点击了取消");
    [self exitKeyBoard];
}
- (void) search{
    NSLog(@"点击了搜索");
    [self exitKeyBoard];
    ZhanDianSearchResultViewController *searchResult = [[ZhanDianSearchResultViewController alloc]init];
    searchResult.zhandianValue = placeSearch.text;
    searchResult.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchResult animated:YES];
}

#pragma mark UITextField UITextFieldDelegate
//UITextField的协议方法：设置键盘点击return后自动收回
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"-------------return");
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"-------------wancheng");
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"------------kaishi");
    [self initNavigationBar];
    
}

//创建搜索历史
-(void)creatSearchHistory{
    historyView = [[UITableView alloc]initWithFrame:(CGRectMake(0, 140, 320, self.view.frame.size.height-60)) style:UITableViewStylePlain];
    historyView.dataSource = self;
    historyView.delegate = self;
    historyView.alpha = 0.5;
    historyView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:historyView];
}
- (void)exitButton:(UIButton *)sender{
    [placeSearch resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 什么是数据源方法，就是tableView提供数据来源的方法
 1,2,3这三个方法必须掌握
 */
#pragma mark 数据源方法
#pragma mark 返回有多少组
//1.返回tableView里面一共有多少组的方法，用一个section表示一组，section从0开始，即section=0时表示是第一组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return [_Source count];
    
}
#pragma mark 返回多少行
//2.第section组有多少行的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_Source[section] count];
    
}
#pragma mark 返回行的内容，返回cell
//3.每一行显示的内容的方法，每一行都是一个cell,该方法没创建一行都会被调用一次
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     indexPath是标识唯一的一行
     indexPath.section标识哪一组
     indexPath.row标识具体哪一行
     */
    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];//基本初始化都选这个
   
    //    myCell.textLabel.text = @"myCell";//设置cell上显示的文字
    myCell.textLabel.text  = _Source[indexPath.section][indexPath.row];
//    if (indexPath.section == 1) {
//        myCell.textLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    if (indexPath.section > 1) {
//        historyView.separatorStyle =UITableViewCellSeparatorStyleNone;
//    }
    
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    myCell.backgroundColor = [UIColor clearColor];
    
    return myCell;
}

#pragma mark 返回cell的高度
//会取得当前cell的高度值
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     indexPath是标识唯一的一行
     indexPath.section标识哪一组
     indexPath.row标识具体哪一行
     */
    if (indexPath.section == 1) {
        NSLog(@"点击了清空历史记录");
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"清空历史记录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
    
    }else{
        ZhanDianSearchResultViewController *result = [[ZhanDianSearchResultViewController alloc]init];
        result.zhandianValue = sectionOne[indexPath.row];
        result.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:result animated:YES];
    }
    
}
#pragma mark UIAlterViewDeleagate
//点击某个按钮触发的方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"点击了取消！");
    }else{
        NSLog(@"点击了确定");
    }
}
@end
