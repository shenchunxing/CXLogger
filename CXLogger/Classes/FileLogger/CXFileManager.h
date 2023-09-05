//
//  CXFileManager.h
//  CXLogger
//
//  Created by shenchunxing on 2021/8/21.
//

#import "DDFileLogger.h"

NS_ASSUME_NONNULL_BEGIN
@class CXFileManagerConfig;
@interface CXFileManager : DDLogFileManagerDefault

- (instancetype)initManagerWithConfig:(CXFileManagerConfig *)config;
@end

NS_ASSUME_NONNULL_END
