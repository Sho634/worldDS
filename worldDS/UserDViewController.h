//
//  UserDViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDViewController : UIViewController
@property NSUserDefaults *userDefaults;
@property NSMutableArray *counter;

@property (weak, nonatomic) IBOutlet UIButton *BackBtn;

- (IBAction)BackTapBtn:(id)sender;


@end