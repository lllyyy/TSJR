//
//  CHDDropDownMenu.m
//  CHDDropDownMenu
//
//  Created by CHD on 15/11/16.
//  Copyright © 2015年 CHD. All rights reserved.
//
#import "CHDDropDownMenu.h"
#define CHD_JCLWIDTH ([[UIScreen mainScreen] bounds].size.width)
#define CHD_JCLHEIGHT ([[UIScreen mainScreen] bounds].size.height)


@implementation chdButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat W=[LHCObject LHCSize:self.title font:[LHCObject LHCFont:14]].width;
    if([self.title isEqualToString:@"主力净流入"] || [self.title  isEqualToString:@"主力净流出"])
    {
         return CGRectMake(W+5,(CGRectGetHeight(contentRect) - 7)/2, 12, 7);
    }else{
         return CGRectMake(30+W,(CGRectGetHeight(contentRect) - 7)/2, 12, 7);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat W=[LHCObject LHCSize:self.title font:[LHCObject LHCFont:14]].width;
    
    if([self.title isEqualToString:@"主力净流入"] || [self.title  isEqualToString:@"主力净流出"])
    {
        return CGRectMake(0, 0, W, CGRectGetHeight(contentRect));
    }else{
        return CGRectMake(25, 0, W, CGRectGetHeight(contentRect));
    }
}
@end

@implementation chdModel

@end


@implementation chdMenuCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CHD_JCLWIDTH, [LHCObject height:40])];
        [self.contentView addSubview:_bgView];
        
        self.point = [[UIView alloc] initWithFrame:CGRectMake(10, ([LHCObject height:40] - 3)/2.0, 3, 3)];
        self.point.layer.masksToBounds = YES;
        self.point.layer.cornerRadius = 1.5;
        [self.bgView addSubview:_point];
        
        self.textL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_point.frame)+35, 0,JCLWIDTH-CGRectGetMaxX(_point.frame)-66, [LHCObject height:40])];
        self.textL.font = [UIFont systemFontOfSize:[LHCObject LHCFont:14]];
        [self.bgView addSubview:_textL];
        
        
        self.img=[LHCObject LHCImage:self.bgView Image:@"xuanzhong"];
        self.img.frame=CGRectMake(20, 0, 25, 25);
        self.img.centerY=[LHCObject height:40]/2;
        self.img.hidden=YES;
        
    }
    return self;
}

@end

@implementation CHDDropDownMenu
{
    UITableView *ChdTable;
    NSInteger currentSelect;
    CGRect orginalFrame;
    BOOL isShow;
    UIView *bgView;
    
    UIButton *_selcted;
}

- (void)initWithFrame:(CGRect)frame showOnView:(UIView*)view AllDataArr:(NSMutableArray*)arr showArr:(NSMutableArray *)showArr
{
    if ([super initWithFrame:frame]) {
        self.AllDataArr = arr;
        self.showArr = showArr;
        if (showArr.count) {
            self.showArr = arr;
        }
        self.frame=frame;
        for (int i=0; i<arr.count; i++) {
            NSArray *temp = self.showArr[i];
            chdModel *model = [temp firstObject];
            
            chdButton *button = [[chdButton alloc] initWithFrame:CGRectMake(i*(CGRectGetWidth(frame)/arr.count), 0, CGRectGetWidth(frame)/arr.count, CGRectGetHeight(frame))];
            if(self.isStock==YES)
            {
                if([model.text isEqualToString:@"主力净流入"] || [model.text  isEqualToString:@"主力净流出"])
                {
                    button.x=0.5*JCLWIDTH-30;
                }
                
                if([model.text isEqualToString:@"前30"] || [model.text  isEqualToString:@"前20"]|| [model.text  isEqualToString:@"前10"])
                {
                
                    if(iPhone5){
                        button.x+=20;
                    }else{
                         button.x+=35;
                    }
                }
                
                if([model.text isEqualToString:@"今日"] || [model.text  isEqualToString:@"3日"]|| [model.text  isEqualToString:@"5日"])
                {
                    if(iPhone5){
                        button.x-=5;
                    }else{
                        button.x+=10;
                    }
                }
            }
            button.tag = 100 + i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:model.text forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.backgroundColor = [UIColor whiteColor];
            [button setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:button];
            button.titleLabel.font=[UIFont systemFontOfSize:[LHCObject LHCFont:14]];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [view addSubview:self];
            
            //
            currentSelect = 0;
            [self selectClum:i Row:0];
            
        }
        
        ChdTable = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), CHD_JCLWIDTH, CHD_JCLHEIGHT - CGRectGetMaxY(self.frame))];
        orginalFrame = CGRectMake(0, CGRectGetMaxY(frame), CHD_JCLWIDTH, 0);
        ChdTable.delegate = self;
        ChdTable.dataSource = self;
        ChdTable.hidden = YES;
        //ChdTable.backgroundColor = [UIColor redColor];
        
        bgView = [[UIView alloc] initWithFrame:orginalFrame];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(bgViewClick:)];
        [bgView addGestureRecognizer:tap];
        bgView.backgroundColor=[UIColor darkGrayColor];
        bgView.alpha=0.4;
        [view addSubview:bgView];
        
        if ([ ChdTable respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [ChdTable   setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        if ([ChdTable respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [ChdTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        
        [view addSubview:ChdTable];
        self.backgroundColor=[UIColor whiteColor];
    }
    
}
- (void)bgViewClick:(UITapGestureRecognizer*)tap
{
    [self hideCurrent];
    bgView.frame = orginalFrame;
}
- (void)selectClum:(NSInteger)colum Row:(NSInteger)row
{
    //默认选中第一个
    NSArray *temp = self.AllDataArr[colum];
    for (int i=0; i<temp.count; i++) {
        chdModel *model = temp[i];
        if (i == row) {
            model.isSelect = YES;
        }else{
            model.isSelect = NO;
        }
    }
    //[ChdTable reloadData];
    
    NSArray *arr = self.subviews;
    chdButton *btn = (chdButton*)arr[colum];
    chdModel *model = self.showArr[colum][row];
    [btn setTitle:model.text forState:UIControlStateNormal];
}

- (void)buttonClick:(chdButton*)button
{
    _selcted.selected = NO;
    button.selected   = YES;
    _selcted          = button;
    if (button.tag - 100 == currentSelect) {
        if (isShow) {
            [self hideCurrent];
        }else{
            [self showIndex:button.tag - 100];
        }
        isShow = !isShow;
    }else{
        [self showIndex:button.tag - 100];
        isShow = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_AllDataArr[currentSelect] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *chdResuseID = @"CHD_RESUSE";
    
    chdMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:chdResuseID];
    
    if (cell == nil) {
        cell = [[chdMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chdResuseID];
    }
    cell.textL.textAlignment=NSTextAlignmentLeft;
    chdModel * model = [_AllDataArr[currentSelect] objectAtIndex:indexPath.row];
    cell.textL.text = model.text;
    if (model.isSub) {
        cell.bgView.mj_x = 25;
    }else{
        cell.bgView.mj_x = 0;
    }
    cell.img.x=20;
    cell.textL.x=50;
    
    if(self.isStock)
    {
        if([cell.textL.text isEqualToString:@"主力净流入"] || [cell.textL.text isEqualToString:@"主力净流出"] ){
        cell.img.x=0.5*JCLWIDTH-40;
        cell.textL.x=0.5*JCLWIDTH-10;
        }
        if([cell.textL.text isEqualToString:@"前10"] || [cell.textL.text isEqualToString:@"前20"] || [cell.textL.text isEqualToString:@"前30"] )
        {
            cell.textL.textAlignment=NSTextAlignmentRight;
            cell.img.x=JCLWIDTH-95;
        }

        
    }else{
    if([cell.textL.text isEqualToString:@"主力净流入"] || [cell.textL.text isEqualToString:@"主力净流出"] ){
        cell.img.x=0.2*JCLWIDTH+10;
        cell.textL.x=0.2*JCLWIDTH+40;
    }
    
    if([cell.textL.text isEqualToString:@"地区"]  || [cell.textL.text isEqualToString:@"行业"]|| [cell.textL.text isEqualToString:@"概念"])
    {
        cell.img.x=0.5*JCLWIDTH+20;
        cell.textL.x=0.5*JCLWIDTH+50;
    }
    
    if([cell.textL.text isEqualToString:@"前10"] || [cell.textL.text isEqualToString:@"前20"] || [cell.textL.text isEqualToString:@"前30"] )
    {
        cell.textL.textAlignment=NSTextAlignmentRight;
        cell.img.x=JCLWIDTH-95;
    }}
    
    
    if (model.isSelect) {
        cell.textL.textColor = [UIColor redColor];
        cell.img.hidden=NO;
    }else{
        cell.textL.textColor = [UIColor blackColor];
        cell.img.hidden=YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LHCObject height:40];
}
- (void)showIndex:(NSInteger)index
{
    
    if (currentSelect != index) {
        chdButton *btn = self.subviews[currentSelect];
        [UIView animateWithDuration:0.2 animations:^{
            btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    
    currentSelect = index;
    [self realShow];
    
}
- (void)realShow
{
    
    
    ChdTable.hidden = YES;
    ChdTable.mj_h = [LHCObject height:40] * [_AllDataArr[currentSelect] count];
    [ChdTable reloadData];
    
    bgView.mj_h = CHD_JCLHEIGHT - CGRectGetMaxY(self.frame);
    
    ChdTable.frame = orginalFrame;
    ChdTable.hidden = NO;
    
    chdButton *btn = self.subviews[currentSelect];
    
    [UIView animateWithDuration:0.2 animations:^{
        if ([LHCObject height:40] * [_AllDataArr[currentSelect] count]>CHD_JCLHEIGHT-CGRectGetMaxY(self.frame)) {
            ChdTable.mj_h = CHD_JCLHEIGHT - CGRectGetMaxY(self.frame);
        }else{
        ChdTable.mj_h = [LHCObject height:40] * [_AllDataArr[currentSelect] count];
        }
        btn.imageView.transform = CGAffineTransformMakeRotation(0);
    }];
}
- (void)hideCurrent
{
    chdButton *btn = self.subviews[currentSelect];
    [UIView animateWithDuration:0.2 animations:^{
        ChdTable.frame = orginalFrame;
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    bgView.frame = orginalFrame;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _selcted.selected=NO;
    //*************  本段代码用于选择相同选项时不在回调，不需要可注掉  ****************
    chdModel *modelLast = self.AllDataArr[currentSelect][indexPath.row];
    if (modelLast.isSelect) {
        [self hideCurrent];
        isShow = NO;
        
        return;
    }
    //*************  本段代码用于选择相同选项时不在回调，不需要可注掉  ****************
    
    
    
    [self selectClum:currentSelect Row:indexPath.row];
    [self hideCurrent];
    isShow = NO;
    chdModel *model = self.AllDataArr[currentSelect][indexPath.row];
//    if ([self.delegate respondsToSelector:@selector(selectClum:Row:)]) {
        [self.delegate selectColum:currentSelect Row:indexPath.row Model:model];
//    }
    NSLog(@"%@",model.text);
    
}
@end
