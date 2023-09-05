//
//  CXDynamicLogLevel.h
//  CXLogger
//
//  Created by shenchunxing on 2021/8/21.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
NS_ASSUME_NONNULL_BEGIN
static DDLogLevel d_logLevel;

@interface CXDynamicLogLevel : NSObject<DDRegisteredDynamicLogging>


@end

NS_ASSUME_NONNULL_END
