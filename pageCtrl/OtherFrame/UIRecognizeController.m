//
//  UIRecognizeController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-10.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "UIRecognizeController.h"


@interface UIRecognizeController(Private)

- (void)disableButton;

- (void)enableButton;

@end

@implementation UIRecognizeController

- (id)init
{
    if (self) {
        self.title = TITLE;
    }
    return self;
}


#pragma mark - 
#pragma mark - 接口回调

// 识别结束回调
-(void)onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(int)error
{
    NSLog(@"识别结束回调finish............");
    [self enableButton];
    
    NSLog(@"getUpflow : %d, getDownflow: %d",[iFlyRecognizeControl getUpflow], [iFlyRecognizeControl getDownflow]);// 查询流量，返回字节数
}


-(void)onUpdateTextView:(NSString *)sentence
{
    NSString *str = [[NSString alloc] initWithFormat:@"%@%@", _textView.text, sentence];
    _textView.text = str;
    
    NSLog(@"str __......");
}

-(void)onRecoginzeResult:(NSArray *)array
{
    [self performSelectorOnMainThread:@selector(onUpdateTextView:) withObject:[[array objectAtIndex:0] objectForKey:@"NAME"] waitUntilDone:YES];
}

-(void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{
    [self onRecoginzeResult:resultArray];
    
    NSLog(@"resultArray---------- %@",resultArray);
}


#pragma mark - 
#pragma mark - 内部调用

-(void)disableButton
{
    _recongnizeButton.enabled = NO;
    _setupButton.enabled = NO;
    _textView.editable = NO;
    self.navigationController.navigationItem.leftBarButtonItem.enabled = NO;
}

-(void)enableButton
{
    _recongnizeButton.enabled = YES;
    _setupButton.enabled = YES;
    _textView.editable = YES;
    self.navigationController.navigationItem.leftBarButtonItem.enabled = YES;
    
}

// 撰写
-(void)onButtonRecoginze
{
    if ([_iFlyTrcongnizeControl start]) {

        [self disableButton];
    }
}

// 设置
-(void)onButtonSetup
{
    
}

- (void)viewDidLoad 
{
	
	NSString *initParam = [[NSString alloc] initWithFormat:
						   @"server_url=%@,appid=%@",ENGINE_URL,APPID];
    
	// 识别控件
	_iFlyTrcongnizeControl = [[IFlyRecognizeControl alloc] initWithOrigin:H_CONTROL_ORIGIN theInitParam:initParam];
    
	[self.view addSubview:_iFlyTrcongnizeControl];
	[_iFlyTrcongnizeControl setEngine:@"sms" theEngineParam:nil theGrammarID:nil];
	[_iFlyTrcongnizeControl setSampleRate:16000];
	_iFlyTrcongnizeControl.delegate = self;
	[initParam release];
	
	//_recoginzeSetupController = [[UIRecognizeSetupController alloc] initWithRecognize:_iFlyRecognizeControl];
	[super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    if (indexPath.section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input.png"]];
        imageView.frame = H_BACK_TEXTVIEW_FRAME;
        [cell addSubview:imageView];
        [imageView release];
    
        _textView = [[self addTextViewWithFrame:H_TEXTVIEW_FRAME theText:nil] retain];
        _textView.backgroundColor = [UIColor clearColor];
        [cell addSubview:_textView];
    }
    else {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button1.frame = CGRectMake(20, 10, 280, 40);
        [button1 setTitle:BUTTON_TITLE1 forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(onButtonRecoginze) forControlEvents:UIControlEventTouchDown];
        
        [cell addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button2.frame = CGRectMake(20, 60, 280, 40);
        [button2 setTitle:BUTTON_TITLE2 forState:UIControlStateNormal];
//        [button2 addTarget:self action:@selector(onButtonSetup) forControlEvents:UIControlEventTouchDown];
        
        [cell addSubview:button2];
    }
  
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = 185;
    }
    else {
        height = 110;
    }
    return height;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


@end
