//
//  CookieData.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "CookieData.h"

@implementation CookieData


@synthesize mname;
@synthesize mdomain;
@synthesize mpath;
@synthesize mvalue;

DECLARE_PROPERTIES(
                   DECLARE_PROPERTY(@"mname", @"@\"NSString\""),
                   DECLARE_PROPERTY(@"mdomain", @"@\"NSString\""),
                   DECLARE_PROPERTY(@"mpath", @"@\"NSString\""),
                   DECLARE_PROPERTY(@"mvalue", @"@\"NSString\"")
                   
                   )

- (id)init
{
self = [super init];
if (self) {
    // Initialization code here.
}

return self;
}
-(void)dealloc{
    self.mpath=nil;
    self.mname=nil;
    self.mvalue=nil;
    self.mdomain=nil;
    
    [super dealloc];
}

@end
