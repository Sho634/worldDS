//
//  DViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/12.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DViewController : UIViewController
//mmmmmmmmmmmmmmセーブボタン（保存）mmmmmmmmmm
@property (weak, nonatomic) IBOutlet UIButton *SaveBtn;

- (IBAction)tapSaveBtn:(id)sender;

//mmmmmmmmmmmmmmシェアボタンmmmmmmmmmmmmmmmmm
@property (weak, nonatomic) IBOutlet UIButton *ShereBtn;

- (IBAction)tapShereBtn:(id)sender;

//mmmmmmmmmmmmmmホームボタンmmmmmmmmmmmmmmmmm

@property (weak, nonatomic) IBOutlet UIButton *Homebtn;

- (IBAction)tapHomebtn:(id)sender;
///////////////////////////////////////////


//mmmmmmmmmmmmmmm名前ラベルmmmmmmmmmmmmmmmmmm
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

//mmmmmmmmmmmmmmm日記のタイトルmmmmmmmmmmmmmmm

@property (weak, nonatomic) IBOutlet UITextView *DtextView;

///////////////////////////////////////////

@end
