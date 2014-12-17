//
//  UserDViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "UserDViewController.h"
#import "WantGoViewController.h"
#import "DViewController.h"


@interface UserDViewController ()

@end

@implementation UserDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //ui　イメージを背景に設定する
    //ui　イメージを背景に設定する
    UIImage *backimage = [UIImage imageNamed:@"omgB.png"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backimage];

    
    //UserDefaultからデータを取り出す
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *gogoTmp;
    
    //保存されたデータを取り出す
    gogoTmp = [defaults objectForKey:@"coffeeTable"];

    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"]; //Tmp一時的な変数
    
    _DiaryTableView.delegate = self;
    _DiaryTableView.dataSource = self;

}

//
-(void)viewDidAppear:(BOOL)animated{
    
     [self.DiaryTableView reloadData];

    
    //テーブルビューを自分好みの色にすけさせる
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.0];
    
    _DiaryTableView.backgroundColor = acolor;



    


}


//行数を決定するメソッド
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MapDiaryArray.count;
}

    // Do any additional setup after loading the view.

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm宿敵ユーザーデフォルトmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    //セルに名前を表示
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //定数を宣言（static = 静的)
   static NSString *CellIdentifer = @"Cell";
    
    //セルの再利用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    //セル背景を透けさせる
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.2];
    
    cell.backgroundColor = acolor;
    
   if(cell == nil){
    //セルの初期化とスタイルの決定
       
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
}
    //cell.textLabel.text = [NSString stringWithFormat:@"行番号=%d",indexPath.row];
    
    cell.textLabel.text = _MapDiaryArray[indexPath.row][@"Pintitle"];
    
    
    
    
    //タイトルの前に赤ピンを表示する
    //cell.imageView.image = [UIImage imageNamed:@"redpppin.png"];
    
    //タイトルの前に緑ピンを表示する
    //cell.imageView.image = [UIImage imageNamed:@"greenpppin"];
    
    // if 文でタイトル前に色分けピンを設置。
    if ([_MapDiaryArray[indexPath.row][@"Pincolor"] isEqualToString:@"green"]){
        
         cell.imageView.image = [UIImage imageNamed:@"pikkoropin"];
      
        
        //色分けピンもすけさせるには？？？？？？？？？？？？？？？？？？？？
//        UIColor *color = [UIColor whiteColor];
//        UIColor *acolor = [color colorWithAlphaComponent:0.2];
//        
//        cell.backgroundColor = acolor;
//
        
    }else{
        
         cell.imageView.image = [UIImage imageNamed:@"redred.png"];
    
    }
    
    
    
   
    return cell;
}
//テーブルビューに_MapDiaryArrayの中身を表示する。
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    NSLog(@"Tap:%ld",(long)indexPath.row);
    
   
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    // if　文を使って緑ピンえお押したときはWG 赤を押したときは　DVに行く
    if ([_MapDiaryArray[indexPath.row][@"Pincolor"] isEqualToString:@"green"]) {
        
        WantGoViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WantGoViewController"];
        dvc.select_num = [_MapDiaryArray[indexPath.row][@"number"] intValue];
        
            [self presentViewController:dvc animated:YES completion:nil];
        
    }else{
        
        DViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DViewController"];
        dvc.select_num = [_MapDiaryArray[indexPath.row][@"number"] intValue];
        
            [self presentViewController:dvc animated:YES completion:nil];
        
    }

    

}



- (IBAction)BackTapBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
   
}
@end
