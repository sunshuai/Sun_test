//
//  UIRecognizeController.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-10.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDemoBaseController.h"
#import <iFlyISR/IFlyRecognizeControl.h>


// 按键坐标
#define H_BUTTON_RECOGNIZE			CGRectMake(50, 300, 80, 40)
#define H_BUTTON_RECOGNIZE_SETUP	CGRectMake(190, 300, 80, 40)


#define SECTION_TITLE1 @"识别结果"
#define SECTION_TITLE2 @"用户操作"

#define BUTTON_TITLE1  @"开始听写"
#define BUTTON_TITLE2  @"设置"

#define TITLE @"转写演示"


@interface UIRecognizeController : UIDemoBaseController <IFlyRecognizeControlDelegate>
{
    UIButton *_recongnizeButton;
    UIButton *_setupButton;
    
    // 中间变量
    IFlyRecognizeControl *_iFlyTrcongnizeControl;
}

@end
