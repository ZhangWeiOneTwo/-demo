//
//  ViewController.m
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/4/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "ViewController.h"
#import "WXImageView.h"
#import "JPImageBrowserViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *_picBtnArr;
    CGFloat imageHeight;
    CGFloat cellHeight;
    NSMutableArray *_imageArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _picBtnArr = [NSMutableArray array];
    _imageArr = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.pictureBackView];
    [self initPicViewPart];
    [self configImage:self.arrayImageUrl];
    
}

- (CGFloat)configImage:(NSArray *)imgArr
{
    if (imgArr.count > 0)
    {
        self.pictureBackView.hidden = NO;
    }
    CGFloat spe = 8;
    CGFloat width = (kScreenWidth - 60 - spe * 2) / 3;
    CGFloat height = width;
    
    for (int i = 0; i < 9; i ++)
    {
        WXImageView *imageView = [self.pictureBackView viewWithTag:1000+i];
        
        @weakify(self);
        __weak WXImageView *weakSelf = imageView;
        [weakSelf setTouchBlock:^() {
            @strongify(self);
            [self showImgScrollAnimation:i imageView:weakSelf];
        }];
        NSInteger count = imgArr.count-1;
        
        if (i <= count)
        {
            [Utility showPicWithUrl:imgArr[i] imageView:imageView placeholder:@"image_loading(1).png"];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.hidden = NO;
            [_imageArr addObject:imgArr[i]];
        }
        else
        {
            imageView.hidden = YES;
        }
    }
    CGFloat rowCount = imgArr.count/3+(imgArr.count % 3 > 0 ? 1:0);
    return imgArr.count > 0 ? (rowCount * (height + 8) + 8) : 0;
}

- (void)showImgScrollAnimation:(NSInteger)index imageView:(WXImageView *)wximageView
{

    [self didSelectedImages:self.arrayImageUrl index:index imageViews:_picBtnArr tempImage:wximageView.image];
}


- (void)didSelectedImages:(NSArray *)imageUrls index:(NSInteger)index imageViews:(NSArray *)imageViewArray tempImage:(UIImage *)image
{
    JPImageBrowserViewController *browserVC = [[JPImageBrowserViewController alloc] init];
    browserVC.images = imageUrls;
    browserVC.imagePicArray = imageViewArray;
    [browserVC presentBy:self tempImage:image selIndex:index];
}

#pragma mark - 添加图片
- (void)initPicViewPart {
    int row = 0;
    int starX = 0;
    CGFloat spe = 8;
    CGFloat width = ((kScreenWidth - 60) - spe * 2) / 3;
    CGFloat height = width;
    for (int i = 0; i < 9; i ++) {
        WXImageView *imageView = [[WXImageView alloc] initWithFrame:CGRectMake((width + 8) * starX, 8 + (height + 8) * row, width, height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = 1000+i;
        [self.pictureBackView addSubview:imageView];
        if ((i + 1) % 3 == 0) {
            row += 1;
            starX = 0;
        }else {
            starX +=1;
        }
        [_picBtnArr addObject:imageView];
    }
}

- (NSArray *)arrayImageUrl
{
    return @[@"http://images.17173.com/2015/news/2015/03/30/2015cpb0330gif37.gif",
             @"http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1396940684766.jpg",
             @"http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1394701139813.jpg",
             @"http://img.jj20.com/up/allimg/911/0P315132137/150P3132137-1-lp.jpg",
             @"http://b.zol-img.com.cn/sjbizhi/images/1/208x312/1350915106394.jpg",
             @"http://b.zol-img.com.cn/sjbizhi/images/8/208x312/1427966117121.jpg",
             @"http://img.jj20.com/up/allimg/811/052515103222/150525103222-1-lp.jpg",
             @"http://b.zol-img.com.cn/sjbizhi/images/8/208x312/1435742799400.jpg",
             @"http://imga1.pic21.com/bizhi/131016/02507/s11.jpg"];
}


- (UIView *)pictureBackView
{
    if (_pictureBackView == nil)
    {
        _pictureBackView = [[UIView alloc] initWithFrame:CGRectMake(15,100 + 10, kScreenWidth - 30, 400)];
        _pictureBackView.backgroundColor = [UIColor orangeColor];
    }
    return _pictureBackView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
