//
//  CustomButton.h
//  video_ios
//
//  Created by wim on 2017/6/9.
//  Copyright © 2017年 wim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomButton;

@protocol CustomButtonDelegate <NSObject>

- (void)didTouchButtonEvent;

@end

@interface CustomButton : UIView

@property (nonatomic, weak) id<CustomButtonDelegate> buttonDelegate;

- (void)setImage:(UIImage *)image;

@end
