//
//  CustomSegment.m
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "CustomSegment.h"
#import "UIView+Utils.h"
#import "NSString+Utils.h"

#import "SegmentLabel.h"



@interface SliderBar : UIView

@property (nonatomic, strong) UIBezierPath *path;

@end


@implementation SliderBar

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // e2410c
    _path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetHeight(rect)/2];
    [[@"#e2410c" colorWithHex] set];
    [_path fill];
}

@end


@interface CustomSegment ()

@property (nonatomic, strong) NSMutableArray* buttons;
@property (nonatomic, assign) CGFloat hSpace;
@property (nonatomic, assign) CGFloat hMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) SliderBar *sliderBar;

@end

@implementation CustomSegment

- (instancetype)init{
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showsHorizontalScrollIndicator = NO;
}

- (void)setSegments:(NSArray*)segments {
    
    _buttons = [[NSMutableArray alloc] init];
    
    if ([[self subviews] count] > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (int i = 0; i < segments.count; i++) {
        NSDictionary *item = (NSDictionary*)[segments objectAtIndex:i];
        NSString *name = [item objectForKey:@"name"];
        
        SegmentLabel *button = [[SegmentLabel alloc] init];
        [button setName:name];
        button.state = SegmentLabelNormal;
        [button setTarget:self selector:@selector(touchSegmentsEvent:)];
        button.tag = i;
        [self addSubview:button];
        
        [_buttons addObject:button];
        [self setNeedsLayout];
    }
//    [self showBorder:[UIColor blueColor]];
    
    _sliderBar = [[SliderBar alloc] init];
    [self addSubview:_sliderBar];
    [self bringSubviewToFront:_sliderBar];
}

- (void)setSelectedAtIndex:(NSInteger)index {
    SegmentLabel *button = (SegmentLabel*)[_buttons objectAtIndex:index];
    _currentIndex = button.tag;
    [self changeButtonState:button];
    
    if ([_segmentDelegate respondsToSelector:@selector(didTouchSegmentAtIndex:)]) {
        [_segmentDelegate didTouchSegmentAtIndex:button.tag];
    }
}

- (void)changeButtonState:(SegmentLabel*)button {
    for (SegmentLabel *tempButton in _buttons) {
        if (tempButton != button) {
            tempButton.state = SegmentLabelNormal;
        }
        else{
            tempButton.state = SegmentLabelSelected;
        }
    }
}

- (void)changeSliderPoint:(NSInteger)index{
    SegmentLabel *button = (SegmentLabel*)[_buttons objectAtIndex:index];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _sliderBar.frame;
        frame.origin.y = CGRectGetHeight(button.frame) + 1;
        int width = CGRectGetWidth(button.frame)/3;
        frame.size.width = width;
        frame.size.height = 3;
        frame.origin.x = button.frame.origin.x + (CGRectGetWidth(button.frame) - width) /2;
        _sliderBar.frame = frame;
        
    }];
}

- (void)layoutSubviews {
    _hMargin = 10;
    _hSpace = 15;
    _bottomMargin = 6;
    
    CGFloat x = _hMargin;
    for (int i = 0; i < _buttons.count; i++) {
        SegmentLabel *button = [_buttons objectAtIndex:i];
        
        int width = [button getWidth];
        button.frame = CGRectMake(x, 0, width, CGRectGetHeight(self.bounds) - _bottomMargin);
        x += _hSpace + width;
    }
    [self setContentSize:CGSizeMake(x, CGRectGetHeight(self.bounds))];
    [self changeSliderPoint:_currentIndex];
}



- (void)touchSegmentsEvent:(UITapGestureRecognizer*)tapGesture {
    SegmentLabel *button = (SegmentLabel*)tapGesture.view;
    _currentIndex = button.tag;
    [self changeButtonState:button];
    [self changeSliderPoint:_currentIndex];
    
    if ([_segmentDelegate respondsToSelector:@selector(didTouchSegmentAtIndex:)]) {
        [_segmentDelegate didTouchSegmentAtIndex:button.tag];
    }
}


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[@"#dbdbdb" colorWithHex] set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx, 0, rect.size.height - 0.5);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height - 0.5);
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end




 
