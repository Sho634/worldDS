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
#import "ErikoViewController.h"
@interface ViewController ()
{
MKMapView* _mapView;
NSInteger n;
BOOL alreadyStartingCordinateSet_;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    alreadyStartingCordinateSet_ = NO;
    
    
    //ローケーション設定
    //ユーザーによる位置情報サービスの許可状態を許可
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
        
    {
        //ユーザーはこのサービスの位置情報のサービスを利用できるまたは無効にできる
        NSLog(@"Location services is unauthorized.");
    }else{
        //位置情報サービスを利用できる、またはまだ利用許可要求を行っていない
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
    }
    //利用許可要求をまだ行っていない状態であれば要求
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        //許可の要求
        //アプリがフォアグラウンドにある間のみ位置情報サービスを使用する許可を要求
        [self.locationManager requestWhenInUseAuthorization];
    }
    //精度要求
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //最小移動間隔
    self.locationManager.distanceFilter = 100.0;                    //100m 移動ごとに通知
    //        self.locationManager.distanceFilter = kCLDistanceFilterNone;    //全ての動きを通知（デフォルト）
    
    //測位開始
    [self.locationManager startUpdatingLocation];
    


}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    //ユーザの位置を表示するかどうか
    _mapView.showsUserLocation = YES;
    
    
    
    
    CLLocation *currentLocation = locations.lastObject;
    CLLocationCoordinate2D centerCoordinate = currentLocation.coordinate;
    //縮尺度を指定
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(0.1, 0.1); //数が小さいほど拡大率アップ
    
    
    
    
    //マップキットとひも付け
    
    if (alreadyStartingCordinateSet_ == NO) {
        MKCoordinateRegion newRegion = MKCoordinateRegionMake(centerCoordinate, coordinateSpan);
        [_mapView setRegion:newRegion animated:YES];
        alreadyStartingCordinateSet_ = YES;
    }
    
}






- (void)viewWillAppear:(BOOL)animated{
        NSLog(@"aaaaaaaaaaaaa");
    //UserDefaultからデータを取り出す箱を取り出す何もないがとりだす
    
   
    //チュートリアル（I）ボタンの作成
    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-60, self.view.bounds.size.height-100, 40, 40)];
    
    //ボタンのタイトルの名前と色の設定
    //[myButton setTitle:@"" forState:(UIControlStateNormal)];//
    //[myButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    //ボタンをベースのビューに表示する設定
    [myButton addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    //自作のボタンに画像を貼付ける
    UIImage *imgIbtn = [UIImage imageNamed:@"iiiii.png"];
    [myButton setBackgroundImage:imgIbtn forState:UIControlStateNormal];
    [self.view addSubview:myButton];


    
    //地図の表示xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

    _mapView = [[MKMapView alloc] init];
    _mapView.delegate = self;
    _mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50);
 
    
    //東京の中心座標
//    CLLocationCoordinate2D co;
//    co.latitude = 35.689488;       //緯度
//    co.longitude = 139.691706;     //軽度
//    MKCoordinateRegion cr = _mapView.region;
//    cr.span.latitudeDelta = 3.0;
//    cr.span.longitudeDelta = 3.0;
//    cr.center = co;
//    [_mapView setRegion:cr];
    
    //地図の表示種類設定
    _mapView.mapType = MKMapTypeHybrid;
    //現在地を表示
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    _mapView.delegate = self;

//ロングジェスチャーの設定とアクション設定xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [_mapView addGestureRecognizer:longPressGesture];
     _mapView.delegate = self;
     _TabBar.delegate = self;
     _redpinFlag = YES;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"];
    NSLog(@"%ld",_MapDiaryArray.count);
    
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
        
        _redpinFlag = YES;
        _greenpinFlag = NO;
        
        //ユーザーデフォルトの中に保存した情報に名前をつけている
        _MapDiaryArray = [defaults objectForKey:@"MapDiary"];
        
        if (_MapDiaryArray == nil) {
            _MapDiaryArray = [[NSMutableArray alloc] init];//初期化
        }
        
        pin.pinNumber = _MapDiaryArray[i][@"number"];;
        
       //アノテーションを追加
        [_mapView addAnnotation:pin];
        //表示する為にビューに追加
        [self.view addSubview:_mapView];
     
        [_mapView.userLocation addObserver:self
                               forKeyPath:@"location"
                                  options:0
                                  context:NULL];
    }
    
    
    
    //指定したメンバ変数を最前面に持ってくる(ここでは i ボタン)
    [self.view bringSubviewToFront:myButton];

}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{

// 地図の中心座標に現在地を設定
    _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
    
    // 表示倍率の設定
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(_mapView.userLocation.coordinate, span);
    [_mapView setRegion:region animated:YES];
    
    // 一度しか更新しない場合はremoveする
    [_mapView.userLocation removeObserver:self forKeyPath:@"location"];
}

//マップ上のボタン（ i ボタン）アクションの設定。
-(void)tapBtn:(UIButton *)myButton{
    NSLog(@"Tap");
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
 
    //ErikoViewControllerに画面遷移
    ErikoViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ErikoViewController"];
    [self presentViewController:tvc animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


//ロングジェスチャーxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    
    //長押し検出時のみ作動
    if ([gesture state] == UIGestureRecognizerStateBegan){
        NSLog(@"handleLongPressGesture");
        
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
        //[_allP
        
    }else if([gesture state] == UIGestureRecognizerStateEnded){
}
}


//ピンが落ちてくるxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-(void)setAnnotation:(CLLocationCoordinate2D) point mapMove:(BOOL)mapMove animated:(BOOL)animated {
    // ピンを全て削除
    //    [_mapView removeAnnotations: _mapView.annotations];
    // 新しいピンを作成
    ShoAnnotation *anno = [[ShoAnnotation alloc] init];
    anno.coordinate = point;
    //int n = 0;
    //NSString *num = [NSString stringWithFormat:@"%ld",n];
    ++n;
    anno.title = [NSString stringWithFormat:@"PIN-%ld",(long)n];
        anno.subtitle = [NSString stringWithFormat:@"緯度:%f 経度:%f",
                     anno.coordinate.latitude,anno.coordinate.longitude];
   
    if (_greenpinFlag) {
        anno.pinColor = @"green";
    }else{
        anno.pinColor = @"red";
        }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    NSArray *tmp_MapDiaryArray =[defaults objectForKey:@"MapDiary"];
    _MapDiaryArray = tmp_MapDiaryArray.mutableCopy;
    
    if (_MapDiaryArray == nil) {
        _MapDiaryArray = [[NSMutableArray alloc] init];//初期化
    }
    
    //ピンを番号で管理するメソッド
    _maxnumber = [[defaults objectForKey:@"maxnumber"] intValue];
    
    if (_maxnumber <=0) {
        _maxnumber = 1;
    }else{
        _maxnumber +=1;
    }
    
    anno.pinNumber = [NSString stringWithFormat:@"%d",_maxnumber];
    

    
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
    
    
    //ユーザーデフォルト　＊データを保存xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    //新しいピンの情報をセット
    NSDictionary *pinInfo = @{@"Latitude":[NSString stringWithFormat:@"%f",anno.coordinate.latitude],
                              @"Longitude":[NSString stringWithFormat:@"%f",anno.coordinate.longitude],
                              @"Pintitle":anno.title,
                              @"Pincolor":anno.pinColor,
                              @"Diary":@"",
                              @"Picture":@"",
                              @"number":[NSString stringWithFormat:@"%d",_maxnumber]};
    
    

    
    [_MapDiaryArray addObject:pinInfo];

    [defaults setObject:_MapDiaryArray forKey:@"MapDiary"];//_coffeearrayをcoffeetableというキーで保存
    [defaults setObject:[NSString stringWithFormat:@"%d",_maxnumber] forKey:@"maxnumber"];
    
    [defaults synchronize];
    
    
}
//　ピン落ちてくるアニメーションのメソッドxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//　pinの色決め


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *pinIndentifier = @"PinAnnotationID";
    
    
    if ([annotation class] == MKUserLocation.class) {
        return nil;
    }
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
}
    
    
    return pinView;
}


- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
 //ピンのiボタンをタップした時にしたい動作を記述するメソッド
    ShoAnnotation *currentpin = (ShoAnnotation *)view.annotation;
    //グリーンピンの　i ボタンを押した時に反応する　if 文
    if ([currentpin.pinColor isEqualToString:@"green"]) {
       
        WantGoViewController *dvc = [self.storyboard
                                     instantiateViewControllerWithIdentifier:@"WantGoViewController"];
        dvc.select_num = [currentpin.pinNumber intValue];
        //[[self navigationController] pushViewController:dvc animated:YES];
        [self presentViewController:dvc animated:YES completion:nil];
        NSLog(@"%@",view.annotation.title);
 
    
    }else{
        
        DViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DViewController"];
        dvc.select_num = [currentpin.pinNumber intValue];
        //[[self navigationController] pushViewController:dvc animated:YES];
        [self presentViewController:dvc animated:YES completion:nil];
        NSLog(@"%@",view.annotation.title);


    }
    
}



    
 //タブバーでの画面遷移xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITabBarItem*)item {
    NSLog(@"tap:%ld",(long)item.tag);
  
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.2];
    
    tabBar.backgroundColor = acolor;
    

    
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
