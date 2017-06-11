//
//  CustomSegment.h
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SegmentLabel.h"

@class CustomSegment;


@protocol CustomSegmentDelegate <NSObject>

- (void)didTouchSegmentAtIndex:(NSInteger)index;

@end

@interface CustomSegment : UIScrollView


@property (nonatomic, weak) id<CustomSegmentDelegate> segmentDelegate;

- (void)setSegments:(NSArray*)segments;
- (void)setSelectedAtIndex:(NSInteger)index;
- (void)changeStateAtIndex:(NSInteger)index;

- (void)changeSliderWidth:(CGFloat)width;

- (SegmentLabel*)getButtonAtIndex:(NSInteger)index;

@end
