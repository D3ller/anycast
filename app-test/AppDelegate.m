//
//  AppDelegate.m
//  anycast
//
//  Created by d3ller on 21/11/2026.
//

#import "AppDelegate.h"
#import "src/Views/SearchBarView.h"
#import "src/Views/ResultsView.h"
#import "src/Views/Layouts/FooterView.h"
#import "src/GlassWindow.h"
#import "src/Services/AppCatalog.h"

@interface AppDelegate ()

@property (nonatomic, strong) GlassWindow *window;
@property (nonatomic, strong) NSArray<AppEntry*> *appEntries;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSRect frame = NSMakeRect(0, 0, 750, 475);
    
    _window = [[GlassWindow alloc] initWithContentRect:frame styleMask:NSWindowStyleMaskBorderless backing:NSBackingStoreBuffered defer:NO];
    _window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
    
    NSView *content = [[NSView alloc] initWithFrame:frame];
    content.wantsLayer = YES;
    content.layer.cornerRadius = 26;
    content.layer.cornerCurve = kCACornerCurveContinuous;
    content.layer.masksToBounds = YES;
    
    NSGlassEffectView *glass = [[NSGlassEffectView alloc] initWithFrame:content.bounds];
    glass.style = NSGlassEffectViewStyleRegular;
    glass.cornerRadius = 0;
    glass.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    glass.tintColor = [NSColor colorWithWhite:0 alpha:0.50];
    
    [content addSubview:glass];
    
    NSView *scrim = [[NSView alloc] initWithFrame:content.bounds];
    scrim.wantsLayer = YES;
    scrim.layer.backgroundColor = [NSColor colorWithWhite:0 alpha:0.30].CGColor;
    scrim.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [content addSubview:scrim];

    
    SearchBarView *searchBarView = [[SearchBarView alloc] initWithFrame:NSMakeRect(0, 415, 750, 60)];
    [content addSubview:searchBarView];
    
    ResultsView *resultsView = [[ResultsView alloc] initWithFrame:NSMakeRect(8, 8, 734, 407)];
    [content addSubview:resultsView];
    
    FooterView *footerView = [[FooterView alloc] initWithFrame:NSMakeRect(0, 0, 750, 52)];
    [content addSubview:footerView];
    
    AppCatalog *appCatalog = [[AppCatalog alloc] init];
    _appEntries = [appCatalog scanApplications];
    
    [resultsView setItems:_appEntries];
    
    
    [_window setTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
        
    _window.opaque = NO;
    _window.backgroundColor = [NSColor clearColor];
    _window.hasShadow = NO;
    _window.movableByWindowBackground = YES;
    _window.contentView = content;
    
    [_window makeKeyAndOrderFront:nil];
    [_window makeFirstResponder:searchBarView.searchField];
    
    [NSApp activate];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
