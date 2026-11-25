//
//  ResultsView.m
//  anycast
//
//  Created by d3ller on 22/11/2026.
//

#import "ResultsView.h"
#import "ResultItem.h"
#import "FlippedView.h"
#import "Theme.h"
#import "ResultHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultsView()
@property (nonatomic) FlippedView *documentView;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray<ResultItemView *> *itemsViews;
@property (nonatomic) NSInteger visibleCount;
@property (nonatomic, strong) NSMutableArray<ResultEntry *> *visibleEntries;
@end

@implementation ResultsView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        _itemsViews = [[NSMutableArray alloc] init];
        _visibleEntries = [[NSMutableArray alloc] init];
        _scrollView = [[NSScrollView alloc] init];
        _scrollView.drawsBackground = NO;
        _scrollView.borderType = NSNoBorder;
        _scrollView.frame = self.bounds;
        _scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        _scrollView.hasVerticalScroller = YES;
        
        _documentView = [[FlippedView alloc] initWithFrame:NSMakeRect(0, 0, self.bounds.size.width, rowHeight)];
        
        _scrollView.documentView = _documentView;
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)setItems: (NSArray<ResultEntry *>*)appEntries {
    
    _selectedIndex = 0;
    CGFloat y = 0;
    [_visibleEntries removeAllObjects];
    
    __weak typeof(self) weakSelf = self;
    for (NSView *v in [_documentView.subviews copy]) {
        if ([v isKindOfClass:[ResultHeader class]]) [v removeFromSuperview];
    }
    
    ResultHeader *applicationHeader = [[ResultHeader alloc] initWithTitle:NSLocalizedString(@"results.header.title", nil) frame:NSMakeRect(0, y, self.bounds.size.width, headerHeight)];
    [_documentView addSubview:applicationHeader];
    y += headerHeight;
    
    NSUInteger count = MIN(appEntries.count, 20);
    for (NSUInteger i = 0; i < count; i++) {
        ResultEntry *entry = appEntries[i];
        [_visibleEntries addObject:entry];
        BOOL isSelected = i == _selectedIndex;
        NSRect rowFrame = NSMakeRect(0, y, self.bounds.size.width, rowHeight);
        
        ResultItemView *item;
        if (i < _itemsViews.count) {
            item = _itemsViews[i];
            [item configureWithName:entry.name icon:entry.icon kind:entry.kindLabel selected:isSelected];
            item.frame = rowFrame;
            item.hidden = NO;
        } else {
            item = [[ResultItemView alloc] initWithFrame:rowFrame name:entry.name icon:entry.icon kind:entry.kindLabel selected:isSelected];
            [self.itemsViews addObject:item];
            [_documentView addSubview:item];
        }
        
        item.onClick = ^{
            if(weakSelf.onActivate) {
                weakSelf.onActivate(entry);
            }
        };
        
        y += rowHeight;
    }
    
    for (NSUInteger i = count; i < _itemsViews.count; i++) {
        _itemsViews[i].hidden = YES;
    }
    _visibleCount = count;
    
    //last row is just to create a space to see all the results.
    _documentView.frame = NSMakeRect(0, 0, self.bounds.size.width, y + rowHeight);
    [_documentView scrollPoint:NSZeroPoint];
    [self notifySelection];
}

- (void)moveSelectionBy:(NSInteger)move {
    NSInteger oldIndex = _selectedIndex;
    NSInteger newIndex = move + _selectedIndex;
    NSInteger count = _visibleCount;
    
    if(count == 0) return;
    if(newIndex >= count) {
        newIndex = 0;
    }
    if(newIndex < 0) {
        newIndex = count -1;
    }
    
    [self.itemsViews[oldIndex] setSelected:NO];
    [self.itemsViews[newIndex] setSelected:YES];
    
    _selectedIndex = newIndex;
    [self notifySelection];
    NSView *row = self.itemsViews[newIndex];
    NSRect zone = NSInsetRect(row.frame, 0, -rowHeight);
    [_documentView scrollRectToVisible:zone];
}

- (void)activateSelected {
    if (_visibleCount == 0) return;
    self.itemsViews[_selectedIndex].onClick();
}
                    
                          

- (void)setSections:(nonnull NSArray<ResultSection *> *)sections {
    
    _selectedIndex = 0;
    CGFloat y = 0;
    NSInteger index = 0;
    [_visibleEntries removeAllObjects];
    
    __weak typeof(self) weakSelf = self;
    for (NSView *v in [_documentView.subviews copy]) {
        if ([v isKindOfClass:[ResultHeader class]]) [v removeFromSuperview];
    }
    
    for (ResultSection *section in sections) {
        ResultHeader *header = [[ResultHeader alloc] initWithTitle:section.title frame:NSMakeRect(0, y, self.bounds.size.width, headerHeight)];
        
        [_documentView addSubview:header];
        y += headerHeight;
        
        for (ResultEntry *entry in section.entries) {
            [_visibleEntries addObject:entry];
            BOOL isSelected = index == _selectedIndex;
            NSRect rowFrame = NSMakeRect(0, y, self.bounds.size.width, rowHeight);
            
            ResultItemView *item;
            if (index < _itemsViews.count) {
                item = _itemsViews[index];
                [item configureWithName:entry.name icon:entry.icon kind:entry.kindLabel selected:isSelected];
                item.frame = rowFrame;
                item.hidden = NO;
            } else {
                item = [[ResultItemView alloc] initWithFrame:rowFrame name:entry.name icon:entry.icon kind:entry.kindLabel selected:isSelected];
                [self.itemsViews addObject:item];
                [_documentView addSubview:item];
            }
            
            item.onClick = ^{
                if(weakSelf.onActivate) {
                    weakSelf.onActivate(entry);
                }
            };
            
            y += rowHeight;
            index++;
        }
    }
    
    for (NSInteger i = index; i < (NSInteger)_itemsViews.count; i++) {
        _itemsViews[i].hidden = YES;
    }
    _visibleCount = index;
    
    _documentView.frame = NSMakeRect(0, 0, self.bounds.size.width, y + rowHeight);
    [_documentView scrollPoint:NSZeroPoint];
    [self notifySelection];
}

- (void)notifySelection {
    if (!self.onSelect) return;
    self.onSelect(_visibleCount > 0 ? _visibleEntries[_selectedIndex] : nil);
}

@end

NS_ASSUME_NONNULL_END
