//
//  GlassWindow.m
//  anycast
//
//  Created by d3ller on 21/11/2026.
//

#import "GlassWindow.h"

NS_ASSUME_NONNULL_BEGIN

@implementation GlassWindow
- (BOOL)canBecomeKeyWindow { return YES; }
- (BOOL)canBecomeMainWindow { return YES; }
@end

NS_ASSUME_NONNULL_END
