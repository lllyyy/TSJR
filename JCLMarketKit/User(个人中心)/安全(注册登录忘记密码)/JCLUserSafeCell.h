//
//  JCLUserCell.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLUserSafeCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table;
@property (nonatomic, weak) UITextField *text;
@property (nonatomic, weak) UIButton *code;
@property (nonatomic, assign) BOOL isCode;
@property (nonatomic, copy) void (^valActionBlock)(NSString *val);
-(void)codeAction;
@end
