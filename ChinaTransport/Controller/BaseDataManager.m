//
//  BaseDataManager.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/2.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "BaseDataManager.h"

@implementation BaseDataManager

+(instancetype)sharedBaseDataManager
{
    static BaseDataManager *baseDataManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseDataManager = [[BaseDataManager alloc] init];
    });
    
    return baseDataManager;
}

-(NSMutableArray *)getMineBaseData
{
    NSMutableArray *baseDataArray =[[NSMutableArray alloc]initWithCapacity:1];
    NSString *titleKey = @"title";
    NSString *imageKey = @"image";
    NSMutableDictionary *mineDic =[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"点击登录",titleKey,@"我的_登录后",imageKey, nil];
    [baseDataArray addObject:@[mineDic]];
    
    NSMutableArray *rowForSecArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSInteger i=0; i<3; i++)
    {
        NSString *title;
        NSString *image;
        switch (i) {
            case 0:
                title = @"周杰伦";
                image = @"我的_登录后";
                break;
            case 1:
                title = @"陈奕迅";
                image = @"我的_登录后";
                break;
            case 2:
                title = @"王攀登";
                image = @"我的_登录后";
                break;
                
            default:
                break;
        }
        NSMutableDictionary *secDic =[[NSMutableDictionary alloc] initWithObjectsAndKeys:title,titleKey,image,imageKey, nil];
        [rowForSecArray addObject:secDic];
    }
    [baseDataArray addObject:rowForSecArray];
    
    return baseDataArray;
}
-(NSMutableArray *)getLoginBaseData{
    NSMutableArray *loginArray = [[NSMutableArray alloc] initWithCapacity:1];
    NSString *titleKey = @"title";
    NSMutableArray *rows = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i < 2; i ++) {
        NSString *title;
        switch (i) {
            case 0:
                title = @"";
                break;
            case 1:
                title = @"";
                break;
            default:
                break;
        }
        NSMutableDictionary *sectionDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:title, titleKey,nil];
        [rows addObject:sectionDictionary];
    }
    [loginArray addObject:rows];
    return loginArray;
}
-(NSMutableArray *)getFindPwdBaseData{
    NSMutableArray *findPwdArray = [[NSMutableArray alloc] initWithCapacity:1];
    NSString *titleKey = @"title";
    NSString *imageKey = @"image";
    NSMutableArray *rows = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i < 3; i ++) {
        NSString *title;
        NSString *imageName;
        switch (i) {
            case 0:
                title = @"手机号";
                imageName = @"image1";
                break;
            case 1:
                title = @"验证码";
                imageName = @"image2";
                break;
            case 2:
                title = @"新密码";
                imageName=@"image3";
                
            default:
                break;
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:title, titleKey, imageName, imageKey, nil];
        [rows addObject:dic];
    }
    [findPwdArray addObject:rows];
    return findPwdArray;
    
}

@end