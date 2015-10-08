//
//  XVersionManager.m
//  Photocus
//
//  Created by Chen Andy on 13-9-27.
//  Copyright (c) 2013年 Dingzai. All rights reserved.
//

#import "XVersionManager.h"

@implementation XVersionManager
+ (void)_version:(void(^)(CGFloat))version {
    if (version) {
        version([[[UIDevice currentDevice] systemVersion] floatValue]);
    }
}

+ (void)ios5Action:(void(^)(void))action5 iso6:(void(^)(void))action6
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) { // iOS 6 code
        if (action6) {
            action6();
        }
    } else { // iOS 5.x code 及以下
        if (action5) {
            action5();
        }
    }
}

+ (void)ios6Action:(void(^)(void))action6 iso7:(void(^)(void))action7
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) { // iOS 7 code
        if (action7) {
            action7();
        }
    } else { // iOS 6.x code 及以下
        if (action6) {
            action6();
        }
    }
}

+ (id)ios6Action:(id)action6 ios7:(id)action7 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) { // iOS 7 code
        return action7;
    } else { // iOS 6.x code 及以下
        return action6;
    }
}

+ (void)h480Action:(void(^)(void))action480 h568Action:(void(^)(void))action568
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // iphone 5 屏幕
        if (action568) {
            action568();
        }
    } else { // iphone 4s 屏幕 及以下
        if (action480) {
            action480();
        }
    }
}

+ (id)h480:(id)h480 h568:(id)h568 {
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // iphone 5 屏幕
        return h568;
    } else { // iphone 4s 屏幕 及以下
        return h480;
    }
}

+ (CGFloat)w320:(CGFloat)w320 w375:(CGFloat)w375 w414:(CGFloat)w414 {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        size = CGSizeMake(size.height, size.width);
    }
    if (size.width == 320) {
        return w320;
    } else if(size.width == 375) {
        return w375;
    } else if(size.width == 414) {
        return w414;
    }
    return w320;
}

+ (CGFloat)h480:(CGFloat)h480 h568:(CGFloat)h568 h667:(CGFloat)h667 h736:(CGFloat)h736 {
    CGSize size = [[UIScreen mainScreen] bounds].size;
 
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        size = CGSizeMake(size.height, size.width);
    }
    
    if (size.height == 480) {
        return h480;
    }else if(size.height == 568) {
        return h568;
    }else if(size.height == 667) {
        return h667;
    }else if(size.height == 736) {
        return h736;
    }
    return h480;
}

+ (CGFloat)rotation:(UIInterfaceOrientation)rotation v:(CGFloat)v h:(CGFloat)h {
    switch (rotation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return h;
            break; 
        default:
            return v;
            break;
    }
    return v;
}

+ (void)rotation:(UIInterfaceOrientation)rotation vBlock:(void (^)(void))vBlock
          hBlock:(void(^)(void))hBlock
{
    if (UIInterfaceOrientationIsLandscape(rotation)) {
        if (hBlock) {
            hBlock();
        }
    }else {
        if (vBlock) {
            vBlock();
        }
    }
}
@end


@implementation XVersion
+ (void)ios7Action:(void(^)(void))action7 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) { // iOS 7 code
        if (action7) {
            action7();
        }
    }
}

+ (void)ios6Action:(void(^)(void))action6 {
    if (!([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) { // iOS 7 code
        if (action6) {
            action6();
        }
    }
}

+ (void)ios7_1Action:(void(^)(void))action7_1 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) { // iOS 7.1 code
//        if (action7_1) {
//            action7_1();
//        }
    }
}

+ (void)ios7_1Action:(void(^)(void))action7_1 other:(void(^)(void))action {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) { // iOS 7.1 code
        if (action7_1) {
            action7_1();
        }
    }else {
        if (action) {
            action();
        }
    }
}

+ (void)ios8Action:(void(^)(void))action8  other:(void(^)(void))action {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) { // iOS 7.1 code
        if (action8) {
            action8();
        }
    }else {
        if (action) {
            action();
        }
    }
}

+ (void)iosScreenH:(APP_Height_Type)type block:(dispatch_block_t)block {
    [XVersion iosScreenH:type block:block fBlock:nil];
}

+ (void)iosScreenH:(APP_Height_Type)type block:(dispatch_block_t)block fBlock:(dispatch_block_t)fBlock
{
    if (block) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
            size = CGSizeMake(size.height, size.width);
        }
        
        APP_Height_Type option = -1;
        if (size.height == 480) {
            option = APP_480;
        }else if(size.height == 568){
            option = APP_568;
        }else if(size.height == 667){
            option = APP_667;
        }else if(size.height == 736){
            option = app_736;
        }

        if (type & option) {
            block();
            return;
        }else {
            if (fBlock) {
                fBlock();
            }
        }
    }
}

+ (void)iosScreenW:(APP_Width_Type)type block:(dispatch_block_t)block {
    [XVersion iosScreenW:type block:block fBlock:nil];
}

+ (void)iosScreenW:(APP_Width_Type)type block:(dispatch_block_t)block fBlock:(dispatch_block_t)fBlock
{
    if (block) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
            size = CGSizeMake(size.height, size.width);
        }
        
        APP_Width_Type option = -1;
        if (size.width == 320) {
            option = APP_320;
        }else if(size.width == 375){
            option = APP_375;
        }else if(size.width == 414){
            option = APP_414;
        }
 
        if (type & option) {
            block();
            return;
        }else {
            if (fBlock) {
                fBlock();
            }
        }
    }
}
@end
