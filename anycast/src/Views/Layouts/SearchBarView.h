//
//  SearchBarView.h
//  anycast
//
//  Created by d3ller on 22/11/2026.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchBarView : NSView

@property (nonatomic, readonly) NSTextField* searchField;

@property (nonatomic, copy, nullable) void (^onMove)(NSInteger direction);
@property (nonatomic, copy, nullable) void (^onSearch)(NSString *search);
@property (nonatomic, copy, nullable) void (^onEnter)(void);
@property (nonatomic, copy, nullable) void (^onCancel)(void);


@end

NS_ASSUME_NONNULL_END
