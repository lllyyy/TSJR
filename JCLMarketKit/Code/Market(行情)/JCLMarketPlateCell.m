//
//  JCLMarketPlateCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketPlateCell.h"
#import "JCLMarketInfo.h"
#import "JCLMarketObj.h"

@interface JCLMarketPlateCell()
@property (nonatomic, weak) UIView *line;
@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation JCLMarketPlateCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"MarketPlateCell";
    JCLMarketPlateCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLMarketPlateCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.line = [JCLKitObj JCLView:self color:JCLMAINRGB];
    }
    return self;
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    if (!self.arrM.count) {
        [arr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JCLMarketInfo *info = [[JCLMarketInfo alloc]init]; [self addSubview:info];
            info.title.text = obj[0];  info.code.text = obj[1];
            if(obj.count>3){
            info.range.text = obj[2];  info.scale.text = obj[3];
            }
            info.code.textColor = [JCLMarketObj JCLMarketColor:info.code.text close:@"0"];
            info.scale.textColor = [JCLMarketObj JCLMarketColor:info.scale.text close:@"0"];
            [self.arrM addObject:info];
        }];
        
        NSArray *arr = self.arrM;
        CGFloat w = self.width/arr.count;
        [arr enumerateObjectsUsingBlock:^(JCLMarketInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(w*idx, 0, w, self.height);
            obj.tapActionBlock = ^(){ !self.tapActionBlock ? : self.tapActionBlock(idx); };
        }];
    }
    
    [self.arrM enumerateObjectsUsingBlock:^(JCLMarketInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *array=arr[idx];
        obj.title.text = array[0];  obj.code.text = array[1];
        
        if(array.count>3)
        {
        obj.range.text = arr[idx][2];  obj.scale.text = arr[idx][3];
        }
        obj.code.textColor = [JCLMarketObj JCLMarketColor:obj.code.text close:@"0"];
        obj.scale.textColor = [JCLMarketObj JCLMarketColor:obj.scale.text close:@"0"];
    }];
}
@end
