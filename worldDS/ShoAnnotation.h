//
//  ShoAnnotation.h
//  worldDS
//
//  Created by sho634 on 2014/11/21.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface ShoAnnotation : NSObject <MKAnnotation>{
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    NSString *pinColor;
}

@property(nonatomic)CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, copy) NSString *pinColor;


-(id)initWithCoordinate:(CLLocationCoordinate2D)co;


@end
