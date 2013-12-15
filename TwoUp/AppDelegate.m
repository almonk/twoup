//
//  AppDelegate.m
//  TwoUp
//
//  Created by Alasdair Monk on 13/12/2013.
//  Copyright (c) 2013 Alasdair Monk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *urlAddress = @"http://www.theguardian.com/preference/platform/mobile?page=http%3A%2F%2Fwww.theguardian.com%3Fview%3Dmobile";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [[self.mobileView mainFrame] loadRequest:requestObj];
    [[self.tabletView mainFrame] loadRequest:requestObj];
    
    [self.mobileView setPolicyDelegate:self];
    [self.tabletView setPolicyDelegate:self];
    
    [self.mobileView setFrameLoadDelegate:self];
    [self.tabletView setFrameLoadDelegate:self];
    
    [_addressUrl setStringValue:@"http://www.theguardian.com/preference/platform/mobile?page=http%3A%2F%2Fwww.theguardian.com%3Fview%3Dmobile"];
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id )listener{
    NSLog(@"Change");
    if (WebNavigationTypeLinkClicked == [[actionInformation objectForKey:WebActionNavigationTypeKey] intValue])
    {
        NSString *requestPath = [[request URL] absoluteString];
        
        [[self.mobileView mainFrame] loadRequest:request];
        [[self.tabletView mainFrame] loadRequest:request];
        [_addressUrl setStringValue: requestPath];
        [listener use];
    }
    [listener use]; // Say for webview to do it work...
}

-(IBAction)sendTextToUrl:(id)sender {
    NSString *urlAddress = [_addressUrl stringValue];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [[self.mobileView mainFrame] loadRequest:requestObj];
    [[self.tabletView mainFrame] loadRequest:requestObj];
}


@end
