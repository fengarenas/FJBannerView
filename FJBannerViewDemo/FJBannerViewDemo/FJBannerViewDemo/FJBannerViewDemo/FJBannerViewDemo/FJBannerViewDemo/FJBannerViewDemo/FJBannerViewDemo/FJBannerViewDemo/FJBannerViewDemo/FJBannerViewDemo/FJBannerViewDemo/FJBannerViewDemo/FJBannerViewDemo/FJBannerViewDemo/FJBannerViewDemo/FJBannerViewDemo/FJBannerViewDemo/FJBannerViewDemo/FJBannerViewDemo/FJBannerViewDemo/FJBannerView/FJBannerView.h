//
//  FJAutoScrollAdView.h
//  svAd
//
//  Created by Fengj on 15/10/13.
//  Copyright © 2015年 WanLink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJImageProtocol.h"

typedef void (^ImageTaped)(NSUInteger index);

@class FJBannerView;


@protocol FJBannerViewDelegate <NSObject>
- (void)FJBannerView:(FJBannerView *)bannerView tapedAtIndex:(NSUInteger)index;
@end

@interface FJBannerView : UIView

@property (nonatomic, weak) id <FJBannerViewDelegate> delegate;
@property (nonatomic, copy) NSArray< id<FJImageProtocol> > *images;
@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, assign) NSTimeInterval scrollInterval;

@property (nonatomic, assign ,getter=isShowPageIndicator) BOOL showPageIndicator;
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray< id<FJImageProtocol> > *)images;
- (void)tapedCallBack:(ImageTaped)imageTaped;

@end
