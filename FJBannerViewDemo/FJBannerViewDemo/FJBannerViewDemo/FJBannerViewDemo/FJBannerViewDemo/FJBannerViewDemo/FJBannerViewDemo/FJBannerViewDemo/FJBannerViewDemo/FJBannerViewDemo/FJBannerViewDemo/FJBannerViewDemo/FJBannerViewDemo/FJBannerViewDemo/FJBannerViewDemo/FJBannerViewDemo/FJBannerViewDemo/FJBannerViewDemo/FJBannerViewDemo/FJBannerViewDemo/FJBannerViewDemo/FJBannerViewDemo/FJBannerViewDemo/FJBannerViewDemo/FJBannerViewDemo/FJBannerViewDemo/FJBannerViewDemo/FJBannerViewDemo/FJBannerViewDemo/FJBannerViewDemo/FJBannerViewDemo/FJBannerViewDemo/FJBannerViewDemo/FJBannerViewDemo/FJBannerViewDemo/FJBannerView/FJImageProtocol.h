//
//  FJImageProtocol.h
//  svAd
//
//  Created by Fengj on 15/10/15.
//  Copyright © 2015年 WanLink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FJImageProtocol <NSObject>

- (NSString *)imageName;

- (NSString *)imageUrl;

- (NSString *)placeHolder;

@end
