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
#import "ProfViewController.h"
#import "WantGoViewController.h"
#import "ShoAnnotation.h"
@interface ViewController ()
{
MKMapView* _mapView;
    NSInteger n;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //UserDefaultからデータを取り出す箱を取り出す何もないがとりだす
    
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm地図の表示mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

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

    _mapView.delegate = self;

//mmmmmmmmmmmmmmmmmmmmmmmmロングジェスチャーの設定とアクション設定mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
  
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [_mapView addGestureRecognizer:longPressGesture];
     _mapView.delegate = self;
     _TabBar.delegate = self;
    _redpinFlag = YES;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"];

    //for文　ピンの数分回る
    for (int i=0; i < _MapDiaryArray.count; i++) {
    
    // Arrayの中身を　double 型に変えている
    NSString *Latitude =  _MapDiaryArray[i][@"Latitude"];
    double latitude = Latitude.doubleValue;
    NSString *Longitude =  _MapDiaryArray[i][@"Longitude"];
    double longitude = Longitude.doubleValue;
    
    //ピンを立てるコード
    ShoAnnotation *pin = [[ShoAnnotation alloc] init];
    pin.coordinate = CLLocationCoordinate2DMake(latitude,longitude);//()内は Double じゃないと稼働しない
    pin.title = _MapDiaryArray[i][@"Pintitle"];
    pin.pinColor = _MapDiaryArray[i][@"Pincolor"];
      
       
    //アノテーションを追加
    [_mapView addAnnotation:pin];
    //表示する為にビューに追加
    [self.view addSubview:_mapView];
        
    }
    
   
}
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//mmmmmmmmmmmmmmmmmmmmmmロングジェスチャーのメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
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
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmピンが落ちてくるメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-(void)setAnnotation:(CLLocationCoordinate2D) point mapMove:(BOOL)mapMove animated:(BOOL)animated {
    // ピンを全て削除
    //    [_mapView removeAnnotations: _mapView.annotations];
    // 新しいピンを作成
    ShoAnnotation *anno = [[ShoAnnotation alloc] init];
    anno.coordinate = point;
    //int n = 0;
 //   NSString *num = [NSString stringWithFormat:@"%ld",n];
    ++n;
    anno.title = [NSString stringWithFormat:@"PIN-%ld",(long)n];
        anno.subtitle = [NSString stringWithFormat:@"緯度:%f 経度:%f",
                     anno.coordinate.latitude,anno.coordinate.longitude];
   
    if (_greenpinFlag) {
        anno.pinColor = @"green";
    }else{
        anno.pinColor = @"red";
        }
    
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
    
    
    
//////////////////////////////////////宿敵ユーザーでフォルト/////////////////////////////////////////////////////
///////////////////////////////////////////データを保存////////////////////////////////////////////////////////
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"];
    
    if (_MapDiaryArray == nil) {
        _MapDiaryArray = [[NSMutableArray alloc] init];//初期化
    }
    
    //新しいピンの情報をセット
    NSDictionary *pinInfo = @{@"Latitude":[NSString stringWithFormat:@"%f",anno.coordinate.latitude],
                              @"Longitude":[NSString stringWithFormat:@"%f",anno.coordinate.longitude],
                              @"Pintitle":anno.title,
                              @"Pincolor":anno.pinColor,
                              @"Diary":@""};
    
    

    
    [_MapDiaryArray addObject:pinInfo];

    [defaults setObject:_MapDiaryArray forKey:@"MapDiary"];//_coffeearrayをcoffeetableというキーで保存
    [defaults synchronize];
    
    
}
//mmmmmmmmmmmmmmmmmmmmmmmmピン落ちてくるアニメーションのメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm　pinの色決め　mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *pinIndentifier = @"PinAnnotationID";
        
        //ピン情報の再利用
      MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinIndentifier];
    
    //pinColor = MKPinAnnotationColorGreen;
    ShoAnnotation *sa = (ShoAnnotation *)annotation;
    
    NSLog(@"%@",sa.pinColor);
    if (pinView == nil){
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinIndentifier];
        pinView.animatesDrop = YES;
        //pinView. pinColor = MKPinAnnotationColorGreen;
        pinView.canShowCallout = YES;
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    //ピンが赤から緑を宣言するif文
        if ([sa.pinColor isEqualToString:@"green"]) {
            pinView.pinColor = MKPinAnnotationColorGreen;
        }else{
            pinView.pinColor = MKPinAnnotationColorRed;
            
        }

//        if (_greenpinFlag) {
//            pinView.pinColor = MKPinAnnotationColorGreen;
//        }else{
//            pinView.pinColor = MKPinAnnotationColorRed;
//        
//        }
    
    }
    
    
    return pinView;
}


- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
 //mmmmmmmmmmmmmmmmmmmmmmiボタンをタップした時にしたい動作を記述するメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    
    ShoAnnotation *currentpin = (ShoAnnotation *)view.annotation;
    
    //グリーンピンの　i ボタンを押した時に反応する　if 文mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    if ([currentpin.pinColor isEqualToString:@"green"]) {
       
        WantGoViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WantGoViewController"];
        //[[self navigationController] pushViewController:dvc animated:YES];
        [self presentViewController:dvc animated:YES completion:nil];
        NSLog(@"%@",view.annotation.title);
 
    
    }else{
        
        DViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DViewController"];
        //[[self navigationController] pushViewController:dvc animated:YES];
        [self presentViewController:dvc animated:YES completion:nil];
        NSLog(@"%@",view.annotation.title);


    }


}
    
 //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmタブバーでの画面遷移mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITabBarItem*)item {
    NSLog(@"tap:%ld",(long)item.tag);
  
    //重要重要重要重要　　　　if文
    if (item.tag == 2) {
        UserDViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDViewController"];
        //[[self navigationController] pushViewController:dvc animated:YES];
        [self presentViewController:dvc animated:YES completion:nil];
       
        
    }
    if (item.tag == 3) {
        ProfViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfViewController"];
        
        [self presentViewController:pvc animated:YES completion:nil];
        
    }
    //ピンの色を変更するif文
    if (item.tag == 1) {
        _redpinFlag = NO;
        _greenpinFlag = YES;
    }
    if (item.tag == 0) {
        _redpinFlag = YES;
        _greenpinFlag = NO;
    }
   
    




}

@end
