//
//  AnnotationViewController.h
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
@interface AnnotationViewController : UIViewController<MAMapViewDelegate>
@property (strong,nonatomic)MAMapView *mapView;
@property (strong,nonatomic)NSString *btnString;
@end
