//
//  UserDViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "UserDViewController.h"

@interface UserDViewController ()

@end

@implementation UserDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *MapDiaryTmp;
    // Do any additional setup after loading the view.
}
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm宿敵ユーザーデフォルトmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addFavoriteList:(id)sender {
//手順をふもうまずは変更不可能なDictionaly型を作るselectedCoffee
    NSDictionary *selectedCoffee = _MapDiaryArray[self.select_num];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackTapBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
   
}
@end
