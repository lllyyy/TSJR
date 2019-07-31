//
//  JCLContestHeader.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/23.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLTradMenu.h"

@interface JCLTradMenu()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, assign) BOOL isHave;
@end

@implementation JCLTradMenu
- (instancetype)init{
    if(self=[super init]){
        self.backgroundColor = JCL_Line_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-1.4);
    
    if (self.texts.count && !self.isHave) {
        CGFloat w = (self.width-(self.texts.count-1)*1)/self.texts.count, h = self.bg.height;
        CGFloat lineW = 1, lineH = 0.6*h, lineY = 0.5*(h-lineH);
        [self.texts enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [JCLKitObj JCLLable:self.bg font:13 color:JCL_Text_COL alignment:1];
            info.text = obj;
            info.frame=CGRectMake(idx*w, 0, w, h);
            if (idx > 0) {
                UIView *line = [JCLKitObj JCLView:self.bg color:JCL_Line_COL];
                line.frame = CGRectMake(idx*w+lineW, lineY, lineW, lineH);
            }
        }];
        self.isHave = YES;
    }
}
@end
