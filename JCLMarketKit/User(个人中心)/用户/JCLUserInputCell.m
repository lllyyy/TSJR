//
//  JCLTableInputCell.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserInputCell.h"

@implementation JCLUserInputCell
+(instancetype)cellWithTable:(UITableView *)table{
    static NSString *ID = @"cell";
    JCLUserInputCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLUserInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        self.field = [JCLKitObj JCLField:self font:14 color:JCL_Text_COL delegate:self];
        self.text = [JCLKitObj JCLText:self font:14 color:JCL_Text_COL];
        self.text.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 10;
    if (self.isMore) {
        self.text.frame = CGRectMake(x, 0, self.width-2*x, self.height);
    } else {
        self.field.frame = CGRectMake(x, 0, self.width-2*x, self.height);
    }
    UILabel *label = [self.field valueForKeyPath:@"_placeholderLabel"];
    label.textColor = JCLHexCol(@"#646564");
}
@end
