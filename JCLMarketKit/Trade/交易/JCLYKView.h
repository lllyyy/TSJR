//
//  JCLYKView.h
//  JCLFutures
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLYKView : UIView<UITextFieldDelegate>

@property(nonatomic,strong)NSString *market;

@property(nonatomic,assign)NSInteger decimal;

@property(nonatomic,strong)NSString *code;

@property(nonatomic,strong)UIView *content_bg;

@property(nonatomic,strong)UIView *next_content;

@property(nonatomic,strong)UILabel *title;

@property(nonatomic,strong)UILabel *content_y;

@property(nonatomic,strong)UILabel *content_k;

@property(nonatomic,strong)UITextField *contentField_y;

@property(nonatomic,strong)UITextField *contentField_k;

@property(nonatomic,strong)UILabel *cancel;

@property(nonatomic,strong)UILabel *sure;

@property(nonatomic,strong)UIImageView *image_y;

@property(nonatomic,strong)UIImageView *image_k;

@property(nonatomic,assign)BOOL y_select;

@property(nonatomic,assign)BOOL k_select;

@property(nonatomic,copy)void(^block)(BOOL y_select,BOOL k_select,NSString *profitPrice,NSString *lossPrice);

-(void)showWindow;

-(void)updateStatus:(NSString *)y_price with:(NSString *)k_price;

@end
