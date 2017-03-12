//
//  ChannelLabel.m
//  NetNews
//
//  Created by Lukj on 2017/3/10.
//  Copyright © 2017年 lukj. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel

- (void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
    CGFloat currentScale = 1 + scale * .3;
    
    self.transform = CGAffineTransformMakeScale(currentScale, currentScale);
}

@end
