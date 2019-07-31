//
//  JCLBarList.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/7.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLBarList.h"
#import "JCLBarModel.h"

@interface JCLBarList()
@property(nonatomic, weak) UIView *bg;

@property(nonatomic, strong) NSMutableArray *subs;
@property(nonatomic, weak) JCLBarModel*select;
@property(nonatomic, weak) UIView *line;
@end

@implementation JCLBarList
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.line = [JCLKitObj JCLView:self.bg color:JCL_SelText_COL];
    }
    return self;
}

-(NSMutableArray *)subs{ if (_subs) return _subs; return _subs = [[NSMutableArray alloc]init]; }
-(void)setVals:(NSArray *)vals{
    _vals = vals;
    [vals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JCLBarModel *model = [[JCLBarModel alloc]init]; [self.bg addSubview:model];  model.tag = idx;
        if (self.icons.count) {
            model.isIcon = YES;
            model.icon.image = [UIImage imageNamed:self.icons[idx]];
        }
        model.val.text = obj;
        [self.subs addObject:model];
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH = 1.4, y = self.isBar ? lineH : 0;
    self.bg.frame = CGRectMake(0, y, self.width, self.height-lineH);

    CGFloat w = self.width/self.vals.count;
    CGFloat lineW = 2*[JCLKitObj JCLTextSize:@"4444" font:[JCLKitObj JCLFont:14]].width;
    [self.subs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JCLBarModel *model = (JCLBarModel *)obj;
        if (self.icons.count) {
            model.frame = CGRectMake(w*idx, 0, w, self.bg.height);
            // 有中间的参考
//            if (idx == 2) {
//                CGFloat y = 4, wh = self.bg.height-2*y;
//                model.frame = CGRectMake(w*idx+0.5*(w-wh), y, wh, wh); model.layer.cornerRadius = 0.5*wh;
//                model.backgroundColor = JCL_SelText_COL; model.val.textColor = [HQColorObj HQBgCol];
//            }
        } else {
            model.val.font = [JCLKitObj JCLFont:14];
            model.frame = CGRectMake(w*idx, 0, w, self.bg.height);
        }
                
        if (!self.isAction) {
            if (idx == self.idx) {
                model.val.textColor = JCL_SelText_COL;
                model.icon.image = [UIImage imageNamed:self.icons[idx]];
                self.select.icon.image = [UIImage imageNamed:self.hisIcons[idx]];
                self.select = model; !self.actionBlock ? : self.actionBlock(idx);
                if (!self.icons) {
                    self.line.frame = CGRectMake(w*idx+0.5*(w-lineW), self.height-lineH, lineW, lineH);
                }
            }
            
            [model tapActionBlock:^{
//                if (self.select.tag != 2) {
                    self.select.val.textColor = JCL_Text_COL ;
                    self.select.icon.image = [UIImage imageNamed:self.icons[self.select.tag]];
//                }
//                if (idx != 2) {
                if (self.idx != 44) {
                    model.val.textColor = JCL_SelText_COL;
                    model.icon.image = [UIImage imageNamed:self.hisIcons[idx]];
                }
//                }
                self.select = model; !self.actionBlock ? : self.actionBlock(idx);
                if (!self.icons) {
                    self.line.frame = CGRectMake(w*idx+0.5*(w-lineW), self.height-lineH, lineW, lineH);
                }
            }];
        }
    }];
}
@end
