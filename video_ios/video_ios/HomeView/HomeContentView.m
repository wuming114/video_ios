//
//  HomeContentView.m
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "HomeContentView.h"

@interface HomeContentView ()<UIScrollViewDelegate,CustomSegmentDelegate>

@property (nonatomic, strong) NSArray *views;

@property (nonatomic, assign) CGFloat lastScrollPoint;

@end

@implementation HomeContentView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setSegment];
        [self setContent];
    }
    return self;
}

 
- (void)setup {
//    self.showsHorizontalScrollIndicator = NO;
//    self.pagingEnabled = YES;
}

- (void)setSegment{
    NSDictionary *item1 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"id",@"电影",@"name", nil];
    NSDictionary *item2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"id",@"电视剧",@"name", nil];
    NSDictionary *item3 = [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"id",@"新闻",@"name", nil];
    NSDictionary *item4 = [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"id",@"盗墓空间",@"name", nil];
    NSDictionary *item5 = [NSDictionary dictionaryWithObjectsAndKeys:@"5",@"id",@"我家里有人", @"name",nil];
    NSDictionary *item6 = [NSDictionary dictionaryWithObjectsAndKeys:@"6",@"id",@"我和你", @"name",nil];
    NSDictionary *item7 = [NSDictionary dictionaryWithObjectsAndKeys:@"7",@"id",@"史前一万亿年", @"name",nil];
    NSDictionary *item8 = [NSDictionary dictionaryWithObjectsAndKeys:@"8",@"id",@"最后的战役",@"name", nil];
    NSDictionary *item9 = [NSDictionary dictionaryWithObjectsAndKeys:@"9",@"id",@"战役", @"name",nil];
    
    NSArray *array = [NSArray arrayWithObjects:item1,
                      item2,
                      item3,
                      item4,
                      item5,
                      item6,
                      item7,
                      item8,
                      item9, nil];
    _customSegment = [[CustomSegment alloc] init];
    _customSegment.segmentDelegate = self;
    [_customSegment setSegments:array];
    
    [_customSegment setSelectedAtIndex:0];
    _customSegment.backgroundColor = [UIColor whiteColor];
    [self addSubview:_customSegment];
}

- (void)setContent{
    _contentView = [[UIScrollView alloc] init];
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.pagingEnabled = YES;
    _contentView.delegate = self;
    [self addSubview:_contentView];
}

- (void)setViewControllers:(NSArray*)viewControllers{
    _views = viewControllers;
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *viewController = [viewControllers objectAtIndex:i];
        [_contentView addSubview:viewController.view];
    }
}


- (void)layoutSubviews{
    int width = CGRectGetWidth(self.bounds);
    int height = CGRectGetHeight(self.bounds) - 35;
    _customSegment.frame = CGRectMake(0, 0, self.bounds.size.width, 35);
    _contentView.frame = CGRectMake(0, 35, self.bounds.size.width, height);
    
    
    for (int i = 0; i < _views.count; i++) {
        UIViewController *viewController = [_views objectAtIndex:i];
        viewController.view.frame = CGRectMake(width*i, 0, width, height);
    }
    [_contentView setContentSize:CGSizeMake(width*_views.count, height)];
}

- (void)didTouchSegmentAtIndex:(NSInteger)index{
    [_contentView setContentOffset:CGPointMake(index*CGRectGetWidth(self.bounds), 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (_lastScrollPoint < scrollView.contentOffset.x && scrollView.contentOffset.x < _contentView.contentSize.width) {
        //right
        
    }
    else if (_lastScrollPoint > scrollView.contentOffset.x && scrollView.contentOffset.x > 0) {
        //left
        //NSLog(@"left==%f",scrollView.contentOffset.x);
    }
    
    _lastScrollPoint = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [_customSegment changeStateAtIndex:page];
    
        
}

@end
