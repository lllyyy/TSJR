//
//  UIView+RuiXue.m
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import "UIView+Category.h"
#import <objc/runtime.h>
static char tapIdx;

@implementation UIView (Category)
-(void)setX:(CGFloat)x{ CGRect frame = self.frame; frame.origin.x = x; self.frame = frame; }
-(CGFloat)x{ return self.frame.origin.x; }

-(void)setMaxX:(CGFloat)maxX{ self.x = maxX - self.width; }
-(CGFloat)maxX{ return CGRectGetMaxX(self.frame); }

-(void)setMaxY:(CGFloat)maxY{ self.y = maxY - self.height; }
-(CGFloat)maxY{ return CGRectGetMaxY(self.frame); }

-(void)setY:(CGFloat)y{ CGRect frame = self.frame; frame.origin.y = y; self.frame = frame; }
-(CGFloat)y{ return self.frame.origin.y; }

-(void)setCenterX:(CGFloat)centerX{ CGPoint center = self.center; center.x = centerX; self.center = center; }
-(CGFloat)centerX{ return self.center.x; }

-(void)setCenterY:(CGFloat)centerY{ CGPoint center = self.center; center.y = centerY; self.center = center; }
-(CGFloat)centerY{ return self.center.y; }

-(void)setWidth:(CGFloat)width{ CGRect frame = self.frame; frame.size.width = width; self.frame = frame; }
-(CGFloat)width{ return self.frame.size.width; }

-(void)setHeight:(CGFloat)height{ CGRect frame = self.frame; frame.size.height = height; self.frame = frame; }
-(CGFloat)height{ return self.frame.size.height; }

-(void)setSize:(CGSize)size{ CGRect frame = self.frame; frame.size = size; self.frame = frame; }
-(CGSize)size{ return self.frame.size; }

-(void)tapActionBlock:(void (^)(void))block{
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, &tapIdx);
    if (!tap) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        objc_setAssociatedObject(self, &tapIdx, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, &tapIdx, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded) {
        void(^action)(void) = objc_getAssociatedObject(self, &tapIdx);
        !action ? : action();
    }
}

-(void)longActionBlock:(void (^)(void))block{
    UILongPressGestureRecognizer *lon = objc_getAssociatedObject(self, &tapIdx);
    if (!lon) {
        lon = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
        [self addGestureRecognizer:lon];
        objc_setAssociatedObject(self, &tapIdx, lon, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, &tapIdx, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)longAction:(UILongPressGestureRecognizer *)lon{
    if (lon.state == UIGestureRecognizerStateBegan) {
        void(^action)(void) = objc_getAssociatedObject(self, &tapIdx);
        !action ? : action();
    }
}

@end
