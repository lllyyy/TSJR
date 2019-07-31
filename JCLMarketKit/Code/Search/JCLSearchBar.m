//
//  RXSearchBar.m
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import "JCLSearchBar.h"

@interface JCLSearchBar()
@property (nonatomic, strong) UIImageView *image;
@end

@implementation JCLSearchBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES; self.layer.cornerRadius = 14;
        self.layer.borderWidth = 0.6; self.layer.borderColor = JCL_Line_COL.CGColor;
        self.backgroundColor = JCLHexCol(@"#2E313A"); self.textColor = JCL_Text_COL;
        
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入框_搜索"]];
        self.image.width += 10;
        self.image.contentMode = UIViewContentModeCenter;
        self.leftView = self.image;
        self.leftViewMode = UITextFieldViewModeAlways;
        
//        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//        imageV.width += 24;
//        imageV.contentMode = UIViewContentModeCenter;
//        self.rightView = imageV;
//        self.rightViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UILabel *label = [self valueForKeyPath:@"_placeholderLabel"];
    label.textColor = JCLHexCol(@"#747674");
}
@end
