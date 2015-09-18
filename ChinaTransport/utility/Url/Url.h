//
//  Url.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Url : NSObject
+ (NSString *)GetTransportHeadLineURLWithPage:(NSInteger)page PageSize:(NSString *)Size ContentType:(NSString *)Type;

@end
