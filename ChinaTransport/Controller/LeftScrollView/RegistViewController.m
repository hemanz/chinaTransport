//
//  RegistViewController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/6.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RegistViewController.h"
#import "BaseDataManager.h"
@interface RegistViewController ()
{
    UITableView *dataTableView;
    UITextField *usernameField;       //用户名的tf
    UITextField *smsField;            //验证码的tf
    UITextField *codefield;            //密码的tf
    UIButton * sendSMSButton;         //验证码的button
    NSString * titleString;          //页面的title
}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [[BaseDataManager sharedBaseDataManager] getFindPwdBaseData];
    if (self.regType==RegisterTypeAdd) {
        titleString=@"注册";
    }else{
        titleString=@"绑定手机";
    }
    [self addTiTle:titleString];
    [self addimage:[UIImage imageNamed:@"导航_back"] title:nil selector:@selector(backClick) location:YES ];

    dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh)];
    dataTableView.bounces = YES;
    dataTableView.scrollEnabled = NO;
    [dataTableView setDelegate:self];
    [dataTableView setDataSource:self];
    [self.view addSubview:dataTableView];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self createUI];
}
-(void)createUI{
    dataTableView.backgroundColor=RGBACOLOR(233, 245, 248, 1);
    self.view.backgroundColor=RGBACOLOR(233, 245, 248, 1);
//    UIButton * registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(15,270,wid-30,40)];
//    
//    //    新注册的按钮
//    registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    [registerBtn setBackgroundImage:[UIImage imageNamed:@"btnNormal.png"]  forState:UIControlStateNormal];
//    [registerBtn setBackgroundImage:[UIImage imageNamed: @"btnHigh.png"] forState:UIControlStateHighlighted];
//    [registerBtn setTitle:_viewTitle forState:UIControlStateNormal];
//    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registerBtn];
    
//        新注册的Btn
    UIButton *registerButton = [MyControl createButtonWithFrame:CGRectMake(15,270,wid-30,40) title:titleString titleColor:[UIColor blackColor] imageName:nil bgImageName:@"btnNormal.png" target:self method:@selector(registerBtnClick)];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [registerButton setBackgroundImage:[UIImage imageNamed: @"btnHigh.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:registerButton];
    
    //如果是新注册
    if (self.regType==RegisterTypeAdd) {
//        UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 316,200, 35)];
//        showLabel.font =[UIFont boldSystemFontOfSize:11];
//        showLabel.backgroundColor = [UIColor clearColor];
//        showLabel.textColor = [UIColor grayColor];
//        showLabel.text =@"点击“注册”，表示你同意";
        
        UILabel *showLabel = [MyControl createLabelWithFrame:CGRectMake(15, 316,200, 35) text:@"点击“注册”，表示你同意" font:11 textcolor:[UIColor grayColor] textAlignment:0 backgroundColor:[UIColor clearColor]];
        [self.view addSubview:showLabel];
        
        //        协议条款
//        UIButton * argeementBtn = [[UIButton alloc]initWithFrame:CGRectMake(130, 316, 180, 35)];
//        [argeementBtn setTitle:@"《蓝鲸FM用户协议及软件许可》" forState:UIControlStateNormal];
//        [argeementBtn setTitleColor:RGBACOLOR(22, 169, 177, 1) forState:UIControlStateNormal];
//        [argeementBtn setTitleColor:RGBACOLOR(123, 169, 177, 1) forState:UIControlStateHighlighted];
//        argeementBtn.titleLabel.font =[UIFont boldSystemFontOfSize:11];
//        [argeementBtn addTarget:self action:@selector(argeementBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *agreeButton =[MyControl createButtonWithFrame:CGRectMake(130, 316, 180, 35) title:@"《蓝鲸FM用户协议及软件许可》" titleColor:RGBACOLOR(22, 169, 177, 1)  imageName:nil bgImageName:nil target:self method:@selector(agreeButtonClick)];
        agreeButton.titleLabel.font = [UIFont boldSystemFontOfSize:11];
        [self.view addSubview:agreeButton];
    }
}
/**
 *  点击注册按钮触发事件
 */
-(void)registerBtnClick{
    if (usernameField.text.length == 11 && smsField.text.length ==4 &&codefield.text.length >= 6) {
        NSString *pwdMd5=[UserInfoData getMD5_32Bit_String:codefield.text];
//        NSString *registerURLString = [Url RegisterUrl:usernameField.text andPwd:pwdMd5 andSms:_smsTF.text];
        //获取是否有通过微信来登陆，如果是，将uid一起传入后台
//        UserInfoData *userInfoData=[[[UserInfoData alloc]init] getUserDefault];
//        if (userInfoData.uid && self.regType==RegisterTypeBind) {
//            registerURLString=[registerURLString stringByAppendingString:[NSString stringWithFormat:@"&uid=%@",userInfoData.uid]];
//        }
//        [NetManager requestWithString:registerURLString finished:^(id responseObj) {
//            NSString *resCode =responseObj[@"resCode"];
//            NSString *resMsg =responseObj[@"resMsg"];
//            if ([resCode isEqual:RESCODE_OK]) {
//                if (self.regType==RegisterTypeAdd) {
//                    
//                    /**
//                     *  储存psd pwdMd5
//                     */
//                    UserInfoData *userInfoData=[[[UserInfoData alloc]init] getUserDefault];
//                    userInfoData.pwd=pwdMd5;
//                    [userInfoData setUserDefault:[userInfoData toDictionary] withLogin:YES];
//                    
//                    
//                    [self.navigationController popViewControllerAnimated:YES];
//                    [self showAlertView:@"注册成功"];
//                    
//                }else{
                    /**
                     *  储存psd pwdMd5
                     */
//                    UserInfoData *userInfoData=[[[UserInfoData alloc]init] getUserDefault];
//                    userInfoData.mphone=_usernameTF.text;
//                    userInfoData.pwd=pwdMd5;
//                    [userInfoData setUserDefault:[userInfoData toDictionary] withLogin:YES];
//                    [self.navigationController popViewControllerAnimated:YES];
//                    [self.delegate refreshInfoTableView];
//                }
//                [SVProgressHUD dismiss];
//            }else{
//                [SVProgressHUD dismiss];
//                [self showAlertView:[NSString stringWithFormat:@"失败:%@",resMsg]];
//            }
//        } failed:^(NSString *errorMsg) {
//            
//            [SVProgressHUD dismiss];
//            [self showAlertView:@"网络连接失败"];
//        }];
//        
//    }else{
//        [self showAlertView:@"请输入正确的手机号、验证码和6位以上的密码"];
//    }
    
}
}

//验证码按钮点击触发
-(void)sendSMSButtonClick{
//    if (usernameField.text.length ==11) {
//        [SVProgressHUD showInView:self.view status:@"验证码发送中..."];
//        NSString * URLStr = [Url SecurityCodeUrl:usernameField.text];
//        [NetManager requestWithString:URLStr finished:^(id responseObj) {
//            NSString *resCode = responseObj[@"resCode"];
//            NSString *resMsg = responseObj[@"resMsg"];
//            NSLog(@"SMS code is:%@",resMsg);
        
//            //如果返回成功，则进行短信验证码的倒计时
//            if ([resCode isEqualToString:RESCODE_OK]) {
//                [_sendSMSBtn setEnabled:NO];
//                [self reduceSMSTimer];
//            }else{
//                [self showAlertView:[NSString stringWithFormat:@"失败:%@",resMsg]];
//            }
//        } failed:^(NSString *errorMsg) {
//            [self showAlertView:@"网络连接失败"];
//        }];
//        [SVProgressHUD dismiss];
//    }else{
//        [self showAlertView:@"请输入正确的手机号"];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//更新的代码 验证码的的Timer，30秒倒计时
-(void)reduceSMSTimer{
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sendSMSButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                sendSMSButton.userInteractionEnabled = YES;
                [sendSMSButton setEnabled:YES];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sendSMSButton setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                sendSMSButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"registCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //手机号
    if (indexPath.row == 0){
        usernameField =[[UITextField alloc] initWithFrame:CGRectMake( 50, 2, wid-72, 40)];
        cell.imageView.image=[UIImage imageNamed:@"mphone.png"];
        [usernameField setLeftViewMode:UITextFieldViewModeAlways];
        [usernameField setPlaceholder:@"手机号"];
        usernameField.keyboardType=UIKeyboardTypePhonePad;
        usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        usernameField.delegate = self;
        [cell addSubview:usernameField];
    }
    //验证码
    else if(indexPath.row == 1){
        smsField =[[UITextField alloc] initWithFrame:CGRectMake( 50, 2, wid-72, 40)];
        cell.imageView.image=[UIImage imageNamed:@"SMS.png"];
        [smsField setLeftViewMode:UITextFieldViewModeAlways];
        [smsField setPlaceholder:@"验证码"];
        smsField.keyboardType=UIKeyboardTypeNumberPad;
        //          _smsTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        smsField.delegate=self;
        [cell addSubview:smsField];
        
        sendSMSButton=[[UIButton alloc] initWithFrame:CGRectMake(wid-115, 5, 100, 35)];
        [sendSMSButton setTitle:@"验证码" forState:UIControlStateNormal];
        [sendSMSButton setBackgroundImage:[UIImage imageNamed:@"sendSMSBtn.png"] forState:UIControlStateNormal];
        [sendSMSButton setBackgroundImage:[UIImage imageNamed:@"sendSMSBtnDiable"] forState:UIControlStateDisabled];
        
        sendSMSButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        sendSMSButton.titleLabel.textColor = [UIColor grayColor];
        [sendSMSButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [sendSMSButton addTarget:self action:@selector(sendSMSButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:sendSMSButton];
    }
    //密码
    else if(indexPath.row == 2){
        codefield =[[UITextField alloc] initWithFrame:CGRectMake( 50,2, wid-72, 40)];
        cell.imageView.image=[UIImage imageNamed:@"pwd.png"];
        codefield.clearButtonMode = UITextFieldViewModeWhileEditing;
        [codefield setLeftViewMode:UITextFieldViewModeAlways];
        [codefield setPlaceholder:@"密码"];
        codefield.secureTextEntry=YES;
        codefield.delegate=self;
        [cell addSubview:codefield];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
    
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
    /**
     *  判断TextField的最大字符数，手机号11位，验证码4位，密码25位
     *
     *  @param textField
     *  @param range
     *  @param string
     *
     *  @return 是否允许更改
     */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        NSUInteger length=0;
        if (textField==usernameField) {
            length=11;
        }else if(textField==smsField){
            length=4;
        }else{
            length=25;
        }
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        return newLength <= length;
}
    
#pragma mark - button click or gesture event
    
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
        [self.view endEditing:YES];
}
    
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES ];
}
    
-(void)argeementBtnClick{
//    RadPicTapController *radPicTapVC = [[RadPicTapController alloc] init];
//    radPicTapVC.str =[Url agreementUrl];
//    radPicTapVC.titleStr = @"用户协议及软件许可";
//    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:radPicTapVC];
//    nav.hidesBottomBarWhenPushed =YES;
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];
//    
    
    
    
    
    //    url radio/lisence
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
