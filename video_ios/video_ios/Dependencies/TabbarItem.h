//
//  TabbarItem.h
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TabbarItemClickNormal = 0,
    TabbarItemClickSelected = 1,
}TabbarItemClickState;

@interface TabbarItem : UIView

@property (nonatomic, assign) TabbarItemClickState state;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIImage *normalImage;

- (void)setTitle:(NSString*)title;

- (void)addTarget:(id)target selector:(SEL)selector;

@end
