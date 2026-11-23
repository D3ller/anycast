//
//  ResultsView.m
//  anycast
//
//  Created by d3ller on 22/11/2026.
//

#import "ResultsView.h"
#import "ResultItemView.h"
#import "Special/FlippedView.h"

#define ROW_HEIGHT 40

NS_ASSUME_NONNULL_BEGIN

@interface ResultsView()
@property (nonatomic) FlippedView *documentView;
@end

@implementation ResultsView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        _scrollView = [[NSScrollView alloc] init];
        _scrollView.drawsBackground = NO;
        _scrollView.borderType = NSNoBorder;
        _scrollView.frame = self.bounds;
        _scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        
        CGFloat rowHeight = 40;
        _documentView = [[FlippedView alloc] initWithFrame:NSMakeRect(0, 0, self.bounds.size.width, rowHeight)];
        
        _scrollView.documentView = _documentView;
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)setItems: (NSArray<AppEntry *>*)appEntries {
    
    for (NSView *v in [_documentView.subviews copy]) [v removeFromSuperview];
    
    CGFloat rowHeight = 40;
    
    for (NSUInteger i = 0; i < [appEntries count]; i++) {
        ResultItemView *item = [[ResultItemView alloc] initWithFrame:NSMakeRect(8, i * rowHeight, self.bounds.size.width, rowHeight) name:appEntries[i].name];
        
        [_documentView addSubview:item];
    }
    
    _documentView.frame = NSMakeRect(0, 0, self.bounds.size.width, appEntries.count * rowHeight);
    
}

@end

NS_ASSUME_NONNULL_END
