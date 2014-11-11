//
//  ViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/10.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
MKMapView* _mapView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/////////////////////////////マップ/////////////////////////////////////////////////////////
    
    //MapViewオブジェクト
    MKMapView *mapView = [[MKMapView alloc] init];
    mapView.delegate = self;
    //大きさ,位置決定
    mapView.frame = CGRectMake(0, 20, 320, 460);
    //表示位置を設定
    CLLocationCoordinate2D co;
    //日本（東京）の位置を設定する
    co.latitude = 35.689488;       //緯度
    co.longitude = 139.691706;     //軽度
    //縮尺するためにViewに追加
    MKCoordinateRegion cr = mapView.region;
    
    cr.span.latitudeDelta = 0.05;
    //小さくすると詳細な地図になる
    cr.span.longitudeDelta = 0.05;
    
    cr.center = co;
    
    [mapView setRegion:cr];
    
    //地図の表示種類設定
    mapView.mapType = MKMapTypeStandard;
    
    //現在地を表示
    mapView.showsUserLocation = YES;
    
[self.view addSubview:mapView];


//mmmmmmmmmmmmmmmmmmmmmmmmロングジェスチャーの設定とアクション設定mmmmmmmmmmmmmmmmmmmmmmmmmmmmm
UILongPressGestureRecognizer *longPressGesture;
longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(handleLongPressGesture:)];
[_mapView addGestureRecognizer:longPressGesture];
_mapView.delegate = self;
    NSLog(@"longps");
    
    
    
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//mmmmmmmmmmmmmmmmmmmmmmロングジェスチャーのメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    - (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture {
        NSLog(@"handleLongPressGesture");
        if (gesture.state == UIGestureRecognizerStateBegan) { //長押し検出時のみ作動
            
            CGPoint touchedPoint = [gesture locationInView:_mapView];
            
            NSLog(@"touchedPoint x:[%f]", touchedPoint.x);
            NSLog(@"touchedPoint y:[%f]", touchedPoint.y);
            
            CLLocationCoordinate2D touchCoordinate = [_mapView convertPoint:touchedPoint toCoordinateFromView:_mapView];
            
            NSLog(@"touchCoordinate latitude:%f  longitude:%f", touchCoordinate.latitude, touchCoordinate.longitude);
            
            
            //[self setAnnotation:touchCoordinate mapMove:NO animated:NO];
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:touchCoordinate.latitude longitude:touchCoordinate.longitude];
            float fLat = location.coordinate.latitude;
            float fLng = location.coordinate.longitude;
            //        NSString *str = [NSString stringWithFormat:@"緯度:%f 経度:%f",fLat,fLng];
            NSString *str = [NSString stringWithFormat:@"<array><string>%f</string><string>%f</string></array>",fLat,fLng];
            NSLog(@"str = %@",str);
            NSLog(@"location = %@",location);
            //[_allPinArray2 addObject:location];
            //[_allPinArray addObject:str];
        }


}

@end
