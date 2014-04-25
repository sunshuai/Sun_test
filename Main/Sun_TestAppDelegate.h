//
//  Sun_TestAppDelegate.h
//  Sun_test
//
//  Created by Shuai Sun on 12-7-4.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LaunchAction.h"

@class Sun_TestViewController;

@interface Sun_TestAppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate, SunActionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Sun_TestViewController *viewController;

@property (retain, nonatomic) NSString *m_updateURL;
@property (retain, nonatomic) LaunchAction *m_launchaction;

// 自定义程序完成加载
- (BOOL)application:(UIApplication *)application myDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(void)applicationExit;



// 更新版本
- (void)updateApp;

// 检测版本
- (void)requestCurrentVersion;
// 启动图片
- (void)requestLoadingImage;

// 评价提醒
- (void)evaluateTheApp;

@end
