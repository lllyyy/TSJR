//
//  JCLTradeDefine.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#ifndef JCLTradeDefine_h
#define JCLTradeDefine_h

#include <stdio.h>

#define JCL_PROTOCOL_ZJCX				 11103	 // 用户资金信息查询
#define JCL_PROTOCOL_CCSJ                11123   // 持仓数据
#define JCL_PROTOCOL_WTMM				 11116   // 委托买卖
#define JCL_PROTOCOL_DRWT                11119   // 当日委托查询
#define JCL_PROTOCOL_ZDMM                11114   // 查询 最大可买/可卖
#define JCL_PROTOCOL_LSWT                11120   // 查询用户历史委托记录
#define JCL_PROTOCOL_WTCD                11115   // 委托撤单
#define JCL_PROTOCOL_LSCJ                11121   // 查询用户历史成交记录
#define JCL_PROTOCOL_XGCC                11137   // 修改持仓的止损止盈价格
#define JCL_PROTOCOL_DRCJ                11117   // 当日成交查询
#define JCL_PROTOCOL_HYFY				 11146	 // 查询合约费用信息
#define JCL_PROTOCOL_YK                  11137   // 止盈止损
#define JCL_PROTOCOL_CJCX                11117   // 当日成交查询


#pragma pack(push,1) // 是指把原来对齐方式设置压栈，并设新的对齐方式设置为一个字节对齐
typedef struct {
    unsigned long long            hash64;                // 包头校验(校验整个和后面的数据)
    // 从下面开始计算校验和，一直到后面的数据内容
    unsigned char    version;                // 协议版本号256个版本
    unsigned char    compressed;            // 压缩或者加密，混合最多情况(0 : 没有压缩；1：zlib；2：c压缩)
    unsigned char     encrypt;                // 加密方式：0 不加密,1 ssl加密 ；
    unsigned long long            cookie;                // 用户上层自己携带的信息（可能服务端主动推送给客户端的）
    unsigned long long            synID;                // 同步ID，保留使用的异步信息
    unsigned long long            assisID;                // 辅助ID，方便客户端携带更多信息
    uint            rawLen;                // 原始没有压缩的长度
    uint            packLen;            // 包长,不包括包头自己;放到最前，可以兼容其他系统
    uint               funcID;            // 功能号；常见协议类型，如果需要具体分类，自行处理
    char            packdata[0];        // 后面的数据(实际要传输的数据)
} JCLSocketHeader;
#endif /* JCLTradeDefine_h */
