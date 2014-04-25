//
//  SecondControll.m
//  Sun_test
//
//  Created by Shuai Sun on 12-7-17.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SecondControll.h"

#import "CustomMoviePlayerViewController.h"

#import "SunStringUtility.h"
#import "Sun_UserData.h"

@interface SecondControll ()

@end

@implementation SecondControll
@synthesize userName;
@synthesize userPassWord;
@synthesize loginButton;
@synthesize textNumLabel;
@synthesize textString;
@synthesize textLeftLength;

@synthesize str_pas_word, str_user_name;

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
    [self creatRightNavItemButton];
    
    textLeftLength = 20;
    userName.layer.borderWidth = 1.0f;
    userName.layer.borderColor = [UIColor grayColor].CGColor;
    
    userName.layer.cornerRadius = 5;
    userName.layer.masksToBounds = YES;
    
    [self refreshLabel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self setUserName:nil];
    [self setUserPassWord:nil];
    [self setLoginButton:nil];
    [self setTextNumLabel:nil];
    self.textString = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)pressedToMovieVontroller
{

    CustomMoviePlayerViewController *moviePlayer = [[[CustomMoviePlayerViewController alloc] init] autorelease];
    
    //将视频地址传过去
    moviePlayer.movieURL = [NSURL URLWithString:@"http://img.cnrmall.com/images/tv/product/video/327/3/327341.mp4"];
    //然后播放就OK了
    [moviePlayer readyPlayer];
    [self.navigationController pushViewController:moviePlayer animated:YES];
    
}

-(void)refreshLabel
{
    textNumLabel.text = [NSString stringWithFormat:@"您还可以输入%d个字.",textLeftLength];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *resultString = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    textString = text;

    if (resultString.length >= 20 && range.length != 1) {
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    
	NSInteger textLength = [textView.text length];
	textLeftLength = 20  - textLength;
	[self refreshLabel];
//    self.textString = textView.text;
    
}

// 登录按钮
-(void)loginButtonPressed:(id)sender
{
    [self.view endEditing:YES];
    
    NSError *error = nil;
    //    [[GANTracker sharedTracker] trackEvent:@"iOS1_LogInPage_SubmitLogIn" action:@"click" label:@"" value:0 withError:&error];
    if (error) {
        NSLog(@"[ERR]GANTracker trackEvent in %@\n%@",NSStringFromClass([self class]),error);
    }
    
    if ([userName.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    if (![SunStringUtility  isEmail:userName.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"用户名应该为邮箱格式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    if ([userPassWord.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
}


-(void)canLoginMyfiel
{
    
}


-(void)dismissKeyBord:(id)sender
{
    [self.view endEditing:YES];
}



-(void)creatRightNavItemButton
{
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    UIView *customRightView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, navigationBarHeight)] autorelease];
    UIButton *mSettingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [mSettingButton addTarget:self action:@selector(pressedToMovieVontroller) forControlEvents:UIControlEventTouchUpInside];
    [mSettingButton setTitle:@"视频" forState:UIControlStateNormal];
    mSettingButton.backgroundColor = [UIColor grayColor];
    
    CGRect rect = mSettingButton.frame;
    
    rect.origin.x = 0;
    rect.origin.y = (customRightView.bounds.size.height-rect.size.height)/2;
    
    mSettingButton.frame = rect;
    [customRightView addSubview:mSettingButton];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:customRightView] autorelease];
}

- (void)dealloc {
    [userName release];
    [userPassWord release];
    [loginButton release];
    [textNumLabel release];
    [textString release];
    
    [super dealloc];
}
@end
