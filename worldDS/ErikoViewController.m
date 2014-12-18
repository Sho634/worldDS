//
//  ErikoViewController.m
//  worldDS
//
//  Created by sho634 on 2014/12/18.
//  Copyright (c) 2014年 sho634. All rights reserved.
//

#import "ErikoViewController.h"

@interface ErikoViewController ()

@end

@implementation ErikoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSInteger pageSize = 4; // ページ数
    CGFloat width = self.view.bounds.size.width*0.8;
    CGFloat height = self.view.bounds.size.height*0.8;
    
    CGFloat margin = (self.view.bounds.size.width - width) / 2;
    
    // UIScrollViewのインスタンス化
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // ページングを有効にする
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.delegate = self;
    
    // スクロールの範囲を設定
    [self.scrollView setContentSize:CGSizeMake((pageSize * self.view.bounds.size.width), height)];
    
    // スクロールビューを貼付ける
    [self.view addSubview:self.scrollView];
    
    
    // スクロールビューにラベルを貼付ける
    for (int i = 0; i < pageSize; i++) {
        
        // UILabel作成
        //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, height)];
        //        label.text = [NSString stringWithFormat:@"%d", i + 1];
        //        label.font = [UIFont fontWithName:@"Arial" size:92];
        //        label.backgroundColor = [UIColor yellowColor];
        //        label.textAlignment = NSTextAlignmentCenter;
        //        [self.scrollView addSubview:label];
        //        NSLog(@"imagenum:%d",i);
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cyu-toNo%d.png", i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        
        if (i == 0){
            imageView.frame = CGRectMake(i * width + margin, 0, width, height);
        }else{
            imageView.frame = CGRectMake(i * width + margin*((i+1)*2 - 1), 0, width, height);
        }
        [self.scrollView addSubview:imageView];
    }
  
    // ページコントロールのインスタンス化
    CGFloat x = (width - 300) / 2;
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(x+margin+75, height+65, 150, 50)];
    
    // 背景色を設定
    self.pageControl.backgroundColor = [UIColor whiteColor];
    
    // ページ数を設定
    self.pageControl.numberOfPages = pageSize;
    
    // 現在のページを設定
    self.pageControl.currentPage = 0;
    
    // デフォルトの色
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 選択されてるページを現す色
    self.pageControl.currentPageIndicatorTintColor =  [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:1.0];
    
    // ページコントロールをタップされたときに呼ばれるメソッドを設定
    self.pageControl.userInteractionEnabled = YES;
    [self.pageControl addTarget:self
                         action:@selector(pageControl_Tapped:)
               forControlEvents:UIControlEventValueChanged];
    
    
    //    //キャンセルボタン
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, height-40, 30, 30);
    //    [canselButton.titleLabel setFont:[UIFont systemFontOfSize:22]];
    //    [canselButton setTitle:@"Cansel" forState:UIControlStateNormal];
    //    [canselButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIImage *img =[UIImage imageNamed:@"cancelImage"];
    [cancelButton setImage:img forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(backtoHome:)forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:cancelButton];
    
    
    // ページコントロールを貼付ける
    [self.view addSubview:self.pageControl];
    
}


// スクロールビューがスワイプされたとき
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    if ((NSInteger)fmod(self.scrollView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        self.pageControl.currentPage = self.scrollView.contentOffset.x / pageWidth;
    }
}

// ページコントロールがタップされたとき
- (void)pageControl_Tapped:(id)sender
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}


-(void)backtoHome:(UIButton*)cancelButton{
    NSLog(@"%@",cancelButton);
    //modalを閉じる
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end
