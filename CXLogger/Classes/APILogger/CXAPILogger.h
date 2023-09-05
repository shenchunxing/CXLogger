//
//  CXAPILogger.h
//  CXAPILogger
//
//  Created by shenchunxing on 2021/4/20.
//

#import <Foundation/Foundation.h>

//======================================
// 运行期可通过LLDB `expr`命令实时修改的变量
//======================================

// 所有API日志的统一开关
CF_EXPORT BOOL CXAPILoggerEnabled;
// 请求日志的可定制格式符号
CF_EXPORT char *CXAPILoggerRequestLogIcon;
// 响应日志的可定制格式符号
CF_EXPORT char *CXAPILoggerResponseLogIcon;
// 异常日志的可定制格式符号
CF_EXPORT char *CXAPILoggerErrorLogIcon;


//============================
//   可定制的API日志的组成元素
//============================

typedef NS_OPTIONS(NSUInteger, CXAPILoggerRequestElement) {
    /** API起飞时间 */
    CXAPILoggerRequestElementTakeOffTime        = 1 << 0,
    /** API请求方式 */
    CXAPILoggerRequestElementMethod             = 1 << 1,
    /** API有效的请求路径 */
    CXAPILoggerRequestElementVaildURL           = 1 << 2,
    /** API请求头字段 */
    CXAPILoggerRequestElementHeaderFields       = 1 << 3,
    /** API请求体(一般是入参) */
    CXAPILoggerRequestElementHTTPBody           = 1 << 4,
    /** API任务唯一标识 */
    CXAPILoggerRequestElementTaskIdentifier     = 1 << 5,
    /** API请求任务所有标识 */
    CXAPILoggerRequestElementAll                = ~0UL
};

typedef NS_OPTIONS(NSUInteger, CXAPILoggerResponseElement) {
    /** API着陆时间 */
    CXAPILoggerResponseElementLandTime          = 1 << 0,
    /** API请求-响应耗时 */
    CXAPILoggerResponseElementTimeConsuming     = 1 << 1,
    /** API请求方式 */
    CXAPILoggerResponseElementMethod            = 1 << 2,
    /** API有效的请求路径 */
    CXAPILoggerResponseElementVaildURL          = 1 << 3,
    /** API响应头字段 */
    CXAPILoggerResponseElementHeaderFields      = 1 << 4,
    /** API响应状态码 */
    CXAPILoggerResponseElementStatusCode        = 1 << 5,
    /** API响应主体(或者异常) */
    CXAPILoggerResponseElementResponse          = 1 << 6,
    /** API任务唯一标识 */
    CXAPILoggerResponseElementTaskIdentifier    = 1 << 7,
    /** API响应任务所有标识 */
    CXAPILoggerResponseElementAll               = ~0UL
};


@interface CXAPILogger : NSObject

/**
 请求日志 可定制的组成元素
 */
@property (nonatomic, assign) CXAPILoggerRequestElement requestLoggerElements;

/**
 响应日志/异常日志 可定制的组成元素
 */
@property (nonatomic, assign) CXAPILoggerResponseElement responseLoggerElements;

+ (instancetype)sharedInstance;
/**
 开启API日志
 */
- (void)open;

@end

