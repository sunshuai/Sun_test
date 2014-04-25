//
//  UI_ZbarReaderViewController.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-10.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "ZBarReaderView.h"

@interface UI_ZbarReaderViewController : UIViewController <ZBarReaderViewDelegate>
{
    ZBarReaderView *zBarView;
    ZBarCameraSimulator *camera_simulator;
    UIButton *history_Button;
    UIButton *goBack_Button;
    UIButton *camera_Button;
    UIView *top_view;
    UIView *bottom_view;
    
    UIImageView *resultImage;    // 二维码扫描
    UITextView  *resultText;
    
    UIImagePickerController *m_camara;
}

@property (retain, nonatomic)  UIImageView *resultImage;    // 二维码扫描
@property (retain, nonatomic) IBOutlet UITextView *resultText;    // 二维码扫描

@property (retain, nonatomic) ZBarCameraSimulator *camera_simulator;
@property (retain, nonatomic) IBOutlet ZBarReaderView *zBarView;
@property (retain, nonatomic) UIImagePickerController *m_camara;
@property (retain, nonatomic) IBOutlet UIButton *history_Button;
@property (retain, nonatomic) IBOutlet UIButton *goBack_Button;
@property (retain, nonatomic) IBOutlet UIButton *camera_Button;
@property (retain, nonatomic) IBOutlet UIView *top_view;
@property (retain, nonatomic) IBOutlet UIView *bottom_view;

//返回
-(IBAction)CancelView:(id)sender;

//设置闪光灯模式
-(IBAction)cmara:(id)sender;

//进入二维码历史页面
-(IBAction)GotoHistory:(id)sender;

@end
