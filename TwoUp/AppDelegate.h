//
//  AppDelegate.h
//  TwoUp
//
//  Created by Alasdair Monk on 13/12/2013.
//  Copyright (c) 2013 Alasdair Monk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet WebView *mobileView;
@property (assign) IBOutlet WebView *tabletView;
@property (assign) IBOutlet NSTextField *addressUrl;

@property (assign) IBOutlet NSWindow *window;

-(IBAction)sendTextToUrl:(id)sender;

@end
