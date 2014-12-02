//
//  DViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/12.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "DViewController.h"

@interface DViewController ()

@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSArray *DiaryTmp;
    
    
    // Do any additional setup after loading the view.
    NSString *str_long = @"";
    
    for (int i = 0; i < 10; i++) {NSLog(@"%d",i);
        str_long = [str_long stringByAppendingFormat:@"%@",@""];
}
    
    NSLog(@"%@",str_long);
    
    self.DtextView.text = str_long;

    //pinの番号を表示するメソッド
    
    NSLog(@"dvc-%d",self.select_num);
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
    // Dispose of any resources that can be recreated.
//
//    _coffeeArray = coffeeTmp.mutableCopy;//coffeeTmpを改造できるようにする
//    
//    self.coffeeTitle.text = [NSString stringWithFormat:@"%@とは",_coffeeArray[self.select_num][@"name"]];
//    self.descriptionText.text = _coffeeArray[self.select_num][@"desc"];
//    
//    id favoriteflag = _coffeeArray[self.select_num][@"favoriteflag"];//ここでfavoriteflagを取り出し
//    //上のif文
//    
//    int intFavFlag = [favoriteflag intValue];//調べるintValueでfavoriteflagを整数型に変換する事


//    
//    _MapDiaryArray = *DiaryTmp.mutableCopy;
//    
//    self.
//    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmボタンアクションmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

// save ボタンを押した時に　ユーザーデフォルトにデータを保存
- (IBAction)tapSaveBtn:(id)sender {
    // saveボタンのアクション
    NSLog(@"Save");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"];

   
    for (int i=1; i < _MapDiaryArray.count; i++) {
        
        
        NSString *Latitude =  _MapDiaryArray[i][@"pinNumber"];
        double latitude = Latitude.doubleValue;
        
               //ユーザーデフォルトの中に保存した情報に名前をつけている
        _MapDiaryArray = [defaults objectForKey:@"MapDiary"];
        
        if (_MapDiaryArray == nil) {
            _MapDiaryArray = [[NSMutableArray alloc] init];//初期化
        }

    }
    //    //手順をふもうまずは変更不可能なDictionaly型を作るselectedCoffee
//    NSDictionary *selectedCoffee = _coffeeArray[self.select_num];
//    //次に変更可能なNSMutableDictionaly型をつくる上のやつを代入
//    NSMutableDictionary *changedCoffee = selectedCoffee.mutableCopy;
//    
//    id favoriteflag = _coffeeArray[self.select_num][@"favoriteflag"];//ここで出とりだし
//    
//    int intFavFlag = [favoriteflag intValue];//int型に代入
//    
//    if (intFavFlag == 0) {
//        [changedCoffee setObject:@1 forKey:@"favoriteflag"];
//
    //手順をふまずには変更不可能なDictionaly型を作るselectedDiary
//    NSDictionary *selectedDiary = _MapDiaryArray[self.select_num];
//    
//    NSMutableDictionary *chengedDiary = selectedDiary.mutableCopy;
//    
//    
//    id favoriteflag = _MapDiaryArray[][@"favoriteflag"];
//    
//    
//    
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    // データ保存処理
//        
//        // userDefaults にボタンアクションでデータを保存
//         userDefaults = NSUserDefaults.standardUserDefaults()
//        
//        // キー: "saveText" , 値: "<textFieldの入力値>" を格納。（idは任意）
//        userDefaults.setObject(textField.text?, forKey: "saveText")
//    
//
}


- (IBAction)tapShereBtn:(id)sender {
    NSString *message;//シェアしたいメッセ−ジ
    NSURL *url;//シェアしたいurl
    message = @"これはgoogleのサイトをシェアするボタンです。";
    url = [NSURL URLWithString:@"http://google.com"];
    
    //アクティビティビューに渡す情報を配列に格納
    NSArray *actItems = @[message,url];//この配列には画像もセット可能
    UIActivityViewController *activityView =
    [[UIActivityViewController alloc] initWithActivityItems:actItems applicationActivities:nil];
    //モーダル処理でアクティビティビューを表示
    [self presentViewController:activityView animated:YES completion:nil];
}
    //ボタンを押したらホーム画面に戻るボタン
- (IBAction)tapHomebtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}




@end
