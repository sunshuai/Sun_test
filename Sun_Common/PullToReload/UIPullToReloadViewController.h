//
//  UIPullToReloadViewController.h
//  SeeyonFlow
//
//  Created by YuHui on 10-11-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPullToReloadHeaderView.h"
#import "UIPullToReloadFooterView.h"
#import "SunBaseController.h"


@interface UIPullToReloadViewController: SunBaseController
		<UIScrollViewDelegate> 
{
@private
	UIPullToReloadHeaderView	*pullToReloadHeaderView;	// 下拉视图
	UIPullToReloadFooterView	*pullToReloadFooterView;	// 上拉视图
	BOOL						checkForRefresh;			// 检查刷新
	
    UITableView*                m_FooterTableView;                // 作用目标
	BOOL						isFooterEnable;				// 上拉功能是否可用
}

@property(nonatomic, readonly)UIPullToReloadHeaderView *pullToReloadHeaderView;
@property(nonatomic, readonly)UIPullToReloadFooterView *pullToReloadFooterView;

/**
 * 设置下拉刷新数据视图到表格视图
 *
 * aTableView:		目标表格视图
 * aBkColor:		下拉视图背景颜色
 * aFooterView:     表视图的，footer视图
 *
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(void)setPullReloadFooterToTableView:(UITableView*)aTableView bkColor:(UIColor *)aBkColor footerView:(UIView*)aFooterView;

// 设置上拉功能是否可用
- (void)setPullReloadUpEnable:(BOOL)aEnable;

// 设置pullToReloadView背景
- (void)setPullReloadBkColor:(UIColor *)aBkColor;

// 子类重写此函数，下拉刷新事件产生时，调用此函数
-(void)pullDownToReloadAction;

// 子类重写此函数，上拉刷新事件产生时，调用此函数
-(void)pullUpToReloadAction;

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate ;


// ***********************************以下函数可以不用********************************************************
// 设置pullToReloadHeaderView背景
- (void)setPullReloadHeaderBkColor:(UIColor *)aBkColor;

/**
 * 设置目标表格视图
 *
 * @aTableView:		目标表格
 * @aFooterView:	上拉视图
 * @aEnable:		是否可以上拉
 *
 */
- (void)setTargetWithTableView:(UITableView *)aTableView andFooterView:(UIView *)aFooterView upEnable:(BOOL)aEnable;

/**
 * 设置下拉刷新数据头视图到表格视图
 *
 * aTableView:		目标表格视图
 * aBkColor:		下拉视图背景颜色
 *
 */
-(void)setPullReloadHeaderToTableView:(UITableView*)aTableView bkColor:(UIColor *)aBkColor;



@end
