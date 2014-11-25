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
    
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"]; //Tmp一時的な変数
    _DiaryTableView.delegate = self;
    _DiaryTableView.dataSource = self;
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
    
   if(cell == nil){
    //セルの初期化とスタイルの決定
       
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
}
    //cell.textLabel.text = [NSString stringWithFormat:@"行番号=%d",indexPath.row];
    
    cell.textLabel.text = _MapDiaryArray[indexPath.row][@"Pintitle"];
    
    return cell;
}
//テーブルビューに_MapDiaryArrayの中身を表示する。
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];











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
