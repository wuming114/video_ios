//
//  CommonTabbarViewController.m
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "CommonTabbarViewController.h"

#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "SearchViewController.h"
#import "ChannelViewController.h"
#import "LiveViewController.h"

@interface CommonTabbarViewController (){
    UINavigationController *_homeNav;
    UINavigationController *_searchNav;
    UINavigationController *_liveNav;
    UINavigationController *_channelNav;
    UINavigationController *_profileNav;
}

@property (nonatomic, strong) HomeViewController *homeViewController;
@property (nonatomic, strong) SearchViewController *searchViewController;
@property (nonatomic, strong) LiveViewController *liveViewController;
@property (nonatomic, strong) ChannelViewController *channelViewController;
@property (nonatomic, strong) ProfileViewController *profileViewController;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation CommonTabbarViewController

+ (CommonTabbarViewController*)singleton {
    static dispatch_once_t once;
    static CommonTabbarViewController *client = nil;
    dispatch_once(&once, ^ {
        client = [[self alloc] init];
    });
    return client;
}


- (instancetype)init{
    self = [super init];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _homeViewController = [[HomeViewController alloc] init];
    _searchViewController = [[SearchViewController alloc] init];
    _liveViewController = [[LiveViewController alloc] init];
    _channelViewController = [[ChannelViewController alloc] init];
    _profileViewController = [[ProfileViewController alloc] init];
    
    _homeNav = [[UINavigationController alloc] initWithRootViewController:_homeViewController];
    _searchNav = [[UINavigationController alloc] initWithRootViewController:_searchViewController];
    _liveNav = [[UINavigationController alloc] initWithRootViewController:_liveViewController];
    _channelNav = [[UINavigationController alloc] initWithRootViewController:_channelViewController];
    _profileNav = [[UINavigationController alloc] initWithRootViewController:_profileViewController];
    
    NSDictionary *homeDic = [NSDictionary dictionaryWithObjectsAndKeys:_homeNav,ViewKey,
                             @"home_tab_normal.png",ImgNormalKey,
                             @"home_tab_selected.png",ImgSelectedKey,
                             @"首页",TitleKey,nil];
    NSDictionary *searchDic = [NSDictionary dictionaryWithObjectsAndKeys:_searchNav,ViewKey,
                             @"search_tab_normal.png",ImgNormalKey,
                             @"search_tab_selected.png",ImgSelectedKey,
                             @"搜索",TitleKey,nil];
    NSDictionary *liveDic = [NSDictionary dictionaryWithObjectsAndKeys:_liveNav,ViewKey,
                               @"live_tab_normal.png",ImgNormalKey,
                               @"live_tab_selected.png",ImgSelectedKey,
                               @"直播",TitleKey,nil];
    
    NSDictionary *channelDic = [NSDictionary dictionaryWithObjectsAndKeys:_channelNav,ViewKey,
                               @"channel_tab_normal.png",ImgNormalKey,
                               @"channel_tab_selected.png",ImgSelectedKey,
                               @"频道",TitleKey,nil];
    NSDictionary *profileDic = [NSDictionary dictionaryWithObjectsAndKeys:_profileNav,ViewKey,
                               @"profile_tab_normal.png",ImgNormalKey,
                               @"profile_tab_selected.png",ImgSelectedKey,
                               @"我的",TitleKey,nil];
    
    
    
    _items = [[NSMutableArray alloc] init];
    [_items addObject:homeDic];
    [_items addObject:searchDic];
    [_items addObject:liveDic];
    [_items addObject:channelDic];
    [_items addObject:profileDic];
    
    [self setTabbar:_items];
}


@end
