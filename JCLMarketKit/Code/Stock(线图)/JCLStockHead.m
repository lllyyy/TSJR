//
//  StockTableHeader.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockHead.h"

@implementation JCLStockHead
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCLRGBA(236, 237, 238, 1);
        self.title = [JCLKitObj JCLLable:self font:14 color:nil alignment:0];
        self.date = [JCLKitObj JCLLable:self font:14 color:nil alignment:2];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat s = 10;
    self.title.frame = CGRectMake(s, 0, self.width, self.height);
    self.date.frame = CGRectMake(0, 0, self.width - s, self.height);
}
@end
