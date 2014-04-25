//
//  Sun_PaoductListViewController.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-7.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SunBaseController.h"
#import "YPCategoryData.h"

@interface Sun_PaoductListViewController : SunBaseController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView         *table_Category;
    NSMutableDictionary    *mIndexDic;     // 存储选择行数
    int                section_Index;    // section数量    
    BOOL               isPressedSecBtn;// 是点击了第二级的按钮
    YPCategoryData     *m_categoryData;
    int                secIndexItem;
    int                item_count;      // 第二级总的按钮个数
    CGFloat            contentOffSetX;  // 偏移量
    UIImageView        *image_glass;
}


@property (nonatomic, retain) IBOutlet UITableView  *table_Category;
@property (nonatomic, retain) YPCategoryData            *m_categoryData;
@property (nonatomic, retain) NSMutableDictionary       *mIndexDic;
@property (nonatomic, retain) UIImageView        *image_glass;

@end
