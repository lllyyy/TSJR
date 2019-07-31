//
//  JCLPopCollectCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/23.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLPopCollectCell.h"

@implementation JCLPopCollectCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.text = [JCLKitObj JCLLable:self font:12 color:[UIColor orangeColor] alignment:1];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.text.frame = self.bounds;
}
@end
