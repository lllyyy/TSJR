//
//  MMChangeQuantityView.m
//  Doctor
//
//  Created by jian on 2017/5/13.
//  Copyright © 2017年 com.cti. All rights reserved.
//

#import "MMChangeQuantityView.h"
@interface MMChangeQuantityView ()


@end
@implementation MMChangeQuantityView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(0, 0, 40, 35);
        self.leftButton.backgroundColor = JCL_Bg_COL;
        self.leftButton.titleLabel.text = @"-";
//        [self.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(-2, 0, 0, 0) ];
        [ self.leftButton setTitle: @"-" forState:UIControlStateNormal];
       
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
     
//        self.leftButton.layer.cornerRadius = 10;
       // [self.leftButton setImage:[UIImage imageNamed:@"num_minus"] forState:0];
        [self addSubview:self.leftButton];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.leftButton.right + 10, 0, JCLWIDTH - 200, 30)];
        self.textField.font = [UIFont systemFontOfSize:15];
        self.textField.textAlignment = NSTextAlignmentCenter;
//        self.textField.layer.cornerRadius = 5;
        self.textField.textColor = [UIColor whiteColor];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
//       self.textField.backgroundColor = UIColorHex(f3f5f7);
        [self addSubview:self.textField];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.rightButton.layer.cornerRadius = 10;
        self.rightButton.backgroundColor = JCL_Bg_COL;
        [self.rightButton setTitleEdgeInsets:UIEdgeInsetsMake(-2, 0, 0, 0) ];
        [ self.rightButton setTitle: @"+" forState:UIControlStateNormal];
        
        self.rightButton.titleLabel.textColor = [UIColor whiteColor];
        self.rightButton.frame = CGRectMake( self.textField.right + 10, self.leftButton.top, 40, 35);
      //  [self.rightButton setImage:[UIImage imageNamed:@"num_plus"] forState:0];
        [self addSubview:self.rightButton];
        
        __weak typeof(self) _self = self;
        
        [self.leftButton addBlockForControlEvents:UIControlEventTouchUpInside
                                            block:^(UIButton *sender) {
                                                if( [_self stringIsNumeric: _self.textField.text]  ) {
                                                    
                                                    if (_self.countB) {
                                                        int num  = _self.textField.text.intValue;
                                                        if (num > 0) {
                                                            num -= 1;
                                                            _self.textField.text = [NSString stringWithFormat:@"%d", num];
                                                            
                                                            if ([_self.delegate respondsToSelector:@selector(buttonDidClick:)]) {
                                                                [_self.delegate buttonDidClick:@[_self.textField.text,_self.whichCell]];
                                                            }
                                                            
                                                        }
                                                    }else{
                                                        CGFloat num  = _self.textField.text.floatValue;
                                                        if (num > 0) {
                                                            num -= 0.01;
                                                            _self.textField.text = [NSString stringWithFormat:@"%.2f", num];
                                                            
                                                            if ([_self.delegate respondsToSelector:@selector(buttonDidClick:)]) {
                                                                [_self.delegate buttonDidClick:@[_self.textField.text,_self.whichCell]];
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                             }];
        
        [self.rightButton addBlockForControlEvents:UIControlEventTouchUpInside
                                             block:^(UIButton *sender) {
                                                 if( [_self stringIsNumeric: _self.textField.text]  ) {
                                                     
                                                     if (_self.countB) {
                                                         int num  = _self.textField.text.intValue;
                                                         if (num >= 0) {
                                                            num += 1;
                                                             _self.textField.text = [NSString stringWithFormat:@"%d", num];
                                                             
                                                             if ([_self.delegate respondsToSelector:@selector(buttonDidClick:)]) {
                                                                 [_self.delegate buttonDidClick:@[_self.textField.text,_self.whichCell]];
                                                             }
                                                             
                                                         }
                                                     }else{
                                                         
                                                         CGFloat num  = _self.textField.text.floatValue;
                                                         num += 0.01;
                                                         _self.textField.text = [NSString stringWithFormat:@"%.2f", num];
                                                         
                                                         if ([_self.delegate respondsToSelector:@selector(buttonDidClick:)]) {
                                                             [_self.delegate buttonDidClick:@[_self.textField.text,_self.whichCell]];
                                                         }
                                                     }
                                                 }
                                             }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
 
- (BOOL) stringIsNumeric:(NSString *) str {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:str];
   // NSLog(@"str%@", number);
    return !!number; // If the string is not numeric, number will be nil
}

- (void)setupPlaceholderColor:(NSString *)text{
    UIColor *color = TitleCColor;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color}];
    self.textField.attributedPlaceholder = attrString;
}

@end
