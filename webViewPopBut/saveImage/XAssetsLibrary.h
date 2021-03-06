//
//  XAssetsLibrary.h
//  Photocus
//
//  Created by Chen Andy on 13-7-19.
//  Copyright (c) 2013年 Dingzai. All rights reserved.
//
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XAssetsLibrary : NSObject
+ (void)saveImage:(UIImage*)image withCompletionBlock:(SaveImageCompletion)completionBlock;

+ (void)saveImageWithView:(UIView *)view withCompletionBlock:(SaveImageCompletion)completionBlock;

+ (void)webScreenshot:(UIWebView *)webView
      completionBlock:(void(^)(UIImage *image, NSError *error))cBlock;

+ (void)saveWebScreenshot:(UIWebView *)webView
          completionBlock:(void(^)(UIImage *image, NSError *error))cBlock;
@end
