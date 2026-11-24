//
//  FooterView.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "FooterView.h"
#import "../Components/UI/Keycap/KeyCap.h"

@implementation FooterView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self addSubview:[self createRightFooter]];
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
    
    NSGlassEffectView *glass = [[NSGlassEffectView alloc] initWithFrame:NSMakeRect(100, 8, self.bounds.size.width / 2, footerHeight)];
    NSStackView *stackView = [[NSStackView alloc] init];
    
    stackView.orientation = NSUserInterfaceLayoutOrientationHorizontal;
    stackView.spacing = 16;
    stackView.alignment = NSLayoutAttributeCenterY;
    stackView.edgeInsets = NSEdgeInsetsMake(0, 14, 0, 14);
        
    glass.cornerRadius = footerHeight / 2;
    
    KeyCap *k = [[KeyCap alloc] initWithText:@"K"];
    k.frame = NSMakeRect(350, 20, 18, 18);
    [stackView addArrangedSubview:k];
    glass.contentView = stackView;
    
    return glass;
}

@end
