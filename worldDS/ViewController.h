//
//  ViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/10.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ViewController : UIViewController<MKMapViewDelegate,UITabBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSMutableArray *_MapDiaryArray; //メンバ変数宣言

    
int _maxnumber;
BOOL _redpinFlag;       //赤ピンのフラグ
BOOL _greenpinFlag;     //緑ピンフラグ
}

@property (nonatomic) CLLocationManager *locationManager;
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmタブバーのコマンドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm


@property (weak, nonatomic) IBOutlet UITabBar *TabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *RedPinTab;
@property (weak, nonatomic) IBOutlet UITabBarItem *GreenPinTab;
@property (weak, nonatomic) IBOutlet UITabBarItem *DiaryTabItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *SetBarItem;


@end

