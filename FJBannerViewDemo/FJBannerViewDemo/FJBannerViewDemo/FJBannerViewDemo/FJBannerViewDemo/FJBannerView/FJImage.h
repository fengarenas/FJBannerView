//
//  FJImage.h
//  svAd
//
//  Created by Fengj on 15/10/14.
//  Copyright © 2015年 WanLink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJImageProtocol.h"

@interface FJImage : NSObject <FJImageProtocol>

@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, copy, readonly) NSString *imageUrl;
@property (nonatomic, copy, readonly) NSString *placeHolder;

+ (instancetype)imageName:(NSString *)imageName;

+ (instancetype)imageUrl:(NSString *)imageUrl placeHolder:(NSString *)placeHolder;

@end
