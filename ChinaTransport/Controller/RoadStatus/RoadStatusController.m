//
//  RoadStatusController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/6.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RoadStatusController.h"
#import "MJRefresh.h"

@interface RoadStatusController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bottomView;   //下面的大的View
    UIScrollView *scrView;  //大的scrollView
    UITableView *nowRoadTableView;  //实时路况的tableView
    UITableView *speedRoadTableView;  //高速公路的tableView
    UITableView *roadTrafficTableView; //公路交通的tableView
    NSMutableArray *nowRoadDataArray;  //实时路况的dataArray
    NSMutableArray *speedRoadDataArray;  //高速公路的dataArray
    NSMutableArray *roadTrafficDataArray;  //公路交通的dataArray
    UILabel *scrLabel; //滑动到Label
    BOOL isScroll;    //scroll的bool值
    NSString *sizeString;
}
@end

@implementation RoadStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTiTle:@"实时路况"];
    [self addimage:nil title:@"back" selector:@selector(backClick) location:YES];
    [self createUI];
    sizeString = @"嗲级发布赴埃及法水泥覅哦我房间爱放那边发放那赎金风暴发放";
}
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)createUI{
//               创建三个btn
    NSArray *arr = @[@"实时路况",@"高速公路",@"公路交通"];
    for (NSInteger i=0; i<arr.count; i++) {
    
        UIButton *roadButton =[MyControl createButtonWithFrame:CGRectMake(i*wid/arr.count, 64, wid/arr.count, 35) title:arr[i] titleColor:RGBCOLOR(85, 85, 85) imageName:nil bgImageName:nil target:self method:@selector(roadButtonClick:)];
        [roadButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [roadButton setTitleColor:RGBCOLOR(185, 85, 85) forState:UIControlStateNormal];
        roadButton.tag=201590611+i;
        
        if (i==0) {
            roadButton.selected=YES;
        }
        [self.view addSubview:roadButton];
        
    }
//          滑动的label
    scrLabel = [[UILabel alloc] initWithFrame:CGRectMake(wid/3/2-65/2, 64+33, 65, 2)];
    scrLabel.backgroundColor = RGBCOLOR(237, 88, 81);
    [self.view addSubview:scrLabel];
    
//         下半部分UI
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, 104, wid, heigh-64-50)];
//         创建整个大的scrollView
    scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, wid, heigh-64)];
    scrView.contentSize = CGSizeMake(wid*3, 0);
    scrView.showsHorizontalScrollIndicator = NO;
    scrView.showsVerticalScrollIndicator = NO;
    scrView.pagingEnabled =YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//             nowRoadTableView
    if (!nowRoadTableView) {
        nowRoadTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0,0, wid,heigh-64-45) style:UITableViewStylePlain];
        nowRoadTableView.delegate = self;
        //    fansTabView.bounces = NO;
        nowRoadTableView.separatorStyle = NO; // 分割线
        nowRoadTableView.showsVerticalScrollIndicator = NO;
        nowRoadTableView.dataSource  =self;
        nowRoadTableView.backgroundColor = [UIColor whiteColor];
        
        //[fansTabView setSeparatorColor:[UIColor redColor]]; 分割线颜色
        //        [fansTabView addHeaderWithTarget:self action:@selector(fansHeaderfresh)];
//        [nowRoadTableView addFooterWithTarget:self action:@selector(fansFootmore)];
       
        [scrView addSubview:nowRoadTableView];
    }
//             speedRoadTableView
    if (!speedRoadTableView) {
        //         zhufuTabView的tableView
        speedRoadTableView  = [[UITableView alloc]initWithFrame:CGRectMake(wid, 0, wid,heigh-64-45) style:UITableViewStylePlain];
        speedRoadTableView.delegate = self;
        speedRoadTableView.separatorStyle = NO;  //分割线
        speedRoadTableView.showsVerticalScrollIndicator = NO;
        speedRoadTableView.dataSource  =self;
        speedRoadTableView.backgroundColor = [UIColor grayColor];
        //[zhufuTabView setSeparatorColor:[UIColor redColor]]; 分割线颜色
        //        [zhufuTabView addHeaderWithTarget:self action:@selector(fuHeaderfresh)];
//        [speedRoadTableView addFooterWithTarget:self action:@selector(fuFootmore)];
        [scrView addSubview:speedRoadTableView];
    }
//       roadTrafficTableView
    if (!roadTrafficTableView) {
        roadTrafficTableView  = [[UITableView alloc]initWithFrame:CGRectMake(wid*2, 0, wid,heigh-35-10-64) style:UITableViewStylePlain];
        roadTrafficTableView.delegate = self;
        //huaTabView = NO;
        //    huaTabView.separatorStyle = NO;  分割线
        roadTrafficTableView.showsVerticalScrollIndicator = NO;
        roadTrafficTableView.dataSource  =self;
        //[huaTabView setSeparatorColor:[UIColor redColor]]; 分割线颜色
        //        [huaTabView addHeaderWithTarget:self action:@selector(huaHeaderfresh)];
//        [roadTrafficTableView addFooterWithTarget:self action:@selector(huaFootmore)];
        [scrView addSubview:roadTrafficTableView];
    }
    
    scrView.delegate = self;
    [bottomView addSubview:scrView];
    [self.view addSubview:bottomView];
    
}
//         点击btn切换界面
-(void)roadButtonClick:(UIButton *)btn{
    
    for (NSInteger i=0; i<3; i++) {
        UIButton *btn =(UIButton *)[self.view viewWithTag:201590611+i];
        btn.selected = NO;
    }
    btn.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = btn.frame.origin;
        //         label滑动代码
        scrLabel.frame = CGRectMake(point.x+wid/3/2-65/2, 64+33, 65, 2);

        //         点击Btn实现scrollView切换
        if (isScroll == NO) {
            scrView.contentOffset =CGPointMake((btn.tag-201590611)*wid, 0);
        }
    }];

    
}
#pragma ScrollView
//         滑动切换界面
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    滑动触发三个按钮 和label 的滑动
    if (scrView.contentOffset.x <wid/2) {
        UIButton *btn =(UIButton *)[self.view viewWithTag:201590611];
        isScroll =YES;
        [self roadButtonClick:btn];
    }
    if (scrView.contentOffset.x>wid/2 && scrollView.contentOffset.x<wid*3/2) {
        UIButton *btn =(UIButton *)[self.view viewWithTag:201590612];
        isScroll =YES;
        [self roadButtonClick:btn];
    }
    if (scrView.contentOffset.x>wid*3/2 && scrollView.contentOffset.x<wid*2) {
        UIButton *btn =(UIButton *)[self.view viewWithTag:201590613];
        isScroll =YES;
        [self roadButtonClick:btn];
    }
    
    isScroll =NO;
}

#pragma mark － TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == nowRoadTableView) {
        return nowRoadDataArray.count;
    }else if(tableView == speedRoadTableView){
//        return speedRoadDataArray.count;
        return 12;
    }else{
        return roadTrafficDataArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID;
    if (tableView == nowRoadTableView) {
        cellID =@"nowRoadTableViewCellID";
    }else if(tableView == speedRoadTableView){
        cellID =@"speedRoadTableViewCellID";
    }else{
        cellID =@"roadTrafficTableViewCellID";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    for(UIView * view in cell.subviews){
        if([view isKindOfClass:[UIImageView class]])
        {
            [view removeFromSuperview];
        }
    }
//     cell上面的图片内容
    UIImageView *topimgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 1, wid-20,44 )];
    topimgView.image=[UIImage imageNamed:@"renqi的圆角矩形-1"];
    [cell addSubview:topimgView];
    UIImageView *imageView =[MyControl createImageViewFrame:CGRectMake(10, 10, 45, 24) imageName:@"立即体验"];
    UILabel *titleLabel = [MyControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, 14, 70, 20) text:@"交通畅通" font:17 textcolor:[UIColor blackColor] textAlignment:0 backgroundColor:nil];
    UILabel *gaosuLabel =[MyControl createLabelWithFrame:CGRectMake(wid-20-20-100, 15, 30, 20) text:@"高速" font:13 textcolor:[UIColor grayColor] textAlignment:0 backgroundColor:nil];
    UILabel *timeLable =[MyControl createLabelWithFrame:CGRectMake(wid-20-20-65, 15, 80, 20) text:@"08-31 07:42" font:13 textcolor:[UIColor grayColor] textAlignment:0 backgroundColor:nil];
    [topimgView addSubview:imageView];
    [topimgView addSubview:titleLabel];
    [topimgView addSubview:gaosuLabel];
    [topimgView addSubview:timeLable];
//       cell下面的图片内容
    
    CGFloat height = [self getTextSize:sizeString];
    UIImageView *botimgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 46, wid-20,height+15 )];
    botimgView.image=[UIImage imageNamed:@"renqi的圆角矩形-1"];
    UILabel *sizeStringLabel = [MyControl createLabelWithFrame:CGRectMake(10,5 , wid-40, height) text:sizeString font:18 textcolor:[UIColor grayColor] textAlignment:0 backgroundColor:nil];
    [cell addSubview:botimgView];
    [botimgView addSubview:sizeStringLabel];
//
//    CGSize size = CGSizeMake(CGFLOAT_MAX,20);//LableWight标签宽度，固定的
//    //计算实际frame大小，并将label的frame变成实际大小
//    UIFont *font =[UIFont systemFontOfSize:18 weight:50];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];

    
    if (tableView == speedRoadTableView) {


    }
    
    
    cell.backgroundColor= [UIColor clearColor];
//    cell.backgroundColor =RGBCOLOR(239, 239, 239);
    return cell;
}
//          返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lf",[self getTextSize:sizeString]);
    return 61+[self getTextSize:sizeString]+10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - fresh downmore
-(void)fansFootmore{
}
-(void)fuFootmore{
}
-(void)huaFootmore{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//   根据字数判断size
-(CGFloat)getTextSize:(NSString *)string{
    CGSize size = CGSizeMake(wid-20,999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font =[UIFont systemFontOfSize:18 weight:50];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
   CGRect rect =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
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
