//
//  WhereIsBusViewController.h
//  掌公交
//
//  Created by 张飞 on 14-8-14.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereIsBusViewController : UIViewController{
    MKMapView *_mapView;
    CLLocationManager* locationManager;
}
@property(nonatomic,strong) NSTimer *paintingTimer;
@end
