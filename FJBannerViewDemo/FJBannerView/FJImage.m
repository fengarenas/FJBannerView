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

#import "FJImage.h"

@interface FJImage()

@property (nonatomic, copy, readwrite) NSString *imageName;
@property (nonatomic, copy, readwrite) NSString *imageUrl;
@property (nonatomic, copy, readwrite) NSString *placeHolder;

@end

@implementation FJImage

+ (instancetype)imageName:(NSString *)imageName{
    return [[self alloc]initWithImageName:imageName];
}

+ (instancetype)imageUrl:(NSString *)imageUrl placeHolder:(NSString *)placeHolder{
    return [[self alloc]initWithImageUrl:imageUrl placeHolder:placeHolder];
}

- (instancetype)initWithImageName:(nonnull NSString *)imageName{
    self = [super init];
    if (self) {
        _imageName = [imageName copy];
    }
    return self;
}

- (instancetype)initWithImageUrl:(nonnull NSString *)imageUrl placeHolder:(NSString *)placeHolder{
    self = [super init];
    if (self) {
        _imageUrl = [imageUrl copy];
        _placeHolder = [placeHolder copy];
    }
    return self;
}

@end
