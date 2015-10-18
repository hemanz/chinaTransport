//
//  DrivingTestCollectionViewCell.h
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/10/9.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingModel.h"
@interface DrivingTestCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *testNo;
@property (nonatomic,strong)DrivingModel *model;
@end
