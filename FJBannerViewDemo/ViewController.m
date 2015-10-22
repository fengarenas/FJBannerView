// Copyright (c) 2015 FJBannerView
// Author fengjun
// Blog:http://devfeng.com/
// Url :https://github.com/fengarenas/FJBannerView
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


#import "ViewController.h"
#import "FJBannerView.h"
#import "FJImage.h"

@interface ViewController () <FJBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load image from url
    
    FJImage *image1 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-circles.png" placeHolder:@"defaultimg"];
    FJImage *image2 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-plus.png" placeHolder:@"defaultimg"];
    FJImage *image3 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-stream.png" placeHolder:@"defaultimg"];
    FJImage *image4 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-sparks.png" placeHolder:@"defaultimg"];
    FJImage *image5 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-photos.png" placeHolder:@"defaultimg"];
    NSArray *urlImages = @[image1,image2,image3,image4,image5];
    
    FJBannerView *bannerView1 = [FJBannerView viewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2.0f) images:urlImages];
    bannerView1.delegate = self;
    [self.view addSubview:bannerView1];
    
    
    //load image from project
    
    NSMutableArray *localImages = [NSMutableArray arrayWithCapacity:10];
    for (NSUInteger i = 0; i<5; i++) {
        FJImage *img = [FJImage imageName:[NSString stringWithFormat:@"coolsofa-0%lu",i+1]];
        [localImages addObject:img];
    }
    
    FJBannerView *bannerView2 = [FJBannerView viewWithFrame:CGRectMake(0, bannerView1.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/2.0f) images:localImages];
    [bannerView2 tapedCallBack:^(NSUInteger index) {
        NSLog(@"%@ 点击了第%@张图片", bannerView2, @(index + 1));
    }];
    [self.view addSubview:bannerView2];
    
}

#pragma mark - FJBannerViewDelegate

- (void)FJBannerView:(FJBannerView *)bannerView tapedAtIndex:(NSUInteger)index{
    NSLog(@"%@ 点击了第%@张图片", bannerView, @(index + 1));
}

@end
