//
//  AppEntry.h
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "ResultEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppEntry : ResultEntry

@property (nonatomic, copy) NSString* path;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name path:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
