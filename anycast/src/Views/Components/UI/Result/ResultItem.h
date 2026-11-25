//
//  ResultItemView.h
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "Theme.h"
#import "ResultEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultItemView : NSView
@property (nonatomic, copy, nonnull) void (^onClick)(void);
@property (nonatomic) BOOL selected;

- (instancetype)initWithFrame:(NSRect)frame NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(NSRect)frameRect name:(nonnull NSString *)name icon:(NSImage*)icon kind:(NSString*)kind selected:(BOOL)selected;
- (void)configureWithName:(NSString *)name icon:(NSImage *)image kind:(NSString*)kind selected:(BOOL)selected;
@end

NS_ASSUME_NONNULL_END
