//
//  TabbarView.m
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "UIView+Utils.h"

#import "TabbarView.h"

#import "NSString+Utils.h"

#import "TabbarItem.h"

//FC5344 selected color

@interface TabbarView ()

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleselectedColor;
@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger itemWidth;
@property (nonatomic, assign) NSInteger itemHeight;
@property (nonatomic, assign) NSInteger currentTag;

@end

@implementation TabbarView

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setup {
    _titleNormalColor = [@"#515151" colorWithHex];
    _titleselectedColor = [@"#FC5344" colorWithHex];
    _bgColor = [@"#e6e6e6" colorWithHex];
    
    self.backgroundColor = _bgColor;
    
    _count = [_tabbarDelegate countOfTab:self];
    
    _items = [[NSMutableArray alloc] initWithCapacity:_count];
    
    for (int i = 0; i < _count; i++) {
        TabbarItem *item = [[TabbarItem alloc] init];
        item.tag = i;
        [self addSubview:item];
        [item addTarget:self selector:@selector(touchTabbarItem:)];
        
        [_items addObject:item];
    }
    [self setNeedsLayout];
}

- (void)setTabbar:(NSArray*)tabs{
    
}

- (void)layoutSubviews{
    _itemWidth = CGRectGetWidth(self.bounds) / _count;
    
    _itemHeight = CGRectGetHeight(self.bounds);
    for (int i = 0; i < _items.count; i++) {
        TabbarItem *item = (TabbarItem*)[_items objectAtIndex:i];
        item.titleNormalColor = _titleNormalColor;
        item.titleSelectedColor = _titleselectedColor;
        [item setTitle:[_tabbarDelegate tabbar:self titleAtIndex:i]];
        
        NSString *imgNormalString = [_tabbarDelegate imageFor:self atIndex:i];
        item.normalImage = [UIImage imageNamed:imgNormalString];
        
        NSString *imgSelectedString = [_tabbarDelegate selectedImageFor:self atIndex:i];
        item.selectedImage = [UIImage imageNamed:imgSelectedString];
        
        NSInteger height = 0;
        if ([_tabbarDelegate respondsToSelector:@selector(heightOfTab:atIndex:)]) {
             height = [_tabbarDelegate heightOfTab:self atIndex:i];
            _itemHeight -= height;
        }
        else{
            height = CGRectGetHeight(self.bounds);
        }
        item.frame = CGRectMake(i*_itemWidth, CGRectGetHeight(self.bounds) - height , _itemWidth, height);
        
        if (i == 0) {
            item.state = TabbarItemClickSelected;
            _currentTag = 0;
        }
        else{
            item.state = TabbarItemClickNormal;
        }
    }
}

- (void)touchTabbarItem:(UITapGestureRecognizer*)tapGesture{
    TabbarItem *item = (TabbarItem*)[tapGesture view];
    [self selectItemAtIndex:item.tag];
}

- (void)selectItemAtIndex:(NSInteger)index{
    if (_currentTag == index) {
        return;
    }
    
    
    for (TabbarItem *tempItem in _items) {
        if (index == tempItem.tag) {
            tempItem.state = TabbarItemClickSelected;
        }
        else{
            tempItem.state = TabbarItemClickNormal;
        }
    }
    _currentTag = index;
    if ([_tabbarDelegate respondsToSelector:@selector(tabbar:selectedAtIndex:)]) {
        [_tabbarDelegate tabbar:self selectedAtIndex:_currentTag];
    }
}

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event{
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    CGRect touchRect = CGRectInset(self.bounds, 0, _itemHeight);
    if (CGRectContainsPoint(touchRect, point)) {
        for (UIView *subView in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subView convertPoint:point fromView:self];
            UIView *hitTestView = [subView hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return self;
    }
    return nil;
}


@end
