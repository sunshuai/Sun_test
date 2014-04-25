//
//  Sun_Config.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>



// 主页标题
#define HOME_NAVIGATION_TITLE 				@"首页"
#define BRAND_NAVIGATION_TITLE 				@"分类"
#define CLASSIFIED_NAVIGATION_TITLE 		@"购物车"
#define SHOPPINGCART_NAVIGATION_TITLE 		@"个人中心"
#define MORE_NAVIGATION_TITLE 				@"更多"


/**
 登陆成功通知
 */
#define GS_NOTIFICATION_login_success       @"GS_NOTIFICATION_login_success"    
/**
 注册成功通知
 */
#define GS_NOTIFICATION_reg_sucess          @"GS_NOTIFICATION_reg_success"       
/**
 注销通知
 */
#define GS_NOTIFICATION_login_out           @"GS_NOTIFICATION_login_out"       
/**
 没有登陆直接返回的通知
 */
#define GS_NOTIFICATION_nologin_back           @"GS_NOTIFICATION_nologin_back" 

/**
 TabBar的高度
 */
extern const CGFloat TABBAR_HEIGHT;
/**
 TabBar的背景色
 */
extern const NSString* TABBAR_IMAGE;
/**
 TabBar的选中效果图, 可以为空，空则不显示
 */
extern const NSString* TABBAR_GLOW_IMAGE; //空则不显示
/**
 TabBar的第一个ViewController
 */
extern const NSString* YK_B2C_CLASS_PAGE_1;
/**
 TabBar的第一个ViewController的导航栏标题
 */
extern const NSString* YK_B2C_CLASS_PAGE_1_TITLE;
/**
 第一个TabBar的图标
 */
extern const NSString* YK_B2C_CLASS_PAGE_1_ICON;

/**
 TabBar的第二个ViewController
 */
extern const NSString* YK_B2C_CLASS_PAGE_2;
/**
 TabBar的第二个ViewController的导航栏标题
 */
extern const NSString* YK_B2C_CLASS_PAGE_2_TITLE;
/**
 第二个TabBar的图标
 */
extern const NSString* YK_B2C_CLASS_PAGE_2_ICON;

/**
 TabBar的第三个ViewController
 */
extern const NSString* YK_B2C_CLASS_PAGE_3;

/**
 第三个TabBar的图标
 */
extern const NSString* YK_B2C_CLASS_PAGE_3_ICON;

/**
 TabBar的第四个ViewController
 */
extern const NSString* YK_B2C_CLASS_PAGE_4;

/**
 第四个TabBar的图标
 */
extern const NSString* YK_B2C_CLASS_PAGE_4_ICON;

/**
 TabBar的第五个ViewController
 */
extern const NSString* YK_B2C_CLASS_PAGE_5;

/**
 第五个TabBar的图标
 */
extern const NSString* YK_B2C_CLASS_PAGE_5_ICON;


/**
 UINavgationBar的背景图
 */
extern const NSString* GS_NAVGATIONBAR_BACKGROUND_ICON;

extern const NSString* 						TABBAR_ITEM_SELECTED_BACKGROUND_IMAGE; 	// 空则不显示

extern const NSString* 						TABBAR_NIPPLE_IMAGE; 					// 空则不显示


@interface Sun_Config : NSObject

@end
