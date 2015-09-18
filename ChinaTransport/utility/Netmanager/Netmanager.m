//
//  Netmanager.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "Netmanager.h"
#import "NSString+Hashing.h"
#import "AFNetworking.h"
#import "NSFileManager+pathMethod.h"
#import "Reachability.h"
@implementation Netmanager

+(void)PostRequestWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/caches"];
    //创建目录
    [fileManager createDirectoryAtPath:[path stringByAppendingPathComponent:@"HttpCathes"] withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *newpath = [NSString stringWithFormat:@"%@%@",[path stringByAppendingPathComponent:@"HttpCathes"],[urlString MD5Hash]];
    if ([self IsRequestNetWorkWithResults]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
         [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
        [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [operation.responseData writeToFile:newpath atomically:YES];
            finishedBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            finishedBlock(error.localizedDescription);
        }];
    }
    
}
+(void)GetRequestWithUrlString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFinishedBlock)failedBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            finishedBlock(responseObject);
        }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             failedBlock(error.localizedDescription);
         }];
  }
// 网络状态的判断
+ (BOOL)IsRequestNetWorkWithResults
{
    Reachability *hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([hostReach currentReachabilityStatus] ==NotReachable ){
        return NO;
    }else{
        return YES;
    }
}

@end
