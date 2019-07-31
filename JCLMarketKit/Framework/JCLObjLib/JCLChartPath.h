//
//  JCLChartPath.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/9.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JCLChartRise JCLRGBA(248, 90, 89, 1)
#define JCLChartFall JCLRGBA(59, 186, 105, 1)
#define JCLChartStop JCLRGBA(166, 166, 166, 1)

typedef NS_ENUM(NSInteger, JCLChartPathBorderState) {
    JCLChartPathBorderTop = 0, // 图表框边框方位
    JCLChartPathBorderLeft,
    JCLChartPathBorderRight,
    JCLChartPathBorderBottom,
};

typedef NS_ENUM(NSInteger, JCLChartPathStyle) {
    JCLChartPathBox = 0, //图表框
    JCLChartPathBar, // 柱状图
    JCLChartPathTime,
    JCLChartPathTimeVol,
    JCLChartPathKline,
    JCLChartPathVol,
    JCLChartPathMacd,
    JCLChartPathBroken, // 折线图
    JCLChartPathRing, // 环形图
    JCLChartPathPie, // 饼图
    JCLChartPathRadar, // 雷达图
    JCLChartPathPoint
};

@interface JCLChartPath : UIView
@property (nonatomic, assign) JCLChartPathStyle style; //图表类型

// 图表框
@property (nonatomic, assign) NSInteger boxNumH; //横向图表框条数
@property (nonatomic, assign) NSInteger boxNumV; //竖向图表框条数
@property (nonatomic, assign) BOOL isDash; // 是否是虚线
@property (nonatomic, strong) UIColor *boxCol; // 图表框线条颜色
@property (nonatomic, assign) CGFloat boxW; // 图表框线条宽度
@property (nonatomic, assign) JCLChartPathBorderState borderState; //图表边框显示类型

// 柱状图
@property (nonatomic, assign) CGFloat barWS; // 柱状图宽度比例
@property (nonatomic, assign) BOOL isRound; // 是否有圆角
@property (nonatomic, assign) BOOL isUpDownBar; // 是否上下分离
@property (nonatomic, assign) CGFloat barSpac; // 柱状图每组里的间距（多组有效）
@property (nonatomic, assign) BOOL isLRBar; // 是否左右分离
@property (nonatomic, strong) UIColor *lossCol; // 对应的负数色值

// 股票那点事
@property (nonatomic, assign) BOOL isMacd; // 是否是Macd指标
@property (nonatomic, assign) BOOL isTime; // 是否是分时
@property (nonatomic, assign) CGFloat close; // 昨收（分时专用）
@property (nonatomic, assign) BOOL isSimiK; // 是否是相似k线
@property (nonatomic, assign) BOOL isFillK; // 是否填充k线颜色
@property (nonatomic, assign) CGFloat pathS; // 间距
@property (nonatomic, assign) CGFloat pathW; // 宽度
@property (nonatomic, strong) NSArray *XYArr; // 数据对应的坐标

// 公共属性(PS:折线/柱状)
@property (nonatomic, strong) NSArray *pointArr; // 对应的值数据
@property (nonatomic, strong) NSArray *pointCols; // 对应的色值数据
@property (nonatomic, strong) UIColor *pointCol; // 图表颜色
@property (nonatomic, assign) CGFloat pointW; // 图表线宽
@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) CGFloat min;
@property (nonatomic, strong) NSString *minVal; // 是否不计算最小值:为0
@property (nonatomic, strong) NSString *maxVal; // 是否不计算最小值:为0

// 环形图:
@property (nonatomic, assign) CGFloat ringEndVal; // 环形图结束值
@property (nonatomic, strong) UIColor *ringBgCol; // 环形图背景色
@property (nonatomic, strong) UIColor *ringValCol; // 环形图值颜色

@property (nonatomic, assign) BOOL isRings; // 是否是多组环形
@property (nonatomic, strong) NSArray *ringArr; // 环形图对应的值数据
@property (nonatomic, strong) NSArray *ringCols; // 环形图对应的颜色数据

@property (nonatomic, assign) CGFloat ringW; // 环形线宽

// 饼图
@property (nonatomic, strong) NSArray *pieArr; // 饼图对应的值数据
@property (nonatomic, strong) NSArray *pieCols; // 饼图对应的颜色数据
@property (nonatomic, assign) NSInteger pieIdx; // 饼图动画执行下标
@property (nonatomic, assign) BOOL isPieAnima; // 是否执行饼图动画

// 雷达图
@property (nonatomic, strong) NSArray *radarArr; // 雷达对应的值数据
@property (nonatomic, assign) NSInteger radarNum; // 雷达条数
@property (nonatomic, assign) NSInteger radarW; // 雷达线宽

// 图表公共属性
@property (nonatomic, copy) void (^pathPointBlock)(CGFloat x, CGFloat y); // 图表对应的坐标回调
@property (nonatomic, copy) void (^pathActionBlock)(NSInteger idx);
@property (nonatomic, assign) NSInteger aniTime; // 动画执行时间
@property (nonatomic, copy) void (^animaActionBlock)(); // 图表动画结束后的回调
@end
