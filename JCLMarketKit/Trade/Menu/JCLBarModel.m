//
//  JCLBar.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/7.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLBarModel.h"

@interface JCLBarModel()
@property(nonatomic, weak) UIView *bg;
@end

@implementation JCLBarModel
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = [UIColor clearColor];
        self.bg = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
        self.icon = [JCLKitObj JCLImage:self];
        self.val = [JCLKitObj JCLLable:self font:12 color:JCL_Text_COL alignment:1];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.isIcon) {
        CGSize size = [JCLKitObj JCLTextSize:@"4444" font:self.val.font];
        CGFloat wh = 2*size.height , y = 0.5*(self.height-(wh+size.height+4));
        self.icon.frame = CGRectMake(0.5*(self.width-wh), y, wh, wh);
        self.val.frame = CGRectMake(0, self.icon.maxY+4, self.width, size.height);
    } else {
        self.val.frame = self.bounds;
    }
}
@end
