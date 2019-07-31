//
//  JCLTableInputCell.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLUserInputCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table;
@property (nonatomic, assign) BOOL isMore;

@property (nonatomic, weak) UITextField *field;
@property (nonatomic, weak) JSTextView *text;
@end
