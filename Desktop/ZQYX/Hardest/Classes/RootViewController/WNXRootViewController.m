//
//  RootViewController.m
//  Hardest
//
//  Created by 维尼的小熊 on 16/2/23.
//  Copyright © 2016年 维尼的小熊. All rights reserved.

//  GitHub地址:     https://github.com/ZhongTaoTian
//  Blog讲解地址:    http://www.jianshu.com/users/5fe7513c7a57/latest_articles
//  小熊的新浪微博:   http://weibo.com/5622363113/profile?topnav=1&wvr=6

#import "WNXRootViewController.h"
#import "MainUIWebViewController.h"
#import "MainWebLLViewController.h"
#import "HttpConnectt.h"
#import "IPConfigModel.h"
#import "WNXBaseNavigationController.h"

@interface WNXRootViewController ()
{
    CGRect _settingFrame;
    CGRect _languageFrame;
    CGRect _moreFrame;
    CGRect _rankFrame;
    CGRect _playFrame;
    CGRect _getFrame;
    BOOL _isNotFristLoad;
}

@end

@implementation WNXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getIPConfigData];
    
    [self.view setBackgroundImageWihtImageName:@"home_bg.jpg"];
    
//    [self loadHomeButtonFrame];
    [self creatBtn];
}

//获取web  A 切换数据
- (void)getIPConfigData{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    
    NSMutableDictionary *paramsMutDic = [NSMutableDictionary new];
    [paramsMutDic setObject:@"appstore" forKey:@"channel"];
    [paramsMutDic setObject:version forKey:@"version"];
    [paramsMutDic setObject:bundleId forKey:@"bundldId"];
    [paramsMutDic setObject:@"0" forKey:@"client"];
    
    __weak typeof(self) weakSelf = self;
    
    [HttpConnectt HttpWithURL:@"https://operate.liulianggame.com/operate/app/nodes" paramDic:paramsMutDic completion:^(NSDictionary * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (error == nil && [data[@"code"] integerValue] == 0) {
            NSDictionary *successInfoDic = [data objectForKey:@"data"];
            IPConfigModel *dataModel = [IPConfigModel modelWithJSON:successInfoDic];
            NSInteger styleNum = [dataModel.projectStatus integerValue];//项目状态 1A 2B 3 WAP
            switch (styleNum) {
                case 3:
                {
                    //web
                    [strongSelf changeRootViewcontroller:dataModel];
                }
                    break;
                    
                default:
                {
                    //A
//                    [strongSelf comeToGame];
                }
                    break;
            }
        }else{
//            [strongSelf comeToGame];
        }
    }];
    
}


//切换根视图
- (void)changeRootViewcontroller:(IPConfigModel *)congigModel{
    if ([congigModel.webKitType isEqualToString:@"WKWeb"]) {
        MainWebLLViewController *wkWebPage = [[MainWebLLViewController alloc]init];
        wkWebPage.linkUrl = congigModel.webUrl;
        [UIApplication sharedApplication].keyWindow.rootViewController = wkWebPage;
    }else{
        MainUIWebViewController *uiWebPage = [[MainUIWebViewController alloc]init];
        uiWebPage.linkUrl = congigModel.webUrl;
        [UIApplication sharedApplication].keyWindow.rootViewController = uiWebPage;
    }
}

- (void)comeToGame{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WNXBaseNavigationController *rootNav = (WNXBaseNavigationController *)[sb instantiateViewControllerWithIdentifier:@"RootNavigationController"];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootNav;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_isNotFristLoad) {
        [[WNXSoundToolManager sharedSoundToolManager] playBgMusicWihtPlayAgain:YES];
    }
    
    _isNotFristLoad = YES;
}

- (void)creatBtn{
//    UIButton *setBtn = [[UIButton alloc] initWithFrame:CGRectMake(11, 246,74, 74)];
//    [setBtn setImage:[UIImage imageNamed:@"zq_set_0419"] forState:UIControlStateNormal];
//    [setBtn addTarget:self action:@selector(goSettingPage) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:setBtn];
    
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, [UIScreen mainScreen].bounds.size.height - 200, 80, 80)];
    [playBtn setImage:[UIImage imageNamed:@"zq_go_0419"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
}
- (void)goSettingPage{
    [self performSegueWithIdentifier:@"Setting" sender:nil];
}

- (void)startGame{
    [self performSegueWithIdentifier:@"PlayGame" sender:nil];
}

//- (void)loadHomeButtonFrame {
//    NSString *framePath = [[NSBundle mainBundle] pathForResource:@"home.plist" ofType:nil];
//    NSDictionary *frameDic = [NSDictionary dictionaryWithContentsOfFile:framePath];
//
//    NSDictionary *dict;
//
//    if (iPhone5) {
//        dict = frameDic[@"iphone5"];
//    } else {
//        dict = frameDic[@"iphone4"];
//    }
//
//    _settingFrame = CGRectFromString(dict[@"btn_setting_frame"]);
//    _languageFrame = CGRectFromString(dict[@"btn_language_frame"]);
//    _moreFrame = CGRectFromString(dict[@"btn_more_frame"]);
//    _rankFrame = CGRectFromString(dict[@"btn_rank_frame"]);
//    _playFrame = CGRectFromString(dict[@"btn_play_frame"]);
//    _getFrame = CGRectFromString(dict[@"btn_get_frame"]);
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//
//    CGPoint touchPoint = [touch locationInView:touch.view];
////    NSLog(@"%d ---- %f",touchPoint.x,touchPoint.y);
//    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName: kSoundCliclName];
//
//    if (CGRectContainsPoint(_settingFrame, touchPoint)) {
//
//        [self performSegueWithIdentifier:@"Setting" sender:nil];
//
//    } else if (CGRectContainsPoint(_languageFrame, touchPoint)) {
//
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kBlogURL]];
//
//    } else if (CGRectContainsPoint(_moreFrame, touchPoint)) {
//
////        [self performSegueWithIdentifier:@"Rare" sender:nil];
//
//    } else if (CGRectContainsPoint(_rankFrame, touchPoint)) {
//
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kWeiBoURL]];
//
//    } else if (CGRectContainsPoint(_playFrame, touchPoint)) {
//
//        [self performSegueWithIdentifier:@"PlayGame" sender:nil];
//
//    } else if (CGRectContainsPoint(_getFrame, touchPoint)) {
//
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kGithubUrl]];
//
//    }
//}

@end
