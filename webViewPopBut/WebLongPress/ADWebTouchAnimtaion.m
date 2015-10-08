//
//  ADWebTouchAnimtaion.m
//  DZWebViewTouch
//
//  Created by dz on 15/7/23.
//  Copyright (c) 2015年 Andy Chen. All rights reserved.
//

#import "ADWebTouchAnimtaion.h"

@interface iBMarkView ()

@end
@implementation iBMarkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
          self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
    }
    return self;
}

- (void) drawRect: (CGRect) rect {
    CGRect a =  rect;
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:a cornerRadius:6.0f];
    //    [[UIColor colorWithWhite:0.8 alpha:0.5] setFill];
    [roundedRect fillWithBlendMode:kCGBlendModeClear alpha:1];
}

@end

@interface ADWebTouchAnimtaion ()
@property(nonatomic, strong)iBMarkView  *markView;
@property(nonatomic, strong)UIView      *middleView;
@property(nonatomic, strong)void(^completionBlock)(id);
@property(nonatomic, strong)UIControl *touchView;
@end

@implementation ADWebTouchAnimtaion
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view1 = [self creatShade];
        UIView *view2 = [self creatShade];
        UIView *view3 = [self creatShade];
        UIView *view4 = [self creatShade];
        _middleView = [UIView new];
        _middleView.backgroundColor = [UIColor clearColor];
        [self addSubview:_middleView];
        
        [self addSubview:_markView];
        _markView = [[iBMarkView alloc]initWithFrame:CGRectZero];
        [self addSubview:_markView];
        
        [self addSubview:view1];
        [self addSubview:view2];
        [self addSubview:view3];
        [self addSubview:view4];
        
        _touchView = [UIControl new];
        [self addSubview:_touchView];

        UIView *superview = self;
        [_touchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superview);
        }];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.and.right.equalTo(superview);
            make.bottom.equalTo(_middleView.mas_top);
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_markView);
            make.left.equalTo(superview.mas_left);
            make.right.equalTo(_middleView.mas_left);
        }];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_markView);
            make.left.equalTo(_middleView.mas_right);
            make.right.equalTo(superview.mas_right);
        }];
        [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(superview);
            make.top.equalTo(_middleView.mas_bottom);
        }];
        
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(superview);
            make.size.equalTo(CGSizeZero);
        }];
        
        [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_middleView);
        }];

        [_touchView addTarget:self action:@selector(dismissAction:)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(UIView *)creatShade{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    return view;
}

-(UIView *)creatCorner{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    return view;
}

- (void)dismissAction:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showAnimtaionInView:(UIView *)inView rect:(CGRect)frame
                             completionBlock:(void(^)(id rs))completionBlock
{
    if (inView) {
        ADWebTouchAnimtaion *control = [[ADWebTouchAnimtaion alloc] initWithFrame:inView.frame];
        control.completionBlock = completionBlock;
        [inView addSubview:control];
        
        control.alpha = 0;
        [control.middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(control.mas_left).offset(frame.origin.x );
            make.top.equalTo(control.mas_top).offset(frame.origin.y);
            make.size.equalTo(CGSizeZero);
        }];
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(inView);
        }];
        [control layoutIfNeeded];
        
        [control.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(frame.size);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            control.alpha = 1;
            [control layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completionBlock) {
                completionBlock(@1);
            }
        }];
    }
}

- (ADWebTouchAnimtaion *)showAnimtaionInView:(UIView *)inView
                                        rect:(CGRect)frame completionBlock:(void(^)(id rs))completionBlock{
    if (inView) {
        ADWebTouchAnimtaion *control = [[ADWebTouchAnimtaion alloc] initWithFrame:inView.frame];
        control.completionBlock = completionBlock;
        [inView addSubview:control];
        
        control.alpha = 0;
        [control.middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(control.mas_left).offset(frame.origin.x );
            make.top.equalTo(control.mas_top).offset(frame.origin.y);
            make.size.equalTo(CGSizeZero);
        }];
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(inView);
        }];
        [control layoutIfNeeded];
        
        [control.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(frame.size);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            control.alpha = 1;
            [control layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completionBlock) {
                completionBlock(@1);
            }
        }];
        return control;
    }
    return nil;
}
- (ADWebTouchAnimtaion *)showRectangleAnimtaionInView:(UIView *)inView
                                                 rect:(CGRect)frame completionBlock:(void(^)(id rs))completionBlock{
    if (inView) {
        ADWebTouchAnimtaion *control = [[ADWebTouchAnimtaion alloc] initWithFrame:inView.frame];
        control.completionBlock = completionBlock;
        control.markView.hidden = YES;
        [inView addSubview:control];
        
        control.alpha = 0;

        [control.middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(control.mas_left).offset(frame.origin.x );
            make.top.equalTo(control.mas_top).offset(frame.origin.y);
            make.size.equalTo(CGSizeZero);
        }];
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(inView);
        }];
        [control layoutIfNeeded];
        
        [control.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(frame.size);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            control.alpha = 1;
            [control layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completionBlock) {
                completionBlock(@1);
            }
        }];
        return control;
    }
    return nil;

}
@end
