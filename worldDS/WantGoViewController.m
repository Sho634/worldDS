//
//  WantGoViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "WantGoViewController.h"

@interface WantGoViewController ()

@end

@implementation WantGoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)Sharetapbtn:(id)sender {
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
- (IBAction)Backtapbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
