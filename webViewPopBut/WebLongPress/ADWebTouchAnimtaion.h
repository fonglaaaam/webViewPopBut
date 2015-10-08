//
//  ADWebTouchAnimtaion.h
//  DZWebViewTouch
//
//  Created by dz on 15/7/23.
//  Copyright (c) 2015年 Andy Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface iBMarkView : UIView

@end

@interface ADWebTouchAnimtaion : UIView
+ (void)showAnimtaionInView:(UIView *)inView
                       rect:(CGRect)frame completionBlock:(void(^)(id rs))completionBlock;
//非阴影透明区有圆角
- (ADWebTouchAnimtaion *)showAnimtaionInView:(UIView *)inView
                                        rect:(CGRect)frame completionBlock:(void(^)(id rs))completionBlock;
//非阴影透明区矩形
- (ADWebTouchAnimtaion *)showRectangleAnimtaionInView:(UIView *)inView
                                        rect:(CGRect)frame completionBlock:(void(^)(id rs))completionBlock;
- (void)dismissAction:(id)sender;
@end
