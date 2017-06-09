//
//  UIView+Utils.m
//  video_ios
//
//  Created by wim on 2017/6/7.
//  Copyright © 2017年 wim. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)showBorder:(UIColor*)borderColor{
    if (!borderColor) {
        borderColor = [UIColor redColor];
    }
    
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1;
}

@end
