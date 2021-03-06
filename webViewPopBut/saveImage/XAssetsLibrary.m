//
//  XAssetsLibrary.m
//  Photocus
//
//  Created by Chen Andy on 13-7-19.
//  Copyright (c) 2013年 Dingzai. All rights reserved.
//

#import "XAssetsLibrary.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView-Extensions.h"

#define APP_IMAGE_LIBRARY_NAME @"LongPress"

@implementation XAssetsLibrary
+ (void)saveImage:(UIImage*)image withCompletionBlock:(SaveImageCompletion)completionBlock {
    if (image) {
        ALAssetsLibrary *aLibrary = [[ALAssetsLibrary alloc] init];
        [aLibrary saveImage:image
                    toAlbum:APP_IMAGE_LIBRARY_NAME
        withCompletionBlock:completionBlock];
    }
}

+ (CGFloat)scale {
    CGFloat aScale = 1.0;
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        aScale = [[UIScreen mainScreen] scale];
    }
    return aScale;
}

+ (UIImage *)imageFromView:(UIView *)view  atFrame:(CGRect)frame {
    CGFloat aScale = [XAssetsLibrary scale];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, aScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(frame);
    [view.layer renderInContext:context];
    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  uiImage;
}

+ (UIImage *)spliceImages:(NSArray *)images forSize:(CGSize)size
{
    CGFloat aScale = [XAssetsLibrary scale];
    
	UIGraphicsBeginImageContext(CGSizeMake(size.width * aScale, size.height * aScale));
    CGFloat kheight = 0;
    for (int i=0; i<images.count; i++) {
        UIImage *image = [images objectAtIndex:i];
        [image drawInRect:CGRectMake(0, kheight, image.size.width * aScale, image.size.height * aScale)];
        kheight += image.size.height * aScale;
    }
	UIImage *rImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return rImage;
}

+ (void)webScreenshot:(UIWebView *)webView
      completionBlock:(void(^)(UIImage *image, NSError *error))cBlock
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//    });
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    CGSize cSize = webView.scrollView.contentSize;
    CGFloat page = ceilf(cSize.height / webView.height);
    CGPoint opoint = webView.scrollView.contentOffset;
    [webView.scrollView setContentOffset:CGPointMake(0, 0)];
    for (int i=0 ; i<page; i++) {
        CGFloat y = webView.frame.size.height * i;
        [webView.scrollView setContentOffset:CGPointMake(0, y)];
        CGRect kframe = CGRectMake(0, 0, webView.width, webView.height);
        UIImage *image = [XAssetsLibrary imageFromView:webView atFrame:kframe];
        if (image) {
            [images addObject:image];
        }
    }
    [webView.scrollView setContentOffset:opoint];
    
    if (images.count > 0) {
        CGSize csize = webView.scrollView.contentSize;
        UIImage *image = [XAssetsLibrary spliceImages:images forSize:csize];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cBlock) {
                if (image) {
                    cBlock(image, nil);
                }else
                    cBlock(nil, [NSError errorWithDomain:@"" code:400 userInfo:nil]);
            }
        });
    }
}

+ (void)saveWebScreenshot:(UIWebView *)webView completionBlock:(void(^)(UIImage *image, NSError *error))cBlock
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
// 
//    });
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    CGSize cSize = webView.scrollView.contentSize;
    CGFloat page = ceilf(cSize.height / webView.height);
    CGPoint opoint = webView.scrollView.contentOffset;
    [webView.scrollView setContentOffset:CGPointMake(0, 0)];
    for (int i=0 ; i<page; i++) {
        CGFloat y = webView.frame.size.height * i;
        [webView.scrollView setContentOffset:CGPointMake(0, y)];
        CGRect kframe = CGRectMake(0, 0, webView.width, webView.height);
        UIImage *image = [XAssetsLibrary imageFromView:webView atFrame:kframe];
        if (image) {
            [images addObject:image];
        }
    }
    [webView.scrollView setContentOffset:opoint];
    
    if (images.count > 0) {
        CGSize csize = webView.scrollView.contentSize;
        UIImage *image = [XAssetsLibrary spliceImages:images forSize:csize];
        [XAssetsLibrary saveImage:image withCompletionBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cBlock) {
                    if (error) {
                        cBlock(nil, error);
                    }else
                        cBlock(image, nil);
                }
            });
        }];
    }
    
}

+ (void)saveImageWithView:(UIView *)view withCompletionBlock:(SaveImageCompletion)completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *contentImage = view.contents;
        if (contentImage) {
            [XAssetsLibrary saveImage:contentImage
                  withCompletionBlock:completionBlock];
        }
    });
}
@end
