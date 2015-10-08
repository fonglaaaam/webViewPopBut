//
//  XVersionManager.h
//  Photocus
//
//  Created by Chen Andy on 13-9-27.
//  Copyright (c) 2013年 Dingzai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, APP_Height_Type) {
    APP_480 = 1 << 0,
    APP_568 = 2 << 1,
    APP_667 = 3 << 2,
    app_736 = 4 << 3
};

typedef NS_OPTIONS(NSInteger, APP_Width_Type) {
    APP_320 = 1 << 0,
    APP_375 = 2 << 1,
    APP_414 = 3 << 2
};

#define APP_SYSTEM_VERSION(block) [XVersionManager _version:block]
#define APP_SCREEN_WIDTH(w0,w1,w2) [XVersionManager w320:w0 w375:w1 w414:w2]
#define APP_SCREEN_HEIGHT(h0,h1,h2,h3) [XVersionManager h480:h0 h568:h1 h667:h2 h736:h3]

#define APP_SYSTEM_ROTATION(R,V,H) [XVersionManager rotation:R v:V h:H]
#define APP_SYSTEM_ROTATION_BLOCK(R,VB,HB) [XVersionManager rotation:R vBlock:VB hBlock:HB]

#define APP_SCREEN_HBLOCK(O,B) [XVersion iosScreenH:O block:B]
#define APP_SCREEN_HBLOCK_F(O,B,F) [XVersion iosScreenH:O block:B fBlock:F]

#define APP_SCREEN_WBLOCK(O,B) [XVersion iosScreenW:O block:B]
#define APP_SCREEN_WBLOCK_F(O,B,F) [XVersion iosScreenW:O block:B fBlock:F]

@interface XVersionManager : NSObject

+ (void)_version:(void(^)(CGFloat))version;

+ (void)ios5Action:(void(^)(void))action5 iso6:(void(^)(void))action6;

+ (void)ios6Action:(void(^)(void))action6 iso7:(void(^)(void))action7;

+ (id)ios6Action:(id)action6 ios7:(id)action7;

+ (void)h480Action:(void(^)(void))action480 h568Action:(void(^)(void))action568;

+ (id)h480:(id)h480 h568:(id)h568;

+ (CGFloat)w320:(CGFloat)w320 w375:(CGFloat)w375 w414:(CGFloat)w414;
+ (CGFloat)h480:(CGFloat)h480 h568:(CGFloat)h568 h667:(CGFloat)h667 h736:(CGFloat)h736;

+ (CGFloat)rotation:(UIInterfaceOrientation)rotation v:(CGFloat)v h:(CGFloat)h;
+ (void)rotation:(UIInterfaceOrientation)rotation vBlock:(void (^)(void))vBlock
          hBlock:(void(^)(void))hBlock;
@end

@interface XVersion : XVersionManager
+ (void)ios6Action:(void(^)(void))action6;
+ (void)ios7Action:(void(^)(void))action7;
+ (void)ios7_1Action:(void(^)(void))action7_1;
+ (void)ios7_1Action:(void(^)(void))action7_1  other:(void(^)(void))action;
+ (void)ios8Action:(void(^)(void))action8  other:(void(^)(void))action;
+ (void)iosScreenH:(APP_Height_Type)type block:(dispatch_block_t)block;
+ (void)iosScreenH:(APP_Height_Type)type block:(dispatch_block_t)block fBlock:(dispatch_block_t)fBlock;
+ (void)iosScreenW:(APP_Width_Type)type block:(dispatch_block_t)block;
+ (void)iosScreenW:(APP_Width_Type)type block:(dispatch_block_t)block fBlock:(dispatch_block_t)fBlock; 
@end

