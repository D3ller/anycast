//
//  AppDelegate.m
//  anycast
//
//  Created by d3ller on 21/11/2026.
//

#import "Theme.h"
#import "AppDelegate.h"
#import "SearchBarView.h"
#import "ResultsView.h"
#import "FooterView.h"
#import "GlassWindow.h"
#import "AppCatalog.h"
#import "CommandCatalog.h"
#import "ResultHeader.h"

@interface AppDelegate ()

@property (nonatomic, strong) GlassWindow *window;
@property (nonatomic, strong) NSArray<ResultSection*> *sections;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setupMain];
    NSRect frame = NSMakeRect(0, 0, panelWidth, panelHeight);
    
    NSRect screen = NSScreen.mainScreen.visibleFrame;
    NSRect windowFrame = NSMakeRect(NSMidX(screen) - panelWidth / 2,
                                    NSMaxY(screen) - screen.size.height * panelTopRatio - panelHeight,
                                    panelWidth,
                                    panelHeight);
    
    _window = [[GlassWindow alloc] initWithContentRect:windowFrame styleMask:NSWindowStyleMaskBorderless backing:NSBackingStoreBuffered defer:NO];
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
            

    ResultSection *appsSection = [[ResultSection alloc] initWithTitle:NSLocalizedString(@"section.applications.title", nil) entries:[[[AppCatalog alloc] init] scanApplications]];
    ResultSection *commandsSection = [[ResultSection alloc] initWithTitle:NSLocalizedString(@"section.commands.title", nil) entries:[[[CommandCatalog alloc] init] systemCommands]];
    
    NSMutableArray<ResultSection *> *entries = [[NSMutableArray<ResultSection *> alloc] init];
    [entries addObject:appsSection];
    [entries addObject:commandsSection];
    
    _sections = entries;
    resultsView.onSelect = ^(ResultEntry *entry) {
        [footerView setEntry:entry];
    };
    
    [resultsView setSections:_sections];
    
    __weak typeof(self) weakSelf = self;
    resultsView.onActivate = ^(ResultEntry *entry) {
        entry.perform();
        //[weakSelf.window orderOut:nil];
    };
    
    searchBarView.onMove = ^(NSInteger direction) {
        [resultsView moveSelectionBy:direction];
    };
    
    searchBarView.onEnter = ^{
        [resultsView activateSelected];
    };
    
    searchBarView.onCancel = ^{
        [weakSelf.window orderOut:nil];
    };
    
    searchBarView.onSearch = ^(NSString *search) {
        NSString *trimmedString = [search stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([trimmedString length] == 0) {
            [resultsView setSections:weakSelf.sections];
            return;
        }
        
        NSMutableArray<ResultEntry *> *appCustomEntries = [[NSMutableArray<ResultEntry *> alloc] init];
        for (ResultSection *section in weakSelf.sections) {
            for (ResultEntry *entry in section.entries) {
                if([entry.name rangeOfString:trimmedString options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound) {
                    [appCustomEntries addObject:entry];
                }
            }
        }
        
        [resultsView setItems:appCustomEntries];
    };
    
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

- (void)setupMain {
    NSMenu *menu = [[NSMenu alloc] init];
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    
    NSMenu *editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];
    
    [editMenu addItemWithTitle:@"Select All" action:@selector(selectAll:) keyEquivalent:@"a"];
    [editMenu addItemWithTitle:@"Copy" action:@selector(copy:) keyEquivalent:@"c"];
    [editMenu addItemWithTitle:@"Paste" action:@selector(paste:) keyEquivalent:@"v"];
    [editMenu addItemWithTitle:@"Undo" action:NSSelectorFromString(@"undo:") keyEquivalent:@"z"];
    [editMenu addItemWithTitle:@"Cut" action:@selector(cut:) keyEquivalent:@"x"];
    
    [menu addItem:menuItem];
    menuItem.submenu = editMenu;
    NSApp.mainMenu = menu;
}

@end
