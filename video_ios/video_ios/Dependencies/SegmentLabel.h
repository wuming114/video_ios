//
//  SegmentLabel.h
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SegmentLabelNormal = 1,
    SegmentLabelSelected = 2,
}SegmentLabelState;

@interface SegmentLabel : UILabel

@property (nonatomic, assign) SegmentLabelState state;

@property (nonatomic, strong) UIColor *normaleColor;
@property (nonatomic, strong) UIColor *selectedColor;

- (void)setName:(NSString*)name;
- (void)setTarget:(id)target selector:(SEL)selector;

- (CGFloat)getWidth;


@end
