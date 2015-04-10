//
//  ZFRealTimeViewController.h
//  掌公交
//
//  Created by froda on 15/4/9.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFRealTimeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSString *receive;
@property (strong, nonatomic) IBOutlet UILabel *resultLable;
@property (strong, nonatomic) IBOutlet UITableView *resultTabView;
@end
