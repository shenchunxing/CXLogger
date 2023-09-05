//
//  CXDynamicLogLevel.m
//  CXLogger
//
//  Created by shenchunxing on 2021/8/21.
//

#import "CXDynamicLogLevel.h"
#import "CXLoggerMacor.h"

@implementation CXDynamicLogLevel

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [CXDynamicLogLevel ddSetLogLevel:LOG_LEVEL_WARN];
    });
}

+ (DDLogLevel)ddLogLevel {
    return d_logLevel;
}

+ (void)ddSetLogLevel:(DDLogLevel)ddLogLevel {
    d_logLevel = ddLogLevel;
}
@end
