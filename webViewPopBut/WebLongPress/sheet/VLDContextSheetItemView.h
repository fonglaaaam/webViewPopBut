//
//  VLDContextSheetItem.h
//
//  Created by Vladimir Angelov on 2/9/14.
//  Copyright (c) 2014 Vladimir Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VLDContextSheetItem;

@interface VLDContextSheetItemView : UIView

@property (strong, nonatomic) VLDContextSheetItem *item;
@property (readonly) BOOL isHighlighted;

- (void) setHighlighted: (BOOL) highlighted animated: (BOOL) animated;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
