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
   
    //ui　イメージを背景に設定する
    UIImage *backimage = [UIImage imageNamed:@"gorigori.png"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backimage];

    
    
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.NameLabel.text = [defaults objectForKey:@"Name"];
    self.dreamLabel.text = [defaults objectForKey:@"Dream"];
    
    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc]init];
        
        
    }
    
    [self showPhoto:[defaults objectForKey:@"URL"]];
    
    // Do any additional setup after loading the view.
//    NSString *str_long = @"";
//    
//    for (int i = 0; i < 10; i++) {NSLog(@"%d",i);
//        str_long = [str_long stringByAppendingFormat:@"%@",@""];
//    }
//    
//    NSLog(@"%@",str_long);
//    
//    if (str_long.length > 0){
//        self.DtextView.text = str_long;
//    }
    
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
            if ([[changedPin objectForKey:@"Diary"] length] > 0){
                self.DtextView.text = [changedPin objectForKey:@"Diary"];
            }
            
            self.NameTextField.text = [changedPin objectForKey:@"Pintitle"];
            
            
            //テイストビューの色を透けさせる
            UIColor *color = [UIColor whiteColor];
            UIColor *acolor = [color colorWithAlphaComponent:0.2];
            
            _DtextView.backgroundColor = acolor;
            _NameTextField.backgroundColor = acolor;
            break;
        
        
        
        }
        
    }

    
    
    self.DtextView.delegate = self;
    
    _visibleflag = YES;
    
    
    
    
    
    // UIPanGestureRecognizer をインスタンス化します。また、イベント発生時に呼び出すメソッドを selector で指定します。
    UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selfSwipeDownGesture:)];
    
    // 下スワイプのイベントを指定します。
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    
    // Viewへ関連付けします。
    [self.view addGestureRecognizer:swipeDownGesture];
    
    
    
    
    
    
    
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

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"delete the history" message:@"May I delete this history?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];

}

    
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if(buttonIndex == 1) {
            NSLog(@"delete");
            
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];     
            
            NSArray *checkArray = _MapDiaryArray.mutableCopy;
            
            for (NSDictionary *each in checkArray) {
                if ([each[@"number"] intValue] == self.select_num) {
                    [_MapDiaryArray removeObject:each];
                    break;
                }
            }
            
            
            
            
            [defaults setObject:_MapDiaryArray forKey:@"MapDiary"];
            
            [defaults synchronize];
            
             [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }else{NSLog(@"Cancel");
            
                  }
    
}
    
    
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
    {
        if (_visibleflag) {
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            
            
            _NameLabel.frame = CGRectMake(_NameLabel.frame.origin.x, _NameLabel.frame.origin.y - 220, _NameLabel.frame.size.width , _NameLabel.frame.size.height);
            _ShereBtn.frame = CGRectMake(_ShereBtn.frame.origin.x, _ShereBtn.frame.origin.y - 220, _ShereBtn.frame.size.width , _ShereBtn.frame.size.height);
            _Homebtn.frame = CGRectMake(_Homebtn.frame.origin.x, _Homebtn.frame.origin.y - 220, _Homebtn.frame.size.width , _Homebtn.frame.size.height);
            _SaveBtn.frame = CGRectMake(_SaveBtn.frame.origin.x, _SaveBtn.frame.origin.y - 220, _SaveBtn.frame.size.width , _SaveBtn.frame.size.height);
            _deleteBtn.frame = CGRectMake(_deleteBtn.frame.origin.x, _deleteBtn.frame.origin.y - 220, _deleteBtn.frame.size.width , _deleteBtn.frame.size.height);
            _NameLabel.frame = CGRectMake(_NameLabel.frame.origin.x, _NameLabel.frame.origin.y - 220, _NameLabel.frame.size.width , _NameLabel.frame.size.height);
            _DtextView.frame = CGRectMake(_DtextView.frame.origin.x, _DtextView.frame.origin.y - 220, _DtextView.frame.size.width , _DtextView.frame.size.height);
            _NameTextField.frame = CGRectMake(_NameTextField.frame.origin.x, _NameTextField.frame.origin.y - 220, _NameTextField.frame.size.width , _NameTextField.frame.size.height);
            _dreamLabel.frame = CGRectMake(_dreamLabel.frame.origin.x, _dreamLabel.frame.origin.y - 220, _dreamLabel.frame.size.width , _dreamLabel.frame.size.height);
            _imgEriko.frame = CGRectMake(_imgEriko.frame.origin.x, _imgEriko.frame.origin.y - 220, _imgEriko.frame.size.width , _imgEriko.frame.size.height);
            _profImageView.frame = CGRectMake(_profImageView.frame.origin.x, _profImageView.frame.origin.y - 220, _profImageView.frame.size.width , _profImageView.frame.size.height);
            
            [UIView commitAnimations];
            _visibleflag = NO;
            
        }
        return YES;
    }
    
    
    - (BOOL)textFieldShouldReturn:(UITextField *)textField {
        [textField resignFirstResponder];
        return YES;
    }
    
    - (void)selfSwipeDownGesture:(UISwipeGestureRecognizer *)sender {
        // 下スワイプされた時にログに表示
        if (!_visibleflag) {
            NSLog(@"Notice Down Gesture");
            [_DtextView
             resignFirstResponder];
            
            _ShereBtn.frame = CGRectMake(_ShereBtn.frame.origin.x, _ShereBtn.frame.origin.y + 220, _ShereBtn.frame.size.width , _ShereBtn.frame.size.height);
            _Homebtn.frame = CGRectMake(_Homebtn.frame.origin.x, _Homebtn.frame.origin.y + 220, _Homebtn.frame.size.width , _Homebtn.frame.size.height);
            _SaveBtn.frame = CGRectMake(_SaveBtn.frame.origin.x, _SaveBtn.frame.origin.y + 220, _SaveBtn.frame.size.width , _SaveBtn.frame.size.height);
            _deleteBtn.frame = CGRectMake(_deleteBtn.frame.origin.x, _deleteBtn.frame.origin.y + 220, _deleteBtn.frame.size.width , _deleteBtn.frame.size.height);
            _NameLabel.frame = CGRectMake(_NameLabel.frame.origin.x, _NameLabel.frame.origin.y + 220, _NameLabel.frame.size.width , _NameLabel.frame.size.height);
            _DtextView.frame = CGRectMake(_DtextView.frame.origin.x, _DtextView.frame.origin.y + 220, _DtextView.frame.size.width , _DtextView.frame.size.height);
            _NameTextField.frame = CGRectMake(_NameTextField.frame.origin.x, _NameTextField.frame.origin.y + 220, _NameTextField.frame.size.width , _NameTextField.frame.size.height);
            _dreamLabel.frame = CGRectMake(_dreamLabel.frame.origin.x, _dreamLabel.frame.origin.y + 220, _dreamLabel.frame.size.width , _dreamLabel.frame.size.height);
            _imgEriko.frame = CGRectMake(_imgEriko.frame.origin.x, _imgEriko.frame.origin.y + 220, _imgEriko.frame.size.width , _imgEriko.frame.size.height);
            _profImageView.frame = CGRectMake(_profImageView.frame.origin.x, _profImageView.frame.origin.y + 220, _profImageView.frame.size.width , _profImageView.frame.size.height);
            
            
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            
            
            
            [UIView commitAnimations];
            
            _visibleflag = YES;
        }
    }
    

@end
