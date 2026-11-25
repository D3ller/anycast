//
//  ResultItemView.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "ResultItem.h"

@interface ResultItemView ()
@property (nonatomic, strong) NSImageView *image;
@property (nonatomic, strong) NSTextField *name;
@property (nonatomic, strong) NSTextField *kind;

- (NSAttributedString *)attributedName:(NSString *)string;
- (NSAttributedString *)attributedKind:(NSString *)string;
@end

@implementation ResultItemView

- (instancetype)initWithFrame:(NSRect)frameRect name:(nonnull NSString *)name icon:(NSImage*)icon kind:(NSString*)kind selected:(BOOL)selected {
    self = [super initWithFrame:frameRect];
    if(self) {
        
        self.wantsLayer = YES;
        self.layer.cornerRadius = 10;
        [self setSelected:selected];
        
        NSButton *button = [NSButton buttonWithTitle:@"" target:self action:@selector(clicked:)];
        
        _image = [[NSImageView alloc] init];
        [_image.widthAnchor constraintEqualToConstant:iconSize].active = YES;
        [_image.heightAnchor constraintEqualToConstant:iconSize].active = YES;
        
        _name = [NSTextField labelWithString:@""];
        _name.lineBreakMode = NSLineBreakByTruncatingTail;
        [_name setContentHuggingPriority:NSLayoutPriorityDefaultLow forOrientation:NSLayoutConstraintOrientationHorizontal];
        
        _kind = [NSTextField labelWithString:@""];
        
        NSStackView *stack = [NSStackView stackViewWithViews:@[_image, _name, _kind]];
        stack.spacing = 12;
        stack.alignment = NSLayoutAttributeCenterY;
        stack.distribution = NSStackViewDistributionFill;
        stack.edgeInsets = NSEdgeInsetsMake(0, 8, 0, 12);
        stack.frame = self.bounds;

        button.alignment = NSTextAlignmentLeft;
        
        button.frame = self.bounds;
        button.bordered = NO;
        button.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        
        stack.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:stack];
        [NSLayoutConstraint activateConstraints:@[
            [stack.topAnchor constraintEqualToAnchor:self.topAnchor],
            [stack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [stack.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [stack.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
        ]];
        
        [self configureWithName:name icon:icon kind:kind selected:selected];
        [self addSubview:button];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if(_selected == YES) {
        self.layer.backgroundColor = [NSColor colorWithWhite:1 alpha:0.1].CGColor;
    } else {
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
    }
}

- (void)clicked:(id)sender {
    if(self.onClick) {
        self.onClick();
    }
}

- (void)configureWithName:(NSString *)name icon:(NSImage *)image kind:(NSString*)kind selected:(BOOL)selected {
    _name.attributedStringValue = [self attributedName:name];
    _image.image = image;
    _kind.attributedStringValue = [self attributedKind:kind];
    [self setSelected:selected];
}

- (NSAttributedString *)attributedName:(NSString *)string {
    return [[NSAttributedString alloc] initWithString:string attributes:@{
        NSFontAttributeName: [NSFont systemFontOfSize:13],
        NSForegroundColorAttributeName: [NSColor colorWithWhite:1 alpha:0.85]
    }];
}

- (NSAttributedString *)attributedKind:(NSString *)string {
    return [[NSAttributedString alloc] initWithString:string attributes:@{
        NSFontAttributeName: [NSFont systemFontOfSize:13],
        NSForegroundColorAttributeName: [NSColor colorWithWhite:1 alpha:0.65]
    }];
}

@end
