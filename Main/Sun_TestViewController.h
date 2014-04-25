//
//  Sun_TestViewController.h
//  Sun_test
//
//  Created by Shuai Sun on 12-7-4.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SunCustomTabBar.h"
#import "BadgeView.h"

@interface Sun_TestViewController : UIViewController <CustomTabBarDelegate>
{
    SunCustomTabBar                *m_customTabBar;    // 工具栏的对象
    BadgeView *shoppingBadgeView;//购物袋的标签
    BadgeView *myGlamourBadgeView;//待付款订单数量标签
    
    NSArray 					*m_array_tabBarItems; // 工具条个数
    UIImageView                 *m_glow;                            // 光标
    NSInteger					currentIndex;                       // 当前所处的页数
    NSInteger                   lastIndex;
    
    UINavigationController      *payMementPage;
    
	UINavigationController 		*m_navCtrl_homePage;                // 主页导航条
	UINavigationController 		*m_navCtrl_BrandPage;               // 品牌馆导航条
	UINavigationController 		*m_navCtrl_classifiedPage;          // 选包包导航条
	UINavigationController 		*m_navCtrl_shoppingcartPage;        // 购物车导航条
	UINavigationController 		*m_navCtrl_morePage;                // 更多导航条
    
    BOOL                        isHiddenTabBar;         // 隐藏tab
    NSInteger                   badgeNumber;            // 购物车数量
}


@property (nonatomic, retain) SunCustomTabBar *m_customTabBar;
/**
 *	@brief	我的资料数字图标
 *	
 *	显示我的资料的数字图标
 */
@property (nonatomic,retain) BadgeView *myGlamourBadgeView;

/**
 *	@brief	购物袋的数字图标
 *	
 *	显示购物袋的数字图标
 */
@property (nonatomic,retain) BadgeView *shoppingBadgeView;

@property (nonatomic, assign) UINavigationController *m_navCtrl_homePage;
@property (nonatomic, assign) UINavigationController *m_navCtrl_BrandPage;
@property (nonatomic, assign) UINavigationController *m_navCtrl_classifiedPage;
@property (nonatomic, assign) UINavigationController *m_navCtrl_shoppingcartPage;
@property (nonatomic, assign) UINavigationController *m_navCtrl_morePage;
@property (nonatomic, retain) UINavigationController *payMementPage;

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) NSInteger lastIndex;
@property (nonatomic,assign) BOOL  isHiddenTabBar;
@property (retain, nonatomic) IBOutlet UIButton *button;


/**
 *	@brief	是否隐藏tabbar
 *	
 *	根据传参判断是否隐藏tabBar，YES隐藏
 *
 */
+(void)tabBarHidden:(BOOL)hidden animated:(BOOL)animated;
/**
 *	@brief	获取一个全局的实例
 *	
 *	如果不存在则创建一个
 *
 *	@return	返回一个Sun_TestViewController实例
 */
+(Sun_TestViewController *)shareInstance;

// 设置标记数字
- (void)setBadgeNumber:(int)_num;

-(IBAction)buttonPressed:(id)sender;



@end


@interface MyException : NSException    
-(void)popAlert ;

@end
