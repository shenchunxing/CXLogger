//
//  CXLoggerReporter.m
//  CXLogger
//
//  Created by shenchunxing on 2021/9/2.
//

#import "CXLoggerReporter.h"
#import <SSZipArchive/SSZipArchive.h>
#import "CXLoggerManager.h"
@interface CXLoggerReporter ()
{
    dispatch_queue_t _completeQueue;
}
/* 压缩包路径 */
@property (nonatomic, copy) NSString *zipPath;

@end

@implementation CXLoggerReporter

+ (instancetype)sharedReporter {
    
    static CXLoggerReporter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CXLoggerReporter alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        _completeQueue = dispatch_queue_create("com.yunche.merchant.log", DISPATCH_QUEUE_CONCURRENT);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:@"UIApplicationWillEnterForegroundNotification" object:nil];
    }
    return self;
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    
    [self checkLogNeedUpload];
}

- (void)checkLogNeedUpload {
    
    //日志捞取服务接口调用
    NSLog(@"校验日志是否需要上传...");
    [self uploadLog:@{@"type":@(0),@"dates":@[@"2021-11-11"]}];
}

//MARK:根据服务返回，上传日志,数据结构@{type:0,dates:[]}
- (void)uploadLog:(NSDictionary *)resultDic {
    
    if (!resultDic) {
        return;
    }
    //type 0 不上传 1 上传指定日期 2 上传全部
    NSInteger type = [resultDic[@"type"] integerValue];
    if (type == 0) {
        return;
    }
    dispatch_async(_completeQueue, ^{
        BOOL isZipped = NO;
        if (type == 1) {
            isZipped = [self compressLogByDates:resultDic[@"dates"]];
        }else {
            isZipped = [self compressLogByDates:nil];
        }
        if (isZipped) {
            [self uploadZipToServer:^{
                if ([[NSFileManager defaultManager] fileExistsAtPath:self.zipPath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:self.zipPath error:nil];
                }
            } failure:^{
                NSLog(@"上传日志失败");
            }];
        }
    });
}

//MARK:根据日期压缩日志
- (BOOL)compressLogByDates:(NSArray *)dates {
    
    //本地日志目录下所有日志文件，按日期排序
    NSArray *sortedFilePaths = [CXLoggerManager shareManager].logFilePaths;
    if (sortedFilePaths == nil || sortedFilePaths.count == 0) {
        return NO;
    }
    self.zipPath = [CXLoggerManager shareManager].zipPath;
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.zipPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.zipPath error:nil];
    }
    
    BOOL isCreated = NO;
    if (dates && dates.count > 0) {
        //压缩指定日期日志
        NSMutableArray *paths = [[NSMutableArray alloc] init];
        [dates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [paths addObjectsFromArray:[self findPathsAtDate:obj inPaths:sortedFilePaths]];
        }];
        if (paths.count > 0) {
            isCreated = [SSZipArchive createZipFileAtPath:self.zipPath withFilesAtPaths:paths];
        }
    }else {
        //压缩全部日志
        isCreated = [SSZipArchive createZipFileAtPath:self.zipPath withFilesAtPaths:sortedFilePaths];
    }
    return isCreated;
}

- (NSArray<NSString *> *)findPathsAtDate:(NSString *)date inPaths:(NSArray<NSString *> *)paths {
    
    NSMutableArray *resPaths = [[NSMutableArray alloc] init];
    [paths enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj rangeOfString:date].location != NSNotFound) {
            [resPaths addObject:obj];
        }
    }];
    return resPaths.copy;
}

//MARK:上传日志到服务器
- (void)uploadZipToServer:(void(^)(void))successBlock failure:(void(^)(void))failBlock {
    
    NSLog(@"上传日志中...");
    successBlock();
}

@end
