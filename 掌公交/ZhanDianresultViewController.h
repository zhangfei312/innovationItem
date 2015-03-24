//
//  ZhanDianresultViewController.h
//  掌公交
//
//  Created by 张飞 on 14-9-2.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhanDianresultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSString *resultValue;
@property(nonatomic,retain)NSString *zhanDianString;
@end
