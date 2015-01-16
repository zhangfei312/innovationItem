//
//  IdeaBackViewController.m
//  掌公交
//
//  Created by 张飞 on 14-8-19.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "IdeaBackViewController.h"

@interface IdeaBackViewController ()<UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    UITextView *field;
    UITextField *num;
    UIButton *right;
}

@end

@implementation IdeaBackViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationBar];
    [self creatField];
    [self creatContentWay];
    [self creatButtomView];
	// Do any additional setup after loading the view.
}
- (void)initNavigationBar{
    self.navigationItem.title = @"意见反馈";
    right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right setFrame:CGRectMake(270, 20, 40, 30)];
    
    [right setTitle:@"提交" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor colorWithRed:0.242 green:0.634 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
//    if (field.text != nil && num.text != nil && ![field.text  isEqual: @"请在这里输入您的意见和建议"]) {
//        right.userInteractionEnabled=YES;
//    }else{
//        right.userInteractionEnabled=NO;
//    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
//create UItextView
- (void)creatField{
    field  = [[UITextView alloc]initWithFrame:CGRectMake(10,70 , 300, 200)];
    field.backgroundColor = [UIColor clearColor];
    //[field.layer setCornerRadius:8.0];//设置矩圆角半径
    [field.layer setBorderWidth:1.0];//边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.807, 0.814, 0.788, 1.000 });
    [field.layer setBorderColor:colorref];
    field.text = @"请在这里输入您的意见和建议";
    field.textColor = [UIColor lightGrayColor];
    field.delegate = self;
    field.font =  [UIFont systemFontOfSize:15];
    field.contentInset = UIEdgeInsetsMake(-70,0.0,0,0.0);
    [self.view addSubview:field];
}
- (void)creatContentWay{
    UILabel *content = [[UILabel alloc]init];
    content.frame = CGRectMake(10, 285, 90, 40);
    [content.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.807, 0.814, 0.788, 1.000 });
    [content.layer setBorderColor:colorref];
    //[content setTitle:@"联系方式" forState:UIControlStateNormal];
    content.text = @"联系方式";
    content.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:content];
    
    num = [[UITextField alloc]init];
    num.frame = CGRectMake(99, 285, 210, 40);
    [num.layer setBorderWidth:1.0];
    [num.layer setBorderColor:colorref];
    num.placeholder = @"  手机/QQ号";
    num.delegate = self;
    [self.view addSubview:num];
    
    UIButton *exitKeyBoard = [[UIButton alloc]initWithFrame:CGRectMake(0, 326, 320, 300)];
    [exitKeyBoard addTarget:self action:@selector(exitKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitKeyBoard];
}
- (void)creatButtomView{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 500, 65, 1)];
    view1.backgroundColor = [UIColor colorWithWhite:0.628 alpha:1.000];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(240, 500, 65, 1)];
    view2.backgroundColor = [UIColor colorWithWhite:0.628 alpha:1.000];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 490, 160, 20)];
    [lable1 setText:@"还可以通过其它方式反馈"];
    lable1.font = [UIFont systemFontOfSize:14];
    lable1.textColor = [UIColor colorWithWhite:0.281 alpha:1.000];
    [self.view addSubview:lable1];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, 300, 50)];
    lable2.font = [UIFont systemFontOfSize:14];
    lable2.text = @"官方QQ群:12364829      官方微博/微信:掌公交";
    lable2.textColor = [UIColor colorWithWhite:0.499 alpha:1.000];
    [self.view addSubview:lable2];
    
}
#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    field.text = @"";
    field.textColor = [UIColor blackColor];
    return YES;
}
#pragma mark UItextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [num resignFirstResponder];
    return  YES;
}
//用于点击空白退出键盘
- (void)exitKeyBoard{
    [field resignFirstResponder];
    [num resignFirstResponder];
}
#pragma mark 提交按钮
- (void)tijiao{
    NSLog(@"你点击了提交");
    [num resignFirstResponder];
    [field resignFirstResponder];
    if (field.text != nil && num.text != nil) {
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提交成功" message:@"感谢您的参与" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alter.delegate = self;
        [alter show];
        
    }else{
        
    }

}
#pragma mark UIAlterViewDeleagate
//点击某个按钮触发的方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"点击了取消！");
        [self.navigationController popToRootViewControllerAnimated:YES];
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
