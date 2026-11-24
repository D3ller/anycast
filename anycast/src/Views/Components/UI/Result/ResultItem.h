//
//  ResultItemView.h
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "../Theme.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultItemView : NSView
@property (nonatomic, copy, nonnull) void (^onClick)(void);

- (instancetype)initWithFrame:(NSRect)frame NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(NSRect)frameRect name:(nonnull NSString *)name icon:(NSImage*)icon;
@end

NS_ASSUME_NONNULL_END
