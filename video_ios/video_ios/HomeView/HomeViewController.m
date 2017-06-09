//
//  HomeViewController.m
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "HomeViewController.h"



@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    _homeContentView = [[HomeContentView alloc] init];
    [self.view addSubview:_homeContentView];
    
       
    NSArray *colors = [NSArray arrayWithObjects:[UIColor blackColor],
                       [UIColor brownColor],
                       [UIColor purpleColor],
                       [UIColor darkGrayColor],
                       [UIColor blueColor],
                       [UIColor cyanColor],
                       [UIColor magentaColor],
                       [UIColor yellowColor],
                       [UIColor redColor],nil];
    
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (int i = 0; i < colors.count; i++) {
        UIViewController *view = [[UIViewController alloc] init];
        view.view.backgroundColor = [colors objectAtIndex:i];
        [views addObject:view];
    }
    [_homeContentView setViewControllers:views];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _homeContentView.frame = self.view.bounds;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
