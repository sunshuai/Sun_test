//
//  Sun_TestAppDelegate.m
//  Sun_test
//
//  Created by Shuai Sun on 12-7-4.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_TestAppDelegate.h"

#import "Sun_TestViewController.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "Sun_DateUtility.h"// 过期时间判断
#import "LaunchCount.h"
#import "ServerTimeUtility.h"

#define UPDATE_APP_OPTIONAL_TAG  68465
#define UPDATE_APP_FORCE_TAG     78454
#define EVALUATE_APP_TAG   88411
#define TEST_VERSION_TAG     20001
#define TEST_VERSION_TIMEOUT_TAG     20002

@implementation Sun_TestAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize m_updateURL;
@synthesize m_launchaction;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [m_updateURL release];
    [m_launchaction release];
    [super dealloc];
}


// 退出程序
-(void)applicationExit
{
    exit(0);//
}

/*
 获取运行商名称
 */
-(NSString *)getCarrierName
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	NSString* carrierName=nil;
    if (nil!=NSClassFromString(@"CTTelephonyNetworkInfo")){
		//
		CTTelephonyNetworkInfo* netInfo=[[CTTelephonyNetworkInfo alloc] init];
		if(netInfo!=nil){
			CTCarrier* carrier=netInfo.subscriberCellularProvider;
			if(carrier!=nil){
				carrierName=[carrier.carrierName copy];
			}
		}
		[netInfo autorelease];
	}
	[pool release];
	return [carrierName autorelease];
}
/*
 进入应用程序
 */
- (void)applicationEntry
{
    
    // 服务器时间
    [ServerTimeUtility requestServerTime];
    
    //  判断是否需要评价提醒
    if ([[LaunchCount sharedLaunchCount] shouldShowAlertView]) {
        //  评价提醒
        [self evaluateTheApp];
    }
    
    // loading图片
    [self requestLoadingImage];
}

// 启动图片
- (void)requestLoadingImage{
    
    [m_launchaction release];
    m_launchaction = [[LaunchAction alloc] initWithDelegate:self];
    [m_launchaction requestLoadingImage];
}


#pragma mark 程序启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef TEST_VERSION
    NSString *strTestVersion = [NSString stringWithFormat:@"测试版本V%@",APP_TEST_VERSION];
    NSTimeInterval timeout = [[Sun_DateUtility NSStringDateToNSDate:APP_TEST_TIMEOUT withDateFormat:@"yyyy-MM-dd HH:mm:ss"] timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (timeout>now) { // 过期
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:strTestVersion message:@"此版本为测试版本,您确定继续运行吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        alertView.tag = TEST_VERSION_TAG;
        [alertView show];
        [alertView release];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:strTestVersion message:@"该测试版本已过期,请安装新包." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = TEST_VERSION_TIMEOUT_TAG;
        [alertView show];
        [alertView release];
    }

#endif
    [self application:application myDidFinishLaunchingWithOptions:launchOptions];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 接受远程通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	
	NSLog(@"remote notification----------------------------------------------------: %@",[userInfo description]);
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];
	NSLog(@"Received Push Alert: %@", alert);
    
	NSString *sound = [apsInfo objectForKey:@"sound"];
	NSLog(@"Received Push Sound: %@", sound);
	
	NSString *badge = [apsInfo objectForKey:@"badge"];
	
	NSLog(@"Received Push Badge: %@", badge);
	application.applicationIconBadgeNumber = 0;
	
	if(alert!=nil){
        UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:@"" message:alert delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
		[alertView release];
	}
	[pool release];
    
    [[[Sun_TestViewController shareInstance] m_navCtrl_homePage] popToRootViewControllerAnimated:YES];
    [[[Sun_TestViewController shareInstance] m_customTabBar] selectItemAtIndex:0];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"DeviceTokenFailed: %@",error);
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 自定义程序完成加载
- (BOOL)application:(UIApplication *)application myDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[Sun_TestViewController alloc] initWithNibName:@"Sun_TestViewController" bundle:nil] autorelease];
    
    self.window.rootViewController = _viewController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


-(void)onActionResponse:(id)aResponse requestTag:(NSString *)aRequestTag result:(SunResult *)aResult
{
    if (aResult.isSuccess) {
        
        if ([aRequestTag isEqualToString:(NSString *)TAG_LAUNCH_VERSION]) {
            
        }
    }
}
-(void)onActionFailed:(NSError *)aError requestTag:(NSString *)aRequestTag
{
    
}

#pragma UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case UPDATE_APP_FORCE_TAG:
            if (buttonIndex == 0) {
                [self updateApp];
            }
            break;
            
        case UPDATE_APP_OPTIONAL_TAG:
            if (buttonIndex == 0) {
                [self applicationEntry];
            }
            else {
                [self updateApp];
            }
            break;
            
        case EVALUATE_APP_TAG:
            if (buttonIndex == 1) { // 现在去评价
                [[LaunchCount sharedLaunchCount] stopShowAlertViewAnyMore];
                NSURL *url = [NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=510289916"];
                [[UIApplication sharedApplication] openURL:url];
            }
            else if (buttonIndex == 2) { // 暂不评价
                
            }
            else{ // 不再理会
                [[LaunchCount sharedLaunchCount] stopShowAlertViewAnyMore];
            }
            break;
            
        case TEST_VERSION_TAG:
            if (buttonIndex == 0) {
                
            }
            else {
                [self applicationExit];
            }
            break;
        case TEST_VERSION_TIMEOUT_TAG:
            [self applicationExit];
            break;
        default:
            break;
    }
}


#pragma mark  UpData App methods
- (void)updateApp
{
    NSURL *url = [NSURL URLWithString:self.m_updateURL];
	[[UIApplication sharedApplication] openURL:url];
	[self applicationExit];
}

#pragma mark  evaluate methods
- (void)evaluateTheApp
{
    if ([[LaunchCount sharedLaunchCount] getLaunchCount] % 6 == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"喜欢魅力惠iphone版客户端吗？喜欢的话烦请给我们一个评价吧" delegate:self cancelButtonTitle:@"不再理会" otherButtonTitles:@"现在去评价",@"暂不评价",nil];
        [alert show];
        alert.tag = EVALUATE_APP_TAG;
        [alert release];
    }
}

#pragma mark  Version methods
// 版本检测
- (void)requestCurrentVersion
{
    [m_launchaction release];
    m_launchaction = [[LaunchAction alloc] initWithDelegate:self];
    [m_launchaction requestVersion];
}

@end
