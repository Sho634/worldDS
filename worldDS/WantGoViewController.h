//
//  WantGoViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WantGoViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *Sharebtn;

- (IBAction)Sharetapbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Buckbtn;

- (IBAction)Backtapbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UITextView *TextView;






@end
