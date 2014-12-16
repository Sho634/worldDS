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
    UIImage *backimage = [UIImage imageNamed:@"634.png"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backimage];

    
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    self.nameTextField.text = [defaults objectForKey:@"Name"];
    self.dreamTextField.text = [defaults objectForKey:@"Dream"];
    
    if (_library ==nil) {
        _library = [[ALAssetsLibrary alloc]init];
    }

    [self showPhoto:[defaults objectForKey:@"URL"]];
    
    
    
    
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

    
    
//    UIImagePickerControllerSourceType sourceType = -1;
//    
//    //イメージピッカーの生成
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
//    
//    //カメラロールに起動する
//    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    //その機能が使えなかったら、処理を中止する。
//    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
//    {
//        return;
//    }
//    
//    
//    imagePicker.sourceType = sourceType;
//    imagePicker.delegate = (id)self;
//    
//    //イメージピッカー表示
//    [self presentViewController:imagePicker animated:YES completion:nil];
//    
//
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ////mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmカメラライブラリから選んだ写真のURLを取得。
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
- (IBAction)tapErikobtn:(id)sender;{
    
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



@end
