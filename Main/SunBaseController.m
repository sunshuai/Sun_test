//
//  SunBaseController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-7-17.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SunBaseController.h"

#define ALERT_TITLE @"温馨提示"

@interface SunBaseController ()

@end

@implementation SunBaseController

@synthesize m_str_navTitle;
@synthesize m_str_backButtonTitle;
@synthesize isMainPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    self.m_str_navTitle = nil;
    self.m_str_backButtonTitle = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tag = 111;
    
    [self setCustomNavBackButtonHidden:NO];
    // 设置导航栏标题
	self.navigationItem.title = self.m_str_navTitle;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)isMainPage:(BOOL)isMain
{
    self.isMainPage = isMain;
}

#pragma mark- navController

-(void)creatLeftNavItemButton{}
-(void)creatTittleNavItemButton{}
-(void)creatRightNavItemButton{}

-(void)setCustomNavBackButtonHidden:(BOOL)aHidden
{
    if (!aHidden) {
//        GSButton *navBackButton = [GSButton buttonWithImage:[UIImage imageNamed:@"btn_t_1_normal.png"] highlightBackgroundImage:[UIImage imageNamed:@"btn_t_selected.png"] type:GSButtonTypeRightLine];
        UIButton *navBackButton = [UIButton buttonWithType:UIControlStateNormal];
        navBackButton.backgroundColor  = [UIColor redColor];
        navBackButton.frame = CGRectMake(0, 1, 40, 42);
        [navBackButton setTitle:@"返回" forState:UIControlStateNormal];
        navBackButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [navBackButton setTintColor:[UIColor whiteColor]];
        [navBackButton addTarget:self action:@selector(basePopViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIView *backNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
        [backNavView addSubview:navBackButton];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backNavView] autorelease];
        [backNavView release];
    }
    else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}

-(void)basePopViewControllerAnimated:(BOOL)aAnimated
{
    [self.navigationController popViewControllerAnimated:aAnimated];
}

-(NSString *)m_str_navTitle{
	return m_str_navTitle;
}

-(void)m_str_navTitle:(NSString*)navTitle{
	self.m_str_navTitle = navTitle;
}


#pragma mark - AlertView
-(void)alertWithMassage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];alert = nil;
}
-(void)alertWithMassage:(NSString *)message Tag:(NSInteger)tag cancel:(NSString *)cancelTitile other:(NSString *)otherTItle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:cancelTitile otherButtonTitles:otherTItle, nil];
    [alert show];
    [alert release];alert = nil;
}
@end
