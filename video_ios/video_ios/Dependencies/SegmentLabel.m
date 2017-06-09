//
//  SegmentLabel.m
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "SegmentLabel.h"

#import "UIView+Utils.h"
#import "NSString+Utils.h"

@interface SegmentLabel ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation SegmentLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.font = [UIFont boldSystemFontOfSize:14];
        self.textAlignment = NSTextAlignmentCenter;
        _normaleColor = [@"#707070" colorWithHex];
        _selectedColor = [@"#e2410c" colorWithHex];
        
        _tapGesture = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}


- (void)setState:(SegmentLabelState)state{
    _state = state;
    if (_state == SegmentLabelNormal) {
        self.textColor = _normaleColor;
    }
    else if (_state == SegmentLabelSelected){
        self.textColor = _selectedColor;
    }
}

- (void)setTarget:(id)target selector:(SEL)selector{
    [_tapGesture addTarget:target action:selector];
 

}

- (void)setName:(NSString*)name{
    self.text = name;
    [self adjustWidth];
}

- (void)adjustWidth {
    [self sizeToFit];
    CGRect frame = self.frame;
    frame.size.width += 10;
    self.frame = frame;
    
    _width = CGRectGetWidth(self.bounds);
}

- (CGFloat)getWidth {
    return _width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
