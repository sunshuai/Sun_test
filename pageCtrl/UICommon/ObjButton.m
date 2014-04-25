//
//  ObjButton.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-13.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "ObjButton.h"

@implementation ObjButton

@synthesize anyObjct;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc
{
    [anyObjct release]; anyObjct = nil;
    [super dealloc];
}

@end
