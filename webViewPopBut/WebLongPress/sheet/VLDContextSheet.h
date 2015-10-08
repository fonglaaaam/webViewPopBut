//
//  VLDContextSheet.h
//
//  Created by Vladimir Angelov on 2/7/14.
//  Copyright (c) 2014 Vladimir Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VLDContextSheet;
@class VLDContextSheetItem;

@protocol VLDContextSheetDelegate <NSObject>

- (void) contextSheet: (VLDContextSheet *) contextSheet didSelectItem: (VLDContextSheetItem *) item;

@end

@interface VLDContextSheet : UIView

@property (assign, nonatomic) NSInteger radius;
@property (assign, nonatomic) CGFloat rotation;
@property (assign, nonatomic) CGFloat rangeAngle;
@property (strong, nonatomic) NSArray *items;
//@property (assign, nonatomic) id<VLDContextSheetDelegate> delegate;//delegate
@property(nonatomic, strong)void(^didSelectedBlock)(VLDContextSheetItem *item);//block 二选一
@property (strong, nonatomic) id model;

- (id) initWithItems: (NSArray *) items;

- (void) startWithGestureRecognizer: (UIGestureRecognizer *) gestureRecognizer
                             inView: (UIView *) view;
- (void) end;

+ (VLDContextSheet *) linkPressWithGestureRecognizer: (UIGestureRecognizer *) gestureRecognizer
                                              inView: (UIView *) view
                                    didSelectedBlock:(void(^)(VLDContextSheetItem *item))didSelectedBlock;

+ (VLDContextSheet *) imgPressWithGestureRecognizer: (UIGestureRecognizer *) gestureRecognizer
                                             inView: (UIView *) view
                                   didSelectedBlock:(void(^)(VLDContextSheetItem *item))didSelectedBlock;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
