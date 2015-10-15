//
// Copyright (c) 2013 FJBannerView (http://devfeng.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "FJBannerView.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

static NSUInteger const kTotalImageViews = 3;
static CGFloat const kPageControllBottomMargin = 20.0f;

@interface FJBannerView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSUInteger currentImageIndex;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, copy)  ImageTaped imageTaped;

@end

@implementation FJBannerView

#pragma mark - lifeCycle
+ (instancetype)viewWithFrame:(CGRect)frame images:(NSArray< id<FJImageProtocol> > *)images{
    return [[self alloc]initWithFrame:frame images:images];
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray< id<FJImageProtocol> > *)images{
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    if (!images.count) return nil;

    _images = [images copy];
    [self setup];
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_mainScrollView setFrame:self.bounds];
    [_leftImageView setFrame:CGRectMake(0, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
    [_centerImageView setFrame:CGRectMake(_mainScrollView.frame.size.width, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
    [_rightImageView setFrame:CGRectMake(_mainScrollView.frame.size.width * 2, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
    
    [_mainScrollView setContentSize:CGSizeMake(self.frame.size.width * kTotalImageViews, self.frame.size.height)];
    [_mainScrollView setContentOffset:CGPointMake(self.frame.size.width, 0.0f)];
    
    _pageControl.hidden = YES;
    if (_showPageIndicator) {
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images.count];
        [_pageControl setFrame:CGRectMake((_mainScrollView.frame.size.width - pageControlSize.width) / 2, _mainScrollView.frame.size.height - kPageControllBottomMargin - pageControlSize.height, pageControlSize.width, pageControlSize.height)];
        [_pageControl setCurrentPageIndicatorTintColor:_currentPageIndicatorTintColor];
        [_pageControl setPageIndicatorTintColor:_pageIndicatorTintColor];
        _pageControl.numberOfPages = _images.count;
        _pageControl.currentPage = _currentImageIndex;
        [_pageControl setHidesForSinglePage:YES];
        _pageControl.enabled = NO;
        _pageControl.hidden = NO;
    }

}

- (void)dealloc{
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
    }
}

#pragma mark - response methons

- (void)setup{
    _currentImageIndex = 0;
    _autoScroll = YES;
    _scrollInterval = 3.0f;
    _showPageIndicator = YES;
    _pageIndicatorTintColor = [UIColor lightGrayColor];
    _currentPageIndicatorTintColor = [UIColor blackColor];
    [self initUI];
    [self loadData];
    [self setupTimer];
}

- (void)initUI{
    _mainScrollView = [[UIScrollView alloc]init];
    _mainScrollView.delegate = self;
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    [_mainScrollView setShowsVerticalScrollIndicator:NO];
    [_mainScrollView setPagingEnabled:YES];
    [self addSubview:_mainScrollView];
    
    _leftImageView = [[UIImageView alloc]init];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_mainScrollView addSubview:_leftImageView];
    
    _centerImageView = [[UIImageView alloc]init];
    _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_centerImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerImageViewTaped:)];
    [_centerImageView addGestureRecognizer:tapGes];
    [_mainScrollView addSubview:_centerImageView];
    
    _rightImageView = [[UIImageView alloc]init];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_mainScrollView addSubview:_rightImageView];
    
    _pageControl = [[UIPageControl alloc]init];
    [self addSubview:_pageControl];

}

- (void)loadData{
    NSUInteger totalImageCount = [_images count];
    id<FJImageProtocol> leftImageData = _images[(_currentImageIndex + totalImageCount - 1) % totalImageCount];
    id<FJImageProtocol> centerImageData = _images[_currentImageIndex];
    id<FJImageProtocol> rightImageData = _images[(_currentImageIndex + 1) % totalImageCount];
    
    [self imageView:_leftImageView bindData:leftImageData];
    [self imageView:_centerImageView bindData:centerImageData];
    [self imageView:_rightImageView bindData:rightImageData];
}

- (void)imageView:(UIImageView *)imageView bindData:(id <FJImageProtocol>)ImageData{
    NSString *imageName = [ImageData imageName];
    if (imageName) {
        [imageView setImage:[UIImage imageNamed:imageName]];
        return;
    }
    
    NSString *imageUrl = [ImageData imageUrl];
    if (imageUrl) {
        NSString *placeHolder = [ImageData placeHolder];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placeHolder]];
    }
}

- (void)setupTimer{
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
    }
    
    if (_autoScroll) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(autoPage) userInfo:nil repeats:YES];
    }
}

- (void)resetContentOffSet:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSUInteger totalImageCount = [_images count];
    if (offsetX > scrollView.frame.size.width) {
        _currentImageIndex = ++_currentImageIndex % totalImageCount;
    }
    if (offsetX <scrollView.frame.size.width) {
        _currentImageIndex = (--_currentImageIndex + totalImageCount) % totalImageCount;
    }
    [_mainScrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0.0f) animated:NO];
    [_pageControl setCurrentPage:_currentImageIndex];
    [self loadData];
}

- (void)centerImageViewTaped:(UITapGestureRecognizer *)tapGes{
    if(_delegate && [_delegate respondsToSelector:@selector(FJBannerView:tapedAtIndex:)]){
        [_delegate FJBannerView:self tapedAtIndex:_currentImageIndex];
    }
    if (self.imageTaped) {
        self.imageTaped(_currentImageIndex);
    }
}

- (void)tapedCallBack:(ImageTaped)imageTaped{
    if (imageTaped) {
        self.imageTaped = imageTaped;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self resetContentOffSet:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self resetContentOffSet:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self pauseTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    [self resumeTimerAfterTimeInterval:_scrollInterval];
}

#pragma mark - NSTimer

- (void)pauseTimer{
    if (![_timer isValid] || _timer == nil){
        return ;
    }
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer{
    if (![_timer isValid] || _timer == nil){
        return ;
    }
    [self.timer setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval{
    if (![_timer isValid] || _timer == nil){
        return ;
    }
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

- (void)autoPage{
    [_mainScrollView setContentOffset:CGPointMake(_mainScrollView.frame.size.width * 2, 0.0f) animated:YES];
}

#pragma mark - getter and setter methons

- (void)setImages:(NSArray< id<FJImageProtocol> > *)images{
    if (!images || images.count == 0) return;
    if (_images == images) return;

    _images = [images copy];
    _currentImageIndex = 0;
    _autoScroll = YES;
    [self loadData];
    [self setupTimer];
    [self setNeedsLayout];
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    [self setupTimer];
}

- (void)setScrollInterval:(NSTimeInterval)scrollInterval{
    _scrollInterval = scrollInterval;
    if (_scrollInterval == 0) {
        _autoScroll = NO;
    }
    [self setupTimer];
}

- (void)setShowPageIndicator:(BOOL)showPageIndicator{
    if (_showPageIndicator == showPageIndicator) return;
    _showPageIndicator = showPageIndicator;
    [self setNeedsLayout];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    if (_currentPageIndicatorTintColor == currentPageIndicatorTintColor) return;
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self setNeedsLayout];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    if (_pageIndicatorTintColor == pageIndicatorTintColor) return;
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self setNeedsLayout];
}

@end
