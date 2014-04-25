//
//  UIDemoBaseController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-10.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "UIDemoBaseController.h"

@interface UIDemoBaseController (Prived)

-(void)onButtonKeyBord;

-(void)keyboardWillShow;

@end

@implementation UIDemoBaseController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.tableView.allowsSelection = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}


-(void)onButtonKeyBord
{
    [_textView resignFirstResponder];
    
    self.navigationItem.rightBarButtonItem = NULL;
}
-(void)keyboardWillShow
{
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onButtonKeyBord)] autorelease];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITextViewDelegate
#pragma mark - 

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self keyboardWillShow];
}

-(UITextView *)addTextViewWithFrame:(CGRect)frame theText:(NSString *)text
{
    UITextView *textV = [[UITextView alloc] initWithFrame:frame];
    textV.font = [UIFont systemFontOfSize:18];
    textV.text = text;
    textV.backgroundColor = [UIColor whiteColor];
    textV.layer.cornerRadius = 8.0f;
    textV.delegate = self;
    
    return textV;
}

-(UIButton*)addButton:(CGRect)frame theTitle:(NSString *)title theNomarlImage:(UIImage *)nomarlImage highLightImage:(UIImage *)highLightImage theDisableImage:(UIImage *)disableImage target:(SEL)action
{
    
    UIButton *button = [[[UIButton alloc] initWithFrame:frame] autorelease];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:nomarlImage forState:UIControlStateNormal];
    [button setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:disableImage forState:UIControlStateDisabled];
    button.backgroundColor = [UIColor redColor];
     button.exclusiveTouch = YES;
    
    return button;
}



@end
