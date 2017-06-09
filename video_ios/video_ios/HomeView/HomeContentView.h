//
//  HomeContentView.h
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomSegment.h"

@interface HomeContentView : UIView

@property (nonatomic, strong) CustomSegment *customSegment;
@property (nonatomic, strong) UIScrollView *contentView;

- (void)setViewControllers:(NSArray*)viewControllers;

@end
