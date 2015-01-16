//
//  BusViewController.h
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BusViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet UILabel *historyTextField;

- (IBAction)changeSearch:(UIButton *)sender;
- (IBAction)search:(UIButton *)sender;
- (IBAction)goHome:(UIButton *)sender;
- (IBAction)whereIsBus:(UIButton *)sender;
- (IBAction)whereAmI:(UIButton *)sender;
- (IBAction)exitKeyBoard:(id)sender;
- (IBAction)clickBacgroundExitKeyBoard:(id)sender;

@end
