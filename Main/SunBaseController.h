//
//  SunBaseController.h
//  Sun_test
//
//  Created by Shuai Sun on 12-7-17.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SunBaseController : UIViewController
{
    NSString 						*m_str_navTitle;			// 导航栏标题
    NSString 						*m_str_backButtonTitle;		// 返回按钮
    BOOL                            isMainPage;                 // 主页标志位
}

@property (nonatomic, retain) NSString 						*m_str_navTitle;
@property (nonatomic, assign) NSString 						*m_str_backButtonTitle;
@property (nonatomic, assign) BOOL 							isMainPage;



// 导航栏按钮
-(void)creatLeftNavItemButton;
-(void)creatTittleNavItemButton;
-(void)creatRightNavItemButton;
- (void)setCustomNavBackButtonHidden:(BOOL)aHidden;

-(void)basePopViewControllerAnimated:(BOOL)aAnimated;

-(void)m_str_navTitle:(NSString*)navTitle;
-(NSString*)m_str_navTitle;
-(void)isMainPage:(BOOL)isMain;

// alertView
-(void)alertWithMassage:(NSString *)message;
-(void)alertWithMassage:(NSString *)message Tag:(NSInteger)tag cancel:(NSString *)cancelTitile other:(NSString *)otherTItle;

@end
