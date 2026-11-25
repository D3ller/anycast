//
//  ResultsView.h
//  anycast
//
//  Created by d3ller on 22/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "AppEntry.h"
#import "ResultSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultsView : NSView
@property (nonatomic, readonly) NSScrollView *scrollView;
@property (nonatomic, copy, nullable) void (^onActivate)(ResultEntry *entry);
@property (nonatomic, copy, nullable) void (^onSelect)(ResultEntry * _Nullable entry);

- (void)setItems: (NSArray<ResultEntry *>*)appEntries;
- (void)setSections: (NSArray<ResultSection *>*)sections;
- (void)moveSelectionBy: (NSInteger)move;
- (void)activateSelected;
@end

NS_ASSUME_NONNULL_END
