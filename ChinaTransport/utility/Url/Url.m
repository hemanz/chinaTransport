//
//  Url.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "Url.h"

@implementation Url


/**
 *  获取url地址
 *
 *  @param methodName 方法名
 *  @param param参数      get的所有参数,如果param为空，则传@""
 *
 *  @return url地址
 */
+(NSString *)GetURL:(NSString *)methodName withParam:(NSString *)param{
    NSString *str =[NSString stringWithFormat:@"%@/%@/ios/%@/%.1f%@",kHostAddr,methodName,kCURRENT_UUID,kCURRENT_APP_VERSION,param];
    return str;
}

+ (NSString *)GetTransportHeadLineURLWithPage:(NSInteger)page PageSize:(NSString *)Size ContentType:(NSString *)Type{
    NSString *str = [NSString stringWithFormat:@"%@pagesize=%@&newstype=%@&page=%lu",KUrl,Size,Type,(long)page];
    return str;
}



@end
