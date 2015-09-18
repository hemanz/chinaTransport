//
//  HomeController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "HomeController.h"
#import "PPRevealSideViewController.h"
#import "LeftScrollController.h"
#import "TransprotHeadlineViewController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor purpleColor];
    [self createNavbar];
    [self createUI];
}
//     导航条
-(void)createNavbar {
    [self addimage:nil title:@"我的" selector:@selector(MineItem) location:YES];
    [self addimage:nil title:@"分享" selector:@selector(shareItem) location:NO];
}

#pragma mark - UIload
-(void)createUI {
    
}
#pragma mark - DataRequest

#pragma mark - Click事件
-(void)MineItem{
    NSLog(@"MineLeftItem");
//    LeftScrollController *leftScrollVC =[[LeftScrollController alloc] init];
//    [self.revealSideViewController pushViewController:leftScrollVC onDirection:PPRevealSideDirectionLeft animated:YES];
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}
-(void)shareItem{
    NSLog(@"shareRightItem");
    TransprotHeadlineViewController *tvc = [[TransprotHeadlineViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
    
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
