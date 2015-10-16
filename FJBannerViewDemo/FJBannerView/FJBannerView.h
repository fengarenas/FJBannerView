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

#import <UIKit/UIKit.h>
#import "FJImageProtocol.h"

typedef void (^ImageTaped)(NSUInteger index);

@class FJBannerView;

@protocol FJBannerViewDelegate <NSObject>

- (void)FJBannerView:(FJBannerView *)bannerView tapedAtIndex:(NSUInteger)index;

- (void)FJBannerView:(FJBannerView *)bannerView scrollToIndex:(NSUInteger)index;

@end

@interface FJBannerView : UIView

@property (nonatomic, weak) id <FJBannerViewDelegate> delegate;

/**
 *  You can set images anytime,it works immediately.
 */
@property (nonatomic, copy) NSArray< id<FJImageProtocol> > *images;

/**
 *  default is YES
 *  if scrollInterval greater than zero and autoScroll is equal to YES
 *  then bannerview will scroll automaticity every scrollInterval seconds
 */
@property (nonatomic, assign) BOOL autoScroll;

/**
 *  default is 3.0f,scroll Interval
 */
@property (nonatomic, assign) NSTimeInterval scrollInterval;

/**
 *  default is YES,set this property show or hidden the pageIndicator
 */
@property (nonatomic, assign ,getter=isShowPageIndicator) BOOL showPageIndicator;

/**
 *  default is lightGrayColor.
 */
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;

/**
 *  default is blackColor.
 */
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;

/**
 *  init a banner view.
 *
 *  @param frame  bannerView's frame
 *  @param images a NSArray contain  a group of object that confirm FJImageProtocal(recommend use FJImage class)
 *
 *  @return bannerView instance
 */
+ (instancetype)viewWithFrame:(CGRect)frame images:(NSArray< id<FJImageProtocol> > *)images;


/**
 *  when user taped a image,this block will called.
 *
 *  @param imageTaped callback block
 */
- (void)tapedCallBack:(ImageTaped)imageTaped;

@end
