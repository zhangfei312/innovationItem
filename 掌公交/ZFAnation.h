//
//  ZFAnation.h
//  掌公交
//
//  Created by 张飞 on 14-8-21.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface ZFAnation : NSObject<MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate;
@end
