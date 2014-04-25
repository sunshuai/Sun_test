//
//  SecondControll.h
//  Sun_test
//
//  Created by Shuai Sun on 12-7-17.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SunBaseController.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondControll : SunBaseController<UITextFieldDelegate,UITextViewDelegate>

@property (retain, nonatomic) IBOutlet UITextView *userName;
@property (retain, nonatomic) IBOutlet UITextField *userPassWord;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UILabel *textNumLabel;
@property (retain , nonatomic) NSString *textString;
@property (nonatomic, retain) NSString *str_user_name;
@property (nonatomic, retain) NSString *str_pas_word;
@property NSInteger textLeftLength;

-(void)pressedToMovieVontroller;

-(IBAction)loginButtonPressed:(id)sender;

-(IBAction)dismissKeyBord:(id)sender;

-(void)refreshLabel;

@end
