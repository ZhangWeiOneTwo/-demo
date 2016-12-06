//
//  UIImage+Utils.h
//  TemplateTest
//
//  Created by caijingpeng on 16/3/5.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Utils)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageFromView:(UIView *)theView;
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;
+ (UIImage *)imageWithTriangleInSize:(CGSize)size color:(UIColor *)color;

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
