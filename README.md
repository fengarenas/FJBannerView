# FJBannerView

**FJBannerView** is a simple ,light weight bannerView 

![demo icon](http://7xljbp.com1.z0.glb.clouddn.com/FJBannerViewDemo.gif)

### Installation
***
* Drag the FJBannerViewDemo/FJBannerView folder into your project.
* You need install SDWebImage manually or use cocoapods execute "pod install"

### Usage
***
```
    //load image from url
    
    FJImage *image1 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-circles.png" placeHolder:@"defaultimg"];
    FJImage *image2 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-plus.png" placeHolder:@"defaultimg"];
    FJImage *image3 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-stream.png" placeHolder:@"defaultimg"];
    FJImage *image4 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-sparks.png" placeHolder:@"defaultimg"];
    FJImage *image5 = [FJImage imageUrl:@"http://d.lanrentuku.com/down/png/1107/google_plus/google-photos.png" placeHolder:@"defaultimg"];
    NSArray *urlImages = @[image1,image2,image3,image4,image5];
    
    FJBannerView *bannerView1 = [FJBannerView viewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2.0f) images:urlImages];
    bannerView1.delegate = self;
    
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
```

## Author
**FengJun** e-mail:<fengarenas@126.com> Blog:[DevFeng](http://devfeng.com/)
