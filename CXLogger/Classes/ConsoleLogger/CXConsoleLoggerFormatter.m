//
//  CXConsoleLoggerFormatter.m
//  CXLogger
//
//  Created by shenchunxing on 2021/8/26.
//

#import "CXConsoleLoggerFormatter.h"
#import "CXLoggerManager.h"

@interface CXConsoleLoggerFormatter ()
{
    NSDateFormatter *_dateFormatter;
}

@end

@implementation CXConsoleLoggerFormatter

- (instancetype)init {
    
    if (self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {

    NSString *date = [_dateFormatter stringFromDate:logMessage->_timestamp];
    NSString *fileName = logMessage->_fileName;
    NSString *lineNum = @(logMessage->_line).stringValue;
    NSString *methodName = [[[logMessage->_function componentsSeparatedByString:@" "] lastObject] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSString *msg = logMessage->_message;
    NSString *log = [NSString stringWithFormat:@"date : %@ file : %@ line : %@ method : %@ msg : %@",date,fileName,lineNum,methodName,msg];
    [[CXLoggerManager shareManager] addConsoleLogger:log];
    return log;
}

@end
