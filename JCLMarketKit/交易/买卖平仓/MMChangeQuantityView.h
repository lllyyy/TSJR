//
//  MMChangeQuantityView.h
//  Doctor
//
//  Created by jian on 2017/5/13.
//  Copyright © 2017年 com.cti. All rights reserved.
//


@protocol MMChangeQuantityViewDelegate <NSObject>
@optional

- (void)buttonDidClick:(NSArray *) value;

@end

@interface MMChangeQuantityView : UIView
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) NSString *whichCell;
@property(nonatomic,strong) UIButton *leftButton;
@property(nonatomic,strong) UIButton *rightButton;
@property(nonatomic,assign) BOOL countB;
@property (nonatomic, weak) id <MMChangeQuantityViewDelegate> delegate;

- (void)setupPlaceholderColor:(NSString *)text;
@end
