//
//  LHCObject.m
//  常用类的封装
//
//  Created by 刘虎超 on 2017/2/15.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "LHCObject.h"

#pragma mark ---- UIDevice
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
@implementation LHCObject

#pragma mark ---- CGSize
//字体适配
+ (CGFloat)LHCFont:(CGFloat)size{
    if (iPhone6) { size = size;
    } else if(iPhone5){ size = size - 1;
    } else if(iPhone6Plus){ size = size + 1;}
    return size;
}

+ (CGSize)LHCSize:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}



//获取字符串高度
+ (CGSize)LHCSize:(NSString *)text font:(CGFloat)fontSize{
    return [self LHCSize:text font:[UIFont systemFontOfSize:fontSize] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}
+ (CGFloat)height:(CGFloat)height
{
    if(iPhone6){
        height=height;
    }else if(iPhone5){height=height-3;}
    
    return height;
}

#pragma mark ---- UIKit
+ (UITableView *)LHCTable:(UIView *)parentView target:(id)target frame:(CGRect)frame style:(UITableViewStyle)style
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.showsVerticalScrollIndicator=NO;
    [parentView addSubview:tableView];
    tableView.dataSource = target;
    tableView.delegate = target;
    tableView.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}
//初始化按钮
+ (UIButton *)LHCButton:(UIView *)parentView Img:(NSString *)img Title:(NSString *)title backgroundColor:(UIColor *)backgroundColor Target:(id)target Action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [parentView addSubview:btn];
//    btn.frame=frame;
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",img]] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor=backgroundColor;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIView *)LHCView:(UIView *)parnetView backgroundColor:(UIColor *)backgroundColor
{
    UIView *view=[[UIView alloc]init];
    [parnetView addSubview:view];
    view.backgroundColor=backgroundColor;
    return view;
}

+ (UILabel *)LHCLable:(UIView *)parentView  size:(CGFloat)size Textcolor:(UIColor *)color alignment:(NSInteger)alignment text:(NSString *)text
{
    UILabel *label=[[UILabel alloc]init];
    [parentView addSubview:label];
    label.textColor=color;
    label.text=text;
    label.font = [UIFont fontWithName:@"Zapf Dingbats" size:[self LHCFont:size]];
    label.textAlignment = alignment;
    label.numberOfLines = 0;
    label.layer.masksToBounds = YES;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    return label;
}

+ (UIImageView *)LHCImage:(UIView *)parnetView Image:(NSString *)image
{
    UIImageView *img=[[UIImageView alloc]init];
    [parnetView addSubview:img];
    img.image=[UIImage imageNamed:image];
    return img;
}

+ (UITextField *)LHCField:(UIView *)parnetView   BorderColor:(UIColor *)color BorderWidth:(CGFloat)width  Placeholder:(NSString *)placeholder
{
    UITextField *field=[[UITextField alloc]init];
    field.placeholder=placeholder;
    field.layer.borderColor=color.CGColor;
    field.layer.borderWidth=width;
    [parnetView addSubview:field];
    field.font=[UIFont systemFontOfSize:[LHCObject LHCFont:14]];
    return field;
}

#pragma mark ---- UIAlertView
+(void)setupAlert:(NSString *)message {
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark ---- UIColor
+ (UIColor *)getRGBColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:alpha];
}

+ (UIColor *)getRandomColor:(CGFloat)alpha{
    return [self getRGBColor:arc4random_uniform(256) g:arc4random_uniform(256) b:arc4random_uniform(256) alpha:alpha];
}

+ (UIColor *)getBackgroundColor:(CGFloat)alpha{
    return [self getRGBColor:243 g:243 b:243 alpha:alpha];
}

+ (UIColor *)getHexColor:(NSString *)value alpha:(CGFloat)alpha{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[value substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[value substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[value substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}

+ (UIImage *)getImageColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -Base64
+(NSString *)base64FromJson:(NSMutableDictionary *)dicM{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicM options:NSJSONWritingPrettyPrinted error:NULL];
    return [jsonData base64EncodedStringWithOptions:0];
}
//时间格式化
+ (NSString *)FormatTimeString:(NSString *)timeStr
{
    if(timeStr.length<3){return @"";}
    NSString *time = [NSString stringWithFormat:@"%@",timeStr];
    NSString *time1 = [NSString string];
    NSString *time2 = [NSString string];
    NSString *time3 = [NSString string];
    if (time.length == 5) {
        time1 = [NSString stringWithFormat:@"0%@", [time substringToIndex:1]];
        time2 = [time substringWithRange:NSMakeRange(1, 2)];
        time3 = [time substringFromIndex:3];
    }else{
        time1 = [time substringToIndex:2];
        time2 = [time substringWithRange:NSMakeRange(2, 2)];
        time3 = [time substringWithRange:NSMakeRange(4, 2)];
    }
    return [NSString stringWithFormat:@"%@:%@:%@",time1,time2,time3];;
}

+(NSString *)FormatDateString:(NSString *)DateStr
{
    if(DateStr.length){
    NSString *time = [NSString stringWithFormat:@"%@",DateStr];
    NSString *time1 = [NSString string];
    NSString *time2 = [NSString string];
    NSString *time3 = [NSString string];
    time1 = [time substringToIndex:4];
    time2 = [time substringWithRange:NSMakeRange(4, 2)];
    time3 = [time substringWithRange:NSMakeRange(6, 2)];
    return [NSString stringWithFormat:@"%@-%@-%@",time1,time2,time3];
    }else{
        return nil;
    }
}

#pragma mark ---- 富文本
+ (NSMutableAttributedString *)LHCattributedStr:(NSString *)str Range:(NSRange)range Color:(UIColor *)color FontSize:(CGFloat)fontSize
{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:fontSize]
                          range:range];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
     
                          range:range];
    return AttributedStr;
}


/**
 @param string 需要处理的字符串
 @param start  起始位置
 @param Len    结束为止
 @return 处理好的字符串
 */
+ (NSString *)FormCutString:(NSString *)string Start:(NSInteger)start Len:(NSInteger)Len
{
    NSString *str=[string substringWithRange:NSMakeRange(start, Len)];
    return str;
}

#pragma mark ---- 手势
+(UITapGestureRecognizer *)LHCRecognizerTarget:(id)target Action:(SEL)action Num:(NSInteger)num
{
    UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    //num为1是单击
    tag.numberOfTapsRequired=num;
    return tag;
}

#pragma mark 手机号正则表达式
+ (BOOL)validatePhone:(NSString *)phone
{
    NSString* number = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:phone];
}

+ (UIColor *)Newprice:(NSString *)Newprice Price:(NSString *)price
{
    float s=[Newprice floatValue];
    float j=[price floatValue];
    if(s>j)
    {
        return [UIColor redColor];
    }else if(s<j){
        return JCLRGB(1, 189, 112);
    }else{
        return [UIColor blackColor];
    }
}

//模拟交易用到的
+ (UILabel *)LHCLable:(UIView *)parentView text:(NSString *)text size:(CGFloat)size Textcolor:(UIColor *)color alignment:(NSInteger)alignment
{
    UILabel *label=[[UILabel alloc]init];
    [parentView addSubview:label];
    label.textColor=color;
    label.text=text;
    label.font = [UIFont fontWithName:@"Zapf Dingbats" size:size];
    label.textAlignment = alignment;
    label.numberOfLines = 0;
    label.layer.masksToBounds = YES;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    return label;
}

+ (UIView *)LHCView:(UIView *)parnetView frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIView *view=[[UIView alloc]init];
    [parnetView addSubview:view];
    view.frame=frame;
    view.backgroundColor=backgroundColor;
    return view;
}

//+(NSMutableArray *)JCLSZStockInfo:(NSString *)code type:(NSString *)type{
//    NSArray *codeSZ = FileRead(CachesFile(NYSE)); NSArray *codeSH = FileRead(CachesFile(CodeSH));
//    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", code];
//    if ([type isEqualToString:@"SZ"]) {
//        [codeSZ enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
//            NSArray *group = [NSArray arrayWithArray:[obj filteredArrayUsingPredicate:preicate]];
//            if (group.count) { [arrayM addObject:obj]; }
//        }];
//    } else {
//        [codeSH enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
//            NSArray *group = [NSArray arrayWithArray:[obj filteredArrayUsingPredicate:preicate]];
//            if (group.count) { [arrayM addObject:obj]; }
//        }];
//    }
//    return arrayM;
//}

+(BOOL)testzs:(NSString *)codeStr{
    NSString *setCode = [codeStr substringToIndex:2];
    NSString *code = [codeStr substringFromIndex:2];
    if ([setCode isEqualToString:@"SH"]) {
        if ([[code substringToIndex:3] isEqualToString:@"000"] || [[code substringToIndex:3] isEqualToString:@"990"] ||
            [[code substringToIndex:2] isEqualToString:@"88"] || [[code substringToIndex:3] isEqualToString:@"777"] ||
            [[code substringToIndex:3] isEqualToString:@"778"] || [[code substringToIndex:3] isEqualToString:@"779"]){
            return true;
        }
    } else if ([setCode isEqualToString:@"SZ"]){
        if ([[code substringToIndex:3] isEqualToString:@"399"]){
            return true;
        }
    }
    return false;
}
//根据代码获取市场和保留小数
+ (id)loadMarketcode:(NSString *)code{
    NSArray *szArr = FileRead(CachesFile(NYSE))
    NSArray *shArr = FileRead(CachesFile(NASDAQ));
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:0];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", code];
    
    [szArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        NSArray *group = [NSArray arrayWithArray:[obj filteredArrayUsingPredicate:preicate]];
        if (group.count) {
            [array addObject:obj];
        }
    }];
    
    [shArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        NSArray *group = [NSArray arrayWithArray:[obj filteredArrayUsingPredicate:preicate]];
        if (group.count) {
            [array addObject:obj];
        }
    }];
    
    id obj = array[0];
    return obj;
}

+ (int)second{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int second = [dateComponent second];
    return second;
}


//utf转GB2312
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
    
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString= (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)utf8string,CFSTR(""),kCFStringEncodingGB_18030_2000));
    NSString *newStr =(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingGB_18030_2000)) ;
    return newStr;
}

+ (NSString *)NewDateFormat:(NSString *)format{
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *now = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *Dateformat = [[NSDateFormatter alloc] init];
    [Dateformat setDateFormat:format];
    
    return  [Dateformat stringFromDate:now];
}


#pragma mark -富文本
+(NSMutableAttributedString *)LHCAttStr:(NSString *)str spac:(NSUInteger)spac{
    if(str.length){
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = spac; // 调整行间距
    NSRange range = NSMakeRange(0, [str length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
    }
    return nil;
}

+ (NSString *)filterStr:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）￥「」＂、[]{}#%-*+=_\\|~＜＞$€^·'@#$%^&*()_+\"'"];
    str=[[str componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString:@""];
    return str;
}

+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
@end
