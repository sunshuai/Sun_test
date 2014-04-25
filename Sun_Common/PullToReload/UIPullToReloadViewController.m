//
//  UIPullToReloadViewController.m
//  SeeyonFlow
//
//  Created by YuHui on 10-11-16.
//  Copyright 2010 Seeyon ShangHai. All rights reserved.
//

#import "UIPullToReloadViewController.h"


@implementation UIPullToReloadViewController
@synthesize pullToReloadHeaderView, pullToReloadFooterView;
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
	[pullToReloadHeaderView release]; 
	pullToReloadHeaderView = nil;	
	
	[pullToReloadFooterView release]; 
	pullToReloadFooterView = nil;	
}

- (void)dealloc {
	[pullToReloadHeaderView release]; 
	pullToReloadHeaderView = nil;	
	
	[pullToReloadFooterView release]; 
	pullToReloadFooterView = nil;	
    [super dealloc];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	if ([pullToReloadHeaderView status] == kPullStatusLoading || [pullToReloadFooterView status] == kPullStatusLoading) return;
	checkForRefresh = YES;  //  only check offset when dragging
} 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if ([pullToReloadHeaderView status] == kPullStatusLoading || [pullToReloadFooterView status] == kPullStatusLoading) return;
	
	if (checkForRefresh) {
		// 下拉
		if (pullToReloadHeaderView) {
			if (scrollView.contentOffset.y > -kPullDownToReloadToggleHeight && scrollView.contentOffset.y < 0.0f) {
				[pullToReloadHeaderView setStatus:kPullStatusPullDownToReload animated:YES];
				
			} else if (scrollView.contentOffset.y < -kPullDownToReloadToggleHeight) {
				[pullToReloadHeaderView setStatus:kPullStatusReleaseToReload animated:YES];
			}
		}
		
		// 上拉
		if( pullToReloadFooterView  && isFooterEnable ) {
			if (scrollView.contentSize.height <= scrollView.bounds.size.height) {
				if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < kPullDownToReloadToggleHeight) {
					[pullToReloadHeaderView setStatus:kPullStatusPullDownToReload animated:YES];
					
				} else if (scrollView.contentOffset.y > kPullDownToReloadToggleHeight) {
					[pullToReloadHeaderView setStatus:kPullStatusReleaseToReload animated:YES];
				}
			}
			else {
				if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height && scrollView.contentOffset.y < scrollView.contentSize.height - scrollView.bounds.size.height + 40/*kPullDownToReloadToggleHeight*/) {
					[pullToReloadFooterView setStatus:kPullStatusPullDownToReload animated:YES];
					
				} else if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height + 20/*kPullDownToReloadToggleHeight*/) {
					[pullToReloadFooterView setStatus:kPullStatusReleaseToReload animated:YES];
				}
			}
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if ( [pullToReloadHeaderView status] == kPullStatusLoading || [pullToReloadFooterView status] == kPullStatusLoading ) return;
	
	// 下拉
	if ([pullToReloadHeaderView status]==kPullStatusReleaseToReload) {
		[pullToReloadHeaderView startReloading:(UITableView*)scrollView animated:YES];
		[self pullDownToReloadAction];
	}
	
	// 上拉
	if ( [pullToReloadFooterView status] == kPullStatusReleaseToReload && isFooterEnable ) {
	  [pullToReloadFooterView startReloading:(UITableView*)scrollView animated:YES];
	  [self pullUpToReloadAction];
    }
	checkForRefresh = NO;
}

#pragma mark actions
-(void) pullDownToReloadAction {
	NSLog(@"TODO: Overload this");
}

-(void)pullUpToReloadAction
{
	NSLog(@"TODO: Overload this");
}

// 设置上拉功能是否可用
- (void)setPullReloadUpEnable:(BOOL)aEnable {
	isFooterEnable = aEnable;
    
    if (isFooterEnable) {
        m_FooterTableView.tableFooterView.hidden = NO;
    }
    else
    {
        m_FooterTableView.tableFooterView.hidden = YES;
    }
}

// 设置pullToReloadView背景
- (void)setPullReloadBkColor:(UIColor *)aBkColor {
	pullToReloadHeaderView.backgroundColor = aBkColor;
	pullToReloadFooterView.backgroundColor = aBkColor;
}

// 设置pullToReloadHeaderView背景
- (void)setPullReloadHeaderBkColor:(UIColor *)aBkColor {
	pullToReloadHeaderView.backgroundColor = aBkColor;
}

// 设置下拉刷新数据头视图到表格视图
-(void)setPullReloadHeaderToTableView:(UITableView*)aTableView bkColor:(UIColor *)aBkColor {
	// 下拉视图
	if ( !pullToReloadHeaderView ) {
		[pullToReloadHeaderView release];
		pullToReloadHeaderView = [[UIPullToReloadHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - aTableView.bounds.size.height,
																							 320.0f, aTableView.bounds.size.height)];
	}
	pullToReloadHeaderView.backgroundColor = aBkColor;
	[aTableView addSubview:pullToReloadHeaderView];
}

// 设置上拉刷新数据头视图到表格视图
-(void)setPullReloadFooterToTableView:(UITableView*)aTableView bkColor:(UIColor *)aBkColor footerView:(UIView*)aFooterView {
	
    m_FooterTableView = aTableView;
    
	// 上拉视图
	if ( !pullToReloadFooterView ) {
		[pullToReloadFooterView release];
		pullToReloadFooterView = [[UIPullToReloadFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
																							320.0f, aTableView.bounds.size.height)];
	}
	
	pullToReloadFooterView.backgroundColor = aBkColor;
	pullToReloadFooterView.clipsToBounds = YES;
    
    if (aFooterView == nil) {
        [aTableView.tableFooterView insertSubview:pullToReloadFooterView atIndex:0];
    }
    else
        [aFooterView insertSubview:pullToReloadFooterView atIndex:0];
}

// 设置目标表格视图
- (void)setTargetWithTableView:(UITableView *)aTableView andFooterView:(UIView *)aFooterView upEnable:(BOOL)aEnable {
	
	isFooterEnable = aEnable;
	
	// 下拉视图
	if ( !pullToReloadHeaderView ) {
		pullToReloadHeaderView = [[UIPullToReloadHeaderView alloc] 
								  initWithFrame:CGRectMake(0.0f, 0.0f - aTableView.bounds.size.height, 320.0f, aTableView.bounds.size.height)];
		
	}
	
	pullToReloadFooterView.frame = CGRectMake(0.0f, 0.0f - aTableView.bounds.size.height, 320.0f, aTableView.bounds.size.height);
	[pullToReloadHeaderView removeFromSuperview];
	[aTableView addSubview:pullToReloadHeaderView];
	
	// 上拉视图
	if ( !pullToReloadFooterView ) {
		pullToReloadFooterView = [[UIPullToReloadFooterView alloc] 
								  initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, aTableView.bounds.size.height)];
	}
	
	pullToReloadFooterView.frame = CGRectMake(0.0f, 0.0f, 320.0f, aTableView.bounds.size.height);// CGRectMake(0.0f, 0.0f, 320.0f, aFooterView.size.height);
	
	[pullToReloadFooterView removeFromSuperview];
	[aFooterView insertSubview:pullToReloadFooterView atIndex:0];
}

@end
