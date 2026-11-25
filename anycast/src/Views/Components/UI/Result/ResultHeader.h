//
//  ResultSectionView.h
//  anycast
//
//  Created by Corentin on 25/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "ResultEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultHeader : NSView

@property (nonatomic, copy) NSString *title;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString*)title frame:(NSRect)frameRect;

@end

NS_ASSUME_NONNULL_END
