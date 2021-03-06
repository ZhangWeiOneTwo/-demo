//
//  STIndicatorView.m
//  STPhotoBrowser
//
//  Created by https://github.com/STShenZhaoliang/STPhotoBrowser.git on 16/1/15.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "STIndicatorView.h"
//#import "STConfig.h"
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
/** 1.统一的较小间距 5*/
CGFloat const STMarginSmall = 5;

/** 2.统一的间距 10*/
CGFloat const STMargin = 10;

/** 3.统一的较大间距 16*/
CGFloat const STMarginBig = 16;

/** 4.图片最大的放大比例 */
CGFloat const STScaleMax = 2.0;

/** 5.图片最小的缩放比例 */
CGFloat const STScaleMin = 0.8;



static CGFloat const WidthIndicator = 42;

@implementation STIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(255, 255, 255, 0.7);
        self.clipsToBounds = YES;
        self.viewMode = STIndicatorViewModeLoopDiagram;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
    
    // 1.当进度完成时，从父视图移除
    if (progress >= 1) {
        [self removeFromSuperview];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width = WidthIndicator;
    frame.size.height = WidthIndicator;
    self.layer.cornerRadius = WidthIndicator / 2;
    [super setFrame:frame];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef content = UIGraphicsGetCurrentContext();

    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    [[UIColor whiteColor] set];
    
    switch (self.viewMode) {
        case STIndicatorViewModeLoopDiagram:
        {
            CGContextSetLineWidth(content, 2);
            CGContextSetLineCap(content, kCGLineCapRound);
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
            CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - STMargin;
            CGContextAddArc(content, centerX, centerY, radius, - M_PI * 0.5, to, 0);
            CGContextStrokePath(content);}
            break;
        default:
        {
            CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - STMarginSmall;
            
            CGFloat contentW = radius * 2 + STMargin;
            CGFloat contentH = contentW;
            CGFloat contentX = (rect.size.width - contentW) * 0.5;
            CGFloat contentY = (rect.size.height - contentH) * 0.5;
            CGContextAddEllipseInRect(content, CGRectMake(contentX, contentY, contentW, contentH));
            CGContextFillPath(content);
            
            [[UIColor lightGrayColor] set];
            CGContextMoveToPoint(content, centerX, centerY);
            CGContextAddLineToPoint(content, centerX, 0);
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 初始值
            CGContextAddArc(content, centerX, centerY, radius, - M_PI * 0.5, to, 1);
            CGContextClosePath(content);
            
            CGContextFillPath(content);
        }
            break;
    }
}
@end
