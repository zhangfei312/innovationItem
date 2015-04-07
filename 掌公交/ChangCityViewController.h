//
//  ChangCityViewController.h
//  掌公交
//
//  Created by froda on 15/4/6.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangCityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *cityTableView;
@property (strong, nonatomic) UITableView *provinceTabview;


@end
