//
//  CXLoggerManager.h
//  CXLogger
//
//  Created by shenchunxing on 2021/8/20.
//

#import <Foundation/Foundation.h>
#import "CXFileManagerConfig.h"
NS_ASSUME_NONNULL_BEGIN
@class CXConsoleLoggerModel;
@interface CXLoggerManager : NSObject

+ (instancetype)shareManager;

/* 文件日志配置项 */
@property (nonatomic, strong) CXFileManagerConfig *fileConfig;
/* 控制台日志 */
@property (nonatomic, strong,readonly) NSMutableArray<NSString *> *loggers;

- (void)startLogger;

- (void)addConsoleLogger:(NSString *)log;
- (void)removeAllConsoleLoggers;


/**
 获取所有按日期降序的日志文件路径

 @return 日志文件路径列表
 */
- (NSArray<NSString *> *)logFilePaths;


/**
 获取所有按日期降序的日志文件名

 @return 文件名列表
 */
- (NSArray<NSString *> *)logFileNames;

- (NSString *)zipPath;

@end

NS_ASSUME_NONNULL_END
