//
//  JSTextView.h
//  Doctor
//
//  Created by jian on 2017/5/15.
//  Copyright © 2017年 com.cti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSTextView : UITextView

@property(nonatomic,copy) NSString *myPlaceholder;  //文字
@property (nonatomic,weak) UILabel *placeholderLabel;
@property(nonatomic,strong) UIColor *myPlaceholderColor; //文字颜色

@end
