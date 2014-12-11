//
//  DViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/12.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "DViewController.h"
#import "ShoAnnotation.h"



@interface DViewController ()

@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.NameLabel.text = [defaults objectForKey:@"Name"];
    self.dreamLabel.text = [defaults objectForKey:@"Dream"];
    
    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc]init];
        
        
    }
    
    [self showPhoto:[defaults objectForKey:@"URL"]];
    
    // Do any additional setup after loading the view.
    NSString *str_long = @"";
    
    for (int i = 0; i < 10; i++) {NSLog(@"%d",i);
        str_long = [str_long stringByAppendingFormat:@"%@",@""];
    }
    
    NSLog(@"%@",str_long);
    
    self.DtextView.text = str_long;

    //pinの番号を表示するメソッド
    NSLog(@"dvc-%d",self.select_num);
    
    
    
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //ユーザーデフォルトの中に保存した情報に名前をつけている
    _MapDiaryArray = [defaults objectForKey:@"MapDiary"];
    
    
    for (int i=0; i < _MapDiaryArray.count; i++) {
        
        
        NSString *pinNumber =  _MapDiaryArray[i][@"number"];
        
        if (self.select_num == [pinNumber intValue]){
            NSDictionary *selectedPin = _MapDiaryArray[i];
            NSMutableDictionary *changedPin = selectedPin.mutableCopy;
            
            NSLog(@"%@",[changedPin objectForKey:@"Diary"]);
            self.DtextView.text = [changedPin objectForKey:@"Diary"];
            self.NameTextField.text = [changedPin objectForKey:@"Pintitle"];
            break;
            
        }
        
    }

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)showPhoto:(NSString *)url
{
    
    //URLからALAssetを取得
    [_library assetForURL:[NSURL URLWithString:url]
              resultBlock:^(ALAsset *asset) {
                  
                  //画像があればYES、無ければNOを返す
                  if(asset){
                      NSLog(@"data");
                      //ALAssetRepresentationクラスのインスタンスの作成
                      ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
                      
                      //ALAssetRepresentationを使用して、フルスクリーン用の画像をUIImageに変換
                      //fullScreenImageで元画像と同じ解像度の写真を取得する。
                      UIImage *fullscreenImage = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]];
                      self.profImageView.image = fullscreenImage; //イメージをセット
                      
                      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                      
                      [defaults setObject:url forKey:@"URL"];//_coffeearrayをcoffeetableというキーで保存
                      
                      
                      [defaults synchronize];
                      
                  }else{
                      NSLog(@"no data");
                  }
                  
              } failureBlock: nil];
    
    
    
}

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmボタンアクションmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

// save ボタンを押した時に　ユーザーデフォルトにデータを保存
- (IBAction)tapSaveBtn:(id)sender {
    // saveボタンのアクション
    NSLog(@"Save");
    
    //タイトル入力チェック
    if ([self.NameTextField.text isEqualToString:@""]){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"NO TITLE" message:@"please imput title"
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;

    }
    
    
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

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
    //現在作成した地図のスクリーンショットを作成
    UIImage *mapPic = [self screenshotWithView:self.view];
    
    // PNGの場合（view.alphaで指定した透明度も維持されるみたい）
    NSData *dataSaveImage = UIImagePNGRepresentation(mapPic);
    
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd_HHmmss"];
    NSString *strNow = [df stringFromDate:now];
    
    NSDateFormatter *dfkey = [[NSDateFormatter alloc] init];
    [dfkey setDateFormat:@"yyyy/MM/dd_HH:mm:ss"];
    //NSString *strNowKey = [dfkey stringFromDate:now];
    
    NSString *FileName = [NSString stringWithFormat:@"%@.png",strNow];
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);
    
    [dataSaveImage writeToFile:[path stringByAppendingPathComponent:FileName] atomically:YES];
    
    
    
    [defaults synchronize];
    
    //シェア用文章,URL,画像（モダンな書き方）
    NSArray *actItems = @[mapPic];
    
    UIActivityViewController
    *activityView = [[UIActivityViewController alloc] initWithActivityItems:actItems applicationActivities:nil];
    
    //モーダルの処理
    [self presentViewController:activityView animated:YES completion:nil];
    
}

//スクリーンショットを取る
- (UIImage *)screenshotWithView:(UIView *)view
{
    CGSize imageSize = [self.view bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, [view center].x, [view center].y);
    CGContextConcatCTM(context, [view transform]);
    CGContextTranslateCTM(context,
                          -[view bounds].size.width * [[view layer] anchorPoint].x - view.frame.origin.x,
                          -[view bounds].size.height * [[view layer] anchorPoint].y - view.frame.origin.y);
    
    [[view layer] renderInContext:context];
    
    CGContextRestoreGState(context);
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

    

    //ボタンを押したらホーム画面に戻るボタン
- (IBAction)tapHomebtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}




- (IBAction)tapdeleteBtn:(id)sender {//データー削除が分からない！！！！！！！！！！！！！！！！！！！！！！！！！
    NSLog(@"delete");
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    //宿題
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *ShoAnnotation = @"favoritelist";
//    //番号にそった名前を代入
//    ShoAnnotation = [self returnBoxName:app.second_select_num];
//    NSArray *favorite;
//    //保存されたデータを取り出す
//    favorite = [defaults objectForKey:boxname];
//    _MapDiaryArray = favorite.mutableCopy;
//
//    
//    
////    
////    //ユーザーデフォルトを取得する
////    NSUserDefaults * userDefaults;
////    
////    //userDefaults = [NSUserDefaults standardUserDefaults];
////    
////    //設定値を保存する
////    [userDefaults setInteger:6
////                      forKey:@"myValue"];
////    
////    //設定値を削除する
////    [userDefaults removeObjectForKey:@"myValue"];
////    
////    //ファイルに反映する
////    [userDefaults synchronize];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"履歴を削除" message:@"こちらの履歴を削除してもよろしいですか？" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    
//    [alert show];
//    
//    //ユーザーデフォルトを使えるようにする
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    //消したいデーターをセレクトナムを使って消す
//    [_MapDiaryArray removeObject:_MapDiaryArray[_select_num]];
//    
//    NSString * = @"favoritelist";
//    //グローバ変数を扱うオブジェクト
//    //AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    //番号にそった名前を代入
//    boxname = [self returnBoxName:app.second_select_num];
//    
//    [defaults setObject:_MapDiaryArray forKey:boxname];
//    [defaults synchronize];
//    

    
    
    
    //
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"履歴を削除" message:@"こちらの履歴を削除してもよろしいですか？" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    
//    [alert show];
//    
//    //ユーザーデフォルトを使えるようにする
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//   
//    
//    //消したいデーターをセレクトナムを使って消す
//    [_MapDiaryArray removeObject:_MapDiaryArray[_select_num]];
//    
//    NSString *boxname = @"UserDViewController";
//    
//    //_listArray = list;
//    
//    [defaults setObject:_MapDiaryArray forKey:boxname];
//    [defaults synchronize];
//    
//
    
    
    
    
}
@end
