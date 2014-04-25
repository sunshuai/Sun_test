//
//  UIDemoBaseController.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-10.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


// 文本框
#define H_BACK_TEXTVIEW_FRAME		CGRectMake(6, 0, 308, 187)
//#define H_TEXTVIEW_FRAME			CGRectMake(10, 3, 300, 179)
#define H_TEXTVIEW_FRAME			CGRectMake(6, 0, 308, 185)
// 图片名称
#define PNG_CONTENT_BACK	@"editbox.png"

#define H_CONTROL_ORIGIN CGPointMake(20, 70)
//此appid为您所申请,请勿随意修改
#define APPID @"4fbf5036"
#define ENGINE_URL @"http://dev.voicecloud.cn:1028/index.htm"

typedef enum IstrTppe
{
    IsText = 0,         // 转写
    IsrKeyword,         // 关键字识别
    IsrUploadKeyWord    // 关键字上传
}IsrType;


@interface UIDemoBaseController : UITableViewController <UITextViewDelegate>
{
    UITextView  *_textView;
}

-(UITextView *)addTextViewWithFrame:(CGRect)frame theText:(NSString *)text;

- (UIButton *)addButton:(CGRect)frame theTitle:(NSString *)title theNomarlImage:(UIImage *)nomarlImage highLightImage:(UIImage *)highLightImage theDisableImage:(UIImage *)disableImage target:(SEL)action;


@end
