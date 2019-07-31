//
//  LDYSelectivityAlertView.m
//  LDYSelectivityAlertView
//
//  Created by 李东阳 on 2018/8/15.
//



#import "TSJRYSelectivityAlertView.h"
#import "JCLBaseTableViewCell.h"
 

@interface TSJRYSelectivityAlertView () {
    float alertViewHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}

@property (nonatomic, strong) NSArray *datas;//数据源
@property (nonatomic, assign) BOOL ifSupportMultiple;//是否支持多选功能
@property (nonatomic, strong) UILabel *titleLabel;//标题label
@property (nonatomic, strong) UILabel *submitLabel;//标题label
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic, strong) UIButton *confirmButton;//确定按钮
@property (nonatomic, strong) UIButton *cancelButton;//取消按钮

@property (nonatomic, assign) NSIndexPath *selectIndexPath;//选择项的下标(单选)
@property (nonatomic, strong) NSMutableArray *selectArray;//选择项的下标数组(多选)


@end

@implementation TSJRYSelectivityAlertView

-(instancetype)initWithTitle:(NSString *)title
                       datas:(NSArray *)datas
           ifSupportMultiple:(BOOL)ifSupportMultiple{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertViewHeight = datas.count * 30+80 + 80;
        buttonHeight = 40;
        self.selectArray = [NSMutableArray array];
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(30, (JCLHEIGHT-alertViewHeight)/2.0, JCLWIDTH-60, alertViewHeight)];
        self.alertView.backgroundColor = ViewBG;
        self.alertView.alpha = 0.6;
        self.alertView.layer.cornerRadius = 8;
        self.alertView.layer.masksToBounds = YES;
        [self addSubview:self.alertView];

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.alertView.frame.size.width, 20)];
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:self.titleLabel];
        
        self.submitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom, self.alertView.frame.size.width, 20)];
        self.submitLabel.text = @"T+0剩余次数 无限次";
        self.submitLabel.textColor = JCLAccountRGB;
        self.submitLabel.font = [UIFont systemFontOfSize:12];
        self.submitLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:self.submitLabel];
         
        self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.submitLabel.bottom, JCLWIDTH-60, self.alertView.bounds.size.height-buttonHeight*2-10-10) style:UITableViewStylePlain];
        self.selectTableView.scrollEnabled = NO;
        self.selectTableView.delegate = self;
        self.selectTableView.dataSource = self;
        self.selectTableView.showsVerticalScrollIndicator =NO;
        self.selectTableView.showsHorizontalScrollIndicator =NO;
        self.selectTableView.backgroundColor = [UIColor clearColor];
        self.selectTableView.backgroundView.backgroundColor = [UIColor clearColor];
        self.datas = datas;
        self.selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.ifSupportMultiple = ifSupportMultiple;
        [self.alertView addSubview:self.selectTableView];
        
        if (self.ifSupportMultiple == YES){
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [self.selectTableView addGestureRecognizer:tap];
            [tap addTarget:self action:@selector(clickTableView:)];
        }
        
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.frame = CGRectMake(15,CGRectGetMaxY(self.selectTableView.frame), (self.alertView.frame.size.width-45)/2, buttonHeight); CGRectMake(CGRectGetMaxX(self.confirmButton.frame),CGRectGetMaxY(self.selectTableView.frame), self.alertView.frame.size.width/2, buttonHeight);
        self.cancelButton.layer.cornerRadius = 5;
        self.cancelButton.layer.masksToBounds = YES;
        self.cancelButton.backgroundColor = [UIColor whiteColor];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor  redColor] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font =[UIFont systemFontOfSize:16];
        [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.cancelButton];
        
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.frame = CGRectMake(self.cancelButton.right+15,CGRectGetMaxY(self.selectTableView.frame), (self.alertView.frame.size.width-45)/2, buttonHeight);
        self.confirmButton.backgroundColor = JCLRGB(197, 171, 112);
        self.confirmButton.layer.cornerRadius = 5;
        self.confirmButton.layer.masksToBounds = YES;
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.confirmButton];
        
    }
    return self;
}

-(void)show{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

//手势事件
- (void)clickTableView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.selectTableView];
    NSIndexPath *indexPath = [self.selectTableView indexPathForRowAtPoint:point];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.selectArray containsObject:@(indexPath.row)]) {
        [self.selectArray removeObject:@(indexPath.row)];
    }else {
        [self.selectArray addObject:@(indexPath.row)];
    }
    
    //按照数据源下标顺序排列
    [self.selectArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [self.selectTableView reloadData];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    JCLBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[JCLBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = ViewBG;
    cell.textLabel.textColor = JCLAccountRGB;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = TitleAColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = _datas[indexPath.row];
    NSLog(@"--===== %@",self.detailArray);
   cell.detailTextLabel.text = self.detailArray[indexPath.row];
     return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   return 50;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 50)];
    bgview.backgroundColor = ViewBG;
    UILabel *footView = [[UILabel alloc]initWithFrame:CGRectMake(15, 0,self.alertView.frame.size.width-30, 50)];
    footView.text = @"在进行交易之前，敬请阅读我们网站上的相关风险透露声明，点击提交订单代表您已阅读和了解交易过程中的信息";
    footView.textColor =JCLAccountRGB;
    footView.font = [UIFont systemFontOfSize:12];
    footView.numberOfLines = 0;
    [bgview addSubview:footView];
    return bgview;
    
};
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    LDYSelectivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDYSelectivityTableViewCell"];
//    if (self.ifSupportMultiple == NO) {
//        self.selectIndexPath = indexPath;
//        [tableView reloadData];
//    }else{
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//点击空白处
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self cancelAction];
    }
}

//点击确定
- (void)confirmAction{
    if (self.ifSupportMultiple == NO) {
        NSString *data = self.datas[self.selectIndexPath.row];
        if (_delegate && [_delegate respondsToSelector:@selector(singleChoiceBlockData:)])
        {
            [_delegate singleChoiceBlockData:data];
        }
    }else{
        NSMutableArray *dataAr = [NSMutableArray array];
        [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *data = obj;
            int row = [data intValue];
            [dataAr addObject:self.datas[row]];
        }];

        NSArray *datas = [NSArray arrayWithArray:dataAr];
        if (_delegate && [_delegate respondsToSelector:@selector(multipleChoiceBlockDatas:)])
        {
            [_delegate multipleChoiceBlockDatas:datas];
        }
    }
    [self cancelAction];
}

//点击取消
- (void)cancelAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
