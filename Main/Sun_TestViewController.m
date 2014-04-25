//
//  Sun_TestViewController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-7-4.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_TestViewController.h"

#import "Sun_HomeViewController.h"
#import "Sun_CategoryViewController.h"
#import "Sun_OtherViewController.h"
#import "Sun_SearchViewController.h"
#import "Sun_ShopCartViewController.h"

#import "Sun_Config.h"

#define TABBAR_ITEM_NUMBER 5
#define TABBAR_KEY_ICON @"icon"
#define TABBAR_KEY_VIEWCTRL @"viewController"
#define SELECTED_VIEW_CONTROLLER_TAG 98456345

static NSArray *s_tabBarItems = nil;
static Sun_TestViewController *s_sunViewCtroller = nil;


@implementation MyException

-(void)popAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tips" message:self.reason delegate:nil cancelButtonTitle:@"sure" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

@end

@interface Sun_TestViewController (private)

-(void)initTabBarAndCtrl;

@end

@implementation Sun_TestViewController
@synthesize button;
@synthesize payMementPage;
@synthesize m_customTabBar;
@synthesize m_navCtrl_homePage;
@synthesize m_navCtrl_BrandPage;
@synthesize m_navCtrl_classifiedPage;
@synthesize m_navCtrl_shoppingcartPage;
@synthesize m_navCtrl_morePage;
@synthesize shoppingBadgeView,myGlamourBadgeView;
@synthesize currentIndex, lastIndex;
@synthesize isHiddenTabBar;


+(Sun_TestViewController *)shareInstance
{
    if (s_sunViewCtroller == nil) {
        s_sunViewCtroller = [[Sun_TestViewController alloc] initWithNibName:@"Sun_TestViewController" bundle:nil];
    }
    return s_sunViewCtroller;
}


-(void)initTabBarAndCtrl
{
    // Page 1
    Class l_class_page_1 = NSClassFromString((NSString *)YK_B2C_CLASS_PAGE_1);
    id l_ViewCtrl_page_1 = [[l_class_page_1 alloc] initWithNibName:(NSString*)YK_B2C_CLASS_PAGE_1 bundle:nil];
//    [(SunBaseController *)l_ViewCtrl_page_1 m_str_navTitle:HOME_NAVIGATION_TITLE];
//    [l_ViewCtrl_page_1 isMainPage:TRUE];
    m_navCtrl_homePage = [[UINavigationController alloc] initWithRootViewController:l_ViewCtrl_page_1];
    [l_ViewCtrl_page_1 release];
    
    // Page 2
    Class l_class_page_2 = NSClassFromString((NSString *)YK_B2C_CLASS_PAGE_2);
    id l_ViewCtrl_page_2 = [[l_class_page_2 alloc] initWithNibName:(NSString*)YK_B2C_CLASS_PAGE_2 bundle:nil];
    m_navCtrl_BrandPage = [[UINavigationController alloc] initWithRootViewController:l_ViewCtrl_page_2];
    
    // Page 3
	Class l_class_page_3 = NSClassFromString((NSString *)YK_B2C_CLASS_PAGE_3);
	id l_ViewCtrl_page_3 = [[l_class_page_3 alloc] initWithNibName:(NSString *)YK_B2C_CLASS_PAGE_3 bundle:nil];
	m_navCtrl_classifiedPage = [[UINavigationController alloc] initWithRootViewController:l_ViewCtrl_page_3];
	[l_ViewCtrl_page_3 release];
	
	// Page 4
	Class l_class_page_4 = NSClassFromString((NSString *)YK_B2C_CLASS_PAGE_4);
	id l_ViewCtrl_page_4 = [[l_class_page_4 alloc] initWithNibName:(NSString *)YK_B2C_CLASS_PAGE_4 bundle:nil];
	m_navCtrl_shoppingcartPage = [[UINavigationController alloc] initWithRootViewController:l_ViewCtrl_page_4];
	[l_ViewCtrl_page_4 release];
	
	// Page 5
	Class l_class_page_5 = NSClassFromString((NSString *)YK_B2C_CLASS_PAGE_5);
	id l_ViewCtrl_page_5 = [[l_class_page_5 alloc] initWithNibName:(NSString *)YK_B2C_CLASS_PAGE_5 bundle:nil];
	m_navCtrl_morePage = [[UINavigationController alloc] initWithRootViewController:l_ViewCtrl_page_5];
	[l_ViewCtrl_page_5 release];
    
    s_tabBarItems = [[NSArray arrayWithObjects:
                           [NSDictionary dictionaryWithObjectsAndKeys:YK_B2C_CLASS_PAGE_1_ICON, TABBAR_KEY_ICON, m_navCtrl_homePage, TABBAR_KEY_VIEWCTRL, nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:YK_B2C_CLASS_PAGE_2_ICON, TABBAR_KEY_ICON, m_navCtrl_BrandPage, TABBAR_KEY_VIEWCTRL, nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:YK_B2C_CLASS_PAGE_3_ICON, TABBAR_KEY_ICON, m_navCtrl_classifiedPage, TABBAR_KEY_VIEWCTRL, nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:YK_B2C_CLASS_PAGE_4_ICON, TABBAR_KEY_ICON, m_navCtrl_shoppingcartPage, TABBAR_KEY_VIEWCTRL, nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:YK_B2C_CLASS_PAGE_5_ICON, TABBAR_KEY_ICON, m_navCtrl_morePage, TABBAR_KEY_VIEWCTRL, nil], nil] retain];

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTabBarAndCtrl];
    
	// Do any additional setup after loading the view, typically from a nib.
    isHiddenTabBar = NO;
    
    UIImage *tabBarImage = [UIImage imageNamed:(NSString *)TABBAR_IMAGE];
    
    // 创建自定义tabBar, 每一个item的大小, 设定自己为代理
    self.m_customTabBar = [[[SunCustomTabBar alloc] initWithItemCount:TABBAR_ITEM_NUMBER itemSize:CGSizeMake(self.view.frame.size.width/TABBAR_ITEM_NUMBER, tabBarImage.size.height) tag:0 delegate:self] autorelease];
    
    // 将自定义tabBar放置在view的底部
	m_customTabBar.frame = CGRectMake(0, self.view.frame.size.height - tabBarImage.size.height,
									  self.view.frame.size.width, tabBarImage.size.height);
	
	[self.view addSubview:m_customTabBar];
    
    // 选中第一个tab
    [m_customTabBar selectItemAtIndex:0];
    [self touchDownAtItemAtIndex:0];
    
    [m_customTabBar addSubview:shoppingBadgeView];
    [m_customTabBar addSubview:myGlamourBadgeView];
    [m_customTabBar bringSubviewToFront:shoppingBadgeView];
    [m_customTabBar bringSubviewToFront:myGlamourBadgeView];
    
    // tab 的光标
    UIImage *glow = [UIImage imageNamed:(NSString *)TABBAR_GLOW_IMAGE];
    m_glow = [[UIImageView alloc] initWithImage:glow];
    m_glow.frame = CGRectMake(18, 46, 28, 3);
    [m_customTabBar addSubview:m_glow];
    
    
}


// 延迟加载视图
-(BadgeView *)shoppingBadgeView
{
    if (shoppingBadgeView == nil) {
        shoppingBadgeView = [[BadgeView alloc] initWithFrame:CGRectMake(162, -10, 100, 30)];
        shoppingBadgeView.backgroundColor = [UIColor clearColor];
//        [[self class] setShoppingBadgeNumber:[GSCartItemData numberOfCartItems]];
    }
    return shoppingBadgeView;
}
-(BadgeView*)myGlamourBadgeView
{
    if (myGlamourBadgeView == nil) {
        myGlamourBadgeView = [[BadgeView alloc] initWithFrame:CGRectMake(226, -10, 100, 30)];
        myGlamourBadgeView.backgroundColor = [UIColor clearColor];
        [[self class] setOrderBadgeNumber:0];
    }
    return myGlamourBadgeView;
}

// 异常处理
-(void)buttonPressed:(id)sender
{
    
    MyException *exption = [[MyException alloc] initWithName:@"MyException" reason:@"除数为了0" userInfo:nil];
    
    @try {
        int b=0;
        switch (b) {
            case 0:
                @throw (exption); // b= 0 ，则抛出异常
                break;
                
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        [exption popAlert];
        NSLog(@"b == 0 Exception, 抛出异常");
    }
    @finally {
        NSLog(@"finally == 最终结果");
    }
    [exption release];

    
}
- (void)viewDidUnload
{
    [self setButton:nil];
    
    self.shoppingBadgeView = nil;
    self.myGlamourBadgeView = nil;
    self.m_customTabBar = nil;
    
    self.m_navCtrl_morePage = nil;
    self.m_navCtrl_homePage = nil;
    self.m_navCtrl_classifiedPage = nil;
    self.m_navCtrl_shoppingcartPage = nil;
    
	self.payMementPage = nil;
    
    [super viewDidUnload];
}

// 设置标记数字
- (void)setBadgeNumber:(int)_num
{
    shoppingBadgeView.badgeValue = _num;
	shoppingBadgeView.hidden = _num > 0 ? NO : YES;
	[shoppingBadgeView setNeedsDisplay];
    badgeNumber = _num;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [shoppingBadgeView release];shoppingBadgeView = nil;
    [myGlamourBadgeView release];myGlamourBadgeView = nil;
    [m_customTabBar release];m_customTabBar = nil;
    
    [m_navCtrl_morePage release];m_navCtrl_morePage = nil;
    [m_navCtrl_homePage release];m_navCtrl_homePage = nil;
    [m_navCtrl_classifiedPage release];m_navCtrl_classifiedPage = nil;
    [m_navCtrl_shoppingcartPage release];m_navCtrl_shoppingcartPage = nil;
    [m_glow release];
    
	[payMementPage release]; payMementPage = nil;
    
    [super dealloc];
}


#pragma mark -
#pragma mark CustomTabBarDelegate Methods
// 隐藏TabBar
+(void)tabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    s_sunViewCtroller.isHiddenTabBar = hidden;
	s_sunViewCtroller.m_customTabBar.hidden = hidden;
    UIImage *tabBarImage = [UIImage imageNamed:(NSString *)TABBAR_IMAGE];
	NSDictionary *data = [s_tabBarItems objectAtIndex:s_sunViewCtroller.currentIndex];
	UIViewController *assign_viewController = [data objectForKey: TABBAR_KEY_VIEWCTRL];
	
    if (animated) {
        [UIView beginAnimations:@"moveBarsOutOfScreen" context:NULL];
        [UIView setAnimationDuration:3];
    }
    
	assign_viewController.view.frame = CGRectMake(0,0,s_sunViewCtroller.view.frame.size.width, s_sunViewCtroller.view.frame.size.height-((s_sunViewCtroller.isHiddenTabBar)? 0.0 : tabBarImage.size.height)); //-(tabBarImage.size.height)
	assign_viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    
    if (animated) {
        [UIView commitAnimations];
    }
}


-(UIImage*)imageFor:(CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex{
	return nil;
}

//tabBar的背景图
-(UIImage*)backgroundImage{
	// The tab bar's width is the same as our width
	CGFloat width = self.view.frame.size.width;
	// Get the image that will form the top of the background
	UIImage *topImage = [UIImage imageNamed:(NSString *)TABBAR_IMAGE];
	NSLog(@"=Tabbar backgroundImage== topImage :%@, %f, %f ===", topImage, topImage.size.width, topImage.size.height);
	
	// Create a new image context
	if (UIGraphicsBeginImageContextWithOptions != NULL) {
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, topImage.size.height), NO, 0.0);
	} else {
		UIGraphicsBeginImageContext(CGSizeMake(width, topImage.size.height));
	}
	//UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, topImage.size.height), NO, 0.0);
	
	// Create a stretchable image for the top of the background and draw it
	UIImage *stretchedTopImage = [topImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	[stretchedTopImage drawInRect:CGRectMake(0, 0, width, topImage.size.height)];
	
	// Draw a solid black color for the bottom of the background
	[[UIColor blackColor] set];
	CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, topImage.size.height, width, topImage.size.height));
	
	// Generate a new image
	UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

// This is the blue background shown for selected tab bar items
- (UIImage*) selectedItemBackgroundImage
{
	return [UIImage imageNamed:(NSString *)TABBAR_ITEM_SELECTED_BACKGROUND_IMAGE];
}


- (UIImage *)selectedItemBackgroundImage2AtIndex:(NSUInteger)itemIndex{
    NSDictionary *assign_data = [s_tabBarItems objectAtIndex:itemIndex];
    UIImage *tmp_image = [UIImage imageNamed:[assign_data objectForKey:@"icon"]];
    NSLog(@"%@",[assign_data objectForKey:@"icon"]);
    return tmp_image;
}
// this is the title of item button 

-(NSString *)selectedItemTitile2AtIndex:(NSUInteger)itemIndex
{
    NSArray *titleArray = [NSArray arrayWithObjects:@"首页",@"分类",@"购物车",@"个人中心",@"更多", nil];
    NSString * title = [titleArray objectAtIndex:itemIndex];
    return title;
}

// This is the glow image shown at the bottom of a tab bar to indicate there are new items
//tabBar光标
- (UIImage*)glowImage
{
	UIImage* tabBarGlow = [UIImage imageNamed:(NSString *)TABBAR_GLOW_IMAGE];
	
	// Create a new image using the TabBarGlow image but offset 4 pixels down
	if (UIGraphicsBeginImageContextWithOptions != NULL) {
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(tabBarGlow.size.width, tabBarGlow.size.height-4.0), NO, 0.0);
	} else {
		UIGraphicsBeginImageContext(CGSizeMake(tabBarGlow.size.width, tabBarGlow.size.height-4.0));
	}
	
	// Draw the image
	[tabBarGlow drawAtPoint:CGPointZero];
	
	// Generate a new image
	UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

// This is the embossed-like image shown around a selected tab bar item
- (UIImage*) selectedItemImage
{	
	return nil;
}
//设置选中的tabBar的item图片
- (UIImage*) selectedItemImage2:(CustomTabBar*)customTabBar
{
	// Use the TabBarGradient image to figure out the tab bar's height (49x2=98)
	UIImage* tabBarImage = [UIImage imageNamed:(NSString *)TABBAR_IMAGE];
	CGSize tabBarItemSize = CGSizeMake(self.view.frame.size.width/s_tabBarItems.count, tabBarImage.size.height);
	if (UIGraphicsBeginImageContextWithOptions != NULL) {
		UIGraphicsBeginImageContextWithOptions(tabBarItemSize, NO, 0.0);
	} else {
		UIGraphicsBeginImageContext(tabBarItemSize);
	}
    
    // 调整选择按钮位置
    if ( customTabBar.m_CurIndexToInit == 0) {
        [[UIImage imageNamed:(NSString *)YK_B2C_CLASS_PAGE_1_ICON] drawInRect:CGRectMake(0.0, 0.0, 64.0, 49)]; 
    }
    else if ( customTabBar.m_CurIndexToInit == 1) {
        [[UIImage imageNamed:(NSString *)YK_B2C_CLASS_PAGE_2_ICON] drawInRect:CGRectMake(0.0, 0.0, 64.0, 49)]; 
    }
    else if ( customTabBar.m_CurIndexToInit == 2) {
        [[UIImage imageNamed:(NSString *)YK_B2C_CLASS_PAGE_3_ICON] drawInRect:CGRectMake(0.0, 0.0, 64.0, 49)]; 
    }
    else if ( customTabBar.m_CurIndexToInit == 3) {
        [[UIImage imageNamed:(NSString *)YK_B2C_CLASS_PAGE_4_ICON] drawInRect:CGRectMake(0.0, 0.0, 64.0, 49)]; 
    }
    else if ( customTabBar.m_CurIndexToInit == 4) {
        [[UIImage imageNamed:(NSString *)YK_B2C_CLASS_PAGE_5_ICON] drawInRect:CGRectMake(0.0, 0.0, 64.0, 49)]; 
    }
    
    //currentIndex++;
	
	// Generate a new image
	UIImage* selectedItemImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return selectedItemImage;
}

- (UIImage*)tabBarArrowImage
{
	return [UIImage imageNamed:(NSString *)TABBAR_NIPPLE_IMAGE];
}
//点击tabbar上的按钮触发的事件，动画移动光标
- (void) touchDownAtItemAtIndex:(NSUInteger)itemIndex
{
    // 动画移动指标
    [UIView beginAnimations:@"Flips" context:self];
    [UIView setAnimationDuration:0.4];
    
    if (itemIndex == 0) {
        m_glow.frame = CGRectMake(18, 46, 28, 3);
    }
    if (itemIndex == 1) {
        m_glow.frame = CGRectMake(82, 46, 28, 3);
    }
    if (itemIndex == 2) {
        m_glow.frame = CGRectMake(146, 46, 28, 3);
    }
    if (itemIndex == 3) {
        m_glow.frame = CGRectMake(210, 46, 28, 3);
    }
    if (itemIndex == 4) {
        m_glow.frame = CGRectMake(274, 46, 28, 3);
    }
    [UIView commitAnimations];
    
    
	UIView *currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
	[currentView removeFromSuperview];
    
    NSDictionary *old_data = [s_tabBarItems objectAtIndex:currentIndex];
	UIViewController *ol_assign_viewController = [old_data objectForKey: TABBAR_KEY_VIEWCTRL];
    [ol_assign_viewController viewWillDisappear:YES];
    
    currentIndex = itemIndex;
    	
	// Get the right view controller
	NSDictionary *data = [s_tabBarItems objectAtIndex:itemIndex];
	UIViewController *assign_viewController = [data objectForKey: TABBAR_KEY_VIEWCTRL];
	
	// Use the TabBarGradient image to figure out the tab bar's height (22x2=44)
	// UIImage *tabBarImage = [UIImage imageNamed:TABBAR_IMAGE];
	
	// Set the view controller's frame to account for the tab bar    
	assign_viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height); //-(tabBarImage.size.height)
	
	// Se the tag so we can find it later
	assign_viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
	
    
    // Add the new view controller's view
    [self.view insertSubview:assign_viewController.view belowSubview:m_customTabBar];
    
    
	
	// In 0 second glow the selected tab
    //[NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(addGlowTimerFireMethod:) userInfo:[NSNumber numberWithInteger:itemIndex] repeats:NO];
    
    if (IOS_VERSION < 5.0){
        // 显示
        [assign_viewController viewWillAppear:YES];
    }
    // 当前可视视图
    SunBaseController *baseVCtrl = nil;
    
    // 点击标签按钮,回到首页
	if ( itemIndex == 0 ) {
        baseVCtrl = (SunBaseController *)[m_navCtrl_homePage visibleViewController];
	}
    else if ( itemIndex == 1 ) {
        baseVCtrl = (SunBaseController *)[m_navCtrl_BrandPage visibleViewController];
	} 
	else if ( itemIndex == 2 ) {
        baseVCtrl = (SunBaseController *)[m_navCtrl_classifiedPage visibleViewController];
	} 
	else if ( itemIndex == 3 ) {
        baseVCtrl = (SunBaseController *)[m_navCtrl_shoppingcartPage visibleViewController];
	} 
    else if (itemIndex == 4 ) {
        baseVCtrl = (SunBaseController *)[m_navCtrl_morePage visibleViewController];
	}  
    
    if ( baseVCtrl ) {
//        [baseVCtrl popMe];
    }

}

#pragma mark-
#pragma mark 设置badgeNumber
// 设置购物车的badgeNumber
+(void)setShoppingBadgeNumber:(int)anum
{
	s_sunViewCtroller.shoppingBadgeView.badgeValue = anum;
	s_sunViewCtroller.shoppingBadgeView.hidden = anum > 0 ? NO : YES;
	[s_sunViewCtroller.shoppingBadgeView setNeedsDisplay];
}
// 设置订单的badgeNumber
+(void)setOrderBadgeNumber:(int)anum
{
	s_sunViewCtroller.myGlamourBadgeView.badgeValue = anum;
	s_sunViewCtroller.myGlamourBadgeView.hidden = anum > 0 ? NO : YES;
	[s_sunViewCtroller.myGlamourBadgeView setNeedsDisplay];
}



@end
