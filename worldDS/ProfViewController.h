//
//  ProfViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/14.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface ProfViewController : UIViewController
@interface ProfViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property (weak, nonatomic) IBOutlet UIImageView *image;

//Label
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *DreamLabel;

//テキストフィールド
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dreamTextField;

@property (weak, nonatomic) IBOutlet UIButton *BackBtn;

- (IBAction)BuckTapBtn:(id)sender;

//画像の読み込み
@property (weak, nonatomic) IBOutlet UIImageView *profImageView;
//押された時にカメラロールにつながるボタン
@property (weak, nonatomic) IBOutlet UIButton *imgbtn;
- (IBAction)cameraimgbtn:(id)sender;



@end
