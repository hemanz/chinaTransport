//
//  DrivingAnswerTableViewCell.m
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "DrivingAnswerTableViewCell.h"
#import "Masonry.h"

@implementation DrivingAnswerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]  ) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    flagImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:flagImageView];
    answerLabel = [[UILabel alloc] init];
    answerLabel.textAlignment =NSTextAlignmentLeft;
    answerLabel.font=[UIFont systemFontOfSize:14];
    answerLabel.numberOfLines=0;
    [self.contentView addSubview:answerLabel];

}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSString *pngStr=[NSString stringWithFormat:@"answer%@",self.drivingAnswerModel.answerOrder];

    answerLabel.text = self.drivingAnswerModel.answerContent;
    switch (self.drivingAnswerModel.answerChooseType) {
        case DrivingAnswerTypeNotChoose:
            break;
        case DrivingAnswerTypeCorrect:
            pngStr=@"对号";
            break;
        case DrivingAnswerTypeNotCorrect:
            pngStr=@"错号";
            break;
        default:
            break;
    }
    flagImageView.image=[UIImage imageNamed:pngStr];
    
    [flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        make.centerY.equalTo(@[self.contentView]);
    }];
    [answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(flagImageView.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
    }];
    
}

- (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size{
    CGSize newsize ;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    newsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return newsize;
}

@end
