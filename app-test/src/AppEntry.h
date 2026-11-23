//
//  AppEntry.h
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppEntry : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* path;
@property (nonatomic, strong, nullable) NSImage* icon;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString*)name path:(NSString*)path;

@end

NS_ASSUME_NONNULL_END
