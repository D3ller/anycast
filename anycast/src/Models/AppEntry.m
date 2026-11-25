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
    self = [super initWithName:name icon:[[NSWorkspace sharedWorkspace] iconForFile:path] kind:ResultKindApplication perform:^{
        NSURL *url = [NSURL fileURLWithPath:path];
        NSWorkspaceOpenConfiguration *config = [NSWorkspaceOpenConfiguration configuration];
        [[NSWorkspace sharedWorkspace] openApplicationAtURL:url configuration:config completionHandler:nil];
    }];
    if(self) {
        _path = [path copy];
    }
    
    return self;
}


@end

NS_ASSUME_NONNULL_END
