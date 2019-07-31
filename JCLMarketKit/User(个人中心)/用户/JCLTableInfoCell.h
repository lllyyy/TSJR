//
//  JCLTableInfoCell.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTableInfoCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table;
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UITextField *text;

@property (nonatomic, copy) void (^valActionBlock)(NSString *text);
@property (nonatomic, copy) void (^actionBlock)();
@property (nonatomic, assign) BOOL isPhone;
@property (nonatomic, weak) UIImageView *phone;

@property (nonatomic, assign) BOOL isRight;

@property (nonatomic, weak) UILabel *unit;

@property (nonatomic, assign) CGFloat lineH;
@property (nonatomic, weak) UIButton *submit;
@property (nonatomic, weak) UIButton *code;
-(void)codeAction;
@end

