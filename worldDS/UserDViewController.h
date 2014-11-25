//
//  UserDViewController.h
//  worldDS
//
//  Created by sho634 on 2014/11/15.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_MapDiaryArray;
}
@property NSUserDefaults *userDefaults;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;


- (IBAction)BackTapBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *DiaryTableView;


@end
