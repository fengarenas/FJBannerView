//
//  FJImage.m
//  svAd
//
//  Created by Fengj on 15/10/14.
//  Copyright © 2015年 WanLink. All rights reserved.
//

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
