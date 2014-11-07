//
//  UncaughtExceptionHandler.h
//  DT_nearevent
//
//  Created by li on 13-2-21.
//  Copyright 2013年 Apple inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UncaughtExceptionHandler : NSObject {
    
    BOOL dismissed;  
}

@end

void InstallUncaughtExceptionHandler();