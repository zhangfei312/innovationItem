//
//  ZFGoHomeSetViewController.h
//  掌公交
//
//  Created by froda on 15/4/7.
//  Copyright (c) 2015年 froda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFGoHomeSetViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *startStation;
@property (strong, nonatomic) IBOutlet UITextField *endStation;
- (IBAction)btnClicked:(id)sender;
- (IBAction)exitKeyBoard:(UIButton *)sender;
- (IBAction)exitKeyBoardWhenReturn:(id)sender;
@end
