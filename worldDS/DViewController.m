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
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"];
    
    
    for (int i=0; i < _MapDiaryArray.count; i++) {
        
        
        NSString *pinNumber =  _MapDiaryArray[i][@"number"];
        
        if (self.select_num == [pinNumber intValue]){
            NSDictionary *selectedPin = _MapDiaryArray[i];
            NSMutableDictionary *changedPin = selectedPin.mutableCopy;
            
            NSLog(@"%@",[changedPin objectForKey:@"Diary"]);
            self.DtextView.text = [changedPin objectForKey:@"Diary"];
            
            break;
            
        }
        
    }

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmボタンアクションmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

// save ボタンを押した時に　ユーザーデフォルトにデータを保存
- (IBAction)tapSaveBtn:(id)sender {
    // saveボタンのアクション
    NSLog(@"Save");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    NSArray *tmp_MapDiaryArray =[defaults objectForKey:@"MapDiary"];
    _MapDiaryArray = tmp_MapDiaryArray.mutableCopy;

   
    for (int i=0; i < _MapDiaryArray.count; i++) {
        
        
        NSString *pinNumber = [[NSString alloc] init];
        
        pinNumber = _MapDiaryArray[i][@"number"];
    
        if (self.select_num == [pinNumber intValue]){
            NSDictionary *selectedPin = _MapDiaryArray[i];
            NSMutableDictionary *changedPin = selectedPin.mutableCopy;
            
            [changedPin setObject:self.DtextView.text forKey:@"Diary"];
            
            [changedPin setObject:self.NameTextField.text forKey:@"Pintitle"];
            
            [_MapDiaryArray replaceObjectAtIndex:i withObject:changedPin];
            
            // save ボタンを押すとホーム画面に戻る
            [self dismissViewControllerAnimated:YES completion:nil];
            
            break;
        
        
        }

    }
    
    
    [defaults setObject:_MapDiaryArray forKey:@"MapDiary"];
    
    [defaults synchronize];

    
    
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
