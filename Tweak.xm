//
//	DKFLEXLoader
//

#import <dlfcn.h>
#import <UIKit/UIKit.h>
// #import "FLEXManager.h"

@interface DKFLEXLoader : NSObject

@end

@implementation DKFLEXLoader

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static DKFLEXLoader *_sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

- (void)show
{
	// [[FLEXManager sharedManager] showExplorer];

	Class FLEXManager = NSClassFromString(@"FLEXManager");
	id sharedManager = [FLEXManager performSelector:@selector(sharedManager)];
	[sharedManager performSelector:@selector(showExplorer)];
}

@end

%ctor {
	NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/org.kostyshyn.DKFLEXLoader.plist"];
	NSString *dylibPath = @"/Library/Application Support/DKFLEXLoader/libFLEX.dylib";

	if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
		NSLog(@"DKFLEXLoader: library does not exists at path: %@", dylibPath);
	} else {
		NSLog(@"DKFLEXLoader: library found at path: %@", dylibPath);
	}

	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSString *loaderEnabledKey = [NSString stringWithFormat:@"DKFLEXLoaderEnabled-%@", bundleIdentifier];
	if ([preferences[loaderEnabledKey] boolValue]) {
		dlopen([dylibPath UTF8String], RTLD_NOW);
		NSLog(@"DKFLEXLoader: injected successfully");
	} else {
		NSLog(@"DKFLEXLoader: disabled");
	}

	[[NSNotificationCenter defaultCenter] addObserver:[DKFLEXLoader sharedInstance] 
		selector:@selector(show) 
		name:UIApplicationDidBecomeActiveNotification 
		object:nil];
}