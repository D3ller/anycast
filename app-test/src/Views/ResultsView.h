//
//  ResultsView.h
//  anycast
//
//  Created by d3ller on 22/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "../AppEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultsView : NSView
@property (nonatomic, readonly) NSScrollView *scrollView;

- (void)setItems: (NSArray<AppEntry *>*)appEntries;
@end

NS_ASSUME_NONNULL_END
