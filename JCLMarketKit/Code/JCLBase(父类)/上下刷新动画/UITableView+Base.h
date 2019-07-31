//
//  UITableView+Extension.h
//  常用类的封装
//
//  Created by 刘虎超 on 2017/6/7.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Base)
//带动画的refresh
-(void)JCLHeaderGifBlock:(void (^)(void))block;
-(void)JCLFooterGifBlock:(void (^)(void))block;

//不带动画的refresh
-(void)JCLHeaderBlock:(void (^)(void))block;
-(void)JCLFooterBlock:(void (^)(void))block;
@end
