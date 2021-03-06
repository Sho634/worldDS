//
//  WantGoViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface WantGoViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>

{
NSString *_assetsUrl;    //assetsUrlを格納するインスタンス
ALAssetsLibrary *_library;  //ALAssetsLibraryのインスタンス
NSMutableArray *_MapDiaryArray;
    BOOL _visibleflag;
    BOOL _titlevisibleflag;
}

@property (nonatomic,assign) int select_num;

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (weak, nonatomic) IBOutlet UITextField *gogoText;
@property (weak, nonatomic) IBOutlet UILabel *gogoTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnEriko;
- (IBAction)tapErikobtn:(id)sender;




@property (weak, nonatomic) IBOutlet UIButton *Buckbtn;
- (IBAction)Backtapbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Sharebtn;
- (IBAction)Sharetapbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)tapSavebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtngogo;
- (IBAction)deleteBtnTapgogo:(id)sender;


@end
