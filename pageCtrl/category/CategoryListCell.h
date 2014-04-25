//
//  CategoryListCell.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-11.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjButton.h"

@interface FirstCategoryListCell : UITableViewCell
{
    UIImageView *m_BrandImage;
    UILabel *m_BrandName;
    UILabel *m_marketPrice;
    UILabel *m_secondPaice;
}


@property (retain, nonatomic) IBOutlet UIImageView *m_BrandImage;
@property (retain, nonatomic) IBOutlet UILabel *m_BrandName;
@property (retain, nonatomic) IBOutlet UILabel *m_marketPrice;
@property (retain, nonatomic) IBOutlet UILabel *m_secondPaice;

@end


@interface SecondCategoryCell : UITableViewCell
{
    UIScrollView  *m_scrollView;
    UIView        *m_titleView;
}

@property (retain, nonatomic) IBOutlet UIScrollView  *m_scrollView;
@property (retain, nonatomic) IBOutlet UIView        *m_titleView;


@end


@interface ThirdCategoryCell : UITableViewCell
{
    ObjButton *leftButton;
    ObjButton *middleButton;
    ObjButton *rihgtButton;
}

@property (nonatomic, retain) IBOutlet ObjButton *leftButton;
@property (nonatomic, retain) IBOutlet ObjButton *middleButton;
@property (nonatomic, retain) IBOutlet ObjButton *rihgtButton;



@end

@interface OtherCategoryCell : UITableViewCell
{
    UIView *otherView;
}

@property (nonatomic, retain) IBOutlet UIView *otherView;

@end


