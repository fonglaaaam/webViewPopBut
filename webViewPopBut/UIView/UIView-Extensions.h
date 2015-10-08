//
//  UIView-.h
//  Footter 3
//
//  Created by Chen Andy on 11-7-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define __AppViewStorageMaxCountL1 10
#define __AppViewStorageMaxCountL2 10

@interface UIView(Extensions)
- (UIImage*)screenshot;
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier;

/** 视图共享类方法 构造或者取得 于类名为索引的共享视图后者使用 frame 构造
	@param frame 视图boundl
	@returns 视图
 @since v1.1
 */
+ (UIView *)dequeueReusableWithFrame:(CGRect)frame;
+ (UIView *)dequeueReusableWithFrame:(CGRect)frame unique:(BOOL)unique;
/** 视图共享类方法 取得内存中 identifier 视图
	@param identifier 共享索引
	@returns 视图
 @since v1.0
 */
+ (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier;

/** 视图共享类方法 构造或者取得 identifier 视图
	@param identifier 共享索引
	@param frame 视图boundl
	@returns 视图
 @since v1.0
 */
+ (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier frame:(CGRect)frame;

+ (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier frame:(CGRect)frame unique:(BOOL)unique;

/** 视图共享类方法
    清除类名索引视图
 */
+ (void)removeReusableForClass;

/** 视图共享类方法 清除identifier索引视图
	@param identifier 共享索引
 @since v1.0
 */
+ (void)removeReusableViewWithIdentifier:(NSString *)identifier;

/** 视图共享类方法
    删除所有共享视图资源
 */
+ (void)removeReusableViews;

- (UIImage *)contents;

-(UIImage*)convertViewToImage;


- (UIImage*)screenshot:(BOOL)afterUpdates;
- (UIImage*)screenOpaqueshot:(BOOL)afterUpdates ;
@end


@interface UIView (fram)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic, assign) CGSize maxSize;
@property (nonatomic, assign) CGSize minSize;
@end

@interface UIView(ext)
+ (UIView *)view;
+ (UIView *)viewWithFrame:(CGRect)frame;
+ (UIView *)viewWithColor:(UIColor *)color;
+ (UIView *)viewWithFrame:(CGRect)frame color:(UIColor *)color;
+ (UIView *)viewWithFrame:(CGRect)frame color:(UIColor *)color tag:(NSInteger)tag;
@end

@interface UIControl(ext)
+ (UIControl *)viewWithFrame:(CGRect)frame taget:(id)taget tag:(NSInteger)tag action:(SEL)action;
@end

@interface UIButton(ext)
+ (UIButton *)viewWithFrame:(CGRect)frame taget:(id)taget tag:(NSInteger)tag action:(SEL)action;
@end

@interface UILabel(ext)
+ (UILabel *)viewWithFrame:(CGRect)frame font:(UIFont *)font;

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor;

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
               shadowColor:(UIColor *)shadowColor
                      text:(NSString *)text;

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset;

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset
                       tag:(NSInteger)tag;

+ (UILabel *)viewWithFrame:(CGRect)frame copyLabel:(UILabel *)copyLabel;

#pragma mark AutoLayout
+ (UILabel *)autoLayoutView:(UIFont *)font textColor:(UIColor *)tColor;
+ (UILabel *)autoLayoutView:(UIFont *)font textColor:(UIColor *)tColor
                     sColor:(UIColor *)sColor sOffset:(CGSize)sOffset;
@end
