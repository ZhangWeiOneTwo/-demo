//
//  JPImageBrowserViewController.m
//  TemplateTest
//
//  Created by caijingpeng on 16/1/29.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import "JPImageBrowserViewController.h"
#import "ETZoomScrollView.h"
#import "AppDelegate.h"
#import "HWGeneralControl.h"

#define Image_TAG  5555555
@interface JPImageBrowserViewController () <ETZoomScrollViewDelegate, UIScrollViewDelegate, UIActionSheetDelegate>
{
    UIImageView *tempImageView;
    NSArray *tempRects;
    UIImage *_savedImage;
}
@property (nonatomic, strong) UIScrollView *mainSV;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) UILabel *pageLabel;
@end

@implementation JPImageBrowserViewController
@synthesize images;
@synthesize currentPage;
@synthesize mainSV;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainSV];
    [self.view addSubview:self.pageLabel];
    [self.view bringSubviewToFront:self.pageLabel];
    [self buildImageViews];
    self.mainSV.contentOffset = CGPointMake(self.currentPage * CGRectGetWidth(self.mainSV.frame), 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)buildImageViews
{
    // clear
    for (UIView *view in self.mainSV.subviews)
    {
        [view removeFromSuperview];
    }
    self.imageViewArray = [NSMutableArray array];
    // build
    for (int i = 0; i < images.count; i++)
    {
        
        ETZoomScrollView *imageView = [[ETZoomScrollView alloc] initWithFrame:CGRectMake(i * kScreenWidth,
                                                                                         0,
                                                                                         kScreenWidth,
                                                                                         kScreenHeight)];
        imageView.imageView.image = [_imagePicArray objectAtIndex:i].image;
        if ([[images objectAtIndex:i] isKindOfClass:[NSString class]])
        {
            [self setImageWithURL:[images objectAtIndex:i] imageView:imageView.imageView];
        }
        else
        {
            imageView.imageView.image = [images objectAtIndex:i];
        }
        imageView.tDelegate = self;
        imageView.tag = Image_TAG + i;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(toLongpress:)];
        [imageView addGestureRecognizer:longPress];
        [self.mainSV addSubview:imageView];
        [self.imageViewArray addObject:imageView];
    }
    
    self.mainSV.contentSize = CGSizeMake(kScreenWidth * images.count, kScreenHeight);
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",currentPage + 1,images.count];
    [self.pageLabel sizeToFit];
    self.pageLabel.frame = CGRectMake((kScreenWidth - _pageLabel.frame.size.width - 20) / 2.0f, kScreenHeight - 100, _pageLabel.frame.size.width + 20, 30);
}

- (void)toLongpress:(UIGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        ETZoomScrollView *view = (ETZoomScrollView *)sender.view;
        _savedImage = view.imageView.image;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        AppDelegate *appdel = SHARED_APP_DELEGATE;
        [actionSheet showInView:appdel.window];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (_savedImage != nil)
        {
            UIImageWriteToSavedPhotosAlbum(_savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        else
        {
            
        }
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *) error contextInfo:(void *)contextInfo {
    if (error)
    {
        [ViewFactory showToastWithMessage:error.description];
    } else
    {
        [ViewFactory showToastWithMessage:@"保存成功"];
    }
}

- (void)handleSingleTap
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    tempImageView.hidden = NO;
    int index = (self.mainSV.contentOffset.x / self.mainSV.frame.size.width);
    ETZoomScrollView *curView = [self.imageViewArray pObjectAtIndex:index];
    tempImageView.image = curView.imageView.image;
    tempImageView.frame = [curView.imageView.superview convertRect:curView.imageView.frame toView:tempImageView.superview];
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    [UIView animateWithDuration:0.3 animations:^{
        
        UIImage *image = tempImageView.image;
        CGRect rect = [[tempRects pObjectAtIndex:index] CGRectValue];
        CGRect targetRect = [self caculatetargetRect:rect image:image];
        tempImageView.frame = targetRect;
        tempImageView.center = CGRectGetCenter(rect);

    }completion:^(BOOL finished) {
        [tempImageView removeFromSuperview];
    }];
}

- (void)presentBy:(UIViewController *)controller tempImage:(UIImage *)image selIndex:(NSInteger)index
{
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:9090]) return;
    currentPage = index;
    NSMutableArray *rectArray = [NSMutableArray array];
    for (int i = 0; i < _imagePicArray.count; i++)
    {
        UIImageView *imgV = _imagePicArray[i];
        CGRect rect = [imgV convertRect:imgV.bounds toView:[UIApplication sharedApplication].keyWindow];
        [rectArray addObject:[NSValue valueWithCGRect:rect]];
    }
    tempRects = rectArray;
    
    CGRect rect = [[tempRects pObjectAtIndex:index] CGRectValue];
    CGRect targetRect = [self caculatetargetRect:rect image:image];
    
    tempImageView = [[UIImageView alloc] initWithFrame:targetRect];
    tempImageView.center = CGRectGetCenter(rect);
    tempImageView.backgroundColor = [UIColor blackColor];
    tempImageView.image = image;
    tempImageView.tag = 9090;
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [[UIApplication sharedApplication].keyWindow addSubview:tempImageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        tempImageView.frame = [UIScreen mainScreen].bounds;
    }completion:^(BOOL finished) {
        
        [controller presentViewController:self animated:NO completion:^{
            tempImageView.hidden = YES;
        }];
    }];
    
}

- (CGRect)caculatetargetRect:(CGRect)rect image:(UIImage *)image
{
    CGRect targetRect;
    if (image.size.height / image.size.width < 0)
    {
        // 宽图
        CGFloat width = rect.size.height * (image.size.width / image.size.height);
        targetRect = CGRectMake(0, 0, width, rect.size.height);
    }
    else
    {
        CGFloat height = rect.size.width * (image.size.height / image.size.width);
        targetRect = CGRectMake(0, 0, rect.size.width, height);
    }
    return targetRect;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.mainSV)
    {
        NSInteger count = MAX(1, scrollView.contentOffset.x / kScreenWidth + 1);
        NSInteger maxCount = MIN(images.count, scrollView.contentSize.width / kScreenWidth);
        self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",count,maxCount];
        [self.pageLabel sizeToFit];
        self.pageLabel.frame = CGRectMake((kScreenWidth - self.pageLabel.frame.size.width - 20) / 2.0f, kScreenHeight - 100, self.pageLabel.frame.size.width + 20, 30);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x / kScreenWidth);
    ETZoomScrollView *imageView = [self.mainSV viewWithTag:Image_TAG + index];

    if (imageView.imageView.image == nil)
    {
        if ([[images objectAtIndex:index] isKindOfClass:[NSString class]])
        {
            [self setImageWithURL:[images objectAtIndex:index] imageView:imageView.imageView];
        }
        else
        {
            imageView.imageView.image = [images objectAtIndex:index];
        }
    }
}

#pragma mark - 1.设置图片Url和背景图
- (void)setImageWithURL:(NSString *)urlStr imageView:(UIImageView *)imageView
{
    [imageView addSubview:self.indicatorView];
    self.indicatorView.center = imageView.center;
    // 2.加载图片
    __weak UIImageView *weakImageV = imageView;
    @weakify(self);
    [weakImageV sd_setImageWithURL:[NSURL URLWithString:urlStr]
                      placeholderImage:imageView.image
                               options:SDWebImageRetryFailed
                              progress:^(NSInteger receivedSize,
                                         NSInteger expectedSize) {
                                  @strongify (self);
                                  self.indicatorView.progress = (CGFloat)receivedSize / expectedSize;
                                  
                              } completed:^(UIImage *image,
                                            NSError *error,
                                            SDImageCacheType cacheType,
                                            NSURL *imageURL) {
                                  @strongify (self);
                                  [self.indicatorView removeFromSuperview];
                                  
                                  if (error == nil)
                                  {
                                      weakImageV.image = image;
                                  }
                               }];
}
#pragma mark - getters and setters 属性
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.indicatorView.progress = progress;
}

- (void)setImages:(NSArray *)array
{
    images = array;
}

- (void)setCurrentPage:(NSInteger)page
{
    currentPage = page;
}

- (UIScrollView *)mainSV
{
    if (mainSV == nil)
    {
        mainSV = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        mainSV.backgroundColor = [UIColor blackColor];
        mainSV.delegate = self;
        mainSV.pagingEnabled = YES;
    }
    return mainSV;
}


- (UILabel *)pageLabel
{
    if (_pageLabel == nil)
    {
        _pageLabel = [HWGeneralControl createLabel:CGRectMake(20, kScreenHeight - 100, kScreenWidth - 20 * 2, 30) font:15 textAligment:NSTextAlignmentCenter labelColor:[UIColor whiteColor]];
        _pageLabel.backgroundColor = [UIColor grayColor];
        _pageLabel.layer.cornerRadius = 15.0f;
        _pageLabel.layer.masksToBounds = YES;
    }
    return _pageLabel;
}

- (STIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[STIndicatorView alloc]init];
        [_indicatorView setViewMode:STIndicatorViewModePieDiagram];
    }
    return _indicatorView;
}

static inline CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
