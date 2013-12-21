//
//  AppDelegate.h
//  TwoUp
//
//  Created by Alasdair Monk on 13/12/2013.
//  Copyright (c) 2013 Alasdair Monk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet WebView *mobileView;
@property (assign) IBOutlet WebView *tabletView;
@property (assign) IBOutlet NSTextField *addressUrl;
@property (assign) IBOutlet NSView *mobileContainer;

@property (assign) IBOutlet NSTextField *mobileDimensions;
@property (assign) IBOutlet NSTextField *tabletDimensions;

@property (assign) IBOutlet NSWindow *window;

-(IBAction)sendTextToUrl:(id)sender;
-(IBAction)navigateBack:(id)sender;
-(IBAction)navigateForward:(id)sender;
-(IBAction)navigateReload:(id)sender;

-(NSString*)buildUrlFromAddressBar;

@end
