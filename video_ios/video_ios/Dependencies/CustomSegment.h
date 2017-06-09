//
//  CustomSegment.h
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSegment;

@protocol CustomSegmentDelegate <NSObject>

- (void)didTouchSegmentAtIndex:(NSInteger)index;

@end

@interface CustomSegment : UIScrollView


@property (nonatomic, weak) id<CustomSegmentDelegate> segmentDelegate;

- (void)setSegments:(NSArray*)segments;
- (void)setSelectedAtIndex:(NSInteger)index;

@end
