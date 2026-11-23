//
//  AppCatalog.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "AppCatalog.h"
#import "../AppEntry.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AppCatalog

- (NSArray<AppEntry *>*)scanApplications {
    
    NSMutableArray<AppEntry *> *appEntries = [[NSMutableArray<AppEntry *> alloc] init];
    NSFileManager *fm = NSFileManager.defaultManager;
    
    NSArray<NSURL *> *roots = @[[NSURL fileURLWithPath:@"/Applications"], [NSURL fileURLWithPath: @"/System/Applications"], [NSURL fileURLWithPath:@"/System/Library/CoreServices/Applications"], [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Applications"]]];
    
    for (NSURL *root in roots) {
        NSDirectoryEnumerator *e = [fm enumeratorAtURL:root includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants errorHandler:nil];
        
        for (NSURL *url in e) {
            if([url.pathExtension isEqualToString:@"app"]) {
                AppEntry *appEntry = [[AppEntry alloc] initWithName:[url.lastPathComponent stringByDeletingPathExtension] path:[url path]];
                
                [appEntries addObject:appEntry];
            }
            if(e.level >= 2) [e skipDescendants];
        }
    }
        
    [appEntries sortUsingComparator:^NSComparisonResult(AppEntry *a, AppEntry *b) {
        return [a.name localizedCaseInsensitiveCompare:b.name];
    }];
    
    return appEntries;
}

@end

NS_ASSUME_NONNULL_END
