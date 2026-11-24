//
//  SearchBarView.m
//  anycast
//
//  Created by d3ller on 22/11/2026.
//

#import "SearchBarView.h"

#define ZONE_HEIGHT 60
#define ICON_SIZE 22
#define ICON_X 18
#define GAP 12
#define RIGHT_MARGIN 16

NS_ASSUME_NONNULL_BEGIN

@interface SearchBarView () <NSTextFieldDelegate>
@end

@implementation SearchBarView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        _searchField = [self setupSearchField];
        _searchField.delegate = self;
        [self addSubview:[self setupMagnifierIcon]];
        [self addSubview:_searchField];
    }
    return self;
}

- (NSTextField*)setupSearchField {
    
    NSTextField *searchField = [[NSTextField alloc] init];
    searchField.bezeled = NO;
    searchField.drawsBackground = NO;
    searchField.focusRingType = NSFocusRingTypeNone;
    searchField.font = [NSFont systemFontOfSize:20 weight:NSFontWeightRegular];
    searchField.textColor = [NSColor labelColor];
    
    CGFloat x = GAP + ICON_X + ICON_SIZE;
    CGFloat h = searchField.intrinsicContentSize.height;
    
    searchField.frame = NSMakeRect(x,
                                   (self.bounds.size.height - h) / 2,
                                   self.bounds.size.width - x - RIGHT_MARGIN,
                                   h);
    
    NSColor *placeholderColor = [NSColor colorWithWhite:1 alpha:0.40];
    NSString *text = NSLocalizedString(@"search.placeholder", nil);
    
    searchField.placeholderAttributedString = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: placeholderColor, NSFontAttributeName: searchField.font}];
    
    return searchField;
}

- (NSImageView *)setupMagnifierIcon {
    CGFloat iconSize = 22;
    CGFloat iconX = 18;
    CGFloat centerY = self.bounds.size.height - ZONE_HEIGHT / 2;
    
    NSImage *symbol = [NSImage imageWithSystemSymbolName:@"magnifyingglass" accessibilityDescription:nil];
    NSImageSymbolConfiguration *config = [NSImageSymbolConfiguration configurationWithPointSize:iconSize weight:NSFontWeightRegular];
    
    NSImageView *magnifier = [NSImageView imageViewWithImage:[symbol imageWithSymbolConfiguration:config]];
    magnifier.contentTintColor = [NSColor colorWithWhite:1 alpha:0.60];
    magnifier.frame = NSMakeRect(iconX, centerY - iconSize / 2, iconSize, iconSize);
    
    return magnifier;
}

@end

NS_ASSUME_NONNULL_END
