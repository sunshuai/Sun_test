//
//  UIPullToReload.h
//  Untitled
//
//  Created by YuHui on 10-12-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	kPullStatusReleaseToReload = 0,
	kPullStatusPullDownToReload	= 1,
	kPullStatusLoading = 2
} UIPullToReloadStatus;

#define kPullDownToReloadToggleHeight 65.0f

@interface UIPullToReload : NSObject {

}

@end
