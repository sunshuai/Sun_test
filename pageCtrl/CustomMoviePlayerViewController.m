//
//  CustomMoviePlayerViewController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-7-23.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "CustomMoviePlayerViewController.h"

#pragma mark -
#pragma mark Compiler Directives & Static Variables

@implementation CustomMoviePlayerViewController

@synthesize movieURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loadingAni = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 150, 37, 37)];
    loadingAni.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;   
    [self.view addSubview:loadingAni];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(130, 190, 80, 40)];
    label.text = @"加载中...";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    
    [[self view] setBackgroundColor:[UIColor blackColor]];
    self.navigationController.navigationBar.hidden = YES;
    [loadingAni startAnimating];
    [self.view addSubview:label];
    
     
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
    [mp stop];
    
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification
{
    [loadingAni stopAnimating];
    [label removeFromSuperview];
    
    // Unless state is unknown, start playback
    if ([mp loadState] != MPMovieLoadStateUnknown)
    {
        // Remove observer
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        // When tapping movie, status bar will appear, it shows up
        // in portrait mode by default. Set orientation to landscape
        //设置横屏
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        // Rotate the view for landscape playback
        [[self view] setBounds:CGRectMake(0, 44, 320, 416)];
//        [[self view] setCenter:CGPointMake(160, 240)];
        //选中当前view
//        [[self view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        

        // Set frame of movieplayer
        [[mp view] setFrame:CGRectMake(0, 44, 320, 416)];
        
        // Add movie player as subview
        [[self view] addSubview:[mp view]];  
        
        // Play the movie
        [mp play];
    }
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification
{   
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //还原状态栏为默认状态
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    // Remove observer
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}


- (void) readyPlayer
{
    mp =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    
    if ([mp respondsToSelector:@selector(loadState)])
    {
        // Set movie player layout
        [mp setControlStyle:MPMovieControlStyleFullscreen];        //MPMovieControlStyleFullscreen        //MPMovieControlStyleEmbedded
        mp.scalingMode = MPMovieScalingModeAspectFit;    // 自适应大小
        //满屏
        [mp setFullscreen:YES];
        // 有助于减少延迟
        [mp prepareToPlay];
        
        // Register that the load state changed (movie is ready)
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateChanged:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];

    } 
    else
    {
        // Play the movie For 3.1.x devices
        [mp play];
    }
    
    // Register to receive a notification when the movie has finished playing.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}


- (void)dealloc
{
    [mp release];mp = nil;
    [movieURL release];movieURL = nil;
    [loadingAni release]; loadingAni = nil;
    [label release]; label = nil;
    [super dealloc];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    self.movieURL = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait ) { // 竖
        
        mp.view.frame = CGRectMake(0, 0, 320, 416);
        
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ) {
        mp.view.frame = CGRectMake(0, 0, 480, 320);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
        mp.view.frame = CGRectMake(0, 0, 480, 320);
    }
    else {
        mp.view.frame = CGRectMake(0, 0, 320, 460);
    }
    
}

@end