//
//  DrivingTestCollectionViewCell.m
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/10/9.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "DrivingTestCollectionViewCell.h"

@implementation DrivingTestCollectionViewCell

- (void)prepareForReuse{
    [super prepareForReuse];
//    _testNo.textColor = [UIColor lightGrayColor];
}

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _testNo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        _testNo.textAlignment = NSTextAlignmentCenter;
        _testNo.textColor = [UIColor lightGrayColor];
        _testNo.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_testNo];
    }
    
    return self;
}
-(void)createUI{
    

}
//-(void)layoutSubviews{
//    if ([self.model.answerChoose isEqualToString:self.model.answerTrue]) {
//        self.backgroundColor = [UIColor greenColor];
//        self.testNo.textColor = [UIColor blueColor];
//    } else if ([self.model.answerChoose isEqualToString:@""]){
//        self.backgroundColor = [UIColor whiteColor];
//    }else {
//        self.backgroundColor = [UIColor redColor];
//        self.testNo.textColor = [UIColor orangeColor];
//    }
//    self.layer.masksToBounds = YES;
//    
//    self.layer.cornerRadius = 40;
//    self.layer.cornerRadius = self.bounds.size.width * 0.5;
//    self.layer.borderWidth = 0.1;
//    self.layer.borderColor =[UIColor blackColor].CGColor;
//   self.testNo.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
//}
@end
