//
//  Sun_HomeViewController.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SunBaseController.h"

#import "UIRecognizeController.h"

@interface Sun_HomeViewController : SunBaseController <IFlyRecognizeControlDelegate>
{
    IFlyRecognizeControl      *_iFlyRecognizeControl;
    UIButton                  *_recongnizeButton;
    UIButton                  *_setupButton;
}




-(void)loginViewController;

// 语音购物
-(void)voiceButtonTouch;
// 条形码购物
-(void)scanButtonTouch;
@end
