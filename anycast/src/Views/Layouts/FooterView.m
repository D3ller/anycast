//
//  FooterView.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "FooterView.h"
#import "KeyCap.h"

static const CGFloat footerMargin = 8;

@interface FooterView ()
@property (nonatomic, strong) NSGlassEffectView *rightGlass;
@property (nonatomic, strong) NSTextField *actionLabel;
@end

@implementation FooterView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        _rightGlass = [self createRightFooter];
        _rightGlass.hidden = YES;
        [self addSubview:_rightGlass];
        [self addSubview:[self createLeftFooter]];
    }
    
    return self;
}

- (NSGlassEffectView*)createLeftFooter {
    NSGlassEffectView *glassIcon = [[NSGlassEffectView alloc] initWithFrame:NSMakeRect(8, 8, footerHeight, footerHeight)];
    
    glassIcon.cornerRadius = footerHeight / 2;
    
    return glassIcon;
}

- (NSGlassEffectView*)createRightFooter {
    
    NSGlassEffectView *glass = [[NSGlassEffectView alloc] initWithFrame:NSMakeRect(0, footerMargin, 0, footerHeight)];
    glass.cornerRadius = footerHeight / 2;
    glass.autoresizingMask = NSViewMinXMargin;
    
    _actionLabel = [NSTextField labelWithString:@""];
    _actionLabel.font = [NSFont systemFontOfSize:12 weight:NSFontWeightMedium];
    _actionLabel.textColor = [NSColor colorWithWhite:1 alpha:0.65];
    
    KeyCap *enter = [[KeyCap alloc] initWithSymbol:@"return"];
    
    NSStackView *stackView = [NSStackView stackViewWithViews:@[_actionLabel, enter]];
    stackView.orientation = NSUserInterfaceLayoutOrientationHorizontal;
    stackView.spacing = 8;
    stackView.alignment = NSLayoutAttributeCenterY;
    stackView.edgeInsets = NSEdgeInsetsMake(0, 14, 0, 14);
    
    glass.contentView = stackView;
    
    return glass;
}

- (void)setEntry:(ResultEntry *)entry {
    if (!entry) {
        _rightGlass.hidden = YES;
        return;
    }
    
    _actionLabel.stringValue = entry.primaryActionTitle;
    
    NSStackView *stackView = (NSStackView *)_rightGlass.contentView;
    CGFloat width = stackView.fittingSize.width;
    _rightGlass.frame = NSMakeRect(self.bounds.size.width - width - footerMargin, footerMargin, width, footerHeight);
    _rightGlass.hidden = NO;
}

- (NSView *)hitTest:(NSPoint)point {
    NSView *hit = [super hitTest:point];
    return hit == self ? nil : hit;
}

@end
