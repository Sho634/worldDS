//
//  WantGoViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "WantGoViewController.h"

@interface WantGoViewController (){
    BOOL viewIsVisible;
    BOOL firstFlag;
    NSDictionary *colorArea;
    NSDictionary *historyData;
}


@end

@implementation WantGoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ui　イメージを背景に設定する
    //ui　イメージを背景に設定する
    UIImage *backimage = [UIImage imageNamed:@"gorigori.png"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backimage];

    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backimage];
   
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.gogoText.text = [defaults objectForKey:@"Pintitle"];
    
    [self showPhoto:[defaults objectForKey:@""]];

    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc]init];
        
        }
    
    //pinの番号を表示する
    NSLog(@"dvc-%d",self.select_num);

    _MapDiaryArray = [[defaults objectForKey:@"MapDiary"] mutableCopy];
    
    // pin 一つ一つを分別して for 文でまわしている
    for (int i=0; i < _MapDiaryArray.count; i++) {
        
        NSString *pinNumber =  _MapDiaryArray[i][@"number"];
        
        if (self.select_num == [pinNumber intValue]){
            NSDictionary *selectedPin = _MapDiaryArray[i];
            NSMutableDictionary *changedPin = selectedPin.mutableCopy;
            
            NSLog(@"%@",[changedPin objectForKey:@"Diary"]);
            if ([[changedPin objectForKey:@"Diary"] length] > 0){
                self.TextView.text = [changedPin objectForKey:@"Diary"];
            }

            
           // self.TextView.text = [changedPin objectForKey:@"Diary"];
            self.gogoText.text = [changedPin objectForKey:@"Pintitle"];
            
            [self showPhoto:[changedPin objectForKey:@"Picture"]];

            
            
            
            //色を透けさせる
            UIColor *color = [UIColor whiteColor];
            UIColor *acolor = [color colorWithAlphaComponent:0.2];
            
            _TextView.backgroundColor = acolor;
            _gogoText.backgroundColor = acolor;
        
            //テキストビューのデリゲートを使う時
            self.TextView.delegate = self;
            
            break;
        }
        
    }
    
    
    self.TextView.delegate = self;
    self.gogoText.delegate = self;
    
    _visibleflag = YES;
    _titlevisibleflag = YES;

   


    // UIPanGestureRecognizer をインスタンス化します。また、イベント発生時に呼び出すメソッドを selector で指定します。
    UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selfSwipeDownGesture:)];

    // 下スワイプのイベントを指定します。
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;

    // Viewへ関連付けします。
    [self.view addGestureRecognizer:swipeDownGesture];


    
    
    
    
    
    

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
////mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm カメラライブラリから選んだ写真のURLを取得。 mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    _assetsUrl = [(NSURL *)[info objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
    [self showPhoto:_assetsUrl];
    
    [picker dismissViewControllerAnimated:YES completion:nil];  //元の画面に戻る
}

//assetsから取得した画像を表示する
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
                      self.ImageView.image = fullscreenImage; //イメージをセット
                      
                      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                     
                      NSArray *tmp_MapDiaryArray =[defaults objectForKey:@"MapDiary"];
                      _MapDiaryArray = tmp_MapDiaryArray.mutableCopy;
                      
                      
                      for (int i=0; i < _MapDiaryArray.count; i++) {
                          
                          
                          NSString *pinNumber = [[NSString alloc] init];
                          
                          pinNumber = _MapDiaryArray[i][@"number"];
                          
                          if (self.select_num == [pinNumber intValue]){
                              NSDictionary *selectedPin = _MapDiaryArray[i];
                              NSMutableDictionary *changedPin = selectedPin.mutableCopy;
                              
                              [changedPin setObject:url forKey:@"Picture"];
                              
                              
                              [_MapDiaryArray replaceObjectAtIndex:i withObject:changedPin];
                              
                              // save ボタンを押すとホーム画面に戻る
                              [self dismissViewControllerAnimated:YES completion:nil];
                              
                              break;
                              
                              
                          }
                          
                      }
                      
                      
                      [defaults setObject:_MapDiaryArray forKey:@"MapDiary"];
                      
                      [defaults synchronize];
                      
                      
                  }else{
                      NSLog(@"no data");
                 }
                  
              } failureBlock: nil];
    
    
    
}



//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmボタンアクションmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
//シェアボタン作成
- (IBAction)Sharetapbtn:(id)sender {
    
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




//画面遷移
- (IBAction)Backtapbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
}
- (IBAction)tapSavebtn:(id)sender {
    
    NSLog(@"save");
    
    //タイトル入力チェック
    if ([self.gogoText.text isEqualToString:@""]){
        
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
            
            [changedPin setObject:self.TextView.text forKey:@"Diary"];
            
            [changedPin setObject:self.gogoText.text forKey:@"Pintitle"];
            
            [_MapDiaryArray replaceObjectAtIndex:i withObject:changedPin];
            
            // save ボタンを押すとホーム画面に戻る
            [self dismissViewControllerAnimated:YES completion:nil];
            
            break;
            
            
        }
        
    }
    
    
    [defaults setObject:_MapDiaryArray forKey:@"MapDiary"];
    
    [defaults synchronize];
    

    
}


- (IBAction)deleteBtnTapgogo:(id)sender {
    NSLog(@"delete");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"delete the history" message:@"delete this history?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        NSLog(@"delete");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        //削除処理
        
        NSArray *checkArray = _MapDiaryArray.mutableCopy;
        
        for (NSDictionary *each in checkArray) {
            if ([each[@"number"] intValue] == self.select_num) {
                [_MapDiaryArray removeObject:each];
                break;
            }
        }
        
        
              
        
        [defaults setObject:_MapDiaryArray forKey:@"MapDiary"];
        
        [defaults synchronize];

  //12.13      [[self presentingViewController] loadView];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{NSLog(@"Cancel");
        
    }
    

}
- (IBAction)tapErikobtn:(id)sender {
    
    UIImagePickerControllerSourceType sourceType = -1;
    //イメージピッカーの生成
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //カメラロールに起動する
    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //その機能が使えなかったら、処理を中止する。
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        return;
    }
    
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = (id)self;
    
    //イメージピッカー表示
    [self presentViewController:imagePicker animated:YES completion:nil];
}







//テキストビューを触った時上にスライド
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (_visibleflag) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
//         _Sharebtn.frame = CGRectMake(_Sharebtn.frame.origin.x, _Sharebtn.frame.origin.y - 220, _Sharebtn.frame.size.width , _Sharebtn.frame.size.height);
//        _Buckbtn.frame = CGRectMake(_Buckbtn.frame.origin.x, _Buckbtn.frame.origin.y - 220, _Buckbtn.frame.size.width , _Buckbtn.frame.size.height);
//        _saveBtn.frame = CGRectMake(_saveBtn.frame.origin.x, _saveBtn.frame.origin.y - 220, _saveBtn.frame.size.width , _saveBtn.frame.size.height);
//        _deleteBtngogo.frame = CGRectMake(_deleteBtngogo.frame.origin.x, _deleteBtngogo.frame.origin.y - 220, _deleteBtngogo.frame.size.width , _deleteBtngogo.frame.size.height);
        _ImageView.frame = CGRectMake(_ImageView.frame.origin.x, _ImageView.frame.origin.y - 220, _ImageView.frame.size.width , _ImageView.frame.size.height);
        _TextView.frame = CGRectMake(_TextView.frame.origin.x, _TextView.frame.origin.y - 220, _TextView.frame.size.width , _TextView.frame.size.height);
        _gogoText.frame = CGRectMake(_gogoText.frame.origin.x, _gogoText.frame.origin.y - 220, _gogoText.frame.size.width , _gogoText.frame.size.height);
        _gogoTitle.frame = CGRectMake(_gogoTitle.frame.origin.x, _gogoTitle.frame.origin.y - 220, _gogoTitle.frame.size.width , _gogoTitle.frame.size.height);
        _btnEriko.frame = CGRectMake(_btnEriko.frame.origin.x, _btnEriko.frame.origin.y - 220, _btnEriko.frame.size.width , _btnEriko.frame.size.height);
        
        
        [UIView commitAnimations];
        _visibleflag = NO;
        
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_visibleflag) {
        
        _visibleflag = NO;
        _titlevisibleflag = NO;
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
            
            
            if (!_titlevisibleflag) {
                [_gogoText resignFirstResponder];
            }else{
                //キーボードを下げる
                [_TextView resignFirstResponder];
                [_gogoText resignFirstResponder];
                //            _Sharebtn.frame = CGRectMake(_Sharebtn.frame.origin.x, _Sharebtn.frame.origin.y + 220, _Sharebtn.frame.size.width , _Sharebtn.frame.size.height);
                //            _Buckbtn.frame = CGRectMake(_Buckbtn.frame.origin.x, _Buckbtn.frame.origin.y + 220, _Buckbtn.frame.size.width , _Buckbtn.frame.size.height);
                //            _saveBtn.frame = CGRectMake(_saveBtn.frame.origin.x, _saveBtn.frame.origin.y + 220, _saveBtn.frame.size.width , _saveBtn.frame.size.height);
                //            _deleteBtngogo.frame = CGRectMake(_deleteBtngogo.frame.origin.x, _deleteBtngogo.frame.origin.y + 220, _deleteBtngogo.frame.size.width , _deleteBtngogo.frame.size.height);
                _ImageView.frame = CGRectMake(_ImageView.frame.origin.x, _ImageView.frame.origin.y + 220, _ImageView.frame.size.width , _ImageView.frame.size.height);
                _TextView.frame = CGRectMake(_TextView.frame.origin.x, _TextView.frame.origin.y + 220, _TextView.frame.size.width , _TextView.frame.size.height);
                _gogoText.frame = CGRectMake(_gogoText.frame.origin.x, _gogoText.frame.origin.y + 220, _gogoText.frame.size.width , _gogoText.frame.size.height);
                _gogoTitle.frame = CGRectMake(_gogoTitle.frame.origin.x, _gogoTitle.frame.origin.y + 220, _gogoTitle.frame.size.width , _gogoTitle.frame.size.height);
                _btnEriko.frame = CGRectMake(_btnEriko.frame.origin.x, _btnEriko.frame.origin.y + 220, _btnEriko.frame.size.width , _btnEriko.frame.size.height);
                
                
                
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                
                
                
                [UIView commitAnimations];
            
            
            }
            
            _visibleflag = YES;
            _titlevisibleflag = YES;
        }
    
}


@end
