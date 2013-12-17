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
    
    [self updateDimensionFields];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewResized:)
                                          name:NSViewFrameDidChangeNotification object:_mobileView];
}

- (void)viewResized:(NSNotification *)notification
{
    [self updateDimensionFields];
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
    NSURL *url = [NSURL URLWithString:[self buildUrlFromAddressBar]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [[self.mobileView mainFrame] loadRequest:requestObj];
    [[self.tabletView mainFrame] loadRequest:requestObj];
}

-(IBAction)navigateBack:(id)sender {
    [self.mobileView goBack];
    [self.tabletView goBack];
}


-(IBAction)navigateForward:(id)sender {
    [self.mobileView goForward];
    [self.tabletView goForward];
}


-(IBAction)navigateReload:(id)sender {
    [self.mobileView reload:nil];
    [self.tabletView reload:nil];
}

-(NSString*)buildUrlFromAddressBar {
    NSString *urlAddress = [_addressUrl stringValue];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^https?://"
                                                      options:NSRegularExpressionCaseInsensitive
                                                      error:&error];
    
    if (!error) {
        NSTextCheckingResult *match = [regex firstMatchInString:urlAddress
                                             options:0
                                             range:NSMakeRange(0, [urlAddress length])];
        
        if (!match) {
            urlAddress = [@"http://" stringByAppendingString:urlAddress];
        }
    }
    
    return urlAddress;
}

-(void) updateDimensionFields {
    NSSize tabletViewSize = [self.tabletView frame].size;
    NSMutableString *tabletDimensionString = [NSMutableString stringWithFormat: @"%ld", lroundf(tabletViewSize.width)];
    [tabletDimensionString appendString:@"x"];
    [tabletDimensionString appendString:[NSMutableString stringWithFormat: @"%ld", lroundf(tabletViewSize.height)]];
    [_tabletDimensions setStringValue:tabletDimensionString];
    
    NSSize mobileViewSize = [self.mobileView frame].size;
    NSMutableString *mobileDimensionString = [NSMutableString stringWithFormat: @"%ld", lroundf(mobileViewSize.width)];
    [mobileDimensionString appendString:@"x"];
    [mobileDimensionString appendString:[NSMutableString stringWithFormat: @"%ld", lroundf(mobileViewSize.height)]];
    [_mobileDimensions setStringValue:mobileDimensionString];
}

- (void)mouseDragged:(NSEvent *)event
{
    NSLog(@"DRAGGED");
    [self updateDimensionFields];
}

@end
