//
//  FooterView.h
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "Theme.h"
#import "ResultEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface FooterView : NSView

- (void)setEntry:(nullable ResultEntry *)entry;

@end

NS_ASSUME_NONNULL_END
