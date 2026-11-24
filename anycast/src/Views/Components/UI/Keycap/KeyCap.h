//
//  KeyCap.h
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyCap : NSView

@property (nonatomic, copy, nonnull) NSString *key_cap;

- (instancetype)initWithText:(NSString*)text;
- (instancetype)initWithSymbol:(NSString*)symbol;

@end

NS_ASSUME_NONNULL_END
