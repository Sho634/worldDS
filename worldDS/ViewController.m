//
//  ViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/10.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "ViewController.h"
#import "DViewController.h"
#import "UserDViewController.h"
@interface ViewController ()
{
MKMapView* _mapView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//mmmmmmmmmmmmmmmmmmmmmmmmmmm地図の表示mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

    _mapView = [[MKMapView alloc] init];
    _mapView.delegate = self;
    _mapView.frame = CGRectMake(0, 20, 320, 460);
    CLLocationCoordinate2D co;
    co.latitude = 35.689488;       //緯度
    co.longitude = 139.691706;     //軽度
    MKCoordinateRegion cr = _mapView.region;
    cr.span.latitudeDelta = 0.05;
    cr.span.longitudeDelta = 0.05;
    cr.center = co;
    [_mapView setRegion:cr];
    
    //地図の表示種類設定
    _mapView.mapType = MKMapTypeStandard;
    
    //現在地を表示
    _mapView.showsUserLocation = YES;
    
    [self.view addSubview:_mapView];
//
    _mapView.delegate = self;

//mmmmmmmmmmmmmmmmmmmmmmmmロングジェスチャーの設定とアクション設定mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
  
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [_mapView addGestureRecognizer:longPressGesture];
    _mapView.delegate = self;
   
    _TabBar.delegate = self;
    }
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
   
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//mmmmmmmmmmmmmmmmmmmmmmロングジェスチャーのメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    
    //長押し検出時のみ作動
    if ([gesture state] == UIGestureRecognizerStateBegan){
        NSLog(@"handleLongPressGesture");
        
    }else if([gesture state] == UIGestureRecognizerStateEnded){
        CGPoint touchedPoint = [gesture locationInView:_mapView];
            
        NSLog(@"touchedPoint x:[%f]", touchedPoint.x);
        NSLog(@"touchedPoint y:[%f]", touchedPoint.y);
            
        CLLocationCoordinate2D touchCoordinate = [_mapView convertPoint:touchedPoint toCoordinateFromView:_mapView];
            
        NSLog(@"touchCoordinate latitude:%f  longitude:%f", touchCoordinate.latitude, touchCoordinate.longitude);
            
            
        [self setAnnotation:touchCoordinate mapMove:NO animated:NO];
            
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
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmピンが落ちてくるメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-(void)setAnnotation:(CLLocationCoordinate2D) point mapMove:(BOOL)mapMove animated:(BOOL)animated {
    // ピンを全て削除
    //    [_mapView removeAnnotations: _mapView.annotations];
    // 新しいピンを作成
    MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
    anno.coordinate = point;
    int n = 0;
    anno.title = [NSString stringWithFormat:@"PIN-%d",n];
    ++n;
    anno.subtitle = [NSString stringWithFormat:@"緯度:%f 経度:%f",
                     anno.coordinate.latitude,anno.coordinate.longitude];
    
    // マップの表示を変更
    if (mapMove) {
        MKCoordinateSpan CoordinateSpan = MKCoordinateSpanMake(0.005,0.005);
        MKCoordinateRegion CoordinateRegion = MKCoordinateRegionMake(point,CoordinateSpan);
        [_mapView setRegion:CoordinateRegion animated:animated];
    }
    // ピンを追加
    [_mapView addAnnotation:anno];
    
    // ピンの周りに円を表示
    //    MKCircle* circle = [MKCircle circleWithCenterCoordinate:point radius:500];  // 半径500m
    //    [_mapView removeOverlays:_mapView.overlays];
    //    [_mapView addOverlay:circle];
}

//mmmmmmmmmmmmmmmmmmmmmmmmピン落ちてくるアニメーションのメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *pinIndentifier = @"PinAnnotationID";
        
        //ピン情報の再利用
      MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinIndentifier];
        
    if (pinView == nil){
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinIndentifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        
    return pinView;
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
 //mmmmmmmmmmmmmmmmmmmmmmiボタンをタップした時にしたい動作を記述するメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    DViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DViewController"];
    //[[self navigationController] pushViewController:dvc animated:YES];
    [self presentViewController:dvc animated:YES completion:nil];
    NSLog(@"%@",view.annotation.title);
            
}
    
 //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmタブバーでの画面遷移mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITabBarItem*)item {
    NSLog(@"tap:%ld",item.tag);
  
    //まじ重要if文
    if (item.tag == 2) {
        UserDViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDViewController"];
        //[[self navigationController] pushViewController:dvc animated:YES];
        [self presentViewController:dvc animated:YES completion:nil];
       
        
    }


    }



    
    
    
    
    
    
    
    
    
    
    




@end
