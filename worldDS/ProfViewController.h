//
//  ProfViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/14.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


//@interface ProfViewController : UIViewController
@interface ProfViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

{
    NSString *_assetsUrl;    //assetsUrlを格納するインスタンス
    ALAssetsLibrary *_library;  //ALAssetsLibraryのインスタンス
}

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *DreamLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dreamTextField;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
- (IBAction)BuckTapBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profImageView;
@property (weak, nonatomic) IBOutlet UIButton *imgbtn;
- (IBAction)cameraimgbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)tapSavebtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *GGGimg;


@end
