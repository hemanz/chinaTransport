//
//  LeftScrollController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "LeftScrollController.h"
#import "BaseDataManager.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "InfoViewController.h"
#import "LoginViewController.h"
#import "RoadStatusController.h"
@interface LeftScrollController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mineTableView;
}
@end

@implementation LeftScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    /**
     调取用户信息数据
     */
    self.userInfoData=[[[UserInfoData alloc]init] getUserDefault];
    self.dataSource = [[BaseDataManager sharedBaseDataManager] getMineBaseData];
    [self createTableView];
}
-(void)createTableView{
    //添加tableview
    mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh)];
    [mineTableView setDelegate:self];
    [mineTableView setDataSource:self];
    mineTableView.showsHorizontalScrollIndicator=NO;
    mineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    mineTableView.backgroundColor=RGBACOLOR(233, 245, 248, 1);
    [self.view addSubview:mineTableView];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"self.dataSource.count::%ld",self.dataSource.count);
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"[self.dataSource[section] count]::%ld",[self.dataSource[section] count]);
    return [self.dataSource[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    UITableViewCellStyle cellStyle;
    cellStyle = UITableViewCellStyleDefault;
    if (indexPath.section == 0 ) {
        cellStyle = UITableViewCellStyleSubtitle;
    }else if(indexPath.section== 1){
        cellStyle = UITableViewCellStyleValue1;
    }
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:cellStyle reuseIdentifier:cellId];
    }
    NSLog(@"dataSource:%@",self.dataSource);
//    NSMutableDictionary *sectionDictionary =self.dataSource[indexPath.section][indexPath.row];
    NSMutableDictionary *sectionDictionary = self.dataSource[indexPath.section][indexPath.row];
    NSString *title =[sectionDictionary objectForKey:@"title"];
    NSString *image =[sectionDictionary objectForKey:@"image"];
    if(title){
        cell.textLabel.text = title;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    头像的cell判断是否是登陆状态
    if (indexPath.section ==0) {
        //先删除该cell的subview，防止由于循环利用cell导致不断addsubview头像所在的UIImageView
        for(UIView * view in cell.subviews){
            if([view isKindOfClass:[UIImageView class]])
            {
                [view removeFromSuperview];
            }
        }
         // 如果已登录
        if (self.userInfoData.isLogin) {
            UIImageView *avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 7, 60, 60)];
            avatarImgView.layer.cornerRadius = 30;
            avatarImgView.layer.masksToBounds =YES;
            avatarImgView.contentMode =  UIViewContentModeScaleAspectFill;
            if([UserInfoData isBlankString :self.userInfoData.avatar]){
                avatarImgView.image = [UIImage imageNamed:@"我的_登录后"];
            }else{
            
                NSString * imgUrl=[@"" stringByAppendingString:self.userInfoData.avatar];
                avatarImgView.image=nil;
                [avatarImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            }
        //  昵称
            NSString *nickname;
            if ([UserInfoData isBlankString:self.userInfoData.nickname]) {
                nickname =@"点击修改昵称";
            } else{
                nickname = self.userInfoData.nickname;
            }
            cell.textLabel.text = nickname;
            cell.imageView.image = [UIImage imageNamed:@"我的_登录后"];
            cell.imageView.backgroundColor = [UIColor blueColor];
            cell.imageView.frame =CGRectMake(0, 0, 2, 70) ;
            [cell addSubview:avatarImgView];


        }
        //如果未登录
        else{
            cell.imageView.image = [UIImage imageNamed:image];
            cell.detailTextLabel.text=@"hello";
        }

    }else{
        cell.imageView.image = [UIImage imageNamed:image];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 205;
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 14;
}
//cell点击的效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 0 &&indexPath.row == 0){
        if (self.userInfoData.isLogin) {
            InfoViewController *infoVC = [[InfoViewController alloc]init];
            infoVC.hidesBottomBarWhenPushed=YES;
//            infoVC.delegate=self;
            [self.navigationController pushViewController:infoVC animated:YES];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
//            loginVC.delegate=self;
//            loginVC.isVisual=YES;
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:loginNav animated:YES completion:nil];
        }
    }
    if (indexPath.section ==1 && indexPath.row ==0) {
        RoadStatusController *roadStatusVC =[[RoadStatusController alloc] init];
        UINavigationController *NVC =[[UINavigationController alloc] initWithRootViewController:roadStatusVC];
        [self presentViewController:NVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
