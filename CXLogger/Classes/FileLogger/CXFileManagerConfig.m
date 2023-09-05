//
//  CXFileManagerConfig.m
//  CXLogger
//
//  Created by shenchunxing on 2021/8/21.
//

#import "CXFileManagerConfig.h"

//日志文件路径
static NSString *const kCXLoggerFilePath = @"CXLoggers";
//压缩包名
static NSString *const kZipFileName = @"/CXLoggers.zip";

NSUInteger         const kCXDefaultLogMaxNumLogFiles   = 0;                //最大归档数量，默认不可用
unsigned long long const kCXDefaultLogFilesDiskQuota   = 1024 * 1024 * 30; // 日志最大磁盘存储 30 MB
unsigned long long const kCXDefaultLogMaxFileSize      = 1024 * 500;      // 单个文件最大 500 KB
NSTimeInterval     const kCXDefaultLogRollingFrequency = 0;     //日志回滚周期,默认不可用


@implementation CXFileManagerConfig

+ (CXFileManagerConfig *)defaultConfig {
    
    CXFileManagerConfig *config = [[CXFileManagerConfig alloc] init];
    
    return config;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.maximumNumberOfLogFiles = kCXDefaultLogMaxNumLogFiles;
        self.logFilesDiskQuota = kCXDefaultLogFilesDiskQuota;
        self.maximumFileSize = kCXDefaultLogMaxFileSize;
        self.rollingFrequency = kCXDefaultLogRollingFrequency;
        self.fileName = [[NSBundle mainBundle] bundleIdentifier];
        self.zipName = kZipFileName;
        self.logsDirectory = [self defultLogsDirectory];
    }
    return self;
}

- (NSString *)defultLogsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *baseDir = paths.firstObject;
    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:kCXLoggerFilePath];
    return logsDirectory;
}

@end
