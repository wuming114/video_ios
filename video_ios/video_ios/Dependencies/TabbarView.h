//
//  TabbarView.h
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ImgNormalKey @"ImgNormalKey"
#define ImgSelectedKey @"ImgSelectedKey"
#define TitleKey @"TitleKey"
#define ViewKey @"ViewKey"

#define DefaultHeight 49

@class TabbarView;

@protocol TabbarViewDelegate <NSObject>

@required

- (NSString*)tabbar:(TabbarView*)tabbarView titleAtIndex:(NSInteger)index;
- (NSString*)imageFor:(TabbarView*)tabBar atIndex:(NSUInteger)itemIndex;
- (NSString*)selectedImageFor:(TabbarView*)tabBar atIndex:(NSUInteger)itemIndex;
- (NSInteger)countOfTab:(TabbarView*)tabbarView;
- (void)tabbar:(TabbarView*)tabbarView selectedAtIndex:(NSInteger)index;

@optional
- (NSInteger)heightOfTab:(TabbarView*)tabbarView atIndex:(NSInteger)index;
- (UIColor*)backgroundOfTabbar:(TabbarView*)tabbarView;

@end

@interface TabbarView : UIView

@property (nonatomic, weak) id<TabbarViewDelegate> tabbarDelegate;

- (void)setup;

- (void)selectItemAtIndex:(NSInteger)index;

@end
