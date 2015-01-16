//
//  WhereAmIViewController.h
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//声明一个协议，用于传值
@protocol SendValue <NSObject>
- (void)sendBtnValue:(NSString *)value returnTag:(int)tag;
@end
@interface WhereAmIViewController : UIViewController{
    MKMapView *mapView;
    CLLocationManager* locationManager;
}
@property(nonatomic,assign) id deleagate;//当前控制器的属性
@end
