//
//  ShoAnnotation.m
//  worldDS
//
//  Created by sho634 on 2014/11/21.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "ShoAnnotation.h"

@implementation ShoAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize pinColor;
@synthesize pinNumber;

-(id)initWithCoordinate:(CLLocationCoordinate2D)co{
    coordinate = co;
    return  self;
}

@end
