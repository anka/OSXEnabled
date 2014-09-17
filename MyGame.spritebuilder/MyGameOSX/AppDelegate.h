//
//  AppDelegate.h
//  MyGameOSX
//
//  Created by Andreas Katzian on 17/09/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "cocos2d.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
}


@property (weak) IBOutlet CCGLView *glView;

@end

