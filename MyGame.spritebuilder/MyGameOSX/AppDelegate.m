//
//  AppDelegate.m
//  MyGameOSX
//
//  Created by Andreas Katzian on 17/09/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AppDelegate.h"
#import "CCBReader.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Setup file utils and search paths
    [self setupFileUtils];

    // Setup and load your sprite frames
    [self setupSpriteFrames];

    // Setup Cocos2D and run first scene
    [self setupCocos2d];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}


#pragma mark - Helper and setup methods

- (void) setupFileUtils
{
    // Configure CCFileUtils to work with SpriteBuilder
    CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
    
    sharedFileUtils.directoriesDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @"resources-phone", CCFileUtilsSuffixMac,
                                       @"resources-phonethd", CCFileUtilsSuffixMacHD,
                                       nil];

    // Support for tablet resources
//    sharedFileUtils.directoriesDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                       @"resources-tablet", CCFileUtilsSuffixMac,
//                                       @"resources-tablethd", CCFileUtilsSuffixMacHD,
//                                       nil];

    sharedFileUtils.searchPath = [NSArray arrayWithObjects:
                                  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Published-iOS"],
                                  [[NSBundle mainBundle] resourcePath],
                                  nil];
    
    sharedFileUtils.searchMode = CCFileUtilsSearchModeDirectory;
    [sharedFileUtils buildSearchResolutionsOrder];
    [sharedFileUtils loadFilenameLookupDictionaryFromFile:@"fileLookup.plist"];

    // Support for tablet resources
//    [sharedFileUtils setMacContentScaleFactor:2.0];
}

- (void) setupSpriteFrames
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] loadSpriteFrameLookupDictionaryFromFile:@"spriteFrameFileList.plist"];
}

- (void) setupCocos2d
{
    // Setup the CCDirector for Mac
    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
    [director setResizeMode:kCCDirectorResize_NoScale];
    [director setProjection:CCDirectorProjection2D];

    //Support for tablet resources
    [director setContentScaleFactor:2.0];
    
#ifdef DEBUG
    // Enable FPS and SPF
    [director setDisplayStats:YES];
#endif
    
    // Connect the OpenGL view with the director
    [director setView:self.glView];
    [self.glView setFrameSize:NSMakeSize(self.window.frame.size.width,self.window.frame.size.height)];
	   
    // Enable "moving" mouse event. Default no.
    [self.window setAcceptsMouseMovedEvents:NO];
    [self.window center];
    [self.window setRestorable:NO];

    // Run the first scene
    [director runWithScene:[self startScene]];
}


- (CCScene*) startScene
{
    return [CCBReader loadAsScene:@"MainScene"];
}


@end
