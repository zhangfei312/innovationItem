//
//  ZFAnation.m
//  掌公交
//
//  Created by 张飞 on 14-8-21.
//  Copyright (c) 2014年 张飞. All rights reserved.
//

#import "ZFAnation.h"

@implementation ZFAnation

- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self != nil) {
        _coordinate = coordinate;
    }
    return self;
}

@end
