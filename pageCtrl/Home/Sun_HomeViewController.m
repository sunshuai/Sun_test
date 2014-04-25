//
//  Sun_HomeViewController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_HomeViewController.h"
#import "SecondControll.h"
#import "Sun_TestViewController.h"
#import "UI_ZbarReaderViewController.h"

@interface Sun_HomeViewController (Private)

-(void)disableButton;

-(void)enableButton;

@end

@implementation Sun_HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatLeftNavItemButton];
    [self creatRightNavItemButton];
    
//    [self setCustomNavBackButtonHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)loginViewController
{
    SecondControll *loginView = [[SecondControll alloc] initWithNibName:@"SecondControll" bundle:nil];
    [self.navigationController pushViewController:loginView animated:YES];
    [loginView release];
}


#pragma mark 
#pragma mark 内部调用
-(void)disableButton
{
    _recongnizeButton.enabled = NO;
	_setupButton.enabled = NO;
	self.navigationController.navigationItem.leftBarButtonItem.enabled = NO;
}
-(void)enableButton
{
    _recongnizeButton.enabled = YES;
	_setupButton.enabled = YES;
	self.navigationController.navigationItem.leftBarButtonItem.enabled  = YES;
}

#pragma mark - voice and scan buy
#pragma mark - 

// 条码购买
-(void)scanButtonTouch
{
    //bug85------条码购功能： 检查设备是否支持自动对焦功能，无法支持时，弹出提示框，让用户选择返回（隐藏弹框）；文字描述："温馨提示/您的设备不支持条码购，请选择其他方式/知道了"
    if( ![UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear ])
    {
        [self alertWithMassage:@"您的设备不支持条码购，请选择其他方式。"];
        return;
    }
//	[Sun_TestViewController tabBarHidden:YES animated:YES];
    
    UI_ZbarReaderViewController *zBarViewCon = [[UI_ZbarReaderViewController alloc] initWithNibName:@"UI_ZbarReaderViewController" bundle:nil];
    [self presentModalViewController:zBarViewCon animated:YES];
    [zBarViewCon release];zBarViewCon = nil;
    
//	EmbedReaderViewController *embed = [[EmbedReaderViewController alloc] init];
//	embed.target = self;
//	[self presentModalViewController:embed animated:YES];
//	[embed release];
}
// 语音购买
-(void)voiceButtonTouch
{
    UIRecognizeController *_recognizeController = [[UIRecognizeController alloc] init];
    [self.navigationController pushViewController:_recognizeController animated:YES];
    
    if ([_iFlyRecognizeControl start]) {
        
        [self disableButton];
    }
}

#pragma mark 
#pragma mark 接口回调

//	识别结束回调
- (void)onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(SpeechError) error
{
	NSLog(@"识别结束回调finish.....");
	[self enableButton];
	
	NSLog(@"getUpflow:%d,getDownflow:%d",[iFlyRecognizeControl getUpflow],[iFlyRecognizeControl getDownflow]);
	
}

- (void)onUpdateTextView:(NSString *)sentence
{
	
//	NSString *str = [[NSString alloc] initWithFormat:@"%@", sentence];
    //	_textView.text = str;
//	NSLog(@"str======%@",str);
//	YKSearchResultViewController* searchResult = [[YKSearchResultViewController alloc] init];
//	searchResult.str_keyword = str;
//	[self.navigationController pushViewController:searchResult animated:YES];
//	[searchResult release];
}

- (void)onRecognizeResult:(NSArray *)array
{
	[self performSelectorOnMainThread:@selector(onUpdateTextView:) withObject:
	 [[array objectAtIndex:0] objectForKey:@"NAME"] waitUntilDone:YES];
}

- (void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{
	[self onRecognizeResult:resultArray];	
	
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [Sun_TestViewController tabBarHidden:NO animated:NO];
}

#pragma - mark navigationItem
#pragma - mark == 
-(void)creatRightNavItemButton
{
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    UIView *customRightView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, navigationBarHeight)] autorelease];
    UIButton *mSettingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [mSettingButton addTarget:self action:@selector(loginViewController) forControlEvents:UIControlEventTouchUpInside];
    [mSettingButton setTitle:@"登录" forState:UIControlStateNormal];
    mSettingButton.backgroundColor = [UIColor grayColor];
    
    CGRect rect = mSettingButton.frame;
    
    rect.origin.x = 0;
    rect.origin.y = (customRightView.bounds.size.height-rect.size.height)/2;
    
    mSettingButton.frame = rect;
    [customRightView addSubview:mSettingButton];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:customRightView] autorelease];
}

-(void)creatLeftNavItemButton
{
    UIView *leftItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 31)];

    
    // 语音button
    UIButton *bar_voice_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [bar_voice_button setFrame:CGRectMake(0, 0, 58, 31)];
    [bar_voice_button setTitle:@"语音" forState:UIControlStateNormal];
    [bar_voice_button addTarget:self action:@selector(voiceButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    bar_voice_button.backgroundColor=[UIColor grayColor];
    
    [leftItemView addSubview:bar_voice_button];
    
    // 条码购物
    UIButton *bar_code_button = [UIButton buttonWithType:UIButtonTypeCustom];
    bar_code_button.frame = CGRectMake(60, 0, 58, 31);
    [bar_code_button setTitle:@"条码" forState:UIControlStateNormal];
    [bar_code_button addTarget:self action:@selector(scanButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [bar_code_button setBackgroundColor:[UIColor grayColor]];
    
    [leftItemView addSubview:bar_code_button];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftItemView] autorelease];
    
    NSLog(@"%@=====%@",leftItemView.subviews,self.navigationItem.leftBarButtonItem);
    
    [leftItemView release];
}

@end
