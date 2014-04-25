//
//  CategoryListCell.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-11.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "CategoryListCell.h"

@implementation FirstCategoryListCell

@synthesize m_BrandImage;
@synthesize m_BrandName;
@synthesize m_marketPrice;
@synthesize m_secondPaice;


- (void)dealloc {
    
    [m_BrandImage release];
    [m_BrandName release];
    [m_marketPrice release];
    [m_secondPaice release];
    [super dealloc];
}



@end


@implementation SecondCategoryCell

@synthesize m_titleView, m_scrollView;

- (void)dealloc {

    [m_scrollView release];
    [m_titleView release];
    
    [super dealloc];
}

@end


@implementation ThirdCategoryCell

@synthesize leftButton;
@synthesize middleButton;
@synthesize rihgtButton;

-(void)dealloc
{
    [leftButton release];
    [middleButton release];
    [rihgtButton release];
    
    [super dealloc];
}


@end


@implementation OtherCategoryCell

@synthesize otherView;

-(void)dealloc
{
    [otherView release];
    [super dealloc];
}

@end



