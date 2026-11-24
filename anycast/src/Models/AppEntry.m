//
//  AppEntry.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "AppEntry.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AppEntry

- (instancetype)initWithName:(NSString *)name path:(NSString *)path {
    self = [self init];
    if(self) {
        _name = name;
        _path = path;
        
        NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:path];
        _icon = icon;
    }
    
    return self;
}

@end

NS_ASSUME_NONNULL_END
