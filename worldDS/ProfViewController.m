//
//  ProfViewController.m
//  worldDS
//
//  Created by sho634 on 2014/11/14.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "ProfViewController.h"

@interface ProfViewController ()

@end

@implementation ProfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ui　イメージを背景に設定する
    UIImage *backimage = [UIImage imageNamed:@"omg.png"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backimage];

    
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    self.nameTextField.text = [defaults objectForKey:@"Name"];
    self.dreamTextField.text = [defaults objectForKey:@"Dream"];
    
    if (_library ==nil) {
        _library = [[ALAssetsLibrary alloc]init];
    }

    [self showPhoto:[defaults objectForKey:@"URL"]];
    
    //ラベルを透けさせる。
        UIColor *color = [UIColor whiteColor];
        UIColor *acolor = [color colorWithAlphaComponent:0.2];
    
        _nameTextField.backgroundColor = acolor;
        _dreamTextField.backgroundColor = acolor;
    
    //ボタンの枠を生成
//    [[self.BackBtn layer] setCornerRadius:10.0];
//    [self.BackBtn setClipsToBounds:YES];
//    [[self.BackBtn layer] setBorderColor:[[UIColor blackColor] CGColor]];
//    [[self.BackBtn layer] setBorderWidth:1.5];
//    
//    
 
    
    //テキストフィールドのデリゲートを使う時
    self.nameTextField.delegate = self;
    
    self.dreamTextField.delegate = self;
    
    _visibleflag = YES;
    
    
    
    
    
    // UIPanGestureRecognizer をインスタンス化します。また、イベント発生時に呼び出すメソッドを selector で指定します。
    UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selfSwipeDownGesture:)];
    
    // 下スワイプのイベントを指定します。
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    
    // Viewへ関連付けします。
    [self.view addGestureRecognizer:swipeDownGesture];
    


    
    
    
    self.nameTextField.delegate = self;
    self.dreamTextField.delegate = self;
    
    
    
    // UIPanGestureRecognizer をインスタンス化します。また、イベント発生時に呼び出すメソッドを selector で指定します。
//    UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selfSwipeDownGesture:)];
//    
//    // 下スワイプのイベントを指定します。
//    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
//    
//    // Viewへ関連付けします。
//    [self.view addGestureRecognizer:swipeDownGesture];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


}

//mmmmmmmmmmmmmmmmmmmmmmmmカメラロールから画像を取り出す時の動作mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-(void) imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    NSLog(@"selected");
    [self.profImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];

    
    
   
}

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmボタン押した時にホームに帰るmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
- (IBAction)BuckTapBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //カメラライブラリから選んだ写真のURLを取得。
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
                      NSLog(@"データがあります");
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
                      NSLog(@"データがありません");
                  }
                  
              } failureBlock: nil];
    
}
- (IBAction)tapSavebtn:(id)sender {
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.nameTextField.text forKey:@"Name"];//_coffeearrayをcoffeetableというキーで保存
    
    [defaults setObject:self.dreamTextField.text forKey:@"Dream"];

    
    
    [defaults synchronize];
    NSLog(@"tapsave");

    // save ボタンを押すとホーム画面に戻る
    [self dismissViewControllerAnimated:YES completion:nil];

}




- (IBAction)tapErikoBtn:(id)sender {
    
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
    
    NSLog(@"tapimg");


}
-(BOOL)textfieldShouldBeginEditing:(UITextField *)textfield
    {
        if (_visibleflag) {
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            
            _ErikoBtn.frame = CGRectMake(_ErikoBtn.frame.origin.x, _ErikoBtn.frame.origin.y - 220, _ErikoBtn.frame.size.width , _ErikoBtn.frame.size.height);
            _BackBtn.frame = CGRectMake(_BackBtn.frame.origin.x, _BackBtn.frame.origin.y - 220, _BackBtn.frame.size.width , _BackBtn.frame.size.height);
            _saveBtn.frame = CGRectMake(_saveBtn.frame.origin.x, _saveBtn.frame.origin.y - 220, _saveBtn.frame.size.width , _saveBtn.frame.size.height);
            _NameLabel.frame = CGRectMake(_NameLabel.frame.origin.x, _NameLabel.frame.origin.y - 220, _NameLabel.frame.size.width , _NameLabel.frame.size.height);
            _DreamLabel.frame = CGRectMake(_DreamLabel.frame.origin.x, _DreamLabel.frame.origin.y - 220, _DreamLabel.frame.size.width , _DreamLabel.frame.size.height);
            _nameTextField.frame = CGRectMake(_nameTextField.frame.origin.x, _nameTextField.frame.origin.y - 220, _nameTextField.frame.size.width , _nameTextField.frame.size.height);
            _dreamTextField.frame = CGRectMake(_dreamTextField.frame.origin.x, _dreamTextField.frame.origin.y - 220, _dreamTextField.frame.size.width , _dreamTextField.frame.size.height);
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
            [_nameTextField resignFirstResponder];
            [_dreamTextField resignFirstResponder];
            
            
            _ErikoBtn.frame = CGRectMake(_ErikoBtn.frame.origin.x, _ErikoBtn.frame.origin.y + 220, _ErikoBtn.frame.size.width , _ErikoBtn.frame.size.height);
            _BackBtn.frame = CGRectMake(_BackBtn.frame.origin.x, _BackBtn.frame.origin.y + 220, _BackBtn.frame.size.width , _BackBtn.frame.size.height);
            _saveBtn.frame = CGRectMake(_saveBtn.frame.origin.x, _saveBtn.frame.origin.y + 220, _saveBtn.frame.size.width , _saveBtn.frame.size.height);
            _NameLabel.frame = CGRectMake(_NameLabel.frame.origin.x, _NameLabel.frame.origin.y + 220, _NameLabel.frame.size.width , _NameLabel.frame.size.height);
            _DreamLabel.frame = CGRectMake(_DreamLabel.frame.origin.x, _DreamLabel.frame.origin.y + 220, _DreamLabel.frame.size.width , _DreamLabel.frame.size.height);
            _nameTextField.frame = CGRectMake(_nameTextField.frame.origin.x, _nameTextField.frame.origin.y + 220, _nameTextField.frame.size.width , _nameTextField.frame.size.height);
            _dreamTextField.frame = CGRectMake(_dreamTextField.frame.origin.x, _dreamTextField.frame.origin.y + 220, _dreamTextField.frame.size.width , _dreamTextField.frame.size.height);
            _profImageView.frame = CGRectMake(_profImageView.frame.origin.x, _profImageView.frame.origin.y + 220, _profImageView.frame.size.width , _profImageView.frame.size.height);
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            
            
            
            [UIView commitAnimations];
            
            _visibleflag = YES;
        }





}





@end
