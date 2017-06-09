//
//  CustomButton.m
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "CustomButton.h"

#import "UIView+Utils.h"

@interface CustomButton()

@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, assign) BOOL isSingleTouch;

@end

@implementation CustomButton

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _bezierPath = [[UIBezierPath alloc] init];
        _bezierPath.lineWidth = 3;
        
        _shapeLayer = [[CAShapeLayer alloc] init];
        
    }
    return self;
}



- (void)awakeFromNib{
    [super awakeFromNib];
    [self showBorder:nil];
}





- (void)drawRect:(CGRect)rect {
    
    if (_image) {
        [_image drawInRect:rect];
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    [[UIColor blueColor] setStroke];
    //三角形
    CGPathMoveToPoint(path, NULL, 0, CGRectGetHeight(self.bounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(self.bounds), 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    CGPathCloseSubpath(path);
    _bezierPath.CGPath = path;
    
    _shapeLayer.path = _bezierPath.CGPath;
    self.layer.mask = _shapeLayer;
}


- (void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self checkPointInTouch:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self checkPointInTouch:touches];
    
    if (_isSingleTouch) {
        if ([_buttonDelegate respondsToSelector:@selector(didTouchButtonEvent)]) {
            [_buttonDelegate didTouchButtonEvent];
        }
    }
}

- (void)checkPointInTouch:(NSSet<UITouch *> *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint beginPoint = [touch locationInView:self];
    if ([_bezierPath containsPoint:beginPoint]) {
        _isSingleTouch = YES;
    }
    else{
        _isSingleTouch = NO;
    }
}

@end
