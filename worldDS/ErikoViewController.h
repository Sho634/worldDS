//
//  ErikoViewController.h
//  worldDS
//
//  Created by sho634 on 2014/12/18.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface ErikoViewController : UIViewController

@interface ErikoViewController : UIViewController<UIScrollViewDelegate>


@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UIScrollView *canselView;



@end
