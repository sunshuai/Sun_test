//
//  UtilityConfig.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#ifndef Sun_test_UtilityConfig_h
#define Sun_test_UtilityConfig_h


#define Sun_Release(_obj) { if(_obj) { [_obj release]; _obj = nil; }}
#define Sun_Release_tab(__TABLEVIEW){ __TABLEVIEW.dataSource = nil;__TABLEVIEW.delegate = nil; [__TABLEVIEW release];__TABLEVIEW = nil;}


//MARK: - 颜色相关
#define YKNavColor_Title				[UIColor colorWithRed:195.0/255 green:59.0/255 blue:77.0/255 alpha:1.0]// 红色导航按钮

#define YPSkinColor_Font                [UIColor colorWithRed:142.0/255 green:131.0/255 blue:120.0/255 alpha:1.0]

#define YPCustomFont              [UIColor colorWithRed:115.0/255 green:99.0/255 blue:87.0/255 alpha:1.0]//普通字体颜色


#define YP_ColorBorder                  [UIColor colorWithRed:172./255.0 green:172./255.0 blue:172./255.0 alpha:1.0]//普通粗体字体颜色

#define YPShopCarTitleColor    [UIColor colorWithRed:116.0/255 green:104.0/255 blue:91.0/255 alpha:1.0]
//MARK: - 字体相关
#define YKSkinFont_Normal				@"Helvetica"
#define YKSkinFont_NormalBold			@"Helvetica-Bold"



#endif
