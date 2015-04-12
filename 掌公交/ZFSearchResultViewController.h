//
//  ZFSearchResultViewController.h
//  掌公交
//
//  Created by froda on 15/4/5.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFSearchResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *frameButton;
@property (strong, nonatomic) IBOutlet UILabel *lable1;
@property (strong, nonatomic) IBOutlet UILabel *lable2;

@property (nonatomic, retain)  NSString *startValue;
@property (nonatomic, retain)NSString *endValue;
@end
