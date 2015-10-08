//
//  VLDContextSheetItem.m
//
//  Created by Vladimir Angelov on 2/10/14.
//  Copyright (c) 2014 Vladimir Angelov. All rights reserved.
//

#import "VLDContextSheetItem.h"

@implementation VLDContextSheetItem

- (id) initWithTitle:(NSString *)title
               image:(UIImage *)image
    highlightedImage:(UIImage *)highlightedImage {
    
    self = [super init];
    
    if(self) {
        _title = title;
        _image = image;
        _highlightedImage = highlightedImage;
        _enabled = YES;
    }
    
    return self;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
