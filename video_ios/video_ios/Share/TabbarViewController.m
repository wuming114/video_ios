//
//  TabbarViewController.m
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//
#import "UIView+Utils.h"
#import "TabbarViewController.h"



@interface TabbarViewController ()<TabbarViewDelegate>

@property (nonatomic, strong) TabbarView *tabbarView;
@property (nonatomic, strong) NSArray *tabbars;
@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabbarView = [[TabbarView alloc] init];
    _tabbarView.tabbarDelegate = self;
    [self.view addSubview:_tabbarView];
}

- (void)viewWillAppear:(BOOL)animated {
    [_currentViewController viewWillAppear:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [_currentViewController viewDidAppear:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _tabbarView.frame = CGRectMake(0, self.view.frame.size.height - DefaultHeight, self.view.frame.size.width, DefaultHeight);
}

- (void)setTabbar:(NSMutableArray *)tabbars{
    _tabbars = tabbars;
    [_tabbarView setup];
    [self setContentViewAtIndex:0];
}

- (void)setContentViewAtIndex:(NSInteger)index {
    NSDictionary *item = (NSDictionary*)[_tabbars objectAtIndex:index];
    UIViewController *viewController = (UIViewController*)[item objectForKey:ViewKey];
    if (_currentViewController == viewController) {
        return;
    }
    
    if (_currentViewController) {
        [_currentViewController viewWillDisappear:YES];
        [_currentViewController.view removeFromSuperview];
        [_currentViewController viewDidDisappear:YES];
    }
    
    [self adjustViewController:viewController];
    
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [viewController viewWillAppear:YES];
    [self.view insertSubview:viewController.view belowSubview:_tabbarView];
    [viewController viewDidAppear:YES];
    
    _currentViewController = viewController;
    
    if (!_currentViewController.view.superview) {
        [self.view addSubview:_currentViewController.view];
    }
    
}

- (void)adjustViewController:(UIViewController*)viewController {
    CGRect frame = viewController.view.frame;
    frame.origin = CGPointZero;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = self.view.bounds.size.height - _tabbarView.frame.size.height;
    viewController.view.frame = frame;
}

#pragma mark -- TabbarViewDelegate

- (void)tabbar:(TabbarView*)tabbarView selectedAtIndex:(NSInteger)index {
    [self setContentViewAtIndex:index];
}

- (NSString*)tabbar:(TabbarView*)tabbarView titleAtIndex:(NSInteger)index {
    if ([_tabbars count] > 0) {
        NSDictionary *item = [_tabbars objectAtIndex:index];
        NSString *titleString = [item objectForKey:TitleKey];
        return titleString;
    }
    return nil;
}

- (NSString*)imageFor:(TabbarView*)tabBar atIndex:(NSUInteger)itemIndex{
    if ([_tabbars count] > 0) {
        NSDictionary *item = [_tabbars objectAtIndex:itemIndex];
        NSString *imageString = [item objectForKey:ImgNormalKey];
        return imageString;
    }
    return nil;
}

- (NSString*)selectedImageFor:(TabbarView*)tabBar atIndex:(NSUInteger)itemIndex{
    if ([_tabbars count] > 0) {
        NSDictionary *item = [_tabbars objectAtIndex:itemIndex];
        NSString *imageString = [item objectForKey:ImgSelectedKey];
        return imageString;
    }
    return nil;
}


- (NSInteger)countOfTab:(TabbarView*)tabbarView {
    return _tabbars.count;
}

- (NSInteger)heightOfTab:(TabbarView *)tabbarView atIndex:(NSInteger)index{
//    if (index == 2) {
//        return 80;
//    }
    return DefaultHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
