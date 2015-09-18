//
//  LoginViewController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/2.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseDataManager.h"
#import "UserInfoData.h"
#import "RegistViewController.h"

@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * dataTableView; //显示用户名和密码输入的TV
    UITextField * usernameField; //输入用户名
    UITextField * codeField;//输入密码
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTiTle:@"登录"];
    [self addimage:nil title:@"注册" selector:@selector(registerClick) location:NO ];
    //从数据库获取datasource
    self.dataSource = [[BaseDataManager sharedBaseDataManager] getLoginBaseData];
    [self createTableView];
    [self createUI];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];

}
-(void)createTableView
{
    dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, wid, heigh)];
    dataTableView.scrollEnabled = NO;
    [dataTableView setDelegate:self];
    [dataTableView setDataSource:self];
    [dataTableView setBackgroundColor:RGBACOLOR(233, 245, 248, 1)];
    [self.view addSubview:dataTableView];
}
-(void)createUI{
//    背景颜色
    self.view.backgroundColor =RGBACOLOR(233, 245, 248, 1);
    
//    第三方登录
    UILabel *thirdpartLabel =[MyControl createLabelWithFrame:CGRectMake(wid/2-50, heigh*2/3-50+30, 100, 40) text:@"第三方登录" font:14 textcolor:[UIColor grayColor] textAlignment:1 backgroundColor:[UIColor clearColor]];
    //    左侧的分界线
    UILabel * leftLineLabel = [MyControl createLabelWithFrame:CGRectMake(1, heigh*2/3-32+30, wid/2-36, 1) text:nil font:0 textcolor:nil textAlignment:0 backgroundColor:RGBACOLOR(229, 229, 229, 1)];
    //    右侧的分界线
    UILabel * rightLineLabel = [MyControl createLabelWithFrame:CGRectMake(wid/2+36, heigh*2/3-32+30, wid/2-36, 1) text:nil font:0 textcolor:nil textAlignment:0 backgroundColor:RGBACOLOR(229, 229, 229, 1)];
    [self.view addSubview:thirdpartLabel];
    [self.view addSubview:leftLineLabel];
    [self.view addSubview:rightLineLabel];
    
    //    微信登陆的button
    UIButton *wechatButton = [MyControl createButtonWithFrame:CGRectMake(wid/2-30, heigh*2/3+20, 60, 60) title:@"微信登陆" titleColor:[UIColor blackColor] imageName:@"loginwechat.png" bgImageName:nil target:self method:@selector(wechatBtnClick)];
    [self.view addSubview:wechatButton];
    wechatButton.titleEdgeInsets = UIEdgeInsetsMake(25, -80, -55, 0);
    wechatButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];


    
    //登录按钮
    UIButton *loginButton =[MyControl createButtonWithFrame:CGRectMake(15, 220, wid-30, 40) title:@"登录" titleColor:[UIColor whiteColor] imageName:nil bgImageName:@"btnNormal.png" target:self method:@selector(loginBtnClick)];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"btnHigh.png"] forState:UIControlStateHighlighted];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    //忘记密码按钮
    UIButton *forgetButton =[MyControl createButtonWithFrame:CGRectMake(wid*2/3, 270, 100, 20) title:@"忘记密码？" titleColor:[UIColor grayColor] imageName:nil bgImageName:nil target:self method:@selector(forgetBtnClick)];
    forgetButton.titleLabel.font=[UIFont systemFontOfSize:15];
    
    [self.view addSubview:loginButton];
    [self.view addSubview:forgetButton];
}
#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"loginCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
    }
    if (indexPath.row == 0){
        
        //        输入用户名的UITextField
        usernameField = [MyControl createTextFieldFrame:CGRectMake( 50, 2, wid-72, 40) placeholder:@"请输入手机号" bgImageName:nil leftView:nil rightView:nil isPassWord:NO];
//        =[[UITextField alloc] initWithFrame:CGRectMake( 50, 2, wid-72, 40)];
        cell.imageView.image=[UIImage imageNamed:@"username.png"];
//        [usernameTF setLeftViewMode:UITextFieldViewModeAlways];
//        [usernameTF setPlaceholder:@"请输入手机号"];
        usernameField.delegate=self;
        
        usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        usernameField.keyboardType= UIKeyboardTypeNumberPad; //数字键盘
        
        [cell addSubview:usernameField];
    } else if(indexPath.row == 1){
        //        输入密码UITextField
        codeField = [MyControl createTextFieldFrame:CGRectMake(50, 2, wid-72, 40) placeholder:@"请输入密码" bgImageName:nil leftView:nil rightView:nil isPassWord:YES];
//        [[UITextField alloc] initWithFrame:CGRectMake(50, 2, wid-72, 40)];
        cell.imageView.image=[UIImage imageNamed:@"pwd.png"];
        codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
//        [pwdTF setLeftViewMode:UITextFieldViewModeAlways];
//        [pwdTF setPlaceholder:@"请输入密码"];
//        pwdTF.secureTextEntry=YES;
        [cell addSubview:codeField];
    }
    //    cell的背景颜色
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.accessoryType = UITableViewCellAccessoryNone; //cell没有任何的样式
    return cell;
}
//对输入框的文本内容进行限制的功能 限制其长度
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    return newLength <= 11;
}

//tableview被点击的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - button click or gesture tap event

//点击注册按钮触发
-(void)registerClick{
    RegistViewController *regVC =[[RegistViewController alloc] init];
//    regVC.regType=RegisterTypeAdd;
//    regVC.isVisual=YES;
    [self.navigationController pushViewController:regVC animated:YES];
    
}
//点击返回按钮触发
-(void)backClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击登陆按钮触发
-(void)loginBtnClick{
//    if(usernameField.text.length==11 && codeField.text.length >= 6){
//        NSString * codeMD5Str =[UserInfoData getMD5_32Bit_String:codeField.text];
//        NSString * URLString = [Url LoginUrl:usernameField.text andPsw:codeMD5Str];
//        [SVProgressHUD showInView:self.view status:@"登陆中..."];
//        [NetManager requestWithString:URLString finished:^(id responseObj) {
//            NSString * resCode= responseObj[@"resCode"];
//            NSDictionary * loginUserInfoDic = responseObj[@"userInfo"];
//            NSLog(@"loginUserInfoDic %@",loginUserInfoDic);
//            if ([resCode isEqualToString:RESCODE_OK]) {
//                //通过返回userInfo信息，构建UserInfoData，增加密码（原因为接口不返回密码）
//                /**
//                 *  储存psd pwdMd5
//                 */
//                UserInfoData *userInfoData=[[UserInfoData alloc]initWithDictionary:loginUserInfoDic];
//                userInfoData.code=pwdMD5Str;
//                [userInfoData setUserDefault:[userInfoData toDictionary] withLogin:YES];
//                
//               
//                [SVProgressHUD dismiss];
//                [self.delegate refreshMineTableView];
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }else{
//                [SVProgressHUD dismiss];
//                [self showAlertView:@"账号或密码错误"];
//            }
//        } failed:^(NSString *errorMsg) {
//            [SVProgressHUD dismiss];
//            [self showAlertView:@"网络连接失败"];
//        }];
//    }else{
//        [self showAlertView:@"请输入正确格式"];
//    }
}
//微信登录授权触发事件
-(void)wechatBtnClick{
    [self sendAuthRequest];
}
//微信登陆调用微信接口
- (void)sendAuthRequest
{
//    SendAuthReq* req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
//    req.state = @"xxx";
//    
//    [WXApi sendAuthReq:req viewController:self delegate:self];
}
//忘记密码触发事件
-(void)forgetBtnClick{
//    FindPwdViewController * findpwdVC= [[FindPwdViewController alloc]init];
//    findpwdVC.isVisual=YES;
//    [self.navigationController pushViewController:findpwdVC animated:YES];
    
}
//点击除textfield外区域，保证键盘等可编辑内容结束
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

//离开界面时，保证键盘等可编辑内容结束
-(void)viewWillDisappear:(BOOL)animated{
    
    [self.view endEditing:YES];
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
