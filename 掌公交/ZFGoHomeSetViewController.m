//
//  ZFGoHomeSetViewController.m
//  掌公交
//
//  Created by froda on 15/4/7.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import "ZFGoHomeSetViewController.h"

@interface ZFGoHomeSetViewController ()

@end

@implementation ZFGoHomeSetViewController

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
}

- (IBAction)btnClicked:(id)sender {
    if ([_startStation.text isEqualToString:@""] || [_endStation.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"对不起，起点或者终点不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSUserDefaults *gohomeSetting = [NSUserDefaults standardUserDefaults];
        [gohomeSetting setObject:_startStation.text forKey:@"startStation"];
        [gohomeSetting setObject:_endStation.text forKey:@"endStation"];
        UIAlertView *successAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经成功设置好回家的路线了!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        successAlertView.tag = 1;
        [successAlertView show];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
- (IBAction)exitKeyBoard:(UIButton *)sender {
    [_endStation resignFirstResponder];
    [_startStation resignFirstResponder];
}

- (IBAction)exitKeyBoardWhenReturn:(id)sender {
    [sender resignFirstResponder];
}
@end
