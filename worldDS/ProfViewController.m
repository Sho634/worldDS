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
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//mmmmmmmmmmmmmmmmmmmmmmmmカメラロールから画像を取り出す時の動作mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-(void) imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    NSLog(@"selected");
    [self.imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmボタン押した時にホームに帰るmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
- (IBAction)BuckTapBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmカメラロールから画像を取り出すメソッドmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
       imagePicker.delegate = self;
       [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
       [self presentViewController:imagePicker animated:YES completion:nil];




}
@end
