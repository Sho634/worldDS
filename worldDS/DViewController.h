//
//  DViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/12.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DViewController : UIViewController
{
  
    NSMutableArray *_MapDiaryArray;
    NSString *_assetsUrl;    //assetsUrlを格納するインスタンス
    ALAssetsLibrary *_library;  //ALAssetsLibraryのインスタンス
}
@property (nonatomic,assign) int select_num;
@property (weak, nonatomic) IBOutlet UIButton *SaveBtn;
- (IBAction)tapSaveBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ShereBtn;
- (IBAction)tapShereBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Homebtn;
- (IBAction)tapHomebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UITextView *DtextView;
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dreamLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profImageView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)tapdeleteBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgEriko;


@end
