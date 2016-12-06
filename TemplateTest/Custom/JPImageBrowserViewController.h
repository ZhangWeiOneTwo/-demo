//
//  JPImageBrowserViewController.h
//  TemplateTest
//
//  Created by caijingpeng on 16/1/29.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseViewController.h"
#import "STIndicatorView.h"

@interface JPImageBrowserViewController : HWBaseViewController

/**
 dictionary结构：{@"image":@"UIImage",@"source":@"image Url"}
 */
@property (nonatomic, strong) NSArray <UIImageView *>*imagePicArray;//传递过来的图片数组
@property (nonatomic, strong) NSArray <id>*images;
@property (nonatomic, assign) NSInteger currentPage;
/** 3.图片下载进度 */
@property (nonatomic, assign)CGFloat progress;
- (void)presentBy:(UIViewController *)controller tempImage:(UIImage *)image selIndex:(NSInteger)index;

@property (nonatomic, strong, nullable)STIndicatorView  *indicatorView;

@end
