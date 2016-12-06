//
//  ETZoomScrollView.m
//  ScrollViewWithZoom
//
//

#import "ETZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].bounds)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].bounds)

@interface ETZoomScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation ETZoomScrollView

@synthesize imageView,tDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.frame = CGRectMake(frame.origin.x, 0, MRScreenWidth, MRScreenHeight);
        self.contentSize = CGSizeMake(MRScreenWidth, MRScreenHeight);
        self.maximumZoomScale = 10;
        self.minimumZoomScale = 1.0f;
        
        [self initImageView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    imageView.frame = self.bounds;

}
- (void)initImageView
{
    imageView = [[UIImageView alloc]init];
    
    // The imageView can be zoomed largest size
    imageView.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor blackColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    
    
    // Add gesture,double tap zoom imageView.
    doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [imageView addGestureRecognizer:doubleTapGesture];
    
    flagView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    flagView.backgroundColor = [UIColor cyanColor];
    [imageView addSubview:flagView];
    
    singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(handleSingleTap:)];
    [singleTapGesture setNumberOfTapsRequired:1];
    [imageView addGestureRecognizer:singleTapGesture];
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    ownerGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(handleSingleTap:)];
    [ownerGesture setNumberOfTapsRequired:1];
    [self addGestureRecognizer:ownerGesture];

}

- (void)dealloc
{
    [self removeAllGesture];
}

- (void)removeAllGesture
{
    [self removeGestureRecognizer:ownerGesture];
    [imageView removeGestureRecognizer:singleTapGesture];
    [imageView removeGestureRecognizer:doubleTapGesture];
}


#pragma mark - Zoom methods
- (void)handleSingleTap:(UITapGestureRecognizer *)gesture
{
    if (tDelegate && [tDelegate respondsToSelector:@selector(handleSingleTap)]) {
        [tDelegate handleSingleTap];
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gesture
{
    CGFloat zoomScale = self.zoomScale <= 1?2.0f:1.0f;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self scrollViewDidEndZooming:self withView:imageView atScale:zoomScale];
    }];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:NO];
    
    CGFloat size = scrollView.frame.size.height / scrollView.frame.size.width;
    CGFloat imageSize = imageView.image.size.height / imageView.image.size.width;
    if (imageSize > size)
    {
        //高是固定的
        float imageWidth = self.frame.size.height / imageSize * scale;
        float insetWidth = (imageView.frame.size.width - scrollView.frame.size.width) / 2.0f;
        
        if (imageWidth > scrollView.frame.size.width)
        {
            float inset = (scrollView.contentSize.width - imageWidth) / 2.0f;
            scrollView.contentInset = UIEdgeInsetsMake(0, -inset, 0, -inset);
        }
        else
        {
            scrollView.contentInset = UIEdgeInsetsMake(0, -insetWidth, 0, -insetWidth);
        }
    }
    else
    {
        //宽是固定的
        float imageHeight = self.frame.size.width * imageSize * scale;
        float insetHeight = (imageView.frame.size.height - scrollView.frame.size.height) / 2.0f;
        if (imageHeight > scrollView.frame.size.height)
        {
            float inset = (scrollView.contentSize.height - imageHeight) / 2.0f;
            scrollView.contentInset = UIEdgeInsetsMake(-inset, 0, -inset, 0);
        }
        else
        {
            scrollView.contentInset = UIEdgeInsetsMake(-insetHeight, 0, -insetHeight, 0);
        }
    }
    
    if (scale < 1) {
        [UIView animateWithDuration:0.2f animations:^{
            imageView.center = CGPointMake(scrollView.frame.size.width/2, scrollView.frame.size.height/2);
        }];
    }
    
}



@end
