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
    // Do any additional setup after loading the view.
    NSString *str_long = @"";
    
    for (int i = 0; i < 10; i++) {NSLog(@"%d",i);
        str_long = [str_long stringByAppendingFormat:@"%@",@""];
        }
    
    NSLog(@"%@",str_long);
    
    
    self.DtextView.text = str_long;

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)tapSaveBtn:(id)sender {
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
