//
//  UIView-.m
//  Footter 3
//
//  Created by Chen Andy on 11-7-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "UIView-Extensions.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSMutableDictionary *__AppViewIdentifier = nil; 

@implementation UIView(Extensions)
- (UIImage*)screenOpaqueshot:(BOOL)afterUpdates {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,
                                           NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage*)screenshot:(BOOL)afterUpdates {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,
                                           YES, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,
                                           YES, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)contents {
    CGFloat oldAlpha = self.alpha;
	UIImage *image = nil;
	self.alpha = 1;
    
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	self.alpha = oldAlpha;
	return image;
}

-(UIImage *)convertViewToImage{
    __block UIImage *image = Nil;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIView *)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier {
    self = [self initWithFrame:frame];
    if (self) {
        if (__AppViewIdentifier == nil) {
            __AppViewIdentifier = [[NSMutableDictionary alloc] initWithCapacity:0];
        }
        @synchronized(__AppViewIdentifier){
            NSMutableArray *identItems = [__AppViewIdentifier valueForKey:identifier];
            if (identItems && identItems.count>0) {
                for (UIView *view in identItems) {
                    if (view.superview == nil) {
                        return view;
                    }
                }
                [identItems addObject:self];
            }else {
                identItems = [NSMutableArray arrayWithCapacity:0];
                [identItems addObject:self];
                    [__AppViewIdentifier setValue:identItems forKey:identifier];
            }
        }
    }
    return self;
}

+ (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier {
    if (__AppViewIdentifier == nil) return nil;
    __block UIView *view = nil;
    NSMutableArray *identItems = [__AppViewIdentifier valueForKey:identifier];
    [identItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx , BOOL *stop){
        if ([(UIView *)obj superview] == nil) {
            view = obj;
            *stop = YES;
        }
    }];
    return view;
}

+ (UIView *)dequeueReusableWithFrame:(CGRect)frame {
    NSString *identifier = [NSString stringWithFormat:@"ide-%@",NSStringFromClass([self class])];
    return [self dequeueReusableViewWithIdentifier:identifier frame:frame];
}

+ (UIView *)dequeueReusableWithFrame:(CGRect)frame unique:(BOOL)unique{
    NSString *identifier = [NSString stringWithFormat:@"ide-%@",NSStringFromClass([self class])];
    return [self dequeueReusableViewWithIdentifier:identifier frame:frame unique:unique];
}

+ (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier frame:(CGRect)frame {
    if (__AppViewIdentifier !=  nil) {        
        if (__AppViewIdentifier.count>__AppViewStorageMaxCountL1) {
            [__AppViewIdentifier removeAllObjects];
        }
        NSMutableArray *identItems = [__AppViewIdentifier valueForKey:identifier];
        if (identItems.count>__AppViewStorageMaxCountL2) {
            [__AppViewIdentifier removeObjectForKey:identifier];
            identItems = nil;
        }
        
        __block UIView *view = nil;
        [identItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx , BOOL *stop){
            if ([(UIView *)obj superview] == nil) {
                view = obj;
                *stop = YES;
            }
        }];
        if (view) {
            if (!CGRectEqualToRect(CGRectZero, frame)) {
                view.frame = frame;
            }
            return view;
        }
    }
    return [[[self class] alloc] initWithFrame:frame
                                reuseIdentifier:identifier];
 
}

+ (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier frame:(CGRect)frame unique:(BOOL)unique
{
    if (__AppViewIdentifier !=  nil) {
        NSMutableArray *identItems = [__AppViewIdentifier valueForKey:identifier];
        if (identItems && identItems.count>0) {
            if (unique) {
                return [identItems objectAtIndex:0];
            }else {
                __block UIView *view = nil;
                [identItems enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx , BOOL *stop){
                    if (obj.superview == nil) {
                        view = obj;
                        *stop = YES;
                    }
                }];
                if (view) return view;
            }
        }
    }
    return [[[self class] alloc] initWithFrame:frame
                                           reuseIdentifier:identifier];
}

+ (void)removeReusableViews {
    [__AppViewIdentifier removeAllObjects];
    __AppViewIdentifier = nil;
}

+ (void)removeReusableForClass {
    NSString *identifier = [NSString stringWithFormat:@"ide-%@",NSStringFromClass([self class])];
    [self removeReusableViewWithIdentifier:identifier];
}

+ (void)removeReusableViewWithIdentifier:(NSString *)identifier {
    if ([__AppViewIdentifier count]>0) {
        [__AppViewIdentifier removeObjectForKey:identifier];
    }
}
@end

@implementation UIView (fram)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setMaxSize:(CGSize)maxSize {
    if (self.width > maxSize.width) {
        self.width = maxSize.width;
    }
    if (self.height > maxSize.height) {
        self.height = maxSize.height;
    }
}

- (CGSize)maxSize {
    return CGSizeMake(self.width, self.height);
}

- (void)setMinSize:(CGSize)maxSize {
    if (self.width < maxSize.width) {
        self.width = maxSize.width;
    }
    if (self.height < maxSize.height) {
        self.height = maxSize.height;
    }
}

- (CGSize)minSize {
    return CGSizeMake(self.width, self.height);
}
@end

@implementation UIView(ext)
+ (UIView *)view {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

+ (UIView *)viewWithFrame:(CGRect)frame {
    return [[UIView alloc] initWithFrame:frame];
}

+ (UIView *)viewWithColor:(UIColor *)color
{
    UIView *view = [[[self class] alloc] initWithFrame:CGRectZero];
    view.backgroundColor = color;
    return view;
}

+ (UIView *)viewWithFrame:(CGRect)frame color:(UIColor *)color tag:(NSInteger)tag
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    view.tag = tag;
    return view;
}

+ (UIView *)viewWithFrame:(CGRect)frame color:(UIColor *)color
{
    UIView *view = [[[self class] alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}
@end


@implementation UIControl(ext)
+ (UIControl *)viewWithFrame:(CGRect)frame taget:(id)taget tag:(NSInteger)tag action:(SEL)action
{
    UIControl *viewControl = [[UIControl alloc] initWithFrame:frame];
    viewControl.tag = tag;
    [viewControl addTarget:taget
                    action:action
          forControlEvents:UIControlEventTouchUpInside];
    return viewControl;
}
@end

@implementation UIButton(ext)
+ (UIButton *)viewWithFrame:(CGRect)frame taget:(id)taget tag:(NSInteger)tag action:(SEL)action
{
    UIButton *viewControl = [[[self class] alloc] initWithFrame:frame];
    viewControl.tag = tag;
    if (taget) {
        [viewControl addTarget:taget
                        action:action
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    return viewControl;
}
@end

@implementation UILabel(ext)

+ (UILabel *)autoLayoutView:(UIFont *)font textColor:(UIColor *)tColor
{
    UILabel *lable = [[self class] new];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = tColor;
    lable.font = font;
    return lable;
}

+ (UILabel *)autoLayoutView:(UIFont *)font textColor:(UIColor *)tColor sColor:(UIColor *)sColor sOffset:(CGSize)sOffset
{
    UILabel *lable = [UILabel new];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = tColor;
    lable.shadowOffset = sOffset;
    lable.shadowColor = sColor;
    lable.font = font;
    return lable;
}

+ (UILabel *)viewWithFrame:(CGRect)frame font:(UIFont *)font {
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = font;
    return lable;
}

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
               shadowColor:(UIColor *)shadowColor
                      text:(NSString *)text
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = textColor;
    lable.shadowOffset = CGSizeMake(0, 1);
    lable.shadowColor = shadowColor;
    lable.font = font;
    lable.text = text;
    return lable;
}

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
{
    return [UILabel viewWithFrame:frame font:font textColor:textColor
                      shadowColor:[UIColor clearColor] shadowOffset:CGSizeMake(0, 0)];
}

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset
{
    UILabel *lable = [[[self class] alloc] initWithFrame:frame];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = textColor;
    lable.shadowOffset = shadowOffset;
    lable.shadowColor = shadowColor;
    lable.font = font;
    return lable;
}

+ (UILabel *)viewWithFrame:(CGRect)frame
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset
                       tag:(NSInteger)tag
{
    UILabel *lable = [self viewWithFrame:frame
                                    font:font
                               textColor:textColor
                             shadowColor:shadowColor
                            shadowOffset:shadowOffset];
    lable.tag = tag;
    return lable;
}

+ (UILabel *)viewWithFrame:(CGRect)frame copyLabel:(UILabel *)copyLabel
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = copyLabel.textColor;
    lable.shadowOffset = copyLabel.shadowOffset;
    lable.shadowColor = copyLabel.shadowColor;
    lable.textAlignment = copyLabel.textAlignment;
    lable.font = copyLabel.font;
    return lable;
}
@end
