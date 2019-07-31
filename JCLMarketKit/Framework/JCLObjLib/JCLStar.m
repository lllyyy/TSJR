//
//  JCLStar.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/24.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "JCLStar.h"

@interface JCLStar()
@property (nonatomic, strong) UIView *bg;
@property (nonatomic, assign) CGFloat number;
@end

@implementation JCLStar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        self.number = 5;
        [self InitImg:self img:@"star-empty"];

        self.bg = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.bg]; self.bg.clipsToBounds = YES;
        [self InitImg:self.bg img:@"star--full"];
    }
    return self;
}

-(void)InitImg:(UIView *)parent img:(NSString *)img{
    CGFloat w = self.frame.size.width/self.number;
    for (int i = 0; i < self.number; i++) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:img]];
        image.frame = CGRectMake(i*w, 0, w, self.frame.size.height);
        [image setContentMode:UIViewContentModeScaleToFill];
        [parent addSubview:image];
    }
}

#pragma mark- event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchAction:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchAction:event];
}

-(void)touchAction:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    [UIView animateWithDuration:0.1 animations:^{
        self.val = point.x/(self.frame.size.width/self.number);
        self.val = self.val<self.number ? self.val : self.number;
        self.val = self.val>0 ? self.val : 0;
        self.bg.frame = CGRectMake(0, 0, self.val/self.number*self.frame.size.width, self.frame.size.height);
    }];
}
@end
