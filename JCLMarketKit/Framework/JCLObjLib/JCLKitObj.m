//
//  RXPath.m
//  Jincelue
//
//  Created by 邢昭俊 on 2017/1/16.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLKitObj.h"
#import "MBProgressHUD.h"
#import <UShareUI/UShareUI.h>
@implementation JCLKitObj
#pragma mark - UIKit
+(UIView *)JCLView:(UIView *)parent color:(UIColor *)color{
    UIView *view = [[UIView alloc]init]; [parent addSubview:view]; view.backgroundColor = color; return view;
}

+(UIView *)JCLView:(UIView *)parent color:(UIColor *)color target:(id)target action:(SEL)action{
    UIView *view = [self JCLView:parent color:color];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:action]];
    return view;
}

+(UIView *)RXView:(UIView *)parent color:(UIColor *)color{
    UIView *view = [self JCLView:parent color:color];
    view.transform = CGAffineTransformMakeRotation(M_PI*0.5); [UIView commitAnimations];
    return view;
}

+(UIImageView *)JCLImage:(UIView *)parent{
    UIImageView *image = [[UIImageView alloc]init]; [parent addSubview:image];
    image.userInteractionEnabled = YES; image.layer.masksToBounds = YES;
    return image;
}

+(UILabel *)JCLLable:(UIView *)parent font:(NSInteger)font color:(UIColor *)color alignment:(NSInteger)alignment{
    UILabel *lable = [[UILabel alloc]init];
    [parent addSubview:lable];
    lable.font = [self JCLFont:font];
    lable.textColor = color;
    lable.textAlignment = alignment;
    lable.numberOfLines = 0;
    lable.userInteractionEnabled = YES;
    lable.layer.masksToBounds = YES;
    return lable;
}

+(UITextField *)JCLField:(UIView *)parent font:(CGFloat)font color:(UIColor *)color delegate:(id)delegate{
    UITextField *field = [[UITextField alloc]init];
    [parent addSubview:field];
    field.font = [self JCLFont:font];
    field.textColor = color;
    field.textAlignment = NSTextAlignmentLeft;
    field.borderStyle = UITextBorderStyleNone;
    field.delegate = delegate;
  
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
   
    return field;
}

+(UITextView *)JCLText:(UIView *)parent font:(NSInteger)font color:(UIColor *)color{
    JSTextView *text = [[JSTextView alloc]init];
     
    [parent addSubview:text];
    text.font = [self JCLFont:font];
    text.textColor = color;
    return text;
}

+(UIButton *)JCLButton:(UIView *)parent img:(NSString *)img size:(CGFloat)size target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc]init];
    [parent addSubview:button];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    
    button.titleLabel.font = [self JCLFont:size];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    return button;
}

+(UIScrollView *)JCLScroll:(UIView *)parent page:(BOOL)page delegate:(id)delegate{
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [parent addSubview:scroll];
    scroll.showsHorizontalScrollIndicator = YES;
    scroll.showsVerticalScrollIndicator = YES;
    scroll.pagingEnabled = page;
    scroll.delegate = delegate;
    scroll.bounces = NO;
    return scroll;
}

+(UIPageControl *)JCLPage:(UIView *)parent color:(UIColor *)color current:(UIColor *)current{
    UIPageControl *page = [[UIPageControl alloc] init];
    [parent addSubview:page];
    page.currentPageIndicatorTintColor = current;
    page.pageIndicatorTintColor = color;
    return page;
}

+(UITableView *)JCLTable:(UIView *)parent target:(id)target frame:(CGRect)frame style:(UITableViewStyle)style{
    UITableView *table = [[UITableView alloc]initWithFrame:frame style:style];
    [parent addSubview:table];
    table.dataSource = target;
    table.delegate = target;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    return table;
}

+(UICollectionView *)JCLCollect:(UIView *)parent target:(id)target frame:(CGRect)frame style:(NSInteger)style{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:style];
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flow];
    [parent addSubview:collect];
    collect.dataSource = target;
    collect.delegate = target;
    if (style == 4) {
        collect.showsHorizontalScrollIndicator = NO;
        collect.alwaysBounceHorizontal = NO;
    } else {
        collect.showsHorizontalScrollIndicator = NO;
    }
    collect.scrollEnabled = YES;
    collect.alwaysBounceVertical = YES;
    return collect;
}

+ (UICollectionView *)JCLCollect:(UIView *)parent target:(id)target frame:(CGRect)frame cell:(Class)cell ident:(NSString *)ident style:(NSInteger)style{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:style];
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    [parent addSubview:collect];
    collect.dataSource = target; collect.delegate = target;
    [collect registerClass:cell forCellWithReuseIdentifier:ident];
    if (style == 44) {
        collect.showsHorizontalScrollIndicator = NO;
        collect.alwaysBounceHorizontal = NO;
    } else {
        collect.showsHorizontalScrollIndicator = NO;
    }
    collect.backgroundColor = JCLBGRGB;
    collect.scrollEnabled = YES;
    collect.alwaysBounceVertical = YES;
    return collect;
}

#pragma mark - JCLSetup
+(CGSize)JCLStrSize:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+(CGSize)JCLStrSize:(NSString *)text font:(UIFont *)font{
    return [self JCLStrSize:text font:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

+(CGFloat)JCLSize:(CGFloat)size{ if (iPhone6) { return size; } else if (iPhone6Plus){ return size + 1; } else { return size - 1; } }
+(UIFont *)JCLFont:(CGFloat)size{
    return [UIFont systemFontOfSize:[self JCLSize:size]];
    
}
+(CGFloat)JCLHeight:(CGFloat)height{ if (iPhone6){ return height; } else if (iPhone6Plus){ return height + 4; } else { return height - 4; } }

+(NSArray *)JCLRemoveKit:(NSMutableArray *)arrM{
    [arrM enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) { [obj removeFromSuperview]; }];
    [arrM removeAllObjects];
    return arrM;
}

+(NSArray *)JCLRemoveLayer:(NSMutableArray *)arrM{
    [arrM enumerateObjectsUsingBlock:^(CAShapeLayer *obj, NSUInteger idx, BOOL * _Nonnull stop) { [obj removeFromSuperlayer]; }];
    [arrM removeAllObjects];
    return arrM;
}

+(NSString *)JCLBundle:(NSString *)str{
    NSBundle *bundle = [NSBundle bundleWithPath: [[NSBundle mainBundle] pathForResource: @"JCLBundle"  ofType: @"bundle"]];
    return [[bundle resourcePath] stringByAppendingPathComponent: str];
}

#pragma mark ---- UIGestureRecognizer
+ (UIPinchGestureRecognizer *)RXPinch:(UIView *)parentView target:(id)target action:(SEL)action{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
    [parentView addGestureRecognizer:pinch]; return pinch;
}

+ (UIPanGestureRecognizer *)RXPan:(UIView *)parentView target:(id)target action:(SEL)action{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [parentView addGestureRecognizer:pan]; pan.delegate = target; return pan;
}

+ (UILongPressGestureRecognizer *)RXLongPress:(UIView *)parentView target:(id)target action:(SEL)action{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    [parentView addGestureRecognizer:longPress]; return longPress;
}

+ (UITapGestureRecognizer *)RXTap:(id)parent target:(id)target action:(SEL)action number:(NSUInteger)number{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [parent addGestureRecognizer:tap]; tap.numberOfTapsRequired = number; return tap;
}

#pragma mark - NSMutableAttributedString
+(NSString *)JCLStr:(NSString *)str{ return str.length ? str : @""; }
+(NSString *)JCLInt:(NSString *)str{ return str.length ? [NSString stringWithFormat:@"%ld", (long)str.integerValue] : @"0"; }
+(NSString *)JCLDou:(NSString *)str type:(NSInteger)type{
    if (type == 1) {
        return str.length ? [NSString stringWithFormat:@"%.2lf", str.floatValue] : @"0.00";
    } else {
        return str.length ? [NSString stringWithFormat:@"%.2lf%%", str.floatValue] : @"0.00%";
    }
}
+(NSMutableAttributedString *)RXAttStr:(NSString *)str color:(UIColor *)color beginIdx:(NSInteger)idx{
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:str];
    [strM addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, idx)];
    return strM;
}

+(NSMutableAttributedString *)RXAttStr:(NSString *)str color:(UIColor *)color endIdx:(NSInteger)idx{
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:str];
    [strM addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(str.length - idx, idx)];
    return strM;
}

+(NSMutableAttributedString *)RXAttStr:(NSString *)str spac:(NSUInteger)spac{
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:spac];
    [strM addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    return strM;
}

+(CGSize)JCLTextSize:(NSString *)str font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    return [str boundingRectWithSize:CGSizeMake(JCLWIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

+(CGSize)JCLTextSize:(NSString *)str spac:(CGFloat)spac font:(UIFont *)font width:(CGFloat)width{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = spac;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    return [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

+(CGSize)JCLTextSize:(NSString *)val font:(UIFont *)font width:(float)width{
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    text.text = val; text.font = font;
    return [text sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
}

+(CGSize)JCLAttTextSize:(NSAttributedString *)val font:(UIFont *)font width:(float)width{
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    text.attributedText = val; text.font = font;
    return [text sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
}

+(CGFloat)JCLArrStrH:(NSString *)str spac:(CGFloat)spac font:(CGFloat)font width:(CGFloat)width{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = spac;
    NSDictionary *dic = @{NSFontAttributeName:[self JCLFont:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+(NSMutableAttributedString *)RXAttStr:(NSString *)str icon:(NSString *)icon y:(CGFloat)y wh:(CGFloat)wh idx:(NSUInteger)idx{
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:str];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:icon]; attachment.bounds = CGRectMake(0, y, wh, wh);
    [strM insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:idx];
    return strM;
}

#pragma mark - NSDateFormatter
+(NSString *)JCLDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [formatter stringFromDate:date];
}

+(NSString *)JCLDate:(NSString *)str style:(NSString *)style{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:str];
    [formatter setDateFormat:style];
    return [formatter stringFromDate:date];
}

+(NSString *)JCLDate:(NSString *)begin end:(NSString *)end{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beginDate = [formatter dateFromString:begin];
    NSDate *endDate = [formatter dateFromString:end];
    NSTimeInterval time = [endDate timeIntervalSinceDate:beginDate];
    //int month = ((int)time)/(3600*24*30);
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/60;
    
    NSString *times;
//    if(month != 0){
//        times = [NSString stringWithFormat:@"%i 个月 %i", month, days];
//    } else
    if(days != 0){
        times = [NSString stringWithFormat:@"%i 天", days];
    } else if(hours != 0){
        times = [NSString stringWithFormat:@"%i 小时", hours];
    } else {
        times = [NSString stringWithFormat:@"%i 分钟", minute];
    }
    return times;
}

+(NSInteger)JCLDay:(NSInteger)year month:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12)) return 31 ;
    if((month == 4) || (month == 6) || (month == 9) || (month == 11)) return 30;
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3)) return 28;
    if(year % 400 == 0) return 29; if(year % 100 == 0) return 28;
    return 29;
}

+(UIColor *)JCLHexCol:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) { return [UIColor clearColor]; }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(UIImage *)JCLImgCol:(UIColor *)col{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [col CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (void)configUSharePlatforms:(NSString *)url
                           vc:(UIViewController *)vc
                        title:(NSString *)title
                         desc:(NSString *)desc{
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    /* 设置微信的appKey和appSecret */
    
    
    /* 设置新浪的appKey和appSecret */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    //
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        NSLog(@"sdfasdfdsfdfd%@",userInfo);
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.title = title;
        messageObject.text = desc;
        messageObject.shareObject = url;
        
        [self shareWebPageToPlatformType:platformType messageObject:messageObject type:nil vc:vc];
    }];
    
}


//网页分享
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                     messageObject:(UMSocialMessageObject *)messageObject
                              type:(NSString *)type
                                vc:(UIViewController *)vc{
    
    //创建网页内容对象
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:messageObject.title descr:messageObject.text thumImage:[UIImage imageNamed:@"AppIcon"]];
    //设置网页地址
    shareObject.webpageUrl = messageObject.shareObject;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (type.length > 0) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShareNum" object:nil];
        }
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        // [self alertWithError:error];
    }];
}

+ (NSString *)createRand6{
    int from = 100000;
    int to   = 999999;
    
    int index =   (int)(from  + (arc4random() % (to - from + 1)));
    
    return [NSString stringWithFormat:@"%d",index];
}

+(void)showMsg:(NSString *)msg {
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[AppDelegate shareAppDelegate].window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    [hud hideAnimated:YES afterDelay:2.0f];
}

+(NSString *)stringByTrimmingCharactersInSet:(NSString *)str  {
    //过滤空格
    NSString * urlStr = str;
    NSLog(@"urlStr = %@",urlStr);
    
    //过滤字符串前后的空格
    urlStr = [urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"urlStr = %@",urlStr);
    
    //过滤中间空格
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"urlStr = %@",urlStr);
    return urlStr;
}

+(UINavigationController *)rootNav {
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    NSLog(@"rootVC%@",rootVC);
    UINavigationController *topNav = nil;
    if ([rootVC isKindOfClass:[JCLNaviBarList class]]) {
       
        JCLNaviBarList * nav = rootVC.tabBarController.selectedViewController;
        topNav = nav.topViewController.navigationController;
        
        NSLog(@"topNav%@", nav.topViewController);
    } else if ([rootVC isKindOfClass:[JCLNaviBarList class]]) {
        JCLNaviBarList * nav = (JCLNaviBarList *)rootVC;
        topNav = nav.topViewController.navigationController;
    }
    return topNav ;
    
}
+(UIViewController *)rootVC {
 
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    NSLog(@"rootVC%@",rootVC);
    UIViewController *topVC = nil;
    if ([rootVC isKindOfClass:[JCLTabBarList class]]) {
        JCLTabBarList *rootTab = (JCLTabBarList*)rootVC  ;;
        JCLNaviBarList * nav = rootTab.selectedViewController;
        topVC = nav.topViewController;
        
    } else if ([rootVC isKindOfClass:[JCLNaviBarList class]]) {
        JCLNaviBarList * nav = (JCLNaviBarList *)rootVC;
        topVC = nav.topViewController;
    }
    NSLog(@"------ %@",topVC);
    return topVC;
    
}


+(NSString *)moneyFormat:(NSString *)money
{
    if (!money || money.length == 0) {
        return money;
    }
    
    BOOL hasPoint = NO;
    if ([money rangeOfString:@"."].length > 0) {
        hasPoint = YES;
    }
    
    NSMutableString *pointMoney = [NSMutableString stringWithString:money];
    if (hasPoint == NO) {
        [pointMoney appendString:@".00"];
    }
    
    NSArray *moneys = [pointMoney componentsSeparatedByString:@"."];
    if (moneys.count > 2) {
        return pointMoney;
    } else if (moneys.count == 1) {
        return [NSString stringWithFormat:@"%@.00", moneys[0]];
    } else {
        // 整数部分每隔 3 位插入一个逗号
        NSString *frontMoney = [self stringFormatToThreeBit:moneys[0]];
        if ([frontMoney isEqualToString:@""]) {
            frontMoney = @"0";
        }
        // 拼接整数和小数两部分
        NSString *backMoney = moneys[1];
        if ([backMoney length] == 1) {
            return [NSString stringWithFormat:@"%@.%@0", frontMoney, backMoney];
        } else if ([backMoney length] > 2) {
            return [NSString stringWithFormat:@"%@.%@", frontMoney, [backMoney substringToIndex:2]];
        } else {
            return [NSString stringWithFormat:@"%@.%@", frontMoney, backMoney];
        }
    }
}



+ (NSString *)stringFormatToThreeBit:(NSString *)string {
    NSString *tempString = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSMutableString *mutableString = [NSMutableString stringWithString:tempString];
    NSInteger n = 2;
    for (NSInteger i = tempString.length - 3; i > 0; i--) {
        n++;
        if (n == 3) {
            [mutableString insertString:@"," atIndex:i];
            n = 0;
        }
    }
    return mutableString;
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    if([num rangeOfString:@"."].location !=NSNotFound)  {
        NSString *losttotal = [NSString stringWithFormat:@"%.2f",[num floatValue]];//小数点后只保留两位
        NSArray *array = [losttotal componentsSeparatedByString:@"."];
        //小数点前:array[0]
        //小数点后:array[1]
        int count = 0;
        num = array[0];
        long long int a = num.longLongValue;
        while (a != 0)
        {
            count++;
            a /= 10;
        }
        NSMutableString *string = [NSMutableString stringWithString:num];
        NSMutableString *newstring = [NSMutableString string];
        while (count > 3) {
            count -= 3;
            NSRange rang = NSMakeRange(string.length - 3, 3);
            NSString *str = [string substringWithRange:rang];
            [newstring insertString:str atIndex:0];
            [newstring insertString:@"," atIndex:0];
            [string deleteCharactersInRange:rang];
        }
        [newstring insertString:string atIndex:0];
        NSMutableString *newString = [NSMutableString string];
        newString =[NSMutableString stringWithFormat:@"%@.%@",newstring,array[1]];
        return newString;
    }else {
        int count = 0;
        long long int a = num.longLongValue;
        while (a != 0)
        {
            count++;
            a /= 10;
        }
        NSMutableString *string = [NSMutableString stringWithString:num];
        NSMutableString *newstring = [NSMutableString string];
        while (count > 3) {
            count -= 3;
            NSRange rang = NSMakeRange(string.length - 3, 3);
            NSString *str = [string substringWithRange:rang];
            [newstring insertString:str atIndex:0];
            [newstring insertString:@"," atIndex:0];
            [string deleteCharactersInRange:rang];
        }
        [newstring insertString:string atIndex:0];
        return newstring;
    }
}
 

+(NSString *)timeStampString:(NSString *)timeStampString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *dateA = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue] / 1000];
    return [formatter stringFromDate:dateA];
}

+(NSDate *)timeStampStringIn:(NSString *)timeStampString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *dateA = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue]];
    return dateA;
}

//订单类型
+(NSString *)orderType:(NSString *)orderType{
    if ([orderType isEqualToString:@"MKT"]) {
        return @"市价";
    }else if ([orderType isEqualToString:@"LMT"]){
         return @"限价";
    }else if ([orderType isEqualToString:@"STP"]){
         return @"止损单";
    }else if ([orderType isEqualToString:@"STP_LMT"]){
         return @"止损限价单";
    }else{
         return @"跟踪止损单";
    }
}
//订单类型
+(NSString *)actionType:(NSString *)actionType{
    if ([actionType isEqualToString:@"BUY"]) {
        return @"买入";
    }else {
        return @"卖出";
    }
}



+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}
+ (NSString *) createHTMLFile2:(NSString *)value {
    
    NSMutableString *htmlstring=[[NSMutableString alloc]initWithString:@"<html><head><meta name=\"viewport\" content=\"initial-scale=1,user-scalable=no\"><style type=\"text/css\">.text {padding:0 10px 0px 10px; color:white;}.text h3 {font-size:18px; height:24px; line-height:24px;padding-top:0px; font-weight:bold;}.text p {font-size:15px; line-height:18px; margin-bottom:10px;} .img {width:200px;height:100px} </style></head><body><div class=\"text\">"];
    [htmlstring appendString:value];
    [htmlstring appendFormat:@"</div></body></html>"];
  
    return htmlstring;
}
@end
