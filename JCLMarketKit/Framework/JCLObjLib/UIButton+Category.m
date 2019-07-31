//
//  UIButton+RuiXue.m
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)
-(void)setTitle:(NSString *)title{ [self setTitle:title forState:UIControlStateNormal]; }
-(NSString *)title{ return [self titleForState:UIControlStateNormal]; }

-(void)setSelectedTitle:(NSString *)selectedTitle{ [self setTitle:selectedTitle forState:UIControlStateSelected]; }
-(NSString *)selectedTitle{ return [self titleForState:UIControlStateSelected]; }

-(void)setColor:(UIColor *)color{ [self setTitleColor:color forState:UIControlStateNormal]; }
-(UIColor *)color{ return nil; }

-(void)setSelectedColor:(UIColor *)color{ [self setTitleColor:color forState:UIControlStateSelected]; }
-(UIColor *)selectedColor{ return nil; }

-(void)setImg:(NSString *)img{ [self setImage:[UIImage imageNamed:img] forState:UIControlStateNormal]; }
-(NSString *)img{ return nil; }

-(void)setSelectedImg:(NSString *)img{ [self setImage:[UIImage imageNamed:img] forState:UIControlStateSelected]; }
-(NSString *)selectedImg{ return nil; }

-(void)setHighlightedImg:(NSString *)img{ [self setImage:[UIImage imageNamed:img] forState:UIControlStateHighlighted]; }
-(NSString *)highlightedImg{ return nil; }

-(void)setDisabledImg:(NSString *)img{ [self setImage:[UIImage imageNamed:img] forState:UIControlStateDisabled]; }
-(NSString *)disabledImg{ return nil; }


@end
