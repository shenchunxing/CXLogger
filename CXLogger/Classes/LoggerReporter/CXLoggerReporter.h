//
//  CXLoggerReporter.h
//  CXLogger
//
//  Created by shenchunxing on 2021/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXLoggerReporter : NSObject

+ (instancetype)sharedReporter;

/**
 检测日志是否需要上传
 */
- (void)checkLogNeedUpload;

@end

NS_ASSUME_NONNULL_END
