//
//  TabbarItem.m
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "UIView+Utils.h"

#import "TabbarItem.h"

@interface TabbarItem ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;



@end



@implementation TabbarItem



- (instancetype)init{
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    _imageView.frame = CGRectMake(0, 5, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-25);
    _titleLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-17, CGRectGetWidth(self.bounds), 15);
}




- (UITapGestureRecognizer*)tapGesture{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] init];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

- (void)setTitle:(NSString*)title {
    _titleLabel.text = title;
}

- (void)addTarget:(id)target selector:(SEL)selector{
    
    
    if (!self.tapGesture.view) {
        [self addGestureRecognizer:self.tapGesture];
    }
    [self.tapGesture addTarget:target action:selector];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (_state == TabbarItemClickNormal) {
        _state = TabbarItemClickSelected;
    }
    else{
        _state = TabbarItemClickNormal;
    }
    return YES;
}

- (void)setState:(TabbarItemClickState)state{
    _state = state;
    if (_state == TabbarItemClickNormal) {
        _imageView.image = _normalImage;
        _titleLabel.textColor = _titleNormalColor;
    }
    else{
        _imageView.image = _selectedImage;
        _titleLabel.textColor = _titleSelectedColor;
    }
}




@end
