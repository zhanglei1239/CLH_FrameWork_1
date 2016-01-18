//
//  LoadingPageViewController.m
//  CLH_FrameWork
//
//  Created by Mac on 16/1/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LoadingPageViewController.h"
#import "ClipImageView.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface LoadingPageViewController ()
{
    UIScrollView * guideScroll;
    NSMutableArray * dataArray;
    UIButton * btnGoin;
    ClipImageView * clipImage;
    UILabel * lblGoNextTip;
}
@end

@implementation LoadingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    lblGoNextTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
//    [lblGoNextTip setText:@"这里应该就要进入应用内部了!"];
//    [lblGoNextTip setTextAlignment:NSTextAlignmentCenter];
//    lblGoNextTip.center = self.view.center;
//    [self.view addSubview:lblGoNextTip];
    
    dataArray = [NSMutableArray array];
    guideScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    guideScroll.pagingEnabled = YES;
    [self.view addSubview:guideScroll];
    
    [self initData];
    [self initScrollView];
    
}

-(void)initData{
    [dataArray addObject:@"guide_1"];
    [dataArray addObject:@"guide_2"];
    [dataArray addObject:@"guide_3"];
}

-(void)initScrollView{
    int count = 0;
    for (NSString * imgName in dataArray) {
        if (count == dataArray.count-1) {
            clipImage = [[ClipImageView alloc] initWithFrame:CGRectMake(count*UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
            [clipImage clipImage:[UIImage imageNamed:imgName] backgroundImage:nil];
            clipImage.delegate = self;
            [guideScroll addSubview:clipImage];
            
            CGRect rect;
            if (iPhone4s) {
                rect = CGRectMake(count*UI_SCREEN_WIDTH+(UI_SCREEN_WIDTH-130)/2, UI_SCREEN_HEIGHT-80, 130, 40);
            }else if(iPhone5){
                rect = CGRectMake(count*UI_SCREEN_WIDTH+(UI_SCREEN_WIDTH-130)/2, UI_SCREEN_HEIGHT-90, 130, 40);
            }else if(iPhone6){
                rect = CGRectMake(count*UI_SCREEN_WIDTH+(UI_SCREEN_WIDTH-160)/2, UI_SCREEN_HEIGHT-105, 160, 50);
            }else if(iPhone6p){
                rect = CGRectMake(count*UI_SCREEN_WIDTH+(UI_SCREEN_WIDTH-180)/2, UI_SCREEN_HEIGHT-115, 180, 54);
            }else{
                rect = CGRectMake(count*UI_SCREEN_WIDTH+(UI_SCREEN_WIDTH-160)/2, UI_SCREEN_HEIGHT-80, 160, 40);
            }
            UIButton * btnClip = [[UIButton alloc] initWithFrame:rect];
            [btnClip addTarget:self action:@selector(clipImage:) forControlEvents:UIControlEventTouchUpInside]; 
            [guideScroll addSubview:btnClip];
        }else{
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(count*UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
            [img setImage:[UIImage imageNamed:imgName]];
            [guideScroll addSubview:img];
        }
        count++;
    }
    [guideScroll setContentSize:CGSizeMake(count*UI_SCREEN_WIDTH, guideScroll.frame.size.height)];
}

-(void)clipImage:(id)sender{
    [clipImage clip];
}

-(void)ClipFinishCallBack:(ClipImageView *)clipImg{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"yes" forKey:@"firstLoad"];
    [ud synchronize];
    [self dismissViewControllerAnimated:NO completion:^{
       
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
