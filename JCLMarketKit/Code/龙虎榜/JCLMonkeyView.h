//
//  JCLMonkeyView.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMonkeyView : UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;
- (void)start;//开始跑马
- (void)stop;//停止跑马
@end
