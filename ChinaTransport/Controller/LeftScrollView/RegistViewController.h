//
//  RegistViewController.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/6.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RootViewController.h"
#import "UserInfoData.h"

@interface RegistViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIWebViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  区分是注册，还是微信登陆后绑定手机号
 */
@property (nonatomic,assign)RegisterType regType;
//@property (nonatomic, assign) id <UIWebViewDelegate> delegate1;
//@property(nonatomic, weak) id<RefreshInfoTableViewDelegate> delegate;
@end
