//
//  MoreViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "MoreViewController.h"
#import "TempViewController.h"
#import "IdeaBackViewController.h"
#import "VersionUpgradeViewController.h"
#import "AboutUsViewController.h"
#import "ChangCityViewController.h"
@interface MoreViewController (){
    NSArray *_Source;//cell上显示的数据
    int a;
}

@end

@implementation MoreViewController

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
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    myTableView.dataSource = self ;//设置当前控制器为数据源提供者
    myTableView.delegate = self;//设置当前控制器为代理
    
    NSArray *sectionOne = [NSArray arrayWithObjects:@"切换城市",@"回家设置",@"离线数据",@"清空缓存", nil];
    NSArray *sectionTwo = [NSArray arrayWithObjects:@"检测版本", nil];
    NSArray *sectionThere = [NSArray arrayWithObjects:@"意见反馈",@"关于我们",@"用户协议", nil];
    NSArray *shuju = [NSArray arrayWithObjects:sectionOne,sectionTwo,sectionThere,nil];
    _Source = shuju;
    //@"nihao",@"wohao",@"dajiahao"
    
    //设置tableView的背景图片
    //UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgpucture.jpg"]];
   // myTableView.backgroundView = background;
    
    [self.view addSubview:myTableView];
    
    
}

/*
 什么是数据源方法，就是tableView提供数据来源的方法
 1,2,3这三个方法必须掌握
 */
#pragma mark 数据源方法
#pragma mark 返回有多少组
//1.返回tableView里面一共有多少组的方法，用一个section表示一组，section从0开始，即section=0时表示是第一组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 3;
    
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
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    myCell.backgroundColor = [UIColor clearColor];
    return myCell;
}

#pragma mark 返回cell的高度
//会取得当前cell的高度值
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark 选中某一行的时候
//会在你选中了某一行之后触发的方法
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"index:%ld,row:%ld",(long)indexPath.section,(long)indexPath.row);
    switch ((long)indexPath.section) {
        case 0:
            switch ((long)indexPath.row) {
                case 0:
                {
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    ChangCityViewController *temp = [[ChangCityViewController alloc]init];
                    temp.hidesBottomBarWhenPushed  =YES;
                    [self.navigationController pushViewController:temp animated:YES];
                }
                    break;
                case 1:{
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    TempViewController *temp = [[TempViewController alloc]init];
                    temp.hidesBottomBarWhenPushed  =YES;
                    [self.navigationController pushViewController:temp animated:YES];
                }
                    break;
                case 2:
                {
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"您确定要清除缓存吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alter show];
                }
                    break;
                default:
                    break;
            }
            break;
       case 1:
            switch ((long)indexPath.row) {
                case 0:{
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    VersionUpgradeViewController *version = [[VersionUpgradeViewController alloc]init];
                    version.hidesBottomBarWhenPushed  =YES;
                    [self.navigationController pushViewController:version animated:YES];
                }
                    break;
                case 1:{
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    VersionUpgradeViewController *version = [[VersionUpgradeViewController alloc]init];
                    version.hidesBottomBarWhenPushed  =YES;
                    [self.navigationController pushViewController:version animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch ((long)indexPath.row) {
                case 0:{
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    IdeaBackViewController *idea = [[IdeaBackViewController alloc]init];
                    idea.hidesBottomBarWhenPushed  =YES;
                    [self.navigationController pushViewController:idea animated:YES];
                }
                    break;
                case 1:{
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    AboutUsViewController *temp = [[AboutUsViewController alloc]init];
                    temp.hidesBottomBarWhenPushed  =YES;
                    [self.navigationController pushViewController:temp animated:YES];
                }
                    break;
                case 2:{
                    NSLog(@"section:%ld;row:%ld",(long)indexPath.section,(long)indexPath.row);
                    TempViewController *temp = [[TempViewController alloc]init];
                    temp.hidesBottomBarWhenPushed  =YES;
                    [self.navigationController pushViewController:temp animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end