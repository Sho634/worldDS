//
//  ProfViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/14.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;



@property (weak, nonatomic) IBOutlet UITextField *dreamTextField;

@property (weak, nonatomic) IBOutlet UIButton *BackBtn;

- (IBAction)BuckTapBtn:(id)sender;



@end
